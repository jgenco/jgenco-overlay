# Copyright 2023 Gentoo Authors
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
YARN_CONFIG="${WORKDIR}/.yarnrc"
YARN_CMD_OPTIONS="--cache-folder ${YARN_CACHE_DIR} --use-yarnrc ${YARN_CONFIG}  --non-interactive --offline --no-pregess"
YARN_FILES_DIR="${WORKDIR}/.nodejs_files"
YARN_LOCK_FILE=""
NODE_GYP_DIR="${WORKDIR}/node_gyp"
NODE_GYP_FILE=""

yarn_check_pkg_hash() {
	good_match="FALSE"
	bad_match="FALSE"
	while read -r line ;do
		[[ ${line} == "package:${1}   integrity sha1-${2}"   ]] && good_match="TRUE" && continue
		[[ ${line} == "package:${1}   integrity sha512-${3}" ]] && good_match="TRUE" && continue
		bad_match="TRUE"
	done < <(grep  "^package:${1}   integrity " "${YARN_CACHE_DIR}/yarnlines")
	#all good
	[[ ${good_match} == "TRUE" && ${bad_match} == "FALSE" ]] && 
		return
	#didn't find package
	[[ ${good_match} == "FALSE" && ${bad_match} == "FALSE" ]] && 
		einfo "Failed to find package $1" &&  return
	[[ ${good_match} == "TRUE" && ${bad_match} == "TRUE" ]] && 
		einfo "Found competing hashes for package $1"

	echo "package:${1}       \"integrity\": \"sha1-${2}\","
	echo "package:${1}       \"integrity\": \"sha512-${3}\","
	die "Package $1 hash failed to match yarn.lock files(s)"
}

yarn_build_cache() {
	einfo "Building Yarn cache..."
	mkdir -p ${YARN_CACHE_DIR} || die "Failed to create yarn cache dir"

	check_lock_file=""
	for yarn_lock in ${YARN_LOCK_FILE};do
		[[ -f ${yarn_lock} ]] || die "${yarn_lock} not a file"
		einfo "Checking lockfile: $yarn_lock"
		check_lock_file="TRUE"
	done

	if [[ ${check_lock_file} == "TRUE" ]];then
		einfo "Checking yarn lock file(s)"
		sed "s#.*https://[^\/]\+/\([^/]*/\)\?\(.*\)/-/\(\2\)-\(.*\).*.tgz.*#package:\1\2@\4#" "${YARN_LOCK_FILE}" |
			grep  -E "^(package:|  integrity)"| paste -s -d' \n' > "${YARN_CACHE_DIR}/yarnlines" ||
			die "Failed to create yarnlines"
		#"
	else
		einfo "NOT Checking yarn lock file(s)"
	fi

	for pkg in ${@};do
		regex='((.*\/)?(.*))@(.*)'
		[[ ${pkg} =~ ${regex} ]]
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

			[[ ${check_lock_file} == "TRUE" ]] && 
				yarn_check_pkg_hash "${yarn_name_full}@${yarn_ver}" ${pkg_sha1_b64} ${pkg_sha512_b64}

			local yarn_name_DEST=${yarn_name//[._]/-}
			local yarn_name_DEST=${yarn_name_DEST//--/-}
			#remove all capital letters?
			local yarn_name_DEST=${yarn_name_DEST//[A-Z]/}
			local pkg_dest="${YARN_CACHE_DIR}/v6/npm-${yarn_scope/\//-}${yarn_name_DEST}-${yarn_ver}-${pkg_sha1}-integrity"
			local pkg_dest_ln="${YARN_CACHE_DIR}/v6/npm-${yarn_scope/\//-}${yarn_name_DEST}-${yarn_ver}-integrity"
			local pkg_url="https://registry.npmjs.org/${yarn_scope}${yarn_name}/-/${yarn_name}-${yarn_ver}.tgz"
			mkdir -p "${pkg_dest}/node_modules/${yarn_scope}/${yarn_name}" || die "Failed to create node_modules folder"
			ln -s ${pkg_dest} ${pkg_dest_ln} || die "Failed to link the two directories"
			#echo "${yarn_scope} - ${yarn_name} @ ${yarn_ver} "
			#echo "$pkg_path -> ${pkg_dest}"
			#echo "${pkg_dest}/node_modules/${yarn_scope}/${yarn_name}"
			#no-unknown-keyword disables the warning  Ignoring unknown extended header keyword 'foo'
			tar xzf ${pkg_path} -C "${pkg_dest}/node_modules/${yarn_scope}/${yarn_name}" --warning=no-unknown-keyword --strip-components=1 || die "Failed to extract tarball"
			#build ${pkg_dest}/${yarn_name}/.yarn-metadata.json
			cat <<_EOF_ > ${pkg_dest}/node_modules/${yarn_scope}/${yarn_name}/.yarn-metadata.json
			{"remote":{
			"hash": "${pkg_sha1}",
			"integrity":"sha512-${pkg_sha512_b64}",
			"cacheIntegrity": "sha512-${pkg_sha512_b64} sha1-${pkg_sha1_b64}"}}
_EOF_
	done
	einfo "Finished building Yarn cache"
	touch ${YARN_CONFIG}
	[[ ${check_lock_file} == "TRUE" ]] && ( rm ${YARN_CACHE_DIR}/yarnlines || die "Failed to delete yarnlines" )
}
yarn_set_config() {
	[[ -z $1 || -z $2 ]]  && die "Missing argument(s) for yarn_set_config"
	yarn config set ${1} ${2} ${YARN_CMD_OPTIONS} || die "Failed to set ${1}"
}
yarn_set_gyp_file() {
	local node_gyp_file_temp=""
	local bin_path="bin/node-gyp.js"

	if [[ -z $1 ]];then
		node_gyp_file_temp="/usr/$(get_libdir)/node_modules/node-gyp/${bin_path}"
		[[ -f "${node_gyp_file_temp}" ]] &&	NODE_GYP_FILE="${node_gyp_file_temp}" || die "Failed to find system node-gyp bin"
	else
		[[ ! -d $1 ]] && die "${1} NOT a directory"

		node_gyp_file_temp="${1}/${bin_path}"
		[[ -f "${node_gyp_file_temp}" ]] && NODE_GYP_FILE="${node_gyp_file_temp}" || die "Failed to find ${node_gyp_file_temp}"
	fi
	einfo "node-gyp file located at ${NODE_GYP_FILE}"
}
yarn_src_prepare_gyp() {
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
yarn_src_compile_gyp() {
	[[ $NODE_GYP_VER} != "" ]] || return

	einfo "Building node-gyp@${NODE_GYP_VER}"
	pushd ${NODE_GYP_DIR} > /dev/null
	echo "yarn-offline-mirror \"${YARN_FILES_DIR}\"" > ${YARN_CONFIG}
	
	yarn_src_compile
	if [[ -f bin/node-gyp.js ]]; then
		yarn_set_gyp_file ${NODE_GYP_DIR}
	else
		die "Failed to find Node GYP"
	fi

	popd > /dev/null
}
yarn_cmd() {
	if [[ ${NODE_GYP_FILE} != "" ]] ; then
			npm_config_build_from_source=true \
				npm_config_nodedir=/usr/include/node \
				npm_config_node_gyp=${NODE_GYP_FILE} \
				yarn ${YARN_CMD_OPTIONS} ${@} || die "installation failed"
		else
			npm_config_build_from_source=true \
				npm_config_nodedir=/usr/include/node \
				yarn ${YARN_CMD_OPTIONS} ${@} || die "installation failed"
	fi
}
yarn_src_compile() {
	yarn_cmd install
}
fi
