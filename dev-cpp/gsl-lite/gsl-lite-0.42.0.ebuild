# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A single-file header-only version of ISO C++ Guidelines Support Library (GSL)"
HOMEPAGE="https://github.com/gsl-lite/gsl-lite"
SRC_URI="https://github.com/gsl-lite/gsl-lite/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="${DEPEND}"
src_prepare() {
	sed -E -i  's/"--?Werror"//' test/MakeTestTarget.cmake
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSL_LITE_OPT_BUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}
