# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"

RESTRICT="mirror"
IUSE="test"
RESTRICT="!test? ( test )"
#note:
#     knitr bumped down to x.y
RENV_HASH="e0fa802fd58080c84dd35ca4080e12776b5c2551"
RENV_TEST_PKGS="
rlang@1.0.6
Rcpp@1.0.10
base64enc@0.1-3
digest@0.6.31
ellipsis@0.3.2
fastmap@1.1.0
fs@1.6.1
rappdirs@0.3.3
cachem@1.0.6
htmltools@0.5.4
R6@2.5.1
later@1.3.0
magrittr@2.0.3
cli@3.6.0
glue@1.6.2
xfun@0.37
lifecycle@1.0.3
triebeard@0.3.0
promises@1.2.0.1
jquerylib@0.1.4
jsonlite@1.8.4
memoise@2.0.1
mime@0.12
sass@0.4.5
lattice@0.20-45
colorspace@2.1-0
fansi@1.0.4
utf8@1.2.3
sys@3.4.1
bslib@0.4.2
commonmark@1.8.1
crayon@1.5.2
fontawesome@0.5.0
httpuv@1.6.9
sourcetools@0.1.7-1
withr@2.5.0
xtable@1.8-4
curl@5.0.0
httpcode@0.3.0
urltools@1.7.3
stringi@1.7.12
vctrs@0.5.2
evaluate@0.20
highr@0.10
yaml@2.3.7
stringr@1.5.0
knitr@1.42
tinytex@0.44
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
nlme@3.1-162
V8@4.2.2
MASS@7.3-58.2
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
data.table@1.14.8
gdtools@0.3.0
officer@0.5.2
bigD@0.2.0
bitops@1.0-7
dplyr@1.1.0
ggplot2@3.4.1
juicyjuice@0.1.0
renv@0.16.0
gt@0.8.0
flextable@0.8.5
RSQLite@2.3.0
DT@0.27
"
ESBUILD_VER_ORIG="0.15.18"
DENO_NPM="
	anymatch@3.1.3
	@babel/runtime@7.21.5
	binary-extensions@2.2.0
	braces@3.0.2
	chokidar@3.5.3
	csstype@3.1.2
	@emotion/hash@0.9.1
	esbuild@0.15.18
	esbuild-linux-64@${ESBUILD_VER_ORIG}
	fast-glob@3.2.12
	fastq@1.15.0
	fill-range@7.0.1
	@floating-ui/core@1.2.6
	@floating-ui/dom@1.2.7
	@fluentui/keyboard-keys@9.0.2
	@fluentui/priority-overflow@9.0.2
	@fluentui/react-accordion@9.1.10
	@fluentui/react-alert@9.0.0-beta.45
	@fluentui/react-aria@9.3.18
	@fluentui/react-avatar@9.4.10
	@fluentui/react-badge@9.1.10
	@fluentui/react-button@9.3.10
	@fluentui/react-card@9.0.8
	@fluentui/react-checkbox@9.1.11
	@fluentui/react-combobox@9.2.11
	@fluentui/react-components@9.19.1
	@fluentui/react-context-selector@9.1.18
	@fluentui/react-dialog@9.5.3
	@fluentui/react-divider@9.2.10
	@fluentui/react-field@9.1.1
	@fluentui/react-icons@2.0.201
	@fluentui/react-image@9.1.7
	@fluentui/react-infobutton@9.0.0-beta.28
	@fluentui/react-input@9.4.11
	@fluentui/react-jsx-runtime@9.0.0-alpha.2
	@fluentui/react-label@9.1.10
	@fluentui/react-link@9.0.36
	@fluentui/react-menu@9.7.10
	@fluentui/react-overflow@9.0.15
	@fluentui/react-persona@9.2.9
	@fluentui/react-popover@9.5.10
	@fluentui/react-portal@9.2.6
	@fluentui/react-positioning@9.5.10
	@fluentui/react-progress@9.1.11
	@fluentui/react-provider@9.5.4
	@fluentui/react-radio@9.1.11
	@fluentui/react-select@9.1.11
	@fluentui/react-shared-contexts@9.3.3
	@fluentui/react-skeleton@9.0.0-beta.10
	@fluentui/react-slider@9.1.11
	@fluentui/react-spinbutton@9.2.11
	@fluentui/react-spinner@9.1.10
	@fluentui/react-switch@9.1.11
	@fluentui/react-table@9.2.7
	@fluentui/react-tabs@9.3.11
	@fluentui/react-tabster@9.6.5
	@fluentui/react-text@9.3.7
	@fluentui/react-textarea@9.3.11
	@fluentui/react-theme@9.1.7
	@fluentui/react-toolbar@9.1.11
	@fluentui/react-tooltip@9.2.10
	@fluentui/react-tree@9.0.0-beta.12
	@fluentui/react-utilities@9.8.0
	@fluentui/react-virtualizer@9.0.0-alpha.18
	@fluentui/tokens@1.0.0-alpha.4
	fsevents@2.3.2
	fs-extra@11.1.1
	function-bind@1.1.1
	glob-parent@5.1.2
	graceful-fs@4.2.11
	@griffel/core@1.11.0
	@griffel/react@1.5.7
	has@1.0.3
	is-binary-path@2.1.0
	is-core-module@2.12.0
	is-extglob@2.1.1
	is-glob@4.0.3
	is-number@7.0.0
	jsonfile@6.1.0
	js-tokens@4.0.0
	keyborg@2.0.0
	loose-envify@1.4.0
	merge2@1.4.1
	micromatch@4.0.5
	nanoid@3.3.6
	@nodelib/fs.scandir@2.1.5
	@nodelib/fs.stat@2.0.5
	@nodelib/fs.walk@1.2.8
	normalize-path@3.0.0
	object-assign@4.1.1
	path-parse@1.0.7
	picocolors@1.0.0
	picomatch@2.3.1
	postcss@8.4.23
	queue-microtask@1.2.3
	react@18.2.0
	react-dom@18.2.0
	readdirp@3.6.0
	regenerator-runtime@0.13.11
	resolve@1.22.3
	reusify@1.0.4
	rollup@2.79.1
	rtl-css-js@1.16.1
	run-parallel@1.2.0
	scheduler@0.20.2
	scheduler@0.23.0
	source-map-js@1.0.2
	stylis@4.2.0
	supports-preserve-symlinks-flag@1.0.0
	@swc/helpers@0.4.14
	tabster@4.4.1
	to-regex-range@5.0.1
	tslib@2.5.0
	typescript@4.9.5
	@types/prop-types@15.7.5
	@types/react@18.2.6
	@types/react-dom@18.2.4
	@types/scheduler@0.16.3
	universalify@2.0.0
	use-disposable@1.0.1
	vite@3.2.6
	vite-plugin-css-injected-by-js@3.1.1
	vite-plugin-static-copy@0.13.1
