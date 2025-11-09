# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"

QUARTO_CLI_VENDOR="${PN}-1.7.5"
ESBUILD_VER_ORIG="0.15.18"
DENO_NPM="
	ansi-output@0.0.9
	anymatch@3.1.3
	@babel/runtime@7.24.7
	binary-extensions@2.3.0
	braces@3.0.3
	chokidar@3.6.0
	csstype@3.1.3
	dom-helpers@5.2.1
	@emotion/hash@0.9.1
	esbuild@0.15.18
	esbuild-linux-64@0.15.18
	fast-glob@3.3.2
	fastq@1.17.1
	fill-range@7.1.1
	@floating-ui/core@1.6.2
	@floating-ui/devtools@0.2.1
	@floating-ui/dom@1.6.5
	@floating-ui/utils@0.2.2
	@fluentui/keyboard-keys@9.0.7
	@fluentui/priority-overflow@9.1.13
	@fluentui/react-accordion@9.4.0
	@fluentui/react-alert@9.0.0-beta.116
	@fluentui/react-aria@9.12.0
	@fluentui/react-avatar@9.6.29
	@fluentui/react-badge@9.2.38
	@fluentui/react-breadcrumb@9.0.29
	@fluentui/react-button@9.3.83
	@fluentui/react-card@9.0.83
	@fluentui/react-checkbox@9.2.28
	@fluentui/react-combobox@9.11.7
	@fluentui/react-components@9.48.0
	@fluentui/react-context-selector@9.1.61
	@fluentui/react-dialog@9.11.1
	@fluentui/react-divider@9.2.70
	@fluentui/react-drawer@9.5.1
	@fluentui/react-field@9.1.67
	@fluentui/react-icons@2.0.244
	@fluentui/react-image@9.1.68
	@fluentui/react-infobutton@9.0.0-beta.100
	@fluentui/react-infolabel@9.0.36
	@fluentui/react-input@9.4.78
	@fluentui/react-jsx-runtime@9.0.39
	@fluentui/react-label@9.1.71
	@fluentui/react-link@9.2.24
	@fluentui/react-menu@9.14.7
	@fluentui/react-message-bar@9.2.2
	@fluentui/react-motion@9.1.0
	@fluentui/react-motion-preview@0.5.22
	@fluentui/react-overflow@9.1.21
	@fluentui/react-persona@9.2.88
	@fluentui/react-popover@9.9.11
	@fluentui/react-portal@9.4.27
	@fluentui/react-positioning@9.15.3
	@fluentui/react-progress@9.1.78
	@fluentui/react-provider@9.16.2
	@fluentui/react-radio@9.2.23
	@fluentui/react-rating@9.0.11
	@fluentui/react-search@9.0.0
	@fluentui/react-select@9.1.78
	@fluentui/react-shared-contexts@9.19.0
	@fluentui/react-skeleton@9.1.6
	@fluentui/react-slider@9.1.85
	@fluentui/react-spinbutton@9.2.78
	@fluentui/react-spinner@9.4.9
	@fluentui/react-switch@9.1.85
	@fluentui/react-table@9.15.7
	@fluentui/react-tabs@9.4.23
	@fluentui/react-tabster@9.21.5
	@fluentui/react-tags@9.3.8
	@fluentui/react-text@9.4.20
	@fluentui/react-textarea@9.3.78
	@fluentui/react-theme@9.1.19
	@fluentui/react-toast@9.3.46
	@fluentui/react-toolbar@9.1.86
	@fluentui/react-tooltip@9.4.30
	@fluentui/react-tree@9.7.0
	@fluentui/react-utilities@9.18.10
	@fluentui/react-virtualizer@9.0.0-alpha.74
	@fluentui/tokens@1.0.0-alpha.16
	fsevents@2.3.2
	fs-extra@11.2.0
	function-bind@1.1.1
	glob-parent@5.1.2
	graceful-fs@4.2.11
	@griffel/core@1.17.0
	@griffel/react@1.5.23
	@griffel/style-types@1.2.0
	has@1.0.3
	is-binary-path@2.1.0
	is-core-module@2.12.0
	is-extglob@2.1.1
	is-glob@4.0.3
	is-number@7.0.0
	jsonfile@6.1.0
	js-tokens@4.0.0
	keyborg@2.6.0
	loose-envify@1.4.0
	merge2@1.4.1
	micromatch@4.0.7
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
	prop-types@15.8.1
	queue-microtask@1.2.3
	react@18.3.1
	react-dom@18.3.1
	react-is@16.13.1
	react-is@17.0.2
	react-transition-group@4.4.5
	readdirp@3.6.0
	regenerator-runtime@0.14.1
	resolve@1.22.3
	reusify@1.0.4
	rollup@2.79.1
	rtl-css-js@1.16.1
	run-parallel@1.2.0
	scheduler@0.23.0
	scheduler@0.23.2
	source-map-js@1.0.2
	stylis@4.3.2
	supports-preserve-symlinks-flag@1.0.0
	@swc/helpers@0.5.11
	tabster@7.3.0
	to-regex-range@5.0.1
	tslib@2.6.3
	typescript@4.9.5
	@types/prop-types@15.7.12
	@types/react@18.3.3
	@types/react-dom@18.3.0
	universalify@2.0.1
	use-disposable@1.0.2
	vite@3.2.6
	vite-plugin-css-injected-by-js@3.5.1
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
DENO_IMPORT_LIST="${WORKDIR}/full-import.list"

