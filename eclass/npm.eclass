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
			#echo "https://registry.yarnpkg.com/${YARN_NAME_FULL}/-/${YARN_FILENAME} -> ${YARN_FILENAME_SAVE/\//-}"
			echo "https://registry.npmjs.org/${YARN_NAME_FULL}/-/${YARN_FILENAME} -> ${YARN_FILENAME_SAVE/\//-}"
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
npm_fix_lock_path(){
	#1=source 2=dest 3=die info
	local DIE_INFO=${3}
	[[ ${DIE_INFO} != "" ]] || DIE_INFO=${2}
	sed  "s#__GENTOO_PATH__#${WORKDIR}/.nodejs_files#" ${1} > ${2} ||  die "Building ${DIE_INFO} lockfile failed"
}
fi
