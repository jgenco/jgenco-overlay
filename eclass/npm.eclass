# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: npm.eclass
# @MAINTAINER:
# $ECHANGELOG_USER
# @AUTHOR:
# $ECHANGELOG_USER
# @SUPPORTED_EAPIS: 8
# @BLURB: Porvides functions for using npm (WIP!)
# @DESCRIPTION:
# npm/yarn simple cache functions for file://__GENTOO_PATH__ lockfiles

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

if [[ ! ${_NPM_ECLASS} ]]; then
_NPM_ECLASS=1
npm_build_src_uri(){
	local SKEIN=$@
	local gitex='(github):\/\/(.+)\/(.+)#([0-9a-f]+)'
	local regex='((.*\/)?(.*))@(.*)'
	local FILE_EXT="tgz"
	for YARN in ${SKEIN}
	do
		if [[ ${YARN} =~ ${gitex} ]]; then
			PKG_GITSERVER=${BASH_REMATCH[1]}
			PKG_USR=${BASH_REMATCH[2]}
			PKG_PRJ=${BASH_REMATCH[3]}
			PKG_COMMIT=${BASH_REMATCH[4]}
			PKG_URL="https://${PKG_GITSERVER}.com/${PKG_USR}/${PKG_PRJ}/archive/${PKG_COMMIT}.tar.gz"
			PKG_FN="node_${PKG_USR}+${PKG_PRJ}@${PKG_COMMIT}.${FILE_EXT}"
			echo "${PKG_URL} -> ${PKG_FN}"
			continue
		fi
		if [[ ${YARN} =~ ${regex} ]];then
			YARN_NAME_FULL=${BASH_REMATCH[1]}
			YARN_NAME=${BASH_REMATCH[3]}
			YARN_VER=${BASH_REMATCH[4]}
			YARN_FILENAME="${YARN_NAME}-${YARN_VER}.${FILE_EXT}"
			#add node_ change / to + b/c + is an invalid nodejs package char
			YARN_FILENAME_SAVE="node_${YARN_NAME_FULL/\//+}@${YARN_VER}.${FILE_EXT}"
			echo "mirror://npm/${YARN_NAME_FULL}/-/${YARN_FILENAME} -> ${YARN_FILENAME_SAVE/\//-}"
			continue
		fi
		die "NO regex found for packages"
	done
}
npm_src_unpack(){
	mkdir ${WORKDIR}/.nodejs_files
	for ARCHIVE in ${A}; do
		case ${ARCHIVE} in
			# future NODE_GYP
			(node_node-gyp@${NODE_GYP_VER}*)
				if [[ ${NODE_GYP_VER} != "" ]];then
					unpack ${ARCHIVE}
					mv package node_gyp
				fi;;
			(node_*)
				ln -s ${DISTDIR}/${ARCHIVE} ${WORKDIR}/.nodejs_files/${ARCHIVE#node_};;
		esac
	done
}
npm_build_cache(){
	#NOTE this dosn't account for git+ssh:// urls
	NODE_CACHE_DIR="${WORKDIR}/node_cache"
	CUR_TIME=$(date +%s)
	mkdir -p ${NODE_CACHE_DIR}
	mkdir -p ${NODE_CACHE_DIR}/_cacache
	echo "${CUR_TIME}" > ${NODE_CACHE_DIR}/_cacache/_lastverified
	touch ${NODE_CACHE_DIR}/update-notifier-last-checked
	einfo "Building NPM cache..."
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
				die
			fi
			PKG_SIZE=$(wc -c ${PKG_PATH}| sed "s/ .*//")
			PKG_SHA1=$(sha1sum ${PKG_PATH}| sed "s/ .*//")
			PKG_SHA1_B64=$(echo ${PKG_SHA1} | xxd -r -p|base64)
			#PKG_SHA512_B64=$(sha512sum $PKG_PATH |sed "s/ .*//"|xxd -r -p|base64 -w0)
			PKG_SHA512=$(sha512sum $PKG_PATH |sed "s/ .*//")
			PKG_SHA512_B64=$(echo -n ${PKG_SHA512}|xxd -r -p|base64 -w0)
			PKG_URL="https://registry.npmjs.org/${YARN_SCOPE}${YARN_NAME}/-/${YARN_NAME}-${YARN_VER}.tgz"
			NPM_CACHE_IDX="${NODE_CACHE_DIR}/_cacache/index-v5"
			NPM_CACHE_CNT="${NODE_CACHE_DIR}/_cacache/content-v2"
			NODE_URL="make-fetch-happen:request-cache:${PKG_URL}"

			NODE_URL_SHA256=$(echo -n  ${NODE_URL} |sha256sum | sed "s/ .*//")
			NODE_PKG_IDX_PATH="${NPM_CACHE_IDX}/${NODE_URL_SHA256:0:2}/${NODE_URL_SHA256:2:2}"
			mkdir -p ${NODE_PKG_IDX_PATH}
			NODE_PKG_IDX_PATH+="/${NODE_URL_SHA256:4:60}"

			NODE_PKG_CNT_PATH_SHA_512="${NPM_CACHE_CNT}/sha512/${PKG_SHA512:0:2}/${PKG_SHA512:2:2}"
			mkdir -p ${NODE_PKG_CNT_PATH_SHA_512}
			NODE_PKG_CNT_PATH_SHA_512+="/${PKG_SHA512:4:124}"

			NODE_PKG_CNT_PATH_SHA_1="${NPM_CACHE_CNT}/sha1/${PKG_SHA1:0:2}/${PKG_SHA1:2:2}"
			mkdir -p ${NODE_PKG_CNT_PATH_SHA_1}
			NODE_PKG_CNT_PATH_SHA_1+="/${PKG_SHA1:4:36}"

			NODE_CACHE_FILE=${NPM_CACHE_IDX}/${PKG_SHA}

			META_DATA="{\"key\":\"${NODE_URL}\",\"integrity\":\"sha512-${PKG_SHA512_B64}\",\"time\":${CUR_TIME}000,\"size\":${PKG_SIZE}"
			META_DATA+=",\"metadata\":{\"time\":${CUR_TIME}000}"
			META_DATA+="}"
			META_DATA_SHA1=$(echo -n $META_DATA | sha1sum| sed "s/ .*//")
			echo -ne "\n${META_DATA_SHA1}\t${META_DATA}" >> ${NODE_PKG_IDX_PATH}

			META_DATA="{\"key\":\"${NODE_URL}\",\"integrity\":\"sha1-${PKG_SHA1_B64}\",\"time\":${CUR_TIME}000,\"size\":${PKG_SIZE}"
			META_DATA+=",\"metadata\":{\"time\":${CUR_TIME}000}"
			META_DATA+="}"
			META_DATA_SHA1=$(echo -n $META_DATA | sha1sum| sed "s/ .*//")
			echo -ne "\n${META_DATA_SHA1}\t${META_DATA}" >> ${NODE_PKG_IDX_PATH}

			ln -s ${PKG_PATH} ${NODE_PKG_CNT_PATH_SHA_512}
			ln -s ${PKG_PATH} ${NODE_PKG_CNT_PATH_SHA_1}
	done
	einfo "Finished building NPM cache"
}
npm_fix_lock_path(){
	#1=source 2=dest 3=die info
	local DIE_INFO=${3}
	[[ ${DIE_INFO} != "" ]] || DIE_INFO=${2}
	sed  "s#__GENTOO_PATH__#${WORKDIR}/.nodejs_files#" ${1} > ${2} ||  die "Building ${DIE_INFO} lockfile failed"
}
fi
