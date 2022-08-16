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
DENO_LINE_REGEX="((@.*/)?[^@]*)@(([^@ ]*))? +(.*) +(.*) +(.*) +(.*)"
deno_build_src_uri(){
	for (( i = 0; i < ${#DENO_LIBS[@]}; i++ ));do
		[[ ${DENO_LIBS[$i]} =~ ${LINE_REGEX} ]]
		PACKAGE=${BASH_REMATCH[1]}
		VERSION=${BASH_REMATCH[4]}
		URL="${BASH_REMATCH[5]/_VER_/${VERSION}}"
		START_FOLDER=${BASH_REMATCH[6]/_VER_/${VERSION}}
		ACTION=${BASH_REMATCH[7]}
		SOURCE=${BASH_REMATCH[8]}
		FILENAME="${PACKAGE/\//_}@${VERSION}.tar.gz"

		if [[ ${URL} =~ "https://" ]];then
			echo "${URL} -> ${FILENAME#@}"
	#	else
	#		echo "${PACKAGE}@@@${VERSION} links to ${URL}"
		fi
	#	echo "${START_FOLDER} -> ${PACKAGE/\//_}-${VERSION}"
	#	echo "$START_FOLDER $ACTION $SOURCE"
	#	echo ""
	#done
	done
}
deno_src_unpack(){
	einfo "Setting up DENO_SRC/DENO_CACHE"
	mkdir ${DENO_CACHE}
	mkdir ${DENO_SRC}
	for (( i = 0; i < ${#DENO_LIBS[@]}; i++ ));do
		if [[ ${DENO_LIBS[$i]} == "" ]];then continue; fi;
		[[ ${DENO_LIBS[$i]} =~ ${LINE_REGEX} ]]
		PACKAGE=${BASH_REMATCH[1]}
		VERSION=${BASH_REMATCH[4]}
		START_FOLDER=${BASH_REMATCH[6]/_VER_/${VERSION#v}}
		ACTION=${BASH_REMATCH[7]}
		case ${ACTION} in
		"build")
			ln -s "${WORKDIR}/${START_FOLDER}" "${DENO_SRC}/${PACKAGE/\//_}-${VERSION#v}.orig"
			mkdir ${DENO_SRC}/${PACKAGE/\//_}-${VERSION};;
		"bundle"|"special_bundle")
			ln -s "${WORKDIR}/${START_FOLDER}" "${DENO_SRC}/${PACKAGE/\//_}-${VERSION#v}.orig"
			mkdir ${DENO_SRC}/${PACKAGE/\//_}-${VERSION};;
		"NA")
			ln -s "${WORKDIR}/${START_FOLDER}" "${DENO_SRC}/${PACKAGE/\//_}-${VERSION#v}";;
		*) die "Unknown action - ${ACTION} for package ${PACKAGE}";;
		esac
	done
}
deno_build_src(){
	einfo "Building Source Files..."

	for (( i = 0; i < ${#DENO_LIBS[@]}; i++ ));do
		if [[ ${DENO_LIBS[$i]} == "" ]];then continue; fi;
		[[ ${DENO_LIBS[$i]} =~ ${LINE_REGEX} ]]
		PACKAGE=${BASH_REMATCH[1]}
		VERSION=${BASH_REMATCH[4]}
		START_FOLDER=${BASH_REMATCH[6]/_VER_/${VERSION#v}}
		ACTION=${BASH_REMATCH[7]}
		SOURCE=${BASH_REMATCH[8]}
		case ${ACTION} in
		"build")
		esbuild ${DENO_SRC}/${PACKAGE/\//_}-${VERSION#v}.orig${SOURCE} --format=esm --outdir=${DENO_SRC}/${PACKAGE/\//_}-${VERSION#v}||die;;

		"bundle")
		esbuild ${DENO_SRC}/${PACKAGE/\//_}-${VERSION#v}.orig${SOURCE}  --format=esm --bundle --outfile=${DENO_SRC}/${PACKAGE/\//_}-${VERSION#v}/${PACKAGE}.js || die;;

		"NA"|"special_bundle");;

		*) die "Unknown action - ${ACTION} for package ${PACKAGE}";;
		esac
	done
}
deno_build_cache(){
	einfo "Building Deno cache..."
	# curl https://cdn.skypack.dev/moment-guess@1.2.4?meta | sed "s/,/\n,/g"|grep buildId
	#NOTE: the key is the FOLDER
	#      dashes instead of @
	declare -A pkg_hash=(
	["acorn-7.4.1"]="aIeX4aKa0RO2JeS9dtPa"
	["acorn-walk-7.2.0"]="HE7wS37ePcNncqJvsD8k"
	["ansi_up-5.1.0"]="ifIRWFhqTFJbTEKi2tZH"
	["blueimp-md5-2.19.0"]="FsBtHB6ITwdC3L5Giq4Q"
	["dayjs-1.8.21"]="6syVEc6qGP8frQXKlmJD"
	["diff-5.0.0"]="cU62LaUh1QZHrLzL9VHS"
	["lodash-4.17.21"]="K6GEbP02mWFnLA45zAmi"
	["moment-guess-1.2.4"]="bDXl7KQy0hLGNuGhyGb4"
	["@observablehq/parser-4.5.0"]="rWZiNfab8flhVomtfVvr"
	)
	regex="(https?)://([^/]+)(/(./)?((@[^/]*/)?[^/]+)@([^/]+)(/.*)?)"
	TIME=`date +%s`
	compute_folder(){
		PACKAGE=${1}
		echo "${PACKAGE}"
	}
	while read -r line
	do
		[[ ${line} =~ ${regex} ]]
		PROTOCOL=${BASH_REMATCH[1]}
		HOST=${BASH_REMATCH[2]}

		PACKAGE=${BASH_REMATCH[5]}
		VERSION=${BASH_REMATCH[7]}
		ADDR=${BASH_REMATCH[3]}

		FPATH=${BASH_REMATCH[8]}
		SHA256=$(echo -n "${ADDR}"| sha256sum)
		SHA256=${SHA256%  -}

		FILE_SOURCE=${DENO_SRC}/${ADDR}

		mkdir -p ${DENO_CACHE}/deps/${PROTOCOL}/${HOST}

		FILE="${DENO_CACHE}/deps/${PROTOCOL}/${HOST}/${SHA256}"
		FILE_META="${FILE}.metadata.json"
		FOLDER="${PACKAGE}-${VERSION#v}"
		FULLPATH="${DENO_SRC}/${FOLDER/\//_}${FPATH}"
		FILECONTENTS=""
		CHECKFILE=""
		#https://cdn.skypack.dev/dayjs@1.8.21/dayjs.min.js
		#https://cdn.skypack.dev/-/dayjs@v1.8.21-6syVEc6qGP8frQXKlmJD/dist=es2019,mode=imports/optimized/dayjs.js
		if [[ ${HOST} == "cdn.skypack.dev" ]]; then
			if [[ ${FPATH} == ""  ]]; then
				#This gets no {default} except blueimp posibly b/c it has export default ...
				FILECONTENTS="/-/${PACKAGE}@v${VERSION#v}-${pkg_hash[${FOLDER}]}/dist=es2019,mode=imports/optimized/${PACKAGE}.js"
				CHECKFILE="${DENO_SRC}/${FOLDER/\//_}/${PACKAGE/\//_}.js"
			#Special case until more info
			elif [[ ${FPATH} == "/dayjs.min.js" ]]; then
				FILECONTENTS="/-/${PACKAGE}@v${VERSION}-${pkg_hash[${FOLDER}]}/dist=es2019,mode=imports/optimized/${PACKAGE}.js"
				CHECKFILE="${DENO_SRC}/${FOLDER/\//_}/${PACKAGE}.js"
			elif [[ ${ADDR} =~ /-/.*optimized/(.*) ]]; then
				VERSION="${VERSION:1:-21}"
				FULLPATH="${DENO_SRC}/${PACKAGE/\//_}-${VERSION#v}/${BASH_REMATCH[1]/\//_}"
			else
				FILECONTENTS="/-/${PACKAGE}@v${VERSION#v}-${pkg_hash[${FOLDER}]}/dist=es2019,mode=imports/unoptimized${FPATH}.js"
				CHECKFILE="${DENO_SRC}/${FOLDER/\//_}/${FPATH}.js"
			fi
		fi

		if [[ ${HOST} == "deno.land" ]]; then
			#Populate Data
			cp ${FULLPATH} ${FILE}
			echo -n "{\"headers\": {},\"url\": \"${line}\",\"now\": {\"secs_since_epoch\": ${TIME},\"nanos_since_epoch\": 0}}" > ${FILE_META}
		elif [[ ${HOST} == "cdn.skypack.dev" ]]; then
			if [[ ${FILECONTENTS} == "" ]];then
				cp ${FULLPATH} ${FILE}
			else
				echo "export * from '${FILECONTENTS}';" > ${FILE}
				if grep -E "(export|as) default" ${CHECKFILE} > /dev/null; then
					echo  "export {default} from '${FILECONTENTS}';" >> ${FILE}
				fi
			fi
			echo -n "{\"headers\": {\"content-type\":\"application/javascript; charset=utf-8\"},
				\"url\": \"${line}\",\"now\": {\"secs_since_epoch\": ${TIME},\"nanos_since_epoch\": 0}}" > ${FILE_META}
		fi

	done < <(cat "${DENO_IMPORT_LIST}")

}
fi
