# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"
SRC_URI="https://github.com/quarto-dev/quarto-cli/releases/download/v${PV}/quarto-${PV}-linux-amd64.tar.gz -> ${P}-linux-amd64.tar.gz"

S="${WORKDIR}/quarto-${PV}"

LICENSE="MIT GPL-2+ ZLIB BSD BSD-2 Apache-2.0 ISC Unlicense 0BSD BSD"
LICENSE+=" GPL-2+" #app-text/pandoc
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0
	CC0-1.0 ISC MIT MPL-2.0 MPL-2.0 Unicode-3.0 Unicode-DFS-2016 ZLIB
" # net-libs/deno 2.3.1
LICENSE+=" MIT Apache-2.0 Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT Unicode-DFS-2016" #deno-dom 0.1.35
LICENSE+="
	Apache-2.0 BSD-2 BSD Boost-1.0 CC0-1.0 ISC MIT MPL-2.0 UoI-NCSA
	Unicode-3.0 ZLIB OFL-1.1 GFL BitstreamVera
" #app-text/typst 0.13.0
LICENSE+=" MIT Apache-2.0 BSD" #dev-lang/dart-sass 1.87.0
LICENSE+=" MIT BSD-2" #dev-util/esbuild 0.25.3

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

ARCH_FOLDER="x86_64"

QA_PREBUILT="
	opt/quarto-cli/bin/tools/${ARCH_FOLDER}/dart-sass/sass
	opt/quarto-cli/bin/tools/${ARCH_FOLDER}/deno_dom/libplugin.so
	opt/quarto-cli/bin/tools/${ARCH_FOLDER}/pandoc
	opt/quarto-cli/bin/tools/${ARCH_FOLDER}/deno
	opt/quarto-cli/bin/tools/${ARCH_FOLDER}/esbuild
	opt/quarto-cli/bin/tools/${ARCH_FOLDER}/typst
	opt/quarto-cli/bin/tools/${ARCH_FOLDER}/dart-sass/src/dart
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
	dostrip -x ${install_dir}/bin/tools/${ARCH_FOLDER}/dart-sass/sass

	fperms +x ${install_dir}/bin/quarto
	for bin in ${QA_PREBUILT};do
		fperms +x /${bin}
	done

	mkdir "${ED}/opt/bin"
	dosym -r /opt/quarto-cli/bin/quarto /opt/bin/quarto-bin
	dosym -r /opt/quarto-cli/bin/quarto /opt/bin/quarto
}
