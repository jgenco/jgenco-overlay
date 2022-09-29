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
NPM_CACHE_DIR="${WORKDIR}/node_cache"
npm_build_src_uri(){
	local gitex='(github):\/\/(.+)\/(.+)#([0-9a-f]+)'
	local regex='((.*\/)?(.*))@(.*)'
	local file_ext="tgz"
	local pkgs=${@}
	for pkg in ${pkgs}
	do
		if [[ ${pkg} =~ ${gitex} ]]; then
			local pkg_gitserver=${BASH_REMATCH[1]}
			local pkg_usr=${BASH_REMATCH[2]}
			local pkg_prj=${BASH_REMATCH[3]}
			local pkg_commit=${BASH_REMATCH[4]}
			local pkg_url="https://${pkg_gitserver}.com/${pkg_usr}/${pkg_prj}/archive/${pkg_commit}.tar.gz"
			local pkg_fn="node_${pkg_usr}+${pkg_prj}@${pkg_commit}.${file_ext}"
			echo "${pkg_url} -> ${pkg_fn}"
			continue
		fi
		if [[ ${pkg} =~ ${regex} ]];then
			local npm_name_full=${BASH_REMATCH[1]}
			local npm_name=${BASH_REMATCH[3]}
			local npm_ver=${BASH_REMATCH[4]}
			local npm_filename="${npm_name}-${npm_ver}.${file_ext}"
			#add node_ change / to + b/c + is an invalid nodejs package char
			local npm_filename_save="node_${npm_name_full/\//+}@${npm_ver}.${file_ext}"
			echo "mirror://npm/${npm_name_full}/-/${npm_filename} -> ${npm_filename_save/\//-}"
			continue
		fi
		die "NO regex found for packages"
	done
}
npm_src_unpack(){
	mkdir ${NPM_CACHE_DIR}
	for ARCHIVE in ${A}; do
		case ${ARCHIVE} in
			# future NODE_GYP
			(node_node-gyp@${NODE_GYP_VER}*)
				if [[ ${NODE_GYP_VER} != "" ]];then
					unpack ${ARCHIVE}
					mv package node_gyp
				fi;;
			(node_*)
				#ln -s ${DISTDIR}/${ARCHIVE} ${NPM_CACHE_DIR}/${ARCHIVE#node_}
				:;;
		esac
	done
}
npm_build_cache(){
	#NOTE this dosn't account for git+ssh:// urls

	cur_time=$(date +%s)
	mkdir -p ${NPM_CACHE_DIR}
	mkdir -p ${NPM_CACHE_DIR}/_cacache
	echo "${cur_time}" > ${NPM_CACHE_DIR}/_cacache/_lastverified
	touch ${NPM_CACHE_DIR}/update-notifier-last-checked
	einfo "Building NPM cache..."
	for PKG in ${@};do
		regex='((.*\/)?(.*))@(.*)'
		[[ ${PKG} =~ ${regex} ]]
			local npm_name_full=${BASH_REMATCH[1]}
			local npm_scope=${BASH_REMATCH[2]}
			local npm_name=${BASH_REMATCH[3]}
			local npm_ver=${BASH_REMATCH[4]}
			local file_ext="tgz"
			local npm_filename="${npm_name}-${npm_ver}.${file_ext}"
			local npm_filename_save="node_${npm_name_full/\//+}@${npm_ver}.${file_ext}"

			pkg_path=""
			if [[ -f "${DISTDIR}/${npm_filename_save}" ]];then
				pkg_path="${DISTDIR}/${npm_filename_save}"
			else
				echo "${npm_filename_save}"
				echo "Not Found"
				die
			fi
			local pkg_size=$(wc -c ${pkg_path}| sed "s/ .*//")
			local pkg_sha1=$(sha1sum ${pkg_path}| sed "s/ .*//")
			local pkg_sha1_b64=$(echo ${pkg_sha1} | xxd -r -p|base64)
			#local pkg_sha512_b64=$(sha512sum $pkg_path |sed "s/ .*//"|xxd -r -p|base64 -w0)
			local pkg_sha512=$(sha512sum $pkg_path |sed "s/ .*//")
			local pkg_sha512_b64=$(echo -n ${pkg_sha512}|xxd -r -p|base64 -w0)
			local pkg_url="https://registry.npmjs.org/${npm_scope}${npm_name}/-/${npm_name}-${npm_ver}.tgz"
			local npm_cache_idx="${NPM_CACHE_DIR}/_cacache/index-v5"
			local npm_cache_cnt="${NPM_CACHE_DIR}/_cacache/content-v2"
			local npm_url="make-fetch-happen:request-cache:${pkg_url}"

			local npm_url_sha256=$(echo -n  ${npm_url} |sha256sum | sed "s/ .*//")
			local npm_pkg_idx_path="${npm_cache_idx}/${npm_url_sha256:0:2}/${npm_url_sha256:2:2}"
			mkdir -p ${npm_pkg_idx_path}
			npm_pkg_idx_path+="/${npm_url_sha256:4:60}"

			local npm_pkg_cnt_path_sha_512="${npm_cache_cnt}/sha512/${pkg_sha512:0:2}/${pkg_sha512:2:2}"
			mkdir -p ${npm_pkg_cnt_path_sha_512}
			npm_pkg_cnt_path_sha_512+="/${pkg_sha512:4:124}"

			local npm_pkg_cnt_path_sha_1="${npm_cache_cnt}/sha1/${pkg_sha1:0:2}/${pkg_sha1:2:2}"
			mkdir -p ${npm_pkg_cnt_path_sha_1}
			npm_pkg_cnt_path_sha_1+="/${pkg_sha1:4:36}"

			local npm_cache_file=${npm_cache_idx}/${pkg_sha}

			local meta_data="{\"key\":\"${npm_url}\",\"integrity\":\"sha512-${pkg_sha512_b64}\",\"time\":${cur_time}000,\"size\":${pkg_size}"
			meta_data+=",\"metadata\":{\"time\":${cur_time}000}"
			meta_data+="}"
			local meta_data_sha1=$(echo -n $meta_data | sha1sum| sed "s/ .*//")
			echo -ne "\n${meta_data_sha1}\t${meta_data}" >> ${npm_pkg_idx_path}

			meta_data="{\"key\":\"${npm_url}\",\"integrity\":\"sha1-${pkg_sha1_b64}\",\"time\":${cur_time}000,\"size\":${pkg_size}"
			meta_data+=",\"metadata\":{\"time\":${cur_time}000}"
			meta_data+="}"
			meta_data_sha1=$(echo -n $meta_data | sha1sum| sed "s/ .*//")
			echo -ne "\n${meta_data_sha1}\t${meta_data}" >> ${npm_pkg_idx_path}

			ln -s ${pkg_path} ${npm_pkg_cnt_path_sha_512}
			ln -s ${pkg_path} ${npm_pkg_cnt_path_sha_1}
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
