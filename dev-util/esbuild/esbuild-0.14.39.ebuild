# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="An extremely fast JavaScript and CSS bundler and minifier "
HOMEPAGE="https://esbuild.github.io/"

EGO_SUM=(
	"golang.org/x/sys v0.0.0-20210908233432-aa78b53d3365/go.mod"
	"golang.org/x/sys v0.0.0-20210908233432-aa78b53d3365"
	)
go-module_set_globals

SRC_URI="
	https://github.com/evanw/esbuild/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="MIT BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	dobin esbuild
}
