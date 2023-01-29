# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"

RESTRICT="mirror"
IUSE="test"
RESTRICT="!test? ( test )"
#note:matrix bumped to -1
#     knitr bumped down from .9
RENV_HASH="687871a38fe63d04427be971aa65f00af255d33f"
RENV_TEST_PKGS="
cli@3.6.0
glue@1.6.2
rlang@1.0.6
lifecycle@1.0.3
Rcpp@1.0.9
base64enc@0.1-3
digest@0.6.31
ellipsis@0.3.2
fastmap@1.1.0
lattice@0.20-45
colorspace@2.0-3
fansi@1.0.3
utf8@1.2.2
vctrs@0.5.1
withr@2.5.0
pillar@1.8.1
pkgconfig@2.0.3
RColorBrewer@1.1-3
farver@2.1.1
labeling@0.4.2
munsell@0.5.0
viridisLite@0.4.1
Matrix@1.5-3
nlme@3.1-161
curl@5.0.0
jsonlite@1.8.4
xfun@0.36
fs@1.5.2
rappdirs@0.3.3
cachem@1.0.6
htmltools@0.5.4
R6@2.5.1
later@1.3.0
magrittr@2.0.3
promises@1.2.0.1
jquerylib@0.1.4
memoise@2.0.1
mime@0.12
sass@0.4.4
stringi@1.7.12
evaluate@0.20
highr@0.10
yaml@2.3.6
V8@4.2.2
MASS@7.3-58.1
gtable@0.3.1
isoband@0.2.7
mgcv@1.8-41
scales@1.2.1
generics@0.1.3
tibble@3.1.8
tidyselect@1.2.0
bit@4.0.5
DBI@1.1.3
bit64@4.0.5
blob@1.2.3
plogr@0.2.0
bigD@0.2.0
bitops@1.0-7
dplyr@1.0.10
ggplot2@3.4.0
juicyjuice@0.1.0
stringr@1.5.0
knitr@1.41
tinytex@0.43
bslib@0.4.2
commonmark@1.8.1
crayon@1.5.2
fontawesome@0.4.0
httpuv@1.6.8
sourcetools@0.1.7
xtable@1.8-4
shiny@1.7.4
rmarkdown@2.20
renv@0.16.0
gt@0.8.0
RSQLite@2.2.20
"
PYTHON_COMPAT=( python3_{8..11} )
inherit bash-completion-r1 multiprocessing python-any-r1
#NOTE previews for version x.y are simply x.y.[1..n]
#     releases simply bump to x.y.n+1  no need to be fancy
if [[ "${PV}" == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/quarto-dev/${PN}"
	EGIT_BRANCH="main"
else
	SRC_URI="https://github.com/quarto-dev/quarto-cli/archive/refs/tags/v${PV}.tar.gz   -> ${P}.tar.gz "
fi

build_r_src_uri() {
	for rpkg in ${@}; do
		[[ ${rpkg} =~ (.*)@(.*) ]]
		package=${BASH_REMATCH[1]}
		version=${BASH_REMATCH[2]}
		full_name=${package}_${version}
		echo "https://cloud.r-project.org/src/contrib/${full_name}.tar.gz -> R_${full_name}.tar.gz "
		echo "https://cloud.r-project.org/src/contrib/Archive/${package}/${full_name}.tar.gz -> R_${full_name}.tar.gz "
	done
}
SRC_URI+="test? ( $(build_r_src_uri ${RENV_TEST_PKGS} ) )"
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
KEYWORDS=""
PATCHES="
	${FILESDIR}/quarto-cli-9999-pathfixes.patch
	${FILESDIR}/quarto-cli-9999-configuration.patch
"
DEPEND="
	>=net-libs/deno-1.28.2 <net-libs/deno-1.29.0
	|| (
		>=app-text/pandoc-2.19.2
		>=app-text/pandoc-bin-2.19.2
	)
	~dev-lang/dart-sass-1.32.8
	~net-libs/deno-dom-0.1.23_alpha_p20220508
	test? ( >=dev-lang/R-4.1.0 )
"
RDEPEND="${DEPEND}"
BDEPEND="
	test? (
		${PYTHON_DEPS}
	)
	>=dev-util/esbuild-0.15.6
"
DOCS=( COPYING.md COPYRIGHT README.md news )

R_LIB_PATH="${WORKDIR}/r_pkgs"
install_r_packages() {
	mkdir -p ${R_LIB_PATH}
	R_SCRIPT="${S}/R_pkg_ins.R"
	echo -n 'pkgs = c("' >> ${R_SCRIPT}
	echo  -n ${@}|sed 's/@/_/g;s/ /","/g' >> ${R_SCRIPT}
	echo  '")' >> ${R_SCRIPT}
	echo 'pkgs_files = paste0("'"${DISTDIR}"'/R_",pkgs,".tar.gz")' >> ${R_SCRIPT}
	echo 'install.packages(pkgs_files,repos=NULL,Ncpus='$(makeopts_jobs)')' >> ${R_SCRIPT}
	R_LIBS="${R_LIB_PATH}" Rscript ${R_SCRIPT} || die "Failed to install R packages"
}

pkg_setup() {
	use test && python-any-r1_pkg_setup
}
src_unpack() {
	if [[ "${PV}" == *9999 ]];then
		git-r3_src_unpack
		RENV_HASH_CUR=$(sha1sum "${S}/tests/renv.lock")
		if [[ ${RENV_HASH_CUR:0:40} != ${RENV_HASH} ]];then
			ewarn "test/renv.lock has changed"
		fi
	else
		unpack ${P}.tar.gz
	fi
}
src_prepare() {
	#Setup package/bin dir
	mkdir -p package/dist/config/
	mkdir -p package/dist/bin/
	#the quarto files are a custom bash script based on the original
	#quarto-cli has moved to a rust based prog. that does the same thing
	#located in package/launcher
	sed "s#_EPREFIX_#${EPREFIX}# ; s#src/import_map.json#src/dev_import_map.json#" \
		"${FILESDIR}/quarto.combined.eprefix" > "${S}/quarto"
	sed "s#export QUARTO_BASE_PATH=\".*\"#export QUARTO_BASE_PATH=\"${S}\"# ;
		s#export SCRIPT_PATH=\".*\"#export SCRIPT_PATH=\"${S}/package/dist/bin\"#" \
		"${S}/quarto" > "${S}/package/dist/bin/quarto"
	chmod +x "${S}/package/dist/bin/quarto"

	pushd "${S}/package/dist/bin" > /dev/null
	mkdir -p tools/deno-x86_64-unknown-linux-gnu
	ln -s "${EPREFIX}/usr/bin/deno" tools/deno-x86_64-unknown-linux-gnu/deno
	ln -s "${EPREFIX}/usr/bin/pandoc"        pandoc
	ln -s "${EPREFIX}/usr/bin/sass"          sass
	ln -s "${EPREFIX}/usr/bin/esbuild"       esbuild
	ln -s "${EPREFIX}/usr/lib64/deno-dom.so" libplugin.so
	#added for quarto-sandbox for simplicity
	ln -s "${EPREFIX}/usr/bin/deno"          deno
	popd > /dev/null

	mkdir -p "${S}/package/dist/config"
	default
}
src_configure() {
	pushd "${S}/package/src" > /dev/null
	#disables creating symlink
	export QUARTO_NO_SYMLINK="TRUE"
	#With the configuration patch this just write the devConfig for unbundled and testing
	./quarto-bld configure    --log-level info || die "Failed to run configure"
	#copy dev-config b/c prepare-dist deletes it
	cp "${S}/package/dist/config/dev-config" "${S}/dev-config"
	popd > /dev/null
}
src_compile() {
	#Configuration
	einfo "Setting Configuration"

	export QUARTO_ROOT="${S}"
	pushd "${S}/package/src"

	einfo "Building ${P}..."
	./quarto-bld prepare-dist --log-level info || die "Failed to run prepare-dist"
	popd

	[[ "${PV}" == "9999" ]] && MY_PV="99.9.9" || MY_PV=${PV}
	echo -n "${MY_PV}" > "${S}/package/dist/share/version"
	echo -n "${MY_PV}" > "${S}/src/resources/version"

	"${S}/package/dist/bin/quarto" completions bash > _quarto.sh || die "Failed to build bash completion"
	#>=app-shells/zsh-4.3.5 is what app-shells/gentoo-zsh-completions depends on NOT tested
	if has_version  ">=app-shells/zsh-4.3.5";then
		"${S}/package/dist/bin/quarto" completions zsh > _quarto || die "Failed to build zsh completion"
	fi

	use test && install_r_packages ${RENV_TEST_PKGS}
}

src_test() {
	rm tests/bin/python3 || die "Failed to delete tests/bin/python3"
	ln -s "${EPREFIX}/usr/bin/${EPYTHON}" tests/bin/python3

	mkdir -p "${S}/package/dist/config"
	mv "${S}/dev-config" "${S}/package/dist/config/dev-config"

	pushd "${S}/tests" > /dev/null
	#this disables renv - it might be nice to use renv
	rm .Rprofile || die "Failed to delete .Rprofile"
	#this test needs internet access thus fails
	rm smoke/extensions/install.test.ts || die "Failed to delete smoke/extensions/install.test.ts"
	#check test is for dev builds
	[[ "${PV}" != *9999 ]] && rm smoke/env/check.test.ts
	#install test runs 'quarto list' which requires internet access
	rm smoke/env/install.test.ts || die "Failed to delete smoke/env/install.test.ts"

	export QUARTO_ROOT="${S}"
	export QUARTO_BASE_PATH=${S}
	export QUARTO_BIN_PATH=${QUARTO_BASE_PATH}/package/dist/bin/
	export QUARTO_SHARE_PATH=${QUARTO_BASE_PATH}/src/resources/
	export QUARTO_DEBUG=true
	export R_LIBS="${R_LIB_PATH}"
	#add QUARTO_BIN_PATH so the test can find the newly built quarto
	export PATH="${QUARTO_BIN_PATH}:${PATH}"
	DENO_OPTS="--unstable --no-config --allow-read --allow-write --allow-run --allow-env --allow-net --allow-ffi --importmap=${QUARTO_BASE_PATH}/src/dev_import_map.json"
	einfo "Starting unit test"
	deno test ${DENO_OPTS} test.ts unit

	#will need to install/setup
	# * python libraries - see requirements.txt - not all in portage
	# * dev-python/jupyter
	# * install tinytex - not in portage
	# * it uses chrome (see if ff will work) based browser to do screen shots - probably not possible

	einfo "Starting smoke test"
	deno test ${DENO_OPTS} test.ts smoke

	#Gentoo sand  238 passed / 57 failed
	#On an internet connected terminal
	#w/o  tinytex 239 passed / 72 failed
	#with tinytex 281 passed / 30 failed
	popd > /dev/null
}
src_install() {
	dobin "${S}/quarto"
	insinto /usr/share/${PN}/
	doins -r "${S}/package/dist/share/"*
	insinto /usr/share/${PN}/bin
	doins "${S}/package/dist/bin/quarto.js"
	doins -r "${S}/package/dist/bin/vendor"
	rm "${ED}/usr/share/${PN}/"{COPYING.md,COPYRIGHT}

	newbashcomp _quarto.sh quarto

	if has_version  ">=app-shells/zsh-4.3.5";then
		insinto /usr/share/zsh/site-functions
		doins _quarto
	fi
	einstalldocs
}