inherit shell-completion prefix npm deno

if [[ "${PV}" == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/quarto-dev/${PN}"
	EGIT_BRANCH="main"
else
	SRC_URI="https://github.com/quarto-dev/quarto-cli/archive/refs/tags/v${PV}.tar.gz   -> ${P}.tar.gz "
fi

PANDOC_VER="3.6.3"
SRC_URI+="
	https://github.com/jgenco/jgenco-overlay-files/releases/download/${QUARTO_CLI_VENDOR}/${QUARTO_CLI_VENDOR}-deno_vendor.tar.xz
	!system-pandoc? (
		https://github.com/jgm/pandoc/releases/download/${PANDOC_VER}/pandoc-${PANDOC_VER}-linux-amd64.tar.gz
	)
	$(npm_build_src_uri ${DENO_NPM})
"

LICENSE="MIT GPL-2+ ZLIB BSD BSD-2 Apache-2.0 ISC || ( MIT GPL-3 ) Unlicense 0BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="system-pandoc"
RESTRICT="mirror test"
PATCHES="
	${FILESDIR}/quarto-cli-1.5.75-pathfixes.patch
	${FILESDIR}/quarto-cli-1.3.340-configuration.patch
	${FILESDIR}/quarto-cli-1.7.23-check.patch
"
ESBUILD_DEP_SLOT="0.19"
DEPEND="
	app-arch/unzip
	~app-text/typst-0.13.0[embed-fonts]
	system-pandoc? ( || (
		(
			>=dev-haskell/pandoc-3.1
			app-text/pandoc-cli
		)
		>=app-text/pandoc-bin-${PANDOC_VER}
	) )
	~dev-lang/dart-sass-1.85.1
	>=dev-lang/R-4.1.0
	dev-libs/libxml2
	dev-util/esbuild:${ESBUILD_DEP_SLOT}
	dev-vcs/git
	>=dev-lang/deno-1.46 <dev-lang/deno-1.47
	~net-libs/deno-dom-0.1.41
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

	unpack ${QUARTO_CLI_VENDOR}-deno_vendor.tar.xz
	mv cache "${S}/src/resources/deno_std/" || die

	! use system-pandoc && unpack pandoc-${PANDOC_VER}-linux-amd64.tar.gz

	pushd "${S}/src/vendor/deno.land/" > /dev/null || die "Failed to push to deno.land"
	find -H std@${DENO_STD_VER} -regextype egrep -regex ".*\.(ts|mjs)$" | \
	sed "s%^%https://deno.land/%" > "${WORKDIR}/full-import.list" || \
		die "Failed to make import list"
	popd

	ESBUILD_PLATFORMS=$(printf "esbuild-%s\n" ${ESBUILD_PLATFORMS})
	ESBUILD_PLATFORMS+=" ${ESBUILD_PLATFORMS_EXT}"
	ESBUILD_PLATFORMS_VER=$(printf "%s@${ESBUILD_VER_ORIG}\n" ${ESBUILD_PLATFORMS})
	DENO_NPM_DUMMIES="sass stylus sugarss terser @types/node"
	build_deno_npm dummy less ${DENO_NPM_DUMMIES}
	build_deno_npm true ${DENO_NPM}
	build_deno_npm false ${ESBUILD_PLATFORMS_VER}
	for esbuild_platform in ${ESBUILD_PLATFORMS};do
		local os=${esbuild_platform/*esbuild[-\/]/}
		os=${os%-*}
		local cpu=${esbuild_platform/*-/}

		edit_deno_pkg_reg "${esbuild_platform}@${ESBUILD_VER_ORIG}" '.versions.[$ver] |= . + {"os":[$os],"cpu":[$cpu]}' --arg os ${os} --arg cpu ${cpu}
	done

	edit_deno_pkg_reg "vite@3.2.6" '.versions.[$ver].optionalDependencies |= . + {"fsevents":"~2.3.2"}'
	edit_deno_pkg_reg "fsevents@2.3.2" '.versions.[$ver] |= . + {"os":["darwin"],"cpu":[]}'
}
src_prepare() {
	#the quarto files are a custom bash script based on the original
	#quarto-cli has moved to a rust based prog. that does the same thing
	#located in package/launcher
	cp "${FILESDIR}/quarto.combined.eprefix.1.6" quarto || die "Failed to copy quarto"
	sed "s#export QUARTO_BASE_PATH=\".*\"#export QUARTO_BASE_PATH=\"${S}/package/pkg-working/share\"#"\
		quarto > package/scripts/common/quarto || die "Failed to build quarto sandbox file"

	sed -i "s/sha512.*==//" src/webui/quarto-preview/deno.lock || die
	pushd "${DENO_CACHE}/npm/registry.npmjs.org" > /dev/null || die
	rm "esbuild-linux-64/${ESBUILD_VER_ORIG}/bin/esbuild" || die
	cp "${EPREFIX}/usr/bin/esbuild" "esbuild-linux-64/${ESBUILD_VER_ORIG}/bin/esbuild" || die
	sed -i "s/${ESBUILD_VER_ORIG}/$(esbuild --version)/g" esbuild/${ESBUILD_VER_ORIG}/{install.js,lib/main.js} || die
	popd

	DENO_DIR="src/resources/deno_std/cache" deno cache --unstable-ffi \
		--lock src/resources/deno_std/deno_std.lock \
		package/scripts/deno_std/deno_std.ts || die

	sed -i "s/\"esbuild\"/\"esbuild-${ESBUILD_DEP_SLOT}\"/" src/core/esbuild.ts || die

	#Setup links
	ln -s "${DENO_CACHE}" package/src/x86_64 || die
	ln -s "${DENO_CACHE}" src/webui/quarto-preview/x86_64 || die

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
	if ! use system-pandoc; then
		export QUARTO_PANDOC="${WORKDIR}/pandoc-${PANDOC_VER}/bin/pandoc"
	else
		export QUARTO_PANDOC="${EPREFIX}/usr/bin/pandoc"
		[[ -f "${QUARTO_PANDOC}-bin" ]] && export QUARTO_PANDOC+="-bin"
	fi
	export QUARTO_ESBUILD="${EPREFIX}/usr/bin/esbuild-${ESBUILD_DEP_SLOT}"
	export QUARTO_DART_SASS="${EPREFIX}/usr/bin/sass"

	export QUARTO_ROOT="${S}"

	[[ "${PV}" == "9999" ]] && MY_PV="99.9.9" || MY_PV=${PV}

	einfo "Building quarto-preview..."
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
