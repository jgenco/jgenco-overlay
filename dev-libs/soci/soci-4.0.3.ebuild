# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Simple Open (Database) Call Interface - write SQL in C++"
HOMEPAGE="https://github.com/SOCI/soci"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
IUSE="boost firebird mysql odbc oracle postgres +sqlite test"
RESTRICT="!test? ( test )"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	boost? ( >=dev-libs/boost-1.33.1:= )
	firebird? ( dev-db/firebird )
	mysql? ( dev-db/mysql:5.7= )
	odbc? ( dev-db/unixODBC )
	oracle? ( dev-db/oracle-instantclient )
	postgres? ( dev-db/postgresql:* )
	sqlite? ( dev-db/sqlite )
"
DEPEND="
	${RDEPEND}
"

#PATCHES=( "${FILESDIR}/${PN}-4.0.1-cmake-config-path.patch" )

src_configure() {
	local mycmakeargs=(
		-DSOCI_CXX11=ON
		-DSOCI_STATIC=OFF
		-DSOCI_TESTS=$(usex test)
		-DWITH_BOOST=$(usex boost)
		-DWITH_DB2=OFF
		-DWITH_FIREBIRD=$(usex firebird)
		-DWITH_MYSQL=$(usex mysql)
		-DWITH_ODBC=$(usex odbc)
		-DWITH_ORACLE=$(usex oracle)
		-DWITH_POSTGRESQL=$(usex postgres)
		-DWITH_SQLITE3=$(usex sqlite)
	)

	cmake_src_configure
}

src_test() {
	# I can confirm that these two sets of test work properly in the network
	# sandbox. I don't think the other backend tests work in the sandbox though.
	local myctestargs=(
		-R "soci_((empty)|(sqlite3))"
	)

	cmake_src_test
}
