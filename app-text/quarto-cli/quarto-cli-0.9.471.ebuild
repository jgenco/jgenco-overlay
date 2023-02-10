# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit deno

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"

RESTRICT="mirror"
IUSE="bundle"

#package@version url unpack_folder action from
DENO_LIBS=(
"std@0.138.0 https://github.com/denoland/deno_std/archive/refs/tags/_VER_.tar.gz deno_std-_VER_ NA NA"
"cliffy@v0.24.2 https://github.com/c4spar/deno-cliffy/archive/refs/tags/_VER_.tar.gz deno-cliffy-_VER_ NA NA"
"deno_dom@v0.1.20-alpha https://github.com/b-fuze/deno-dom/archive/refs/tags/_VER_.tar.gz deno-dom-_VER_ NA NA"
"events@v1.0.0 https://github.com/deno-library/events/archive/refs/tags/_VER_.tar.gz events-_VER_ NA NA"
"media_types@v2.10.1 https://github.com/oakserver/media_types/archive/refs/tags/_VER_.tar.gz media_types-_VER_ NA NA"
"semver@v1.4.0 https://github.com/justjavac/deno-semver/archive/refs/tags/_VER_.tar.gz deno-semver-_VER_ NA NA"
"xmlp@v0.2.8 https://github.com/masataka/xmlp/archive/refs/tags/_VER_.tar.gz xmlp-_VER_ NA NA"

"acorn@7.4.1 https://github.com/acornjs/acorn/archive/refs/tags/_VER_.tar.gz acorn-_VER_ bundle /acorn/src/index.js"
"acorn-walk@7.2.0 https://github.com/acornjs/acorn/archive/refs/tags/_VER_.tar.gz acorn-_VER_ bundle /acorn-walk/src/index.js"
"ansi_up@v5.1.0 https://github.com/drudru/ansi_up/archive/refs/tags/_VER_.tar.gz ansi_up-_VER_ bundle /ansi_up.js"
"blueimp-md5@2.19.0 https://github.com/blueimp/JavaScript-MD5/archive/refs/tags/v_VER_.tar.gz JavaScript-MD5-_VER_ bundle /js/md5.js"
"dayjs@1.8.21 https://github.com/iamkun/dayjs/archive/refs/tags/v_VER_.tar.gz dayjs-_VER_ bundle /src/index.js"
"diff@5.0.0 https://github.com/kpdecker/jsdiff/archive/refs/tags/v_VER_.tar.gz jsdiff-_VER_ bundle /src/index.js"
"lodash@4.17.21 https://github.com/lodash/lodash/archive/refs/tags/_VER_.tar.gz lodash-_VER_-es build /*.js"
"moment-guess@1.2.4 https://github.com/apoorv-mishra/moment-guess/archive/refs/tags/v_VER_.tar.gz moment-guess-_VER_ bundle /src/index.js"
"@observablehq/parser@4.5.0 https://github.com/observablehq/parser/archive/refs/tags/_VER_.tar.gz parser-_VER_ special_bundle special"
)
declare -A DENO_PKG_HASH=(
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
DENO_IMPORT_LIST="${FILESDIR}/quarto-imports-0.9.471"

if [[ "${PV}" == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/quarto-dev/${PN}"
	EGIT_BRANCH="main"
else
	SRC_URI="https://github.com/quarto-dev/quarto-cli/archive/refs/tags/v${PV}.tar.gz   -> ${P}.tar.gz"
fi

SRC_URI="${SRC_URI} bundle? ( $(deno_build_src_uri) )"

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
	${FILESDIR}/quarto-cli-0.9.471-pathfixes.patch
	${FILESDIR}/quarto-cli-0.9.256-configuration.patch
"
#DENO 1.22
#DART-sass 1.32.8
#esbuild 14.39

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

src_unpack(){
	if [[ "${PV}" == *9999 ]];then
		git-r3_src_unpack
	fi
	default
	if use bundle; then
###Setting up DENO_CACHE/DENO_SRC###
	deno_src_unpack
###End setting up DENO_CACHE/DENO_SRC###
	fi
}
src_compile(){
	if use bundle;then
	#Building Source Files
	deno_build_src

	esbuild ${DENO_SRC}/@observablehq_parser-4.5.0.orig/src/index.js  --format=esm --bundle --external:acorn* \
		| sed "s#\"acorn\"#\"https://cdn.skypack.dev/acorn@7.4.1\"#" \
		| sed "s#\"acorn-walk\"#\"https://cdn.skypack.dev/acorn-walk@7.2.0\"#" > ${DENO_SRC}/@observablehq_parser-4.5.0/@observablehq_parser.js
###End Building Source Files###
	fi
	if use bundle;then
###BUILD DENO CACHE###
	deno_build_cache
###END BUILDING DENO CACHE###
	fi

	#Configuration
	einfo "Setting Configuration"
	mkdir -p package/dist/config/
	sed "s#_EPREFIX_#${EPREFIX}#" "${FILESDIR}/quarto.combined.eprefix" > "${S}/quarto"

	if use bundle;then
		#Setup package/bin dir
		mkdir -p "${S}/package/dist/bin"

		pushd "${S}/package/dist/bin" > /dev/null
		mkdir tools
		ln -s "${EPREFIX}/usr/bin/deno" tools/deno
		ln -s "${EPREFIX}/usr/bin/pandoc"        pandoc
		ln -s "${EPREFIX}/usr/bin/sass"          sass
		ln -s "${EPREFIX}/usr/bin/esbuild"       esbuild
		ln -s "${EPREFIX}/usr/lib64/deno-dom.so" libplugin.so
		popd > /dev/null

		#End package/bin dir

		mkdir -p "${S}/package/dist/config"
		export QUARTO_ROOT_DIR="${S}"
		pushd "${S}/package/src"

		einfo "Building ${P}..."
		export DENO_DIR=${DENO_CACHE}
		./quarto-bld prepare-dist --log-level info || die
		popd
		echo -n "${PV}"  > "${S}/package/dist/share/version"
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
		QUARTO_MD5=`md5sum "${S}/quarto"`
		#QUARTO_MD5=`grep  "export QUARTO_MD5="  configuration |sed "s/.*=//"`

		echo -n "{\"deno\": \"${DENO}\",\"deno_dom\": \"${DENO_DOM}\",\"pandoc\": \"${PANDOC}\",\"dartsass\": \"${DARTSASS}\",\"esbuild\": \"${ESBUILD}\",\"script\": \"${QUARTO_MD5:0:32}\"}" > package/dist/config/dev-config
		deno -V |sed "s/deno //" > package/dist/config/deno-version
		echo -n "${PV}"  > src/resources/version
	fi
	rm tests/bin/python3
	ln -s "${EPREFIX}/usr/bin/python" tests/bin/python3
}
src_install(){
	if use bundle;then
		dobin "${S}/quarto"
		insinto /usr/share/${PN}/
		doins -r "${S}/package/dist/share/"*
		insinto /usr/share/${PN}/bin
		doins "${S}/package/dist/bin/quarto.js"
		doins -r "${S}/package/dist/bin/vendor"
	else
		dobin "${S}/quarto"
		insinto /usr/share/${PN}/
		doins -r *
		dosym -r "${EPREFIX}/usr/share/${PN}/src/resources/version" "${EPREFIX}/usr/share/${PN}/version"
	fi

}
src_test(){
	#this only works with bundled libraries
	if use bundle;then
		pushd "${S}/tests" > /dev/null
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
		#* it uses a chrome (see if ff will work) based browser to do
		#  screen shots - probably not possible
		#deno test --unstable --allow-read --allow-write --allow-run --allow-env --allow-net --allow-ffi --importmap=${QUARTO_BASE_PATH}/src/import_map.json test.ts smoke
		popd > /dev/null
	fi
}
