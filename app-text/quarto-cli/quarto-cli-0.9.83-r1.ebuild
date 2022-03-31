# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"
SRC_URI="
	https://github.com/quarto-dev/quarto-cli/archive/refs/tags/v${PV}.tar.gz   -> ${P}.tar.gz
	https://github.com/denoland/deno_std/archive/refs/tags/0.122.0.tar.gz      -> deno_std@0.122.0.tar.gz
	https://github.com/c4spar/deno-cliffy/archive/refs/tags/v0.19.3.tar.gz     -> deno_cliffy@v0.19.3.tar.gz
	https://github.com/b-fuze/deno-dom/archive/refs/tags/v0.1.20-alpha.tar.gz  -> deno_dom@v0.1.20-alpha.tar.gz
	https://github.com/oakserver/media_types/archive/refs/tags/v2.10.1.tar.gz  -> media_types@v2.10.1.tar.gz
	https://github.com/masataka/xmlp/archive/refs/tags/v0.2.8.tar.gz           -> xmlp@v0.2.8.tar.gz
	https://github.com/lodash/lodash/archive/refs/tags/4.17.21-es.tar.gz       -> lodash@4.17.21.tar.gz
	https://github.com/acornjs/acorn/archive/refs/tags/7.4.1.tar.gz            -> acorn@7.4.1.tar.gz
	https://github.com/acornjs/acorn/archive/refs/tags/7.2.0.tar.gz            -> acorn-walk@7.4.1.tar.gz
	https://github.com/kpdecker/jsdiff/archive/refs/tags/v5.0.0.tar.gz         -> jsdiff@5.0.0.tar.gz
	https://github.com/blueimp/JavaScript-MD5/archive/refs/tags/v2.19.0.tar.gz -> JavaScript-MD5@2.19.0.tar.gz
	https://github.com/observablehq/parser/archive/refs/tags/v4.5.0.tar.gz     -> observablehq_parser@4.5.0.tar.gz
"

#MIT denos_std, acorn{,-walk}, blueimp-md5, lodash
#BSD jsdiff 
#ISC @observablehq/parser


LICENSE="GPL-2+ MIT BSD ISC"
SLOT="0"
KEYWORDS="~amd64"
PATCHES="
	${FILESDIR}/quarto-cli-0.9.83-pathfixes.patch
	${FILESDIR}/quarto-cli-0.9.83-configuration.patch
"
DEPEND="
	net-libs/deno
	>=app-text/pandoc-2.17.1.1
	dev-lang/dart-sass
	dev-util/esbuild
	net-libs/deno-dom
"
RDEPEND="${DEPEND}"
BDEPEND=""
RESTRICT="test mirror"

