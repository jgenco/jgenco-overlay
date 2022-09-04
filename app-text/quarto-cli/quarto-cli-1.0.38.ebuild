# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"

RESTRICT="mirror"
IUSE="bundle"

inherit bash-completion-r1
#NOTE previews for version x.y are simply x.y.[1..n]
#     releases simply bump to x.y.n+1  no need to be fancy
if [[ "${PV}" == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/quarto-dev/${PN}"
	EGIT_BRANCH="main"
else
	SRC_URI="https://github.com/quarto-dev/quarto-cli/archive/refs/tags/v${PV}.tar.gz   -> ${P}.tar.gz"
fi

#SRC_URI="${SRC_URI} bundle? ( $(build_deno_src_uri) )"

#Quarto-cli has third party libraries bundled in their software
#BOOTSWATCH=5.1.3
#MIT & BSD: rstudio/bslib
#MIT: twbs/icons Anchor-js poppperjs clipboard.js tippy.js
#     hakimel/reveal.js denehyg/reveal.js-menu rajgoel/reveal.js-plugins
#     McShelby/reveal-pdfexport javve/list.js iamkun/dayjs
#     @algolia/autocomplete-js @algolia/autocomplete-preset-algolia
#Apache-2.0 mozilla/pdf.js krisk/Fuse
#ALGOLIA_SEARCH_JS=4.5.1
#ALGOLIA_SEARCH_INSIGHTS_JS=2.0.3
#https://www.cookieconsent.com/releases/4.0.0/cookie-consent.js UNKNOWN

#"Downloaded" libs
#MIT: denos_std, events, cache, cliffy, dayjs, moment-guess, deno_dom, media_types,
#     xmlp, another_cookiejar, ansi_up. lodash, acorn{,-walk}, binary-search-bounds,
#     blueimp-md5, js-yaml
#BSD: diff(jsdiff)
#ISC: semver, @observablehq/parser
#MIT or GPLv3: jszip
#Apache-2.0: puppeteer

#"Scopes" - src/resources/vendor
#MIT: immediate, lie, set-immediate-shim
#MIT and ZLIB: pako
#Apache-2.0: jspm-core

LICENSE="GPL-2+ MIT ZLIB BSD Apache-2.0 ISC || ( MIT GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
PATCHES="
	${FILESDIR}/quarto-cli-0.9.596-pathfixes.patch
	${FILESDIR}/quarto-cli-0.9.256-configuration.patch
"
#DENO 1.22.0 NOTE
#DART-sass 1.32.8
#esbuild 0.14.39

DEPEND="
	<=net-libs/deno-1.22.0
	>=app-text/pandoc-2.18
	dev-lang/dart-sass
	~net-libs/deno-dom-0.1.17_alpha
	dev-lang/lua
"
RDEPEND="${DEPEND}"
BDEPEND="
bundle? ( ~dev-util/esbuild-0.14.39 )
"

DENO_SRC="${WORKDIR}/deno_src"
DENO_CACHE="${WORKDIR}/deno_cache"

src_unpack(){
	if [[ "${PV}" == *9999 ]];then
		git-r3_src_unpack
	fi
	default
}
src_compile(){
	#Configuration
	einfo "Setting Configuration"
	mkdir -p package/dist/config/
	sed "s#_EPREFIX_#${EPREFIX}#" ${FILESDIR}/quarto.combined.eprefix |sed "s#src/import_map.json#src/dev_import_map.json#" > ${S}/quarto

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
		DENO=$(grep     "export DENO="     configuration |sed "s/.*=//")
		#
		DENO_DOM=$(grep "export DENO_DOM=" configuration |sed "s/.*=//")
		#pandoc -v|grep "pandoc "|sed "s/pandoc //"
		PANDOC=$(grep   "export PANDOC="   configuration |sed "s/.*=//")
		#sass --version
		DARTSASS=$(grep "export DARTSASS=" configuration |sed "s/.*=//")
		#esbuild --version
		ESBUILD=$(grep  "export ESBUILD="  configuration |sed "s/.*=//")
		QUARTO_MD5=$(md5sum ${S}/quarto)
		#QUARTO_MD5=`grep  "export QUARTO_MD5="  configuration |sed "s/.*=//"`
		importMap=$(md5sum       ${S}/src/import_map.json)
		bundleImportMap=$(md5sum ${S}/src/resources/vendor/import_map.json)

		echo -n "{\"deno\": \"${DENO}\",\"deno_dom\": \"${DENO_DOM}\",\"pandoc\": \"${PANDOC}\",\"dartsass\": \"${DARTSASS}\",\"esbuild\": \"${ESBUILD}\",
		\"script\": \"${QUARTO_MD5:0:32}\",\"importMap\":\"${importMap:0:32}\",\"bundleImportMap\":\"${bundleImportMap:0:32}\"}" > package/dist/config/dev-config
		deno -V |sed "s/deno //" > package/dist/config/deno-version
		echo -n "${PV}"  > src/resources/version
	fi
	rm tests/bin/python3
	ln -s ${EPREFIX}/usr/bin/python tests/bin/python3
}
src_install(){
	#DENO_DIR, QUARTO_* sets vars for quarto to run to build
	#shell completion file(s)
	export DENO_DIR=${DENO_CACHE}
	if use bundle;then
		export QUARTO_BASE_PATH=${S}
		export QUARTO_BIN_PATH="${QUARTO_BASE_PATH}/package/dist/bin"
		export QUARTO_SHARE_PATH="${QUARTO_BASE_PATH}/package/dist/share"
		QUARTO_TARGET="${QUARTO_BIN_PATH}/quarto.js"
		dobin ${S}/quarto
		insinto /usr/share/${PN}/
		doins -r ${S}/package/dist/share/*
		insinto /usr/share/${PN}/bin
		doins ${S}/package/dist/bin/quarto.js
		doins -r ${S}/package/dist/bin/vendor
	else
		export QUARTO_BASE_PATH=${S}
		export QUARTO_BIN_PATH=${S}
		QUARTO_TARGET="${QUARTO_BASE_PATH}/src/quarto.ts"
		export QUARTO_SHARE_PATH="${QUARTO_BASE_PATH}/src/resources/"
		dobin ${S}/quarto
		insinto /usr/share/${PN}/
		doins -r *
		dosym -r ${EPREFIX}/usr/share/${PN}/src/resources/version ${EPREFIX}/usr/share/${PN}/version

	fi
	#This builds the shell completion files
	DENO_OPTS="run --unstable --no-config --allow-read --allow-write --allow-run --allow-env --allow-net --allow-ffi --importmap=${QUARTO_BASE_PATH}/src/dev_import_map.json"
	deno ${DENO_OPTS} ${QUARTO_TARGET} completions bash > _quarto.sh || die "Failed to build bash completion"
	newbashcomp _quarto.sh quarto

	#>=app-shells/zsh-4.3.5 is what app-shells/gentoo-zsh-completions depends on NOT tested
	if has_version  ">=app-shells/zsh-4.3.5";then
		deno ${DENO_OPTS} ${QUARTO_TARGET} completions zsh > _quarto || die "Failed to build zsh  comletion"
		insinto /usr/share/zsh/site-functions
		doins _quarto
	fi
}
src_test(){
	#this only works with bundled libraries
	#TODO: with deno versioning can be done w/o bundling
	if use bundle;then
		pushd ${S}/tests > /dev/null
		export DENO_DIR=${DENO_CACHE}
		export QUARTO_BASE_PATH=${S}
		export QUARTO_BIN_PATH=${QUARTO_BASE_PATH}/package/dist/bin/
		export QUARTO_SHARE_PATH=${QUARTO_BASE_PATH}/src/resources/
		export QUARTO_DEBUG=true
		deno test --unstable --no-config --allow-read --allow-write --allow-run --allow-env --allow-net --allow-ffi --importmap=${QUARTO_BASE_PATH}/src/import_map.json test.ts unit
		#This will run an extended test about half work now
		#will need to install/setup
		#* python libraries - see requirements.txt - not all in portage
		#* a correct R enviroment - see renv.lock
		#* install tinytex - not in portage
		#* it uses a chrome (see if ff will work) based browser to do
		#  screen shots - probably not possible
		#deno test --unstable --no-config --allow-read --allow-write --allow-run --allow-env --allow-net --allow-ffi --importmap=${QUARTO_BASE_PATH}/src/import_map.json test.ts smoke
		popd > /dev/null
	fi
}
