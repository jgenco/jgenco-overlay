# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="diff template library written by C++"
HOMEPAGE="https://github.com/cubicdaiya/dtl"
SRC_URI="https://github.com/cubicdaiya/dtl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

#uses scons for installing/testing
src_install() {
	insinto /usr/include/
	doins -r "${S}/dtl"
	default
}
