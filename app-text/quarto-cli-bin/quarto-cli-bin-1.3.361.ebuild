# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"
SRC_URI="https://github.com/quarto-dev/quarto-cli/releases/download/v${PV}/quarto-${PV}-linux-amd64.tar.gz"

LICENSE="GPL-2+ MIT ZLIB BSD Apache-2.0 ISC || ( MIT GPL-3 )"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	app-arch/unzip
	>=dev-lang/R-4.1.0
	dev-libs/libxml2
	dev-vcs/git
	sys-apps/which
	x11-misc/xdg-utils
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/quarto-${PV}"

QA_PREBUILT="
	/opt/quarto-cli/bin/tools/dart-sass/sass
	/opt/quarto-cli/bin/tools/deno_dom/libplugin.so
	/opt/quarto-cli/bin/tools/pandoc
	/opt/quarto-cli/bin/tools/deno-x86_64-unknown-linux-gnu/deno
	/opt/quarto-cli/bin/tools/esbuild
"
src_prepare() {
	#fix location of rserver-url
	sed -i "s#/usr/lib/rstudio-server/bin/rserver-url#${EPREFIX}/usr/bin/rserver-url#" \
		bin/quarto.js || die "failed to update path to rserver-url"
	default
}
src_install() {
	local install_dir="/opt/quarto-cli"
	insinto ${install_dir}
	doins -r .
	#strip removes to much and makes it not work
	dostrip -x ${install_dir}/bin/tools/dart-sass/sass

	fperms +x ${install_dir}/bin/quarto
	for bin in ${QA_PREBUILT};do
		fperms +x ${bin}
	done

	mkdir "${ED}/opt/bin"
	dosym -r /opt/quarto-cli/bin/quarto /opt/bin/quarto-bin
}
