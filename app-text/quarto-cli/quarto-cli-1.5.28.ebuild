# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"

RESTRICT="mirror test"
ESBUILD_VER_ORIG="0.15.18"
DENO_NPM="
	ansi-output@0.0.1
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
DENO_STD_VER="0.217.0"
DENO_LIBS=(
"std@${DENO_STD_VER} https://github.com/denoland/deno_std/archive/refs/tags/_VER_.tar.gz deno_std-_VER_ NA NA"
)
DENO_IMPORT_LIST="${WORKDIR}/full-import.list"

inherit shell-completion prefix npm deno

if [[ "${PV}" == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/quarto-dev/${PN}"
	EGIT_BRANCH="main"
else
	SRC_URI="https://github.com/quarto-dev/quarto-cli/archive/refs/tags/v${PV}.tar.gz   -> ${P}.tar.gz "
fi

PANDOC_VER="3.1.11.1"
SRC_URI+="
	!system-pandoc? (
		https://github.com/jgm/pandoc/releases/download/${PANDOC_VER}/pandoc-${PANDOC_VER}-linux-amd64.tar.gz
	)
	$(deno_build_src_uri)
	$(npm_build_src_uri ${DENO_NPM})
"



LICENSE="MIT GPL-2+ ZLIB BSD Apache-2.0 ISC || ( MIT GPL-3 ) Unlicense 0BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="system-pandoc"
PATCHES="
	${FILESDIR}/quarto-cli-9999-pathfixes.patch
	${FILESDIR}/quarto-cli-1.3.340-configuration.patch
	${FILESDIR}/quarto-cli-9999-check.patch
"
ESBUILD_DEP_SLOT="0.19"
DEPEND="
	app-arch/unzip
	~app-text/typst-0.10.0
	|| (
		(
			>=dev-haskell/pandoc-3.1
			app-text/pandoc-cli
		)
		>=app-text/pandoc-bin-${PANDOC_VER}
	)
	~dev-lang/dart-sass-1.70.0
	>=dev-lang/R-4.1.0
	dev-libs/libxml2
	dev-util/esbuild:${ESBUILD_DEP_SLOT}
	dev-vcs/git
	>=net-libs/deno-1.41.0 <net-libs/deno-1.42
	~net-libs/deno-dom-0.1.35
	sys-apps/which
	x11-misc/xdg-utils
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-misc/jq
	=dev-util/esbuild-0.15*:0
"

QA_FLAGS_IGNORED="usr/bin/pandoc-quarto"
QA_PRESTRIPPED="${QA_FLAGS_IGNORED}"

DOCS=( COPYING.md COPYRIGHT README.md news )

src_unpack() {
	if [[ "${PV}" == *9999 ]];then
		git-r3_src_unpack
	else
		unpack ${P}.tar.gz
	fi
	unpack deno_std@${DENO_STD_VER}.tar.gz
	! use system-pandoc && unpack pandoc-${PANDOC_VER}-linux-amd64.tar.gz

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
	cp "${FILESDIR}/quarto.combined.eprefix.1.5" quarto || die "Failed to copy quarto"
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
	rm "${S}/src/resources/deno_std/deno_std.ts.list" || die

	DENO_CACHE="${deno_cache_old}"
	export DENO_DIR="${deno_dir_old}"

	sed -i "s/sha512.*==//" src/webui/quarto-preview/deno.lock || die
	pushd "${DENO_CACHE}/npm/registry.npmjs.org" > /dev/null || die
	rm "esbuild-linux-64/${ESBUILD_VER_ORIG}/bin/esbuild" || die
	cp "${EPREFIX}/usr/bin/esbuild" "esbuild-linux-64/${ESBUILD_VER_ORIG}/bin/esbuild" || die
	sed -i "s/${ESBUILD_VER_ORIG}/$(esbuild --version)/g" esbuild/${ESBUILD_VER_ORIG}/{install.js,lib/main.js} || die
	popd

	sed -i -E  "s/2.19.2(\", \"Pandoc)/$(ver_cut 1-3 ${PANDOC_VER})\1/;s/1.32.8(\", \"Dart Sass)/1.70.0\1/" \
		src/command/check/check.ts || die "Failed to correct versions"

	sed -i "s/\"esbuild\"/\"esbuild-${ESBUILD_DEP_SLOT}\"/" src/core/esbuild.ts || die

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
	export QUARTO_ESBUILD="${EPREFIX}/usr/bin/esbuild-${ESBUILD_DEP_SLOT}"
	export QUARTO_DART_SASS="${EPREFIX}/usr/bin/sass"

	export QUARTO_ROOT="${S}"

	[[ "${PV}" == "9999" ]] && MY_PV="99.9.9" || MY_PV=${PV}

	einfo "Building ${MY_PV}..."
	pushd src/webui/quarto-preview > /dev/null || die
	#run deno task build manually
	DENO_DIR="${DENO_CACHE}" deno task build || die "Failed to build prepare-dist"
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

	./package/pkg-working/bin/quarto completions bash > quarto.sh || die "Failed to build bash completion"
	./package/pkg-working/bin/quarto completions zsh  > _quarto || die "Failed to build zsh completion"
	./package/pkg-working/bin/quarto completions fish > quarto.fish || die "Failed to build fish completion"

	rm package/pkg-working/share/man -r || die
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

	newbashcomp quarto.sh quarto
	dozshcomp _quarto
	dofishcomp quarto.fish

	mv src/resources/man/quarto{-man.man,.1} || die
	doman src/resources/man/quarto.1
	einstalldocs

	! use system-pandoc && newbin "${WORKDIR}/pandoc-${PANDOC_VER}/bin/pandoc" pandoc-quarto
}
pkg_postinst() {
	if use system-pandoc;then
		elog "Building with *sytem-pandoc* will use your system pandoc version"
		elog "instead of the official pandoc-${PANDOC_VER}"
		elog "This is not supported by upstream."
		elog "If you find or think you found a bug please try:"
		elog " * building w/o *system-pandoc*"
		elog " * using quarto-bin from app-text/quarto-bin"
		elog " * the latest from https://quarto.org/docs/download/"
		elog "*before* reporting an issue to quarto-cli"
	fi
}