# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# hat tip to https://github.com/mausys and https://github.com/danielrobbins

# todo:
# debundle third party libs if possible
# use cflags - could pose problems - build/config/compiler/BUILD.gn
# use github sources to reduce d/l prebuilt clang and third party libs
# update LICENSE for the third party libs

EAPI=8
#19 fails fixed in 3.5.0ish - 2d0e514583129f30da2a529ae00a65ede4870c7a
LLVM_COMPAT=( 18, 20 )
LLVM_OPTIONAL=1

PYTHON_COMPAT=( python3_{12..13} )

inherit check-reqs llvm-r1 ninja-utils python-any-r1

DESCRIPTION="An approachable, portable, and productive language for high-quality apps"
HOMEPAGE="https://dart.dev/"
SRC_URI="https://storage.googleapis.com/dart-archive/channels/stable/release/${PV}/linux_packages/dart_${PV}.orig.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}/dart"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="llvm"

REQUIRED_USE="llvm? ( ${LLVM_REQUIRED_USE} )"

DEPEND="${PYTHON_DEPS}"
BDEPEND="
	dev-build/gn
	dev-build/ninja
	llvm? ( $(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}
		llvm-core/llvm:${LLVM_SLOT}
	') )
	!llvm? ( sys-devel/gcc-config )
"
PATCHES=(
	"${FILESDIR}/dart-3.7.2.patch"
)

DOCS="AUTHORS CHANGELOG.md LICENSE OWNERS PATENT_GRANT README* SECURITY.md"

pkg_pretend() {
	#This used 8.1GB using 9G for safety
	CHECKREQS_DISK_BUILD="$(usex llvm 6 9)G"
	check-reqs_pkg_pretend
}

pkg_setup() {
	CHECKREQS_DISK_BUILD="$(usex llvm 6 9)G"
	check-reqs_pkg_setup
	use llvm && llvm-r1_pkg_setup
	python_setup
}

src_prepare() {
	#fun fact these `rm`s removes 2.2G of 3.6G!
	rm -r ../debian || die
	rm -rf buildtools build/linux || die
	default
}
src_configure() {
	local gn_args=(
		dart_debug = false
		dart_platform_sdk = false
		dart_runtime_mode = \"develop\"
		dart_snapshot_kind = \"app-jit\"
		dart_stripped_binary = \"exe.stripped/dart\"
		dart_target_arch = \"x64\"
		dart_use_crashpad = false
		dart_use_fallback_root_certificates = true
		dart_vm_code_coverage = false
		exclude_kernel_service = false
		goma_dir = \"None\"
		host_cpu = \"x64\"
		is_asan = false
		is_debug = false
		is_msan = false
		is_product = false
		is_release = true
		is_tsan = false
		target_cpu = \"x64\"
		target_os = \"linux\"
		target_sysroot = \"\"
		use_goma = false
		custom_cflags_c  = [$(printf \"%s\",  ${CFLAGS[@]})]
		custom_cflags_cc = [$(printf \"%s\",  ${CXXFLAGS[@]})]
		custom_ldflags   = [$(printf \"%s\",  ${LDFLAGS[@]})]
	)
	if use llvm; then
		gn_args+=(
			llvm_prefix = \"$(get_llvm_prefix)\"
			is_clang = true
		)
	else
		gn_args+=(
			x64_toolchain_prefix = \"$(gcc-config --get-bin-path 2> /dev/null)/\"
			is_clang = false
		)
	fi
	#what black magic is this?
	gn_args="${gn_args[@]}"
	gn gen --args="${gn_args}" out || die

}

src_compile() {
	eninja -C out create_sdk
}

#add test

src_install() {
	local instdir=/usr/$(get_libdir)/dart-sdk

	insinto ${instdir}
	doins -r "${S}/out/dart-sdk/"*

	dosym -r ${instdir}/bin/dart /usr/bin/dart
	fperms +x ${instdir}/bin/dart{,aotruntime}
	fperms +x ${instdir}/bin/utils/{gen_snapshot,wasm-opt}

	einstalldocs
}
