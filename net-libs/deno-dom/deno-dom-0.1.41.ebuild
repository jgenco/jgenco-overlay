# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	autocfg@1.1.0
	bitflags@1.3.2
	cfg-if@1.0.0
	futf@0.1.5
	getrandom@0.1.16
	getrandom@0.2.11
	html5ever@0.25.2
	itoa@1.0.9
	libc@0.2.150
	lock_api@0.4.11
	log@0.4.20
	mac@0.1.1
	markup5ever@0.10.1
	new_debug_unreachable@1.0.4
	once_cell@1.18.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	phf@0.8.0
	phf_codegen@0.8.0
	phf_generator@0.8.0
	phf_generator@0.10.0
	phf_shared@0.8.0
	phf_shared@0.10.0
	ppv-lite86@0.2.17
	precomputed-hash@0.1.1
	proc-macro2@1.0.69
	quote@1.0.33
	rand@0.7.3
	rand@0.8.5
	rand_chacha@0.2.2
	rand_chacha@0.3.1
	rand_core@0.5.1
	rand_core@0.6.4
	rand_hc@0.2.0
	rand_pcg@0.2.1
	redox_syscall@0.4.1
	ryu@1.0.15
	scopeguard@1.2.0
	serde@1.0.192
	serde_derive@1.0.192
	serde_json@1.0.108
	siphasher@0.3.11
	smallvec@1.11.1
	static_vcruntime@2.0.0
	string_cache@0.8.7
	string_cache_codegen@0.5.2
	syn@1.0.109
	syn@2.0.39
	tendril@0.4.3
	unicode-ident@1.0.12
	utf-8@0.7.6
	wasi@0.9.0+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
"

inherit cargo deno

DENO_LIBS=(
	"std@0.97.0 https://github.com/denoland/deno_std/archive/refs/tags/_VER_.tar.gz std-_VER_ NA NA"
	"std@0.157.0 https://github.com/denoland/deno_std/archive/refs/tags/_VER_.tar.gz std-_VER_ NA NA"
	"plug@1.0.0-rc.3 https://github.com/denosaurs/plug/archive/refs/tags/_VER_.tar.gz plug-_VER_ NA NA"
)
MY_PV="$(ver_cut 1-4)-alpha-artifacts"

DESCRIPTION="Deno-DOM Plugin"
HOMEPAGE="https://deno.land/x/deno_dom"

SRC_URI="${CARGO_CRATE_URIS}
	https://github.com/b-fuze/deno-dom/archive/refs/tags/v${MY_PV}.tar.gz -> deno-dom-${MY_PV}.tgz
	test? ( $(deno_build_src_uri) )"
S=${WORKDIR}/${PN}-${MY_PV}
LICENSE="MIT Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT Unicode-DFS-2016 ZLIB"

SLOT="0"
KEYWORDS="amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	test? (
		net-libs/deno
	)
"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
#QA_FLAGS_IGNORED="usr/$(get_libdir)/${PN}"
src_unpack() {
	cargo_src_unpack
	use test && deno_src_unpack
}
src_compile() {
	pushd html-parser/plugin > /dev/null || die
	cargo_src_compile
	popd > /dev/null || die
	cp "$(cargo_target_dir)/libplugin.so" ${PN}.so || die "Failed to copy file"

	DENO_IMPORT_LIST="${FILESDIR}/deno-dom-${PV}.imports"
	use test && deno_build_src && deno_build_cache
}
src_install() {
	dolib.so ${PN}.so
}
src_test() {
	export DENO_DOM_PLUGIN="${S}/$(cargo_target_dir)/libplugin.so"

	#standerdize to older std to 0.97.0
	sed -i -E "s#std@0.[0-9]{2}.0#std@0.97.0#" \
		test/wpt.ts test/wpt-runner.ts test/units.ts test/units/* ||
		die "Failed to modify std version"
	sed -i "s#https://deno.land/std/testing/asserts.ts#https://deno.land/std@0.97.0/testing/asserts.ts#" \
		test/units/comments-outside-html-test.ts || die "Failed to set std version"

	deno test --unstable -A  native.test.ts
	#Quoting README.md: WPT tests are still a WIP, passed tests likely haven't actually passed.
	#requires downloading a version of wpt @ https://github.com/web-platform-tests/wpt
	#replace ${S}/wpt
	#deno test --allow-read --allow-net wasm.test.ts -- --wpt
}