"
ESBUILD_PLATFORMS="
	android-64
	android-arm64
	darwin-64
	darwin-arm64
	freebsd-64
	freebsd-arm64
	linux-32
	linux-arm
	linux-arm64
	linux-mips64le
	linux-ppc64le
	linux-riscv64
	linux-s390x
	netbsd-64
	openbsd-64
	sunos-64
	windows-32
	windows-64
	windows-arm64
"
ESBUILD_PLATFORMS_EXT="@esbuild/android-arm @esbuild/linux-loong64"
DENO_STD_VER="0.185.0"
DENO_LIBS=(
"std@${DENO_STD_VER} https://github.com/denoland/deno_std/archive/refs/tags/_VER_.tar.gz deno_std-_VER_ NA NA"
)
DENO_IMPORT_LIST="${WORKDIR}/full-import.list"

PYTHON_COMPAT=( python3_{8..11} )
inherit bash-completion-r1 multiprocessing python-any-r1 prefix npm deno
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
SRC_URI+="
	$(deno_build_src_uri)
	$(npm_build_src_uri ${DENO_NPM})
	test? ( $(build_r_src_uri ${RENV_TEST_PKGS} ) )
"

PANDOC_VERSION="3.1.2"

LICENSE="GPL-2+ MIT ZLIB BSD Apache-2.0 ISC || ( MIT GPL-3 ) Unlicense 0BSD"
SLOT="0"
KEYWORDS=""
PATCHES="
	${FILESDIR}/quarto-cli-9999-pathfixes.patch
	${FILESDIR}/quarto-cli-1.3.340-configuration.patch
	${FILESDIR}/quarto-cli-9999-check.patch
