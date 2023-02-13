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
RENV_HASH="b8bc164f8e22e540972a8f35c474c76c8386888d"
RENV_TEST_PKGS="
rlang@1.0.6
Rcpp@1.0.9
base64enc@0.1-3
digest@0.6.31
ellipsis@0.3.2
fastmap@1.1.0
fs@1.5.2
rappdirs@0.3.3
cachem@1.0.6
htmltools@0.5.4
R6@2.5.1
later@1.3.0
magrittr@2.0.3
cli@3.6.0
glue@1.6.2
xfun@0.36
lifecycle@1.0.3
triebeard@0.3.0
promises@1.2.0.1
jquerylib@0.1.4
jsonlite@1.8.4
memoise@2.0.1
mime@0.12
sass@0.4.4
lattice@0.20-45
colorspace@2.0-3
fansi@1.0.3
utf8@1.2.2
sys@3.4.1
bslib@0.4.2
commonmark@1.8.1
crayon@1.5.2
fontawesome@0.4.0
httpuv@1.6.8
sourcetools@0.1.7
withr@2.5.0
xtable@1.8-4
curl@5.0.0
httpcode@0.3.0
urltools@1.7.3
stringi@1.7.12
vctrs@0.5.1
evaluate@0.20
highr@0.10
yaml@2.3.6
stringr@1.5.0
knitr@1.41
tinytex@0.43
cpp11@0.4.3
crul@1.3
shiny@1.7.4
askpass@1.1
pillar@1.8.1
pkgconfig@2.0.3
RColorBrewer@1.1-3
farver@2.1.1
labeling@0.4.2
munsell@0.5.0
viridisLite@0.4.1
Matrix@1.5-3
nlme@3.1-161
V8@4.2.2
MASS@7.3-58.1
gtable@0.3.1
isoband@0.2.7
mgcv@1.8-41
scales@1.2.1
generics@0.1.3
tibble@3.1.8
tidyselect@1.2.0
openssl@2.0.5
uuid@1.1-0
xml2@1.3.3
zip@2.2.2
gfonts@0.2.0
systemfonts@1.0.4
bit@4.0.5
rmarkdown@2.20
lazyeval@0.2.2
crosstalk@1.2.0
htmlwidgets@1.6.1
DBI@1.1.3
bit64@4.0.5
blob@1.2.3
plogr@0.2.0
data.table@1.14.6
gdtools@0.3.0
officer@0.5.2
bigD@0.2.0
bitops@1.0-7
dplyr@1.0.10
ggplot2@3.4.0
juicyjuice@0.1.0
renv@0.16.0
gt@0.8.0
flextable@0.8.5
RSQLite@2.2.20
DT@0.27
"
DENO_STD_VER="0.170.0"
CLIFFY_VER="0.25.7"
DENO_LIBS=(
"std@${DENO_STD_VER} https://github.com/denoland/deno_std/archive/refs/tags/_VER_.tar.gz deno_std-_VER_ NA NA"
"cliffy@v${CLIFFY_VER} https://github.com/c4spar/deno-cliffy/archive/refs/tags/_VER_.tar.gz deno-cliffy-_VER_ NA NA"
)
DENO_IMPORT_LIST="${WORKDIR}/full-import.list"