DENO_SRC="${WORKDIR}/deno_src"
DENO_CACHE="${WORKDIR}/deno_cache"
src_unpack(){
	default
	mkdir ${DENO_CACHE}
	mkdir ${DENO_SRC}
	#rename jsdiff -> diff
	#		JavaScript-MD5 -> blueimp-md5
	#       observablehq_parser -> @observablehq_parser
	mv ${WORKDIR}/deno_std-0.122.0 ${DENO_SRC}/std-0.122.0
	mv ${WORKDIR}/deno-cliffy-0.19.3 ${DENO_SRC}/cliffy-0.19.3
	mv ${WORKDIR}/deno-dom-0.1.20-alpha ${DENO_SRC}/deno_dom-0.1.20-alpha
	mv ${WORKDIR}/media_types-2.10.1 ${DENO_SRC}
	mv ${WORKDIR}/xmlp-0.2.8 ${DENO_SRC}
	mv ${WORKDIR}/lodash-4.17.21-es ${DENO_SRC}/lodash-4.17.21.orig
	mkdir ${DENO_SRC}/lodash-4.17.21
	mv ${WORKDIR}/acorn-7.4.1 ${DENO_SRC}
	mv ${WORKDIR}/acorn-7.2.0 ${DENO_SRC}/acorn-walk-7.2.0
	mv ${WORKDIR}/jsdiff-5.0.0 ${DENO_SRC}/diff-5.0.0
	mv ${WORKDIR}/JavaScript-MD5-2.19.0 ${DENO_SRC}/blueimp-md5-2.19.0
	mv ${WORKDIR}/parser-4.5.0 ${DENO_SRC}/@observablehq_parser-4.5.0


}
src_compile(){
	einfo "Building Source Files..."
	esbuild ${DENO_SRC}/lodash-4.17.21.orig/*.js                     --format=esm          --outdir=${DENO_SRC}/lodash-4.17.21
	esbuild ${DENO_SRC}/acorn-7.4.1/acorn/src/index.js               --format=esm --bundle --outfile=${DENO_SRC}/acorn-7.4.1/acorn.js
	esbuild ${DENO_SRC}/acorn-walk-7.2.0/acorn-walk/src/index.js     --format=esm --bundle --outfile=${DENO_SRC}/acorn-walk-7.2.0/acorn-walk.js
	esbuild ${DENO_SRC}/diff-5.0.0/src/index.js                      --format=esm --bundle --outfile=${DENO_SRC}/diff-5.0.0/diff.js
	esbuild ${DENO_SRC}/blueimp-md5-2.19.0/js/md5.js                 --format=esm          --outfile=${DENO_SRC}/blueimp-md5-2.19.0/blueimp-md5.js
	esbuild ${DENO_SRC}/@observablehq_parser-4.5.0/src/index.js      --format=esm --bundle --external:acorn* \
		| sed "s#\"acorn\"#\"https://cdn.skypack.dev/acorn@7.4.1\"#" \
		| sed "s#\"acorn-walk\"#\"https://cdn.skypack.dev/acorn-walk@7.2.0\"#" > ${DENO_SRC}/@observablehq_parser-4.5.0/@observablehq_parser.js
###BUILD DENO CACHE###
	einfo "Building Deno cache..."

	declare -A pkg_hash=( 
	["lodash-4.17.21"]="K6GEbP02mWFnLA45zAmi" 
	["blueimp-md5@2.19.0"]="FsBtHB6ITwdC3L5Giq4Q"
	["acorn-7.4.1"]="aIeX4aKa0RO2JeS9dtPa" 
	["diff-5.0.0"]="cU62LaUh1QZHrLzL9VHS"
	["blueimp-md5-2.19.0"]="FsBtHB6ITwdC3L5Giq4Q"
	["acorn-walk-7.2.0"]="HE7wS37ePcNncqJvsD8k"
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
		SHA256=`echo -n "${ADDR}"| sha256sum`
		SHA256=${SHA256%  -}

		FILE_SOURCE=${DENO_SRC}/${ADDR}

		mkdir -p ${DENO_CACHE}/deps/${PROTOCOL}/${HOST}

		FILE="${DENO_CACHE}/deps/${PROTOCOL}/${HOST}/${SHA256}"
		FILE_META="${FILE}.metadata.json"

		FOLDER="${PACKAGE}-${VERSION#v}"
		FULLPATH="${DENO_SRC}/${FOLDER/\//_}${FPATH}"
		FILECONTENTS=""
		if [[ ${HOST} == "cdn.skypack.dev" ]]; then
			if [[ ${FPATH} == "" ]]; then
				#This gets no {default} except blueimp posibly b/c it has export default ...
				FILECONTENTS="/-/${PACKAGE}@v${VERSION}-${pkg_hash[${FOLDER}]}/dist=es2019,mode=imports/optimized/${PACKAGE}.js"
			elif [[ ${ADDR} =~ /-/.*optimized/(.*) ]]; then
				VERSION="${VERSION:1:-21}"
				FULLPATH="${DENO_SRC}/${PACKAGE/\//_}-${VERSION}/${BASH_REMATCH[1]/\//_}"
			else
				FILECONTENTS="/-/${PACKAGE}@v${VERSION}-${pkg_hash[${FOLDER}]}/dist=es2019,mode=imports/unoptimized${FPATH}.js"
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
				if [[ ${PACKAGE} == "blueimp-md5" || ${PACKAGE} == "lodash" ]];then 
					echo  "export {default} from '${FILECONTENTS}';" >> ${FILE}
				fi
			fi
			echo -n "{\"headers\": {\"content-type\":\"application/javascript; charset=utf-8\"},
				\"url\": \"${line}\",\"now\": {\"secs_since_epoch\": ${TIME},\"nanos_since_epoch\": 0}}" > ${FILE_META}
		fi

		
	done < <(cat "${FILESDIR}/quarto-imports")

###END BUILDING DENO CACHE###


	#Configuration
	einfo "Setting Configuration"

	mkdir -p package/dist/config/
	#source configuration
	#echo -n "{\"deno\": \"${DENO}\",\"deno_dom\": \"${DENO_DOM}\",\"pandoc\": \"${PANDOC}\",\"dartsass\": \"${DARTSASS}\",\"esbuild\": \"${ESBUILD}\",\"script\": \"${QUARTO_MD5:0:32}\"}" > package/dist/config/dev-config
	#deno -v |sed "s/deno //" > package/dist/config/deno-version
	#echo -n "${PV}"  > src/resources/version


	mkdir -p ${S}/package/dist/bin
	pushd ${S}/package/dist/bin
	ln -s ${EPREFIX}/usr/bin/deno deno
	#Theses are all here for completion
	mkdir dart-sass
	ln -s ${EPREFIX}/usr/bin/sass dart-sass/sass
	ln -s ${EPREFIX}/usr/bin/pandoc pandoc
	ln -s ${EPREFIX}/usr/bin/esbuild esbuild
	mkdir deno_dom
	ln -s ${EPREFIX}/usr/lib64/deno-dom.so deno_dom/libplugin.so
	popd
	mkdir -p ${S}/package/dist/config
	export QUARTO_ROOT_DIR="${S}"
	pushd ${S}/package/src
	export DENO_DIR=${DENO_CACHE}

	einfo "Building ${P}..."
	./quarto-bld prepare-dist --log-level info || die
	popd
	cp ${FILESDIR}/quarto.bundle ${S}/quarto

	#we currently just use the unbundled dev version
	#to bundle this is a rough outline of what is needed
	#mkdir -p ${S}/package/dist/bin/
	#cd ${S}/package/dist/bin
	#ln -s /usr/bin/deno deno
	#deno cache --reload ../../../src/quarto.ts --unstable --import-map=../../../src/import_map.json
	#these will need to be converted to patches
	#export QUARTO_ROOT_DIR="${S}"
	#cd ${S}/package/src
	#./quarto-bld configure --log-level info
	#NOTE might have to populate bin
	#cd ${S}/package/dist/bin
	#mkdir dart-sass
	#ln -s /usr/bin/sass dart-sass/sass
	#ln -s /usr/bin/pandoc pandoc
	#ln -s /usr/bin/esbuild esbuild
	#mkdir deno_dom
	#ln -s /usr/lib64/deno-dom.so deno_dom/libplugin.so
	#cd ${S}/package/src
	#./quarto-bld prepare-dist --log-level info


	#rm tests/bin/python3
	#ln -s /usr/bin/python tests/bin/python3
}
src_install(){
	dobin ${S}/quarto
	#dobin src/resources/formats/html/quarto.js
	#remember to change folder name to quarto
	insinto /usr/share/${PN}/
	doins -r ${S}/package/dist/share/*
	insinto /usr/share/${PN}/bin
	doins ${S}/package/dist/bin/quarto.js
}
