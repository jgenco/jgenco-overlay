# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"

RESTRICT="mirror"
IUSE="bundle"

DENO_LIBS="
std@0.138.0 https://github.com/denoland/deno_std/archive/refs/tags/_VER_.tar.gz deno_std-_VER_ NA NA
cliffy@v0.24.2 https://github.com/c4spar/deno-cliffy/archive/refs/tags/_VER_.tar.gz deno-cliffy-_VER_ NA NA
deno_dom@v0.1.20-alpha https://github.com/b-fuze/deno-dom/archive/refs/tags/_VER_.tar.gz deno-dom-_VER_ NA NA
events@v1.0.0 https://github.com/deno-library/events/archive/refs/tags/_VER_.tar.gz events-_VER_ NA NA
media_types@v2.10.1 https://github.com/oakserver/media_types/archive/refs/tags/_VER_.tar.gz media_types-_VER_ NA NA
xmlp@v0.2.8 https://github.com/masataka/xmlp/archive/refs/tags/_VER_.tar.gz xmlp-_VER_ NA NA
lodash@4.17.21 https://github.com/lodash/lodash/archive/refs/tags/_VER_.tar.gz lodash-_VER_-es build /*.js
acorn@7.4.1 https://github.com/acornjs/acorn/archive/refs/tags/_VER_.tar.gz acorn-_VER_ bundle /acorn/src/index.js
acorn-walk@7.2.0 https://github.com/acornjs/acorn/archive/refs/tags/_VER_.tar.gz acorn-_VER_ bundle /acorn-walk/src/index.js
diff@5.0.0 https://github.com/kpdecker/jsdiff/archive/refs/tags/v_VER_.tar.gz jsdiff-_VER_ bundle /src/index.js
blueimp-md5@2.19.0 https://github.com/blueimp/JavaScript-MD5/archive/refs/tags/v_VER_.tar.gz JavaScript-MD5-_VER_ bundle /js/md5.js
@observablehq/parser@4.5.0 https://github.com/observablehq/parser/archive/refs/tags/_VER_.tar.gz parser-_VER_ special_bundle special
binary-search-bounds@2.0.5 https://github.com/mikolalysenko/binary-search-bounds/archive/refs/heads/master.tar.gz binary-search-bounds-master bundle /search-bounds.js
moment-guess@1.2.4 https://github.com/apoorv-mishra/moment-guess/archive/refs/tags/v_VER_.tar.gz moment-guess-_VER_ bundle /src/index.js
dayjs@1.8.21 https://github.com/iamkun/dayjs/archive/refs/tags/v_VER_.tar.gz dayjs-_VER_ bundle /src/index.js
"

build_deno_src_uri(){
	#package@version url unpack_folder action from
	LINE_REGEX="((@.*/)?[^@]*)@(([^@ ]*))? +(.*) +(.*) +(.*) +(.*)"
	while read -r line
	do
		[[ ${line} =~ ${LINE_REGEX} ]]
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
	done <<<$DENO_LIBS
}