"
DEPEND="
	app-arch/unzip
	|| (
		(
			>=app-text/pandoc-${PANDOC_VERSION}
			app-text/pandoc-cli
		)
		>=app-text/pandoc-bin-${PANDOC_VERSION}
	)
	~dev-lang/dart-sass-1.55.0
	>=dev-lang/R-4.1.0
	dev-libs/libxml2
	>=dev-util/esbuild-0.15.6
	dev-vcs/git
	>=net-libs/deno-1.33.0 <net-libs/deno-1.34.0
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
	app-misc/jq
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

	pushd "${S}/src/vendor/deno.land/" > /dev/null || die "Failed to push to deno.land"
	find -H std@${DENO_STD_VER} -regextype egrep -regex ".*\.(ts|mjs)$" | \
	sed "s%^%https://deno.land/%" > "${WORKDIR}/full-import.list" || \
		die "Failed to make import list"
	popd
	deno_src_unpack

	ESBUILD_PLATFORMS=$(printf "esbuild-%s\n" ${ESBUILD_PLATFORMS})
	ESBUILD_PLATFORMS+=" ${ESBUILD_PLATFORMS_EXT}"
	ESBUILD_PLATFORMS=$(printf "%s@${ESBUILD_VER_ORIG}\n" ${ESBUILD_PLATFORMS})
	DENO_NPM_DUMMIES="sass stylus sugarss terser @types/node"
	build_deno_npm dummy less ${DENO_NPM_DUMMIES}
	build_deno_npm true ${DENO_NPM}
	build_deno_npm false ${ESBUILD_PLATFORMS}
}
src_prepare() {
	#the quarto files are a custom bash script based on the original
	#quarto-cli has moved to a rust based prog. that does the same thing
	#located in package/launcher
	cp "${FILESDIR}/quarto.combined.eprefix.1.4" quarto || die "Failed to copy quarto"
	sed "s#export QUARTO_BASE_PATH=\".*\"#export QUARTO_BASE_PATH=\"${S}/package/pkg-working/share\"#"\
		quarto > package/scripts/common/quarto || die "Failed to build quarto sandbox file"

	deno_build_src
	deno_build_cache
	#build lock the first time to get list of files to import
	deno cache --unstable --lock src/resources/deno_std/deno_std.lock \
		--lock-write package/scripts/deno_std/deno_std.ts || die "Failed to create lockfile"
	grep https src/resources/deno_std/deno_std.lock|sed "s/.*\(https.*\)\":.*/\1/" >\
		src/resources/deno_std/deno_std.ts.list || die "Failed to make deno_std.ts.list"

	#build cache that comes with quarto-cli
	local deno_cache_old="${DENO_CACHE}"
	DENO_CACHE="${S}/src/resources/deno_std/cache"
	local deno_dir_old="${DENO_DIR}"
	export DENO_DIR="${DENO_CACHE}"
	DENO_IMPORT_LIST="${S}/src/resources/deno_std/deno_std.ts.list"

	deno_build_cache
	deno cache --unstable --lock src/resources/deno_std/deno_std.lock \
		--lock-write package/scripts/deno_std/deno_std.ts || die "Failed to build cache"

	DENO_CACHE="${deno_cache_old}"
	export DENO_DIR="${deno_dir_old}"

	sed -i "s/sha512.*==//" src/webui/quarto-preview/deno.lock || die
	pushd "${DENO_CACHE}/npm/registry.npmjs.org" > /dev/null || die
	rm "esbuild-linux-64/${ESBUILD_VER_ORIG}/bin/esbuild" || die
	cp "${EPREFIX}/usr/bin/esbuild" "esbuild-linux-64/${ESBUILD_VER_ORIG}/bin/esbuild" || die
	sed -i "s/${ESBUILD_VER_ORIG}/$(esbuild  --version)/g" esbuild/${ESBUILD_VER_ORIG}/{install.js,lib/main.js} || die
	popd

	sed -i -E  "s/2.19.2(\", \"Pandoc)/${PANDOC_VERSION}\1/;s/1.32.8(\", \"Dart Sass)/1.55.0\1/" \
		src/command/check/check.ts || die "Failed to correct versions"

	default
	eprefixify src/command/render/render-shared.ts quarto package/scripts/common/quarto
}
src_compile() {
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

	export QUARTO_ROOT="${S}"

	[[ "${PV}" == "9999" ]] && MY_PV="99.9.9" || MY_PV=${PV}

	einfo "Building ${MY_PV}..."
	pushd src/webui/quarto-preview > /dev/null || die
	#run deno task build manually
	deno task build || die "Failed to build prepare-dist"
	rm {deno.lock,build.ts} || die
	touch build.ts || die
	popd

	pushd package/src || die "Failed to move to package/src"
	./quarto-bld prepare-dist --set-version ${MY_PV} --log-level info || die "Failed to run prepare-dist"
	popd
	[[ ${PV} == "9999" ]] && ( echo "${EGIT_VERSION}" \
		> package/pkg-working/share/commit || die "Failed to add commit" )

	ln -s ../bin package/pkg-working/share || die "Failed to link bin dir"
	cp package/pkg-working/share/version src/resources/version || die "Failed to create version"
	./package/pkg-working/bin/quarto completions bash > _quarto.sh || die "Failed to build bash completion"

	#>=app-shells/zsh-4.3.5 is what app-shells/gentoo-zsh-completions depends on NOT tested
	if has_version  ">=app-shells/zsh-4.3.5";then
		./package/pkg-working/bin/quarto completions zsh > _quarto || die "Failed to build zsh completion"
	fi
	use test && install_r_packages ${RENV_TEST_PKGS}
}
src_test() {
	pushd "${S}/tests" > /dev/null || die "Failed to move to tests"
	#this disables renv - it might be nice to use renv
	#disable Julia lock like file
	rm .Rprofile Project.toml || die "Failed to delete files"
	einfo "Testing with Python:${EPYTHON}"

	#these test needs internet access thus fails
	rm smoke/{extensions,env}/install.test.ts \
		smoke/extensions/extension-render-journals.test.ts \
		|| die "Failed to delete internet tests"
	#check test is for dev builds
	[[ "${PV}" != "9999" ]] && ( rm smoke/env/check.test.ts || die "Failed to remove check test" )

	export QUARTO_ROOT="${S}"
	export QUARTO_BASE_PATH="${S}"
	export QUARTO_BIN_PATH="${S}/package/pkg-working/bin"
	export QUARTO_SHARE_PATH="${S}/src/resources"
	export R_LIBS="${R_LIB_PATH}"
	#add QUARTO_BIN_PATH so the test can find the newly built quarto
	export PATH="${QUARTO_BIN_PATH}:${PATH}"
	local deno_opts="--config test-conf.json --unstable --allow-read --allow-write --allow-run --allow-env --allow-net --allow-ffi --importmap=${S}/src/dev_import_map.json"

	einfo "Starting unit test"
	deno test ${deno_opts} unit

	# * tinytex - not in portage - downloadableable binary
	# * playright a browser  tester - integration/
	# * julia requires 68 d/ls and 139 dependencies!
	#   - import Pkg; Pkg.add("Plots");Pkg.add("IJulia")
	#   - rm tests/Project.toml
	einfo "Starting smoke test"
	deno test ${deno_opts} smoke

	#Gentoo sand  258 passed / 43 failed
	#On an internet connected terminal
	#w/o  tinytex xxx passed / xx failed
	#with tinytex 319 passed /  2 failed
	popd > /dev/null
}
src_install() {
	rm package/pkg-working/share/bin || die "Failed to delete bin link"
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
pkg_postinst() {
	elog "This ebuild differs somewhat from upstream including using system pandoc"
	elog "instead of official pandoc-${PANDOC_VERSION}"
	elog "This is not supported by upstream."
	elog "If you find or think you found a bug please try the official verson at:"
	elog "https://quarto.org/docs/download/ *before* reporting an issue to quarto-cli"
}
