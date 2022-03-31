# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"
SRC_URI="
	https://github.com/quarto-dev/quarto-cli/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"
#These are download by the user
#MIT denos_std, acorn{,-walk}, blueimp-md5, lodash
#BSD jsdiff 
#ISC @observablehq/parser

LICENSE="GPL-2+ MIT BSD ISC"
SLOT="0"
KEYWORDS="~amd64"
PATCHES="${FILESDIR}/quarto-cli-0.9.83-pathfixes.patch"
#I think esbuild is for when we can bundle quarto into one file

DEPEND="
	net-libs/deno
	>=app-text/pandoc-2.17.1.1
	dev-lang/dart-sass
	dev-util/esbuild
	net-libs/deno-dom
"
RDEPEND="${DEPEND}"
BDEPEND=""
src_compile(){
	#we currently just use the unbundled dev version
	#to bundle this is a rough outline of what is needed
	#mkdir -p ${S}/package/dist/bin/
	#cd ${S}/package/dist/bin
	#ln -s /usr/bin/deno deno
	#deno cache --reload ../../../src/quarto.ts --unstable --import-map=../../../src/import_map.json
	#these will need to be converted to patches
	#export QUARTO_ROOT_DIR="${S}"
	#cp configure2.ts common/configure.ts
	#cp config.ts  /tmp/quarto-cli-0.9.83/package/src/common/config.ts
	#cd ${S}/package/src
	#./quarto-bld configure --log-level info
	#NOTE might have to populate bin
	#cd ${S}/package/dist/bin
	#mkdir dart-sass
	#ln -s /usr/bin/sass dart-sass/sass
	#ln -s /usr/bin/pandoc pandoc
	#ln -s /usr/bin/esbuild esbuild
	#mkdir deno_dom
	#ln -s /usr/lib64/deno-dom.so deno_dom/libplugin.so
	#cd ${S}/package/src
	#./quarto-bld prepare-dist --log-level info

	#
	source configuration
	QUARTO_MD5=`md5sum ${FILESDIR}/quarto`
	mkdir -p package/dist/config/
	echo -n "{\"deno\": \"${DENO}\",\"deno_dom\": \"${DENO_DOM}\",\"pandoc\": \"${PANDOC}\",\"dartsass\": \"${DARTSASS}\",\"esbuild\": \"${ESBUILD}\",\"script\": \"${QUARTO_MD5:0:32}\"}" > package/dist/config/dev-config
	echo -n "${DENO}"> package/dist/config/deno-version
	echo -n "${PV}"  > src/resources/version
	rm tests/bin/python3
	ln -s /usr/bin/python tests/bin/python3
}
src_install(){
	dobin ${FILESDIR}/quarto
	#dobin src/resources/formats/html/quarto.js
	#remember to change folder name to quarto
	insinto /usr/share/${PN}/
	doins -r *
}
