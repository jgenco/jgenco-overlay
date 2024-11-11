# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source scientific and technical publishing system built on Pandoc."
HOMEPAGE="https://quarto.org/"
SRC_URI="https://github.com/quarto-dev/quarto-cli/releases/download/v${PV}/quarto-${PV}-linux-amd64.tar.gz -> ${P}-linux-amd64.tar.gz"

S="${WORKDIR}/quarto-${PV}"

LICENSE="MIT GPL-2+ ZLIB BSD BSD-2 Apache-2.0 ISC || ( MIT GPL-3 ) Unlicense 0BSD"
LICENSE+=" GPL-2+" #pandoc
LICENSE+=" 0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions Artistic-2 BSD BSD-1 BSD-2 Boost-1.0 CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB openssl SSLeay" #deno 1.41.0
LICENSE+=" MIT Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT Unicode-DFS-2016 ZLIB" #deno-dom 0.1.41
LICENSE+=" 0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB SSLeay openssl UoI-NCSA OFL-1.1 GFL BitstreamVera" #typst 0.11.0
LICENSE+=" MIT Apache-2.0 BSD" #dart-sass 1.70.0
LICENSE+=" MIT BSD-2" #esbuild 0.19.5

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
	opt/quarto-cli/bin/tools/${ARCH_FOLDER}/dart-sass/src/sass.snapshot
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
		[[ ${bin} =~ sass.snapshot ]] && continue
		fperms +x /${bin}
	done

	mkdir "${ED}/opt/bin"
	dosym -r ${install_dir}/bin/quarto /opt/bin/quarto-bin
	dosym -r ${install_dir}/bin/quarto /opt/bin/quarto
}
