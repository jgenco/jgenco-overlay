# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"

QUARTO_CLI_VENDOR="${PN}-1.8.19"
ESBUILD_VER_ORIG="0.15.18"

inherit shell-completion prefix

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
"

LICENSE="MIT"
LICENSE+=" GPL-2+ ZLIB BSD BSD-2 Apache-2.0 ISC Unlicense 0BSD" #included files
#cache not used
LICENSE+=" MIT" #deno_cache
LICENSE+=" 0BSD Apache-2.0 BSD ISC MIT" #node_modules

SLOT="0"
KEYWORDS=""
IUSE="system-pandoc"
RESTRICT="mirror test"
PATCHES="
	${FILESDIR}/quarto-cli-1.8.4-pathfixes.patch
	${FILESDIR}/quarto-cli-1.3.340-configuration.patch
	${FILESDIR}/quarto-cli-1.8.4-check.patch
"
ESBUILD_DEP_SLOT="0.25"
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
	~dev-lang/dart-sass-1.87.0
	>=dev-lang/R-4.1.0
	dev-libs/libxml2
	dev-util/esbuild:${ESBUILD_DEP_SLOT}
	dev-vcs/git
	>=dev-lang/deno-2.4 <dev-lang/deno-2.5
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

}
src_prepare() {
	#the quarto files are a custom bash script based on the original
	#quarto-cli has moved to a rust based prog. that does the same thing
	#located in package/launcher
	cp "${FILESDIR}/quarto.combined.eprefix.1.8" quarto || die "Failed to copy quarto"
	sed "s#export QUARTO_BASE_PATH=\".*\"#export QUARTO_BASE_PATH=\"${S}/package/pkg-working/share\"#"\
		quarto > package/scripts/common/quarto || die "Failed to build quarto sandbox file"

	pushd "${WORKDIR}/node_modules" > /dev/null || die
		cp "${EPREFIX}/usr/bin/esbuild" "esbuild-linux-64/bin/esbuild" || die
		cp "${EPREFIX}/usr/bin/esbuild" "esbuild/bin/esbuild" || die
		sed -i "s/${ESBUILD_VER_ORIG}/$(esbuild --version)/g" esbuild/{install.js,lib/main.js} || die
	popd
	pushd "${WORKDIR}/deno_cache/npm/registry.npmjs.org/" > /dev/null || die
		cp "${EPREFIX}/usr/bin/esbuild-${ESBUILD_DEP_SLOT}" "@esbuild/linux-x64/0.20.2/bin/esbuild" || die
		sed -i "s/0.20.2/$(esbuild-${ESBUILD_DEP_SLOT} --version)/g" esbuild/0.20.2/lib/main.js || die
	popd

	DENO_DIR="src/resources/deno_std/cache" deno cache --allow-import --unstable-ffi --lock \
		src/resources/deno_std/deno_std.lock package/scripts/deno_std/deno_std.ts || die

	sed -i "s/\"esbuild\"/\"esbuild-${ESBUILD_DEP_SLOT}\"/" src/core/esbuild.ts || die

	#Setup links
	#ln -s "${DENO_CACHE}" package/src/x86_64 || die
	cp -a  "${WORKDIR}/node_modules" "${S}/src/webui/quarto-preview/node_modules" || die
	default
	eprefixify src/command/render/render-shared.ts quarto package/scripts/common/quarto
}
src_compile() {
	export DENO_DIR="${WORKDIR}/deno_cache"
	#disables creating symlink
	export QUARTO_NO_SYMLINK="TRUE"
	#This will tell quarto not to d/l binaries
	export QUARTO_VENDOR_BINARIES="false"
	export QUARTO_DENO="${EPREFIX}/usr/bin/deno"
	export QUARTO_DENO_DOM="${EPREFIX}/usr/lib64/deno-dom.so"
	export DENO_DOM_PLUGIN="${QUARTO_DENO_DOM}"
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
	rm build.ts && touch build.ts || die
	npm install &&	npm run build || die "Failed to build quarto-preview"
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
	#doins -r "${S}/package/pkg-working/bin/vendor"
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
