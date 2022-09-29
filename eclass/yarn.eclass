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
export YARN_CACHE_DIR="${WORKDIR}/yarn_cache"
YARN_CONFIG=${WORKDIR}/.yarnrc
YARN_CMD_OPTIONS="--cache-folder ${YARN_CACHE_DIR} --use-yarnrc ${YARN_CONFIG}  --non-interactive --offline --no-pregess"
YARN_FILES_DIR=${WORKDIR}/.nodejs_files
NODE_GYP_DIR=${WORKDIR}/node_gyp
NODE_GYP_FILE=""

yarn_build_cache(){
	einfo "Building Yarn cache..."
	mkdir -p ${YARN_CACHE_DIR}
	for PKG in ${@};do
		regex='((.*\/)?(.*))@(.*)'
		[[ ${PKG} =~ ${regex} ]]
			local yarn_name_full=${BASH_REMATCH[1]}
			local yarn_scope=${BASH_REMATCH[2]}
			local yarn_name=${BASH_REMATCH[3]}
			local yarn_ver=${BASH_REMATCH[4]}
			local file_ext="tgz"
			local yarn_filename="${yarn_name}-${yarn_ver}.${file_ext}"
			local yarn_filename_save="node_${yarn_name_full/\//+}@${yarn_ver}.${file_ext}"
			
			local pkg_path=""
			if [[ -f "${DISTDIR}/${yarn_filename_save}" ]];then
				pkg_path="${DISTDIR}/${yarn_filename_save}"
			else
				echo "${yarn_filename_save}"
				echo "Not Found"
				exit
			fi
			local pkg_size=$(wc -c ${pkg_path}| sed "s/ .*//")
			local pkg_sha1=$(sha1sum ${pkg_path}| sed "s/ .*//")
			local pkg_sha1_b64=$(echo ${pkg_sha1} | xxd -r -p|base64)
			local pkg_sha512=$(sha512sum $pkg_path |sed "s/ .*//")
			local pkg_sha512_b64=$(echo -n ${pkg_sha512}|xxd -r -p|base64 -w0)
			local yarn_name_DEST=${yarn_name//[._]/-}
			local yarn_name_DEST=${yarn_name_DEST//--/-}
			local pkg_dest="${YARN_CACHE_DIR}/v6/npm-${yarn_scope/\//-}${yarn_name_DEST}-${yarn_ver}-${pkg_sha1}-integrity"
			local pkg_url="https://registry.npmjs.org/${yarn_scope}${yarn_name}/-/${yarn_name}-${yarn_ver}.tgz"
			mkdir -p ${pkg_dest}/node_modules/${yarn_scope}
			#echo "${yarn_scope} - ${yarn_name} @ ${yarn_ver} "
			#echo "$pkg_path -> ${pkg_dest}"
			mkdir -p ${pkg_dest}/unpack
			#no-unknown-keyword disables the warning  Ignoring unknown extended header keyword 'foo'
			tar xzf ${pkg_path} -C ${pkg_dest}/unpack --warning=no-unknown-keyword || die "Failed to extract tarball"
			if [[ -d ${pkg_dest}/unpack/package ]];then
				mv ${pkg_dest}/unpack/package ${pkg_dest}/node_modules/${yarn_scope}/${yarn_name} || die "Failed to move 1"
			else
				local yarn_folder_name=(${pkg_dest}/unpack/*)
				[[ ${yarn_folder_name[0]} == "${pkg_dest}/unpack/*" ]] && die "Oops"
				#echo ${#yarn_folder_name[@]} - ${yarn_folder_name}
				if [[ 1 -eq ${#yarn_folder_name[@]} ]];then
					mv "${yarn_folder_name[0]}" "${pkg_dest}/node_modules/${yarn_scope}/${yarn_name}" || die "Failed to move 2"
				else
					die "Failed to move n"
				fi
			fi
			rmdir ${pkg_dest}/unpack || die "Failed to remove unpack dir"
			#build ${pkg_dest}/${yarn_name}/.yarn-metadata.json
			cat <<_EOF_ > ${pkg_dest}/node_modules/${yarn_scope}/${yarn_name}/.yarn-metadata.json
			{"remote":{
			"hash": "${pkg_sha1}",
			"integrity":"sha512-${pkg_sha512_b64}",
			"cacheIntegrity": "sha512-${pkg_sha512_b64} sha1-${pkg_sha1_b64}"}}
_EOF_
	done
	einfo "Finished building Yarn cache"
}
yarn_set_config(){
	[[ -z $1 || -z $2 ]]  && die "Missing argument(s) for yarn_set_config"
	yarn config set ${1} ${2} ${YARN_CMD_OPTIONS} || die "Failed to set ${1}"
}
yarn_src_prepare_gyp(){
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

	einfo "Building node-gyp@${NODE_GYP_VER}"
	pushd ${NODE_GYP_DIR}
	echo "yarn-offline-mirror \"${YARN_FILES_DIR}\"" > ${YARN_CONFIG}
	
	yarn_src_compile
	if [[ -f bin/node-gyp.js ]]; then
		NODE_GYP_FILE="${NODE_GYP_DIR}/bin/node-gyp.js"
	else
		die "Failed to find Node GYP"
	fi

	popd > /dev/null
}
yarn_src_compile(){
	if [[ ${NODE_GYP_FILE} != "" ]] ; then
			npm_config_build_from_source=true \
				npm_config_nodedir=/usr/include/node \
				npm_config_node_gyp=${NODE_GYP_FILE} \
				yarn install ${YARN_CMD_OPTIONS} || die "installation failed"
		else
			npm_config_build_from_source=true \
				npm_config_nodedir=/usr/include/node \
				yarn install ${YARN_CMD_OPTIONS} || die "installation failed"
	fi
}
fi