PYTHON_COMPAT=( python3_{8..11} )
inherit bash-completion-r1 multiprocessing python-any-r1 prefix deno
#NOTE previews for version x.y are simply x.y.[1..n]
#     releases simply bump to x.y.n+1  no need to be fancy
if [[ "${PV}" == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/quarto-dev/${PN}"
	EGIT_BRANCH="main"

else
	SRC_URI="https://github.com/quarto-dev/quarto-cli/archive/refs/tags/v${PV}.tar.gz   -> ${P}.tar.gz "
fi
SRC_URI+="  $(deno_build_src_uri) "

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
	app-arch/unzip
	|| (
		>=app-text/pandoc-2.19.2
		>=app-text/pandoc-bin-2.19.2
	)
	~dev-lang/dart-sass-1.55.0
	>=dev-lang/R-4.1.0
	dev-libs/libxml2
	dev-vcs/git
	>=net-libs/deno-1.28.2 <net-libs/deno-1.31.0
	~net-libs/deno-dom-0.1.35
	sys-apps/which
	x11-misc/xdg-utils
"
RDEPEND="${DEPEND}"
BDEPEND="
	test? (
		$(python_gen_any_dep '
			dev-python/jupyter[${PYTHON_USEDEP}]
			dev-python/pandas[${PYTHON_USEDEP}]
			dev-python/nbformat[${PYTHON_USEDEP}]
			dev-python/bokeh[${PYTHON_USEDEP}]
		')
		|| (
			dev-lang/julia
			dev-lang/julia-bin
		)
	)
	>=dev-util/esbuild-0.15.6
"
python_check_deps() {
	use test || return 0
	python_has_version -b "dev-python/jupyter[${PYTHON_USEDEP}]" &&
	python_has_version -b "dev-python/pandas[${PYTHON_USEDEP}]" &&
	python_has_version -b "dev-python/nbformat[${PYTHON_USEDEP}]" &&
	python_has_version -b "dev-python/bokeh[${PYTHON_USEDEP}]"
}
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
	unpack deno_std@${DENO_STD_VER}.tar.gz
	unpack deno_cliffy@v${CLIFFY_VER}.tar.gz

	pushd "${S}/src/vendor/deno.land/" > /dev/null || die "Failed to push to deno.land"
	rm -r std@0.166.0 || die "Failed to delete deno_std"
	ln -s "${WORKDIR}/deno_std-${DENO_STD_VER}" std@${DENO_STD_VER} || die "Failed to rename deno_std"
	find -H std@${DENO_STD_VER} -regextype egrep -regex ".*\.(ts|mjs)$" | \
		sed "s%^%https://deno.land/%" > "${WORKDIR}/full-import.list" || \
		die "Failed to make import list"

	pushd x > /dev/null || die "Failed to push to x"
	rm -r cliffy@v0.25.4 || die "Failed to delete old cliff"
	ln -s "${WORKDIR}/deno-cliffy-${CLIFFY_VER}" cliffy@v${CLIFFY_VER} || die "Failed to rename cliffy"
	popd

	popd
	deno_src_unpack
}
src_prepare() {
	#Setup package/bin dir
	mkdir -p package/dist/{config,bin} || die "Failed to make directories"
	#the quarto files are a custom bash script based on the original
	#quarto-cli has moved to a rust based prog. that does the same thing
	#located in package/launcher
	cp "${FILESDIR}/quarto.combined.eprefix" quarto || die "Failed to copy quarto"
	sed "s#export QUARTO_BASE_PATH=\".*\"#export QUARTO_BASE_PATH=\"${S}\"# ;
		s#export SCRIPT_PATH=\".*\"#export SCRIPT_PATH=\"${S}/package/dist/bin\"#" \
		"${S}/quarto" > "${S}/quarto.sandbox" || die "Failed to build quarto.sandbox"
	chmod +x "${S}/quarto.sandbox" || die "Failed to chmod +x quarto"
	cp "${S}/quarto.sandbox" "${S}/package/dist/bin/quarto" || die "Failed to copy quarto"

	pushd "${S}/package/dist/bin" > /dev/null || die "Failed to move to bin"
	for bin in {pandoc,sass,esbuild,deno};do
		ln -s "${EPREFIX}/usr/bin/${bin}" ${bin} || die "Failed to link binary $bin"
	done
	ln -s "${EPREFIX}/usr/lib64/deno-dom.so" libplugin.so || die "Failed to link deno-dom.so"
	popd > /dev/null

	sed -i "s/std@0.166.0/std@${DENO_STD_VER}/" \
		src/{,dev_}import_map.json \
		src/vendor/import_map.json \
		src/resources/deno_std/{,run_}import_map.json \
		package/scripts/deno_std/deno_std.ts \
		package/src/common/dependencies/deno.ts || die "Failed to update various files"
	sed -i "s/cliffy@v0.25.4/cliffy@v${CLIFFY_VER}/" \
		src/{,dev_}import_map.json \
		src/vendor/import_map.json || die "Failed to update cliffy"

	deno_build_src
	deno_build_cache
	#build lock the first time to get list of files to import
	deno cache --unstable --lock "${S}/src/resources/deno_std/deno_std.lock" \
		--lock-write "${S}/package/scripts/deno_std/deno_std.ts" || die "Failed to create lockfile"
	grep https "${S}/src/resources/deno_std/deno_std.lock"|sed "s/.*\(https.*\)\":.*/\1/" >\
		"${S}/src/resources/deno_std/deno_std.ts.list"|| die "Failed to make deno_std.ts.list"

	#build cache that comes with quarto-cli
	local deno_cache_old="${DENO_CACHE}"
	DENO_CACHE="${S}/src/resources/deno_std/cache"
	local deno_dir_old="${DENO_DIR}"
	export DENO_DIR="${DENO_CACHE}"
	DENO_IMPORT_LIST="${S}/src/resources/deno_std/deno_std.ts.list"

	deno_build_cache
	deno cache --unstable --lock "${S}/src/resources/deno_std/deno_std.lock" \
		--lock-write "${S}/package/scripts/deno_std/deno_std.ts" || die "Failed to build cache"

	DENO_CACHE="${deno_cache_old}"
	export DENO_DIR="${deno_dir_old}"
	default
	eprefixify src/command/render/render-shared.ts quarto quarto.sandbox
}
src_configure() {
	#disables creating symlink
	export QUARTO_NO_SYMLINK="TRUE"
	#This will tell quarto not to d/l binaries
	export QUARTO_VENDOR_BINARIES="false"
	export QUARTO_DENO="${EPREFIX}/usr/bin/deno"
	export QUARTO_DENO_DOM="${EPREFIX}/usr/lib64/deno-dom.so"
	export DENO_DOM_PLUGIN="${EPREFIX}/usr/lib64/deno-dom.so"
	export QUARTO_PANDOC="${EPREFIX}/usr/bin/pandoc"
	export QUARTO_ESBUILD="${EPREFIX}/usr/bin/esbuild"
	export QUARTO_DART_SASS="${EPREFIX}/usr/bin/sass"
	export QUARTO_SHARE_PATH="${EPREFIX}/usr/share/quarto"

	pushd package/src > /dev/null ||die "Failed to move to package/src"
	./quarto-bld configure --log-level info || die "Failed to run configure"
	popd > /dev/null

	use test &&
		( mv package/dist/config/dev-config dev-config || die "Failed to save dev-config" )
}
src_compile() {
	export QUARTO_ROOT="${S}"
	pushd package/src || die "Failed to move to package/src"

	[[ "${PV}" == "9999" ]] && MY_PV="99.9.9" || MY_PV=${PV}
	einfo "Building ${P}...${MY_PV}..."
	./quarto-bld prepare-dist --set-version ${MY_PV} --log-level info || die "Failed to run prepare-dist"
	popd

	cp package/pkg-working/share/version src/resources/version || die "Failed to create version"
	mv "${S}/quarto.sandbox" "${S}/package/pkg-working/bin/quarto" || die "Failed to move quarto.sandbox"
	./package/pkg-working/bin/quarto completions bash > _quarto.sh || ewarn "Failed to build bash completion"

	#>=app-shells/zsh-4.3.5 is what app-shells/gentoo-zsh-completions depends on NOT tested
	if has_version  ">=app-shells/zsh-4.3.5";then
		./package/pkg-working/bin/quarto completions zsh > _quarto || die "Failed to build zsh completion"
	fi

	use test && install_r_packages ${RENV_TEST_PKGS}
}
src_test() {
	mkdir -p "${S}/package/dist/config" || die "Failed to make config dir"
	mv "${S}/dev-config" "${S}/package/dist/config/dev-config" || die "Failed to move dev-config"

	pushd "${S}/tests" > /dev/null || die "Failed to move to tests"
	#this disables renv - it might be nice to use renv
	#disable Julia lock like file
	rm bin/python3 .Rprofile Project.toml || die "Failed to delete files"
	einfo "Testing with Python:${EPYTHON}"
	ln -s "${EPREFIX}/usr/bin/${EPYTHON}" bin/python3 || die "Failed to link python3"

	#these test needs internet access thus fails
	rm smoke/{extensions,env}/install.test.ts \
		smoke/extensions/extension-render-journals.test.ts \
		|| die "Failed to delete internet tests"
	#check test is for dev builds
	[[ "${PV}" != "9999" ]] && ( rm smoke/env/check.test.ts || die "Failed to remove check test" )

	export QUARTO_ROOT="${S}"
	export QUARTO_BASE_PATH=${S}
	export QUARTO_BIN_PATH=${QUARTO_BASE_PATH}/package/dist/bin/
	export QUARTO_SHARE_PATH=${QUARTO_BASE_PATH}/src/resources/
	export QUARTO_DEBUG=true
	export R_LIBS="${R_LIB_PATH}"
	#add QUARTO_BIN_PATH so the test can find the newly built quarto
	export PATH="${QUARTO_BIN_PATH}:${PATH}"
	DENO_OPTS="--unstable --config test-conf.json --allow-read --allow-write --allow-run --allow-env --allow-net --allow-ffi --importmap=${QUARTO_BASE_PATH}/src/dev_import_map.json"
	einfo "Starting unit test"
	deno test ${DENO_OPTS} test.ts unit

	# * tinytex - not in portage - downloadableable binary
	# * playright a browser  tester
	# * julia requires 68 d/ls and 139 dependencies!a
	#   - import Pkg; Pkg.add("Plots");Pkg.add("IJulia")
	#   - rm tests/Project.toml
	einfo "Starting smoke test"
	deno test ${DENO_OPTS} test.ts smoke

	#Gentoo sand  258 passed / 43 failed
	#On an internet connected terminal
	#w/o  tinytex xxx passed / xx failed
	#with tinytex 319 passed /  2 failed
	popd > /dev/null
}
src_install() {
	dobin "${S}/quarto"
	insinto /usr/share/${PN}/
	doins -r "${S}/package/pkg-working/share/"*
	insinto /usr/share/${PN}/bin
	doins "${S}/package/pkg-working/bin/quarto.js"
	doins -r "${S}/package/pkg-working/bin/vendor"
	rm "${ED}/usr/share/${PN}/"{COPYING.md,COPYRIGHT}

	newbashcomp _quarto.sh quarto

	if has_version  ">=app-shells/zsh-4.3.5";then
		insinto /usr/share/zsh/site-functions
		doins _quarto
	fi
	einstalldocs
}
