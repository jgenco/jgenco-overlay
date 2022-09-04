# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.2

EAPI=8

CRATES="
	autocfg-1.1.0
	bitflags-1.3.2
	cfg-if-1.0.0
	futf-0.1.5
	getrandom-0.1.16
	getrandom-0.2.7
	html5ever-0.25.2
	itoa-1.0.3
	libc-0.2.132
	lock_api-0.4.8
	log-0.4.17
	mac-0.1.1
	markup5ever-0.10.1
	new_debug_unreachable-1.0.4
	once_cell-1.14.0
	parking_lot-0.12.1
	parking_lot_core-0.9.3
	phf-0.8.0
	phf_codegen-0.8.0
	phf_generator-0.8.0
	phf_generator-0.10.0
	phf_shared-0.8.0
	phf_shared-0.10.0
	ppv-lite86-0.2.16
	precomputed-hash-0.1.1
	proc-macro2-1.0.43
	quote-1.0.21
	rand-0.7.3
	rand-0.8.5
	rand_chacha-0.2.2
	rand_chacha-0.3.1
	rand_core-0.5.1
	rand_core-0.6.3
	rand_hc-0.2.0
	rand_pcg-0.2.1
	redox_syscall-0.2.16
	ryu-1.0.11
	scopeguard-1.1.0
	serde-1.0.144
	serde_json-1.0.85
	siphasher-0.3.10
	smallvec-1.9.0
	string_cache-0.8.4
	string_cache_codegen-0.5.2
	syn-1.0.99
	tendril-0.4.3
	unicode-ident-1.0.3
	utf-8-0.7.6
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	windows-sys-0.36.1
	windows_aarch64_msvc-0.36.1
	windows_i686_gnu-0.36.1
	windows_i686_msvc-0.36.1
	windows_x86_64_gnu-0.36.1
	windows_x86_64_msvc-0.36.1
"

inherit cargo

DESCRIPTION="Deno-DOM Plugin"
HOMEPAGE="https://deno.land/x/deno_dom"
P_VER="$(ver_cut 1-4)-artifacts"
SRC_URI="$(cargo_crate_uris) "
SRC_URI+="https://github.com/b-fuze/deno-dom/archive/refs/tags/v${P_VER/_/-}.tar.gz -> deno-dom-${PV}.tgz"
S=${WORKDIR}/${PN}-${P_VER/_/-}

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="MIT Apache-2.0 Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
src_compile(){
	pushd html-parser/plugin > /dev/null
	cargo_src_compile
	popd > /dev/null
	mv target/release/libplugin.so ${PN}.so
}
src_install(){
	dolib.so ${PN}.so
}