if [[ "${PV}" == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/quarto-dev/${PN}"
	EGIT_BRANCH="main"
else
	SRC_URI="https://github.com/quarto-dev/quarto-cli/archive/refs/tags/v${PV}.tar.gz   -> ${P}.tar.gz"
fi

SRC_URI="${SRC_URI} bundle? ( $(build_deno_src_uri) )"

#Quarto-cli has third party libraries bundled in their software
#https://github.com/rstudio/bslib/tree/888fbe064491692deb56fd90dc23455052e31073 MIT BSD?
#https://github.com/twbs/icons/tree/v1.8.1/ MIT
#BOOTSWATCH=5.1.3

#https://unpkg.com/anchor-js@4.3.1/anchor.min.js MIT
#https://unpkg.com/@popperjs/core@2.11.4/dist/umd/popper.min.js MIT
#https://github.com/zenorocha/clipboard.js/blob/v2.0.10/dist/clipboard.min.js MIT
#https://unpkg.com/tippy.js@6.3.7/dist/tippy.umd.min.js MIT
#https://github.com/mozilla/pdf.js/tree/v2.8.335 Apache 2.0
#https://github.com/hakimel/reveal.js/tree/4.2.0 MIT
#https://github.com/denehyg/reveal.js-menu/tree/2.1.0 MIT
#https://github.com/rajgoel/reveal.js-plugins/tree/a88c134e2cf3c7780448db003e7329c3cbd8cfb4 MIT
#https://github.com/McShelby/reveal-pdfexport/tree/2.0.1/ MIT
#https://github.com/javve/list.js/tree/v2.3.1/ MIT
#https://github.com/iamkun/dayjs/tree/v1.11.0/ MIT

#https://unpkg.com/@algolia/autocomplete-js@1.5.3/dist/umd/index.production.js MIT
#https://unpkg.com/@algolia/autocomplete-preset-algolia@1.5.3/dist/umd/index.production.js MIT
#https://github.com/krisk/Fuse/tree/v6.5.3 Apache 2.0
#ALGOLIA_SEARCH_JS=4.5.1
#ALGOLIA_SEARCH_INSIGHTS_JS=2.0.3
#https://www.cookieconsent.com/releases/4.0.0/cookie-consent.js UNKNOWN

#in src/resources/vendor
#Apache-2.0: (deno-)puppeteer
#MIT: set-immediate-shim, lie, immediate
#MIT and ZLIB: pako
#MIT or GPLv3: jszip
#Apache-2.0: jspm-core

#"Downloaded" libs
#MIT denos_std, acorn{,-walk}, blueimp-md5, lodash
#BSD jsdiff
#ISC @observablehq/parser

LICENSE="GPL-2+ MIT ZLIB BSD Apache-2.0 ISC || ( MIT GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
PATCHES="
	${FILESDIR}/quarto-cli-0.9.363-pathfixes.patch
	${FILESDIR}/quarto-cli-0.9.256-configuration.patch
"
#DENO 1.22
#DART-sass 1.32.8

DEPEND="
	net-libs/deno
	>=app-text/pandoc-2.18
	dev-lang/dart-sass
	dev-util/esbuild
	net-libs/deno-dom
	dev-lang/lua
"
RDEPEND="${DEPEND}"
BDEPEND=""

DENO_SRC="${WORKDIR}/deno_src"
DENO_CACHE="${WORKDIR}/deno_cache"
DENO_IMPORT_LIST="${FILESDIR}/quarto-imports-0.9.431"
src_unpack(){
	if [[ "${PV}" == *9999 ]];then
		git-r3_src_unpack
	fi
	default
	if use bundle; then
###Setting up DENO_CACHE/DENO_SRC###
	einfo "Setting up DENO_SRC/DENO_CACHE"
	mkdir ${DENO_CACHE}
	mkdir ${DENO_SRC}
	LINE_REGEX="((@.*/)?[^@]*)@(([^@ ]*))? +(.*) +(.*) +(.*) +(.*)"
	while read -r line
	do
		if [[ ${line} == "" ]];then continue; fi;
		[[ ${line} =~ ${LINE_REGEX} ]]
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
	done <<<$DENO_LIBS
###End setting up DENO_CACHE/DENO_SRC###
	fi
}
src_compile(){
	if use bundle;then
	#Building Source Files
	einfo "Building Source Files..."

	LINE_REGEX="((@.*/)?[^@]*)@(([^@ ]*))? +(.*) +(.*) +(.*) +(.*)"
	while read -r line
	do
		if [[ ${line} == "" ]];then continue; fi;
		[[ ${line} =~ ${LINE_REGEX} ]]
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
	done <<<$DENO_LIBS

	esbuild ${DENO_SRC}/@observablehq_parser-4.5.0.orig/src/index.js  --format=esm --bundle --external:acorn* \
		| sed "s#\"acorn\"#\"https://cdn.skypack.dev/acorn@7.4.1\"#" \
		| sed "s#\"acorn-walk\"#\"https://cdn.skypack.dev/acorn-walk@7.2.0\"#" > ${DENO_SRC}/@observablehq_parser-4.5.0/@observablehq_parser.js
###End Building Source Files###
	fi
	if use bundle;then
###BUILD DENO CACHE###
	einfo "Building Deno cache..."
	# curl https://cdn.skypack.dev/moment-guess@1.2.4?meta | sed "s/,/\n,/g"|grep buildId
	#NOTE: the key is the FOLDER
	#      dashes instead of @
	declare -A pkg_hash=(
	["lodash-4.17.21"]="K6GEbP02mWFnLA45zAmi"
	["blueimp-md5@2.19.0"]="FsBtHB6ITwdC3L5Giq4Q"
	["acorn-7.4.1"]="aIeX4aKa0RO2JeS9dtPa"
	["diff-5.0.0"]="cU62LaUh1QZHrLzL9VHS"
	["blueimp-md5-2.19.0"]="FsBtHB6ITwdC3L5Giq4Q"
	["acorn-walk-7.2.0"]="HE7wS37ePcNncqJvsD8k"
	["@observablehq/parser-4.5.0"]="rWZiNfab8flhVomtfVvr"
	["moment-guess-1.2.4"]="bDXl7KQy0hLGNuGhyGb4"
	["dayjs-1.8.21"]="6syVEc6qGP8frQXKlmJD"
	["binary-search-bounds-2.0.5"]="c8IgO4OqUhed8ANHQXKv"
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
				FILECONTENTS="/-/${PACKAGE}@v${VERSION}-${pkg_hash[${FOLDER}]}/dist=es2019,mode=imports/optimized/${PACKAGE}.js"
				CHECKFILE="${DENO_SRC}/${FOLDER/\//_}/${PACKAGE/\//_}.js"
			#Special case until more info
			elif [[ ${FPATH} == "/dayjs.min.js" ]]; then
				FILECONTENTS="/-/${PACKAGE}@v${VERSION}-${pkg_hash[${FOLDER}]}/dist=es2019,mode=imports/optimized/${PACKAGE}.js"
				CHECKFILE="${DENO_SRC}/${FOLDER/\//_}/${PACKAGE}.js"
			elif [[ ${ADDR} =~ /-/.*optimized/(.*) ]]; then
				VERSION="${VERSION:1:-21}"
				FULLPATH="${DENO_SRC}/${PACKAGE/\//_}-${VERSION}/${BASH_REMATCH[1]/\//_}"
			else
				FILECONTENTS="/-/${PACKAGE}@v${VERSION}-${pkg_hash[${FOLDER}]}/dist=es2019,mode=imports/unoptimized${FPATH}.js"
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

###END BUILDING DENO CACHE###
	fi

	#Configuration
	einfo "Setting Configuration"
	mkdir -p package/dist/config/
	sed "s#_EPREFIX_#${EPREFIX}#" ${FILESDIR}/quarto.combined.eprefix > ${S}/quarto

	if use bundle;then
		#Setup package/bin dir
		mkdir -p ${S}/package/dist/bin

		pushd ${S}/package/dist/bin > /dev/null
		mkdir tools
		ln -s ${EPREFIX}/usr/bin/deno tools/deno
		ln -s ${EPREFIX}/usr/bin/pandoc        pandoc
		ln -s ${EPREFIX}/usr/bin/sass          sass
		ln -s ${EPREFIX}/usr/bin/esbuild       esbuild
		ln -s ${EPREFIX}/usr/lib64/deno-dom.so libplugin.so
		popd > /dev/null

		#End package/bin dir

		mkdir -p ${S}/package/dist/config
		export QUARTO_ROOT_DIR="${S}"
		pushd ${S}/package/src

		einfo "Building ${P}..."
		export DENO_DIR=${DENO_CACHE}
		./quarto-bld prepare-dist --log-level info || die
		popd
		echo -n "${PV}"  > ${S}/package/dist/share/version
	else
		#deno -v |sed "s/deno //"
		DENO=`grep     "export DENO="     configuration |sed "s/.*=//"`
		#
		DENO_DOM=`grep "export DENO_DOM=" configuration |sed "s/.*=//"`
		#pandoc -v|grep "pandoc "|sed "s/pandoc //"
		PANDOC=`grep   "export PANDOC="   configuration |sed "s/.*=//"`
		#sass --version
		DARTSASS=`grep "export DARTSASS=" configuration |sed "s/.*=//"`
		#esbuild --version
		ESBUILD=`grep  "export ESBUILD="  configuration |sed "s/.*=//"`
		QUARTO_MD5=`md5sum ${S}/quarto`
		#QUARTO_MD5=`grep  "export QUARTO_MD5="  configuration |sed "s/.*=//"`

		echo -n "{\"deno\": \"${DENO}\",\"deno_dom\": \"${DENO_DOM}\",\"pandoc\": \"${PANDOC}\",\"dartsass\": \"${DARTSASS}\",\"esbuild\": \"${ESBUILD}\",\"script\": \"${QUARTO_MD5:0:32}\"}" > package/dist/config/dev-config
		deno -V |sed "s/deno //" > package/dist/config/deno-version
		echo -n "${PV}"  > src/resources/version
	fi
	rm tests/bin/python3
	ln -s ${EPREFIX}/usr/bin/python tests/bin/python3
}
src_install(){
	if use bundle;then
		dobin ${S}/quarto
		insinto /usr/share/${PN}/
		doins -r ${S}/package/dist/share/*
		insinto /usr/share/${PN}/bin
		doins ${S}/package/dist/bin/quarto.js
		doins -r ${S}/package/dist/bin/vendor
	else
		dobin ${S}/quarto
		insinto /usr/share/${PN}/
		doins -r *
		dosym -r ${EPREFIX}/usr/share/${PN}/src/resources/version ${EPREFIX}/usr/share/${PN}/version
	fi

}
src_test(){
	#this only works with bundled libraries
	if use bundle;then
		pushd ${S}/tests > /dev/null
		export DENO_DIR=${DENO_CACHE}
		echo "${DENO_DIR}"
		export QUARTO_BASE_PATH=${S}
		export QUARTO_BIN_PATH=${QUARTO_BASE_PATH}/package/dist/bin/
		export QUARTO_SHARE_PATH=${QUARTO_BASE_PATH}/src/resources/
		export QUARTO_DEBUG=true
		deno test --unstable --allow-read --allow-write --allow-run --allow-env --allow-net --allow-ffi --importmap=${QUARTO_BASE_PATH}/src/import_map.json test.ts unit
		#This will run an extended test about half work now
		#will need to install/setup
		#* python libraries - see requirements.txt - not all in portage
		#* a correct R enviroment - see renv.lock
		#* install tinytex - not in portage
		#* it uses a chrome(possibly ff if puppeteer is updated)
		#  based browser to do screen shots - probably not possible
		#deno test --unstable --allow-read --allow-write --allow-run --allow-env --allow-net --allow-ffi --importmap=${QUARTO_BASE_PATH}/src/import_map.json test.ts smoke
		popd > /dev/null
	fi
}
