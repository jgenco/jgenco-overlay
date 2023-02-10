# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: deno.eclass
# @MAINTAINER:
# $ECHANGELOG_USER
# @AUTHOR:
# $ECHANGELOG_USER
# @SUPPORTED_EAPIS: 8
# @BLURB: Provides support functions for Deno
# @DESCRIPTION:
# Provides functions for downloading and building Deno's cache

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

if [[ ! ${_DENO_ECLASS} ]]; then
_DENO_ECLASS=1
DENO_SRC="${WORKDIR}/deno_src"
DENO_CACHE="${WORKDIR}/deno_cache"
export DENO_DIR=${DENO_CACHE}

DENO_VER_REGEX="((@.*/)?[^@]*)@(([^@ ]*))?"
deno_build_src_uri() {
	for line in "${DENO_LIBS[@]}"; do
		local package_full url start_folder action index
		read -r package_full url start_folder action index <<< "${line}"
		local package version url filename
		[[ ${package_full} =~ ${DENO_VER_REGEX} ]]
		package=${BASH_REMATCH[1]}
		version=${BASH_REMATCH[4]}
		url="${url/_VER_/${version}}"
		filename="deno_${package/\//_}@${version}.tar.gz"

		if [[ ${url} =~ "https://" ]];then
			echo "${url} -> ${filename#@} "
			
		fi
	done
}
deno_src_unpack() {
	einfo "Setting up DENO_SRC/DENO_CACHE"
	mkdir ${DENO_CACHE}
	mkdir ${DENO_SRC}
	for line in "${DENO_LIBS[@]}"; do
		local package_full url start_folder action index
		read -r package_full url start_folder action index <<< "${line}"
		local start_folder ln_suffix new_dir
		[[ ${package_full} =~ ${DENO_VER_REGEX} ]]
		local package=${BASH_REMATCH[1]}
		local version=${BASH_REMATCH[4]}
		local start_folder=${start_folder/_VER_/${version#v}}
		local package_path="${FILESDIR}/deno_${package/\//_}@${version}.tar.gz"
		local package_dest="${DENO_SRC}/${package/\//_}-${version}"
		case ${action} in
		"build")
			ln -s "${WORKDIR}/${start_folder}" "${DENO_SRC}/${package/\//_}-${version#v}.orig" ||die
			mkdir ${DENO_SRC}/${package/\//_}-${version}||die;;
		"bundle"|"special_bundle")
			ln -s "${WORKDIR}/${start_folder}" "${DENO_SRC}/${package/\//_}-${version#v}.orig" ||die
			mkdir ${DENO_SRC}/${package/\//_}-${version}||die;;
		"NA")
			ln -s "${WORKDIR}/${start_folder}" "${DENO_SRC}/${package/\//_}-${version#v}"||die;;
		*) die "Unknown action - ${action} for package ${package_full}"||die;;
		esac
	done
}
deno_build_src() {
	einfo "Building Source Files..."
	for line in "${DENO_LIBS[@]}"; do
		local package_full url start_folder action index
		read -r package_full url start_folder action index <<< "${line}"
		local start_folder
		[[ ${package_full} =~ ${DENO_VER_REGEX} ]]
		package=${BASH_REMATCH[1]}
		version=${BASH_REMATCH[4]}
		start_folder=${start_folder/_VER_/${version#v}}
		case ${action} in
		"build")
		esbuild ${DENO_SRC}/${package/\//_}-${version#v}.orig${index} --format=esm --outdir=${DENO_SRC}/${package/\//_}-${version#v}||die;;

		"bundle")
		esbuild ${DENO_SRC}/${package/\//_}-${version#v}.orig${index}  --format=esm --bundle --outfile=${DENO_SRC}/${package/\//_}-${version#v}/${package}.js || die;;

		"NA"|"special_bundle");;

		*) die "Unknown action - ${action} for package ${package_full}";;
		esac
	done
}
deno_build_cache() {
	einfo "Building Deno cache..."
	#declare -A DENO_PKG_HASH=(["acorn-7.4.1"]="aIeX4aKa0RO2JeS9dtPa")
	# curl https://cdn.skypack.dev/moment-guess@1.2.4?meta | sed "s/,/\n,/g"|grep buildId
	#NOTE: the key is the FOLDER
	#      dashes instead of @
	
	regex="(https?)://([^/]+)(/(./)?((@[^/]*/)?[^/]+)@([^/]+)(/.*)?)"
	TIME=`date +%s`
	compute_folder(){
		PACKAGE=${1}
		echo "${PACKAGE}"
	}
	while read -r line
	do
		[[ ${line} =~ ${regex} ]]
		local protocol=${BASH_REMATCH[1]}
		local host=${BASH_REMATCH[2]}

		local package=${BASH_REMATCH[5]}
		local version=${BASH_REMATCH[7]}
		local addr=${BASH_REMATCH[3]}

		local fpath=${BASH_REMATCH[8]}
		local sha256=$(echo -n "${addr}"| sha256sum)
		local sha256=${sha256:0:64}

		local file_source=${DENO_SRC}/${addr}

		mkdir -p ${DENO_CACHE}/deps/${protocol}/${host}

		local file="${DENO_CACHE}/deps/${protocol}/${host}/${sha256}"
		local file_meta="${file}.metadata.json"
		local folder="${package}-${version#v}"
		local fullpath="${DENO_SRC}/${folder/\//_}${fpath}"
		local filecontents=""
		local checkfile=""
		#https://cdn.skypack.dev/dayjs@1.8.21/dayjs.min.js
		#https://cdn.skypack.dev/-/dayjs@v1.8.21-6syVEc6qGP8frQXKlmJD/dist=es2019,mode=imports/optimized/dayjs.js
		if [[ ${host} == "cdn.skypack.dev" ]]; then
			if [[ ${fpath} == ""  ]]; then
				#This gets no {default} except blueimp posibly b/c it has export default ...
				filecontents="/-/${package}@v${version#v}-${DENO_PKG_HASH[${folder}]}/dist=es2019,mode=imports/optimized/${package}.js"
				checkfile="${DENO_SRC}/${folder/\//_}/${package/\//_}.js"
			#Special case until more info
			elif [[ ${fpath} == "/dayjs.min.js" ]]; then
				filecontents="/-/${package}@v${version}-${DENO_PKG_HASH[${folder}]}/dist=es2019,mode=imports/optimized/${package}.js"
				checkfile="${DENO_SRC}/${folder/\//_}/${package}.js"
			elif [[ ${addr} =~ /-/.*optimized/(.*) ]]; then
				version="${version:1:-21}"
				fullpath="${DENO_SRC}/${package/\//_}-${version#v}/${BASH_REMATCH[1]/\//_}"
			else
				filecontents="/-/${package}@v${version#v}-${DENO_PKG_HASH[${folder}]}/dist=es2019,mode=imports/unoptimized${fpath}.js"
				checkfile="${DENO_SRC}/${folder/\//_}/${fpath}.js"
			fi
		fi
		if [[ ${host} == "deno.land" ]]; then
			cp ${fullpath} ${file} || die
			echo -n "{\"headers\": {},\"url\": \"${line}\",\"now\": {\"secs_since_epoch\": ${TIME},\"nanos_since_epoch\": 0}}" > ${file_meta} || die
		elif [[ ${host} == "cdn.skypack.dev" ]]; then
			if [[ ${filecontents} == "" ]];then
				cp ${fullpath} ${file} || die
			else
				echo "export * from '${filecontents}';" > ${file} || die
				if grep -E "(export|as) default" ${checkfile} > /dev/null; then
					echo  "export {default} from '${filecontents}';" >> ${file} || die
				fi
			fi
			echo -n "{\"headers\": {\"content-type\":\"application/javascript; charset=utf-8\"},
				\"url\": \"${line}\",\"now\": {\"secs_since_epoch\": ${TIME},\"nanos_since_epoch\": 0}}" > ${file_meta}||die
		fi

	done < <(cat "${DENO_IMPORT_LIST}")

}
fi
