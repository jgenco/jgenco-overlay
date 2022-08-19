# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: yarn.eclass
# @MAINTAINER:
# $ECHANGELOG_USER
# @AUTHOR:
# $ECHANGELOG_USER
# @SUPPORTED_EAPIS: 8
# @BLURB: Provides functions for using Yarn (WIP!)
# @DESCRIPTION:
# builds yarns complex cache and installing yarn based programs
# also builds node_gyp

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

if [[ ! ${_YARN_ECLASS} ]]; then
_YARN_ECLASS=1

yarn_build_cache(){
	YARN_CACHE_DIR="${WORKDIR}/yarn_cache"
	#PACKAGES=$(cat packages)
	CUR_TIME=$(date +%s)
	mkdir -p ${YARN_CACHE_DIR}
	for PKG in ${@};do
		regex='((.*\/)?(.*))@(.*)'
		[[ ${PKG} =~ ${regex} ]]
			YARN_NAME_FULL=${BASH_REMATCH[1]}
			YARN_SCOPE=${BASH_REMATCH[2]}
			YARN_NAME=${BASH_REMATCH[3]}
			YARN_VER=${BASH_REMATCH[4]}
			FILE_EXT="tgz"
			YARN_FILENAME="${YARN_NAME}-${YARN_VER}.${FILE_EXT}"
			YARN_FILENAME_SAVE="node_${YARN_NAME_FULL/\//+}@${YARN_VER}.${FILE_EXT}"
			
			PKG_PATH=""
			if [[ -f "${DISTDIR}/${YARN_FILENAME_SAVE}" ]];then
				PKG_PATH="${DISTDIR}/${YARN_FILENAME_SAVE}"
			else
				echo "${YARN_FILENAME_SAVE}"
				echo "Not Found"
				exit
			fi
			PKG_SIZE=$(wc -c ${PKG_PATH}| sed "s/ .*//")
			PKG_SHA1=$(sha1sum ${PKG_PATH}| sed "s/ .*//")
			PKG_SHA1_B64=$(echo ${PKG_SHA1} | xxd -r -p|base64)
			#PKG_SHA512_B64=$(sha512sum $PKG_PATH |sed "s/ .*//"|xxd -r -p|base64 -w0)
			PKG_SHA512=$(sha512sum $PKG_PATH |sed "s/ .*//")
			PKG_SHA512_B64=$(echo -n ${PKG_SHA512}|xxd -r -p|base64 -w0)
			YARN_NAME_DEST=${YARN_NAME//[._]/-}
			YARN_NAME_DEST=${YARN_NAME_DEST//--/-}
			PKG_DEST="${YARN_CACHE_DIR}/v6/npm-${YARN_SCOPE/\//-}${YARN_NAME_DEST}-${YARN_VER}-${PKG_SHA1}-integrity"
			PKG_URL="https://registry.npmjs.org/${YARN_SCOPE}${YARN_NAME}/-/${YARN_NAME}-${YARN_VER}.tgz"
			mkdir -p ${PKG_DEST}/node_modules/${YARN_SCOPE}
			echo "${YARN_SCOPE} - ${YARN_NAME} @ ${YARN_VER} "
			#echo "$PKG_PATH -> ${PKG_DEST}"
			mkdir -p ${PKG_DEST}/unpack
			pushd ${PKG_DEST}/unpack > /dev/null
			#no-unknown-keyword disables the warning  Ignoring unknown extended header keyword 'foo'
			tar xzf ${PKG_PATH} -C ${PKG_DEST}/unpack --warning=no-unknown-keyword || die "Failed to extract tarball"
			if [[ -d ${PKG_DEST}/unpack/package ]];then
				mv ${PKG_DEST}/unpack/package ${PKG_DEST}/node_modules/${YARN_SCOPE}/${YARN_NAME} || die "Failed to move 1"
			else
				YARN_FOLDER_NAME=(${PKG_DEST}/unpack/*)
				[[ ${YARN_FOLDER_NAME[0]} == "${PKG_DEST}/unpack/*" ]] && die "Oops"
				#echo ${#YARN_FOLDER_NAME[@]} - ${YARN_FOLDER_NAME}
				if [[ 1 -eq ${#YARN_FOLDER_NAME[@]} ]];then
					mv "${YARN_FOLDER_NAME[0]}" "${PKG_DEST}/node_modules/${YARN_SCOPE}/${YARN_NAME}" || die "Failed to move 2"
				else
					die "Failed to move n"
				fi
			fi
			rmdir ${PKG_DEST}/unpack || die "Failed to remove unpack dir"
			#build ${PKG_DEST}/${YARN_NAME}/.yarn-metadata.json
			cat <<_EOF_ > ${PKG_DEST}/node_modules/${YARN_SCOPE}/${YARN_NAME}/.yarn-metadata.json
			{"remote":{
			"hash": "${PKG_SHA1}",
			"integrity":"sha512-${PKG_SHA512_B64}",
			"cacheIntegrity": "sha512-${PKG_SHA512_B64} sha1-${PKG_SHA1_B64}"}}
_EOF_
	done
	echo
}
yarn_set_config(){
	YARN_CACHE_DIR="${WORKDIR}/yarn_cache"
	local YARN_CMD_OPTIONS="--cache-folder ${YARN_CACHE_DIR} --use-yarnrc ${YARN_CONFIG}  --non-interactive --offline --no-pregess"
	yarn config set ${1} ${2} ${YARN_CMD_OPTIONS} || die "Failed to set ${1}"
}
yarn_src_prepare_gyp(){
	local NODE_GYP_DIR=${WORKDIR}/node_gyp
	[[ ! -f ${NODE_GYP_DIR}/package.json ]] && die "Node Gyp ${NODE_GYP_DIR}/package.json not found"
	for package in {bindings,nan,require-inject,standard,tap};do
		echo "Removing ${package} from ${NODE_GYP_DIR}/package.json"
		sed -i "/\"${package}\":/d" ${NODE_GYP_DIR}/package.json
	done
	if [[ -f ${1} ]];then 
			cp ${1} ${NODE_GYP_DIR}/yarn.lock
		else
			die "Node GYP yarn.lock file"
	fi

}
yarn_src_compile_gyp(){
	[[ $NODE_GYP_VER} != "" ]] || return
	local NODE_GYP_DIR=${WORKDIR}/node_gyp
	local YARN_FILES_DIR=${WORKDIR}/.nodejs_files
	#local YARN_CACHE_DIR=${WORKDIR}/.yarn_cache
	local YARN_CONFIG=${WORKDIR}/.yarnrc
	export YARN_CACHE_DIR="${WORKDIR}/yarn_cache"


	einfo "Building node-gyp@${NODE_GYP_VER}"
	pushd ${NODE_GYP_DIR}
	echo "yarn-offline-mirror \"${YARN_FILES_DIR}\"" > ${YARN_CONFIG}
	local YARN_CMD_OPTIONS="--cache-folder ${YARN_CACHE_DIR} --use-yarnrc ${YARN_CONFIG}  --non-interactive --offline --no-pregess"
	
	npm_config_build_from_source=true \
		npm_config_nodedir=/usr/include/node \
		yarn install ${YARN_CMD_OPTIONS}|| die "Node GYP installation failed"
	popd > /dev/null
}
yarn_src_compile(){
	# Setting up variables
	local NODE_GYP_DIR=${WORKDIR}/node_gyp
	local YARN_FILES_DIR=${WORKDIR}/.nodejs_files
	#local YARN_CACHE_DIR=${WORKDIR}/.yarn_cache
	local YARN_CONFIG=${WORKDIR}/.yarnrc
	export YARN_CACHE_DIR="${WORKDIR}/yarn_cache"

	local YARN_CMD_OPTIONS="--cache-folder ${YARN_CACHE_DIR} --use-yarnrc ${YARN_CONFIG}  --non-interactive --offline --no-pregess"
	if [[ ${NODE_GYP_VER} != "" ]] ; then
		npm_config_build_from_source=true \
			npm_config_nodedir=/usr/include/node \
			npm_config_node_gyp=${NODE_GYP_DIR}/bin/node-gyp.js \
			yarn install ${YARN_CMD_OPTIONS} || die "installation failed"
		else
			yarn install ${YARN_CMD_OPTIONS} || die "installation failed"
	fi
	}
fi
