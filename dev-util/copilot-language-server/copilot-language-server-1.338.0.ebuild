# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#grep -o '${pkg}:"[0-9.^]\+"' main.js
#kerberos@2.2.0; sqlite3@5.1.7
DEPS_VER="1.294.0"

DESCRIPTION="GitHub Copilot Language Server"
HOMEPAGE="https://github.com/features/copilot"
SRC_URI="
	https://github.com/github/${PN}-release/releases/download/${PV}/${PN}-js-${PV}.zip -> ${P}-js.zip
	https://github.com/jgenco/jgenco-overlay-files/releases/download/${PN}-${DEPS_VER}/${PN}-${DEPS_VER}_deps.tar.xz
"

LICENSE="MIT"
LICENSE+=" Apache-2.0 BSD ( BSD MIT Apache-2.0 ) ISC MIT ( MIT WTFPL-2 )"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-arch/unzip
	app-crypt/mit-krb5
	dev-db/sqlite
	dev-libs/icu
	net-libs/nodejs
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
#sqlite3:"^5.1.7"
#kerberos:"^2.2.0"
src_unpack() {
	mkdir -p ${P}/${PN} && pushd ${P}/${PN} > /dev/null || die
	unpack ${P}-js.zip
	popd
	unpack ${PN}-${DEPS_VER}_deps.tar.xz
	cd "copilot_${DEPS_VER}_deps" || die
	local install_version="$(grep installVersion "${EPREFIX}/usr/$(get_libdir)/node_modules/npm/node_modules/node-gyp/package.json" |sed -E 's/.* ([0-9]+),/\1/')"
	[[ ${install_version} =~ ^[0-9]+$ ]] || die

	#prepare node headers
	local nodejs_version=$(node -v) || die "Node version not found"
	nodejs_version=${nodejs_version#v}
	mkdir -p "${WORKDIR}/.cache/node-gyp/${nodejs_version}/include" || die
	ln -s "${EPREFIX}/usr/include/node" "${WORKDIR}/.cache/node-gyp/${nodejs_version}/include/node" || die
	#This tells it the headers where installed
	echo "${install_version}" > "${WORKDIR}/.cache/node-gyp/${nodejs_version}/installVersion" || die
}
src_configure() {
	NODE_GYP="${EPREFIX}/usr/$(get_libdir)/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js"
	NODE_MODULES="${WORKDIR}/copilot_${DEPS_VER}_deps/node_modules"
	export HOME="${WORKDIR}"
	export XDG_CACHE_HOME="${WORKDIR}/.cache" \

	cd "${NODE_MODULES}/sqlite3" || die
	"${NODE_GYP}" configure --sqlite="${EPREFIX}/usr/include" || die

	cd "${NODE_MODULES}/kerberos"|| die
	"${NODE_GYP}" configure || die
}
src_compile() {
	einfo "Building node_sqlite3.node"
	cd "${NODE_MODULES}/sqlite3"|| die
	"${NODE_GYP}" build -v || die

	einfo "Building kerberos.node"
	cd "${NODE_MODULES}/kerberos"|| die
	"${NODE_GYP}" build -v || die

	#replace with newly compiled nodes files
	cd "${S}/${PN}" || die
	rm -r compiled crypt32.node || die
	local node_dir="compiled/linux/x64/"
	mkdir -p ${node_dir}/
	cp "${NODE_MODULES}/sqlite3/build/Release/node_sqlite3.node" ${node_dir}/node_sqlite3.node || die
	cp "${NODE_MODULES}/kerberos/build/Release/kerberos.node" ${node_dir}/kerberos.node || die
}
src_install() {
	newbin - ${PN} <<-EOF
	#!/bin/sh
	node "${EPREFIX}/usr/share/${PN}/main.js" "\$@"
	EOF

	insinto /usr/share/
	doins -r ${PN}
	fperms +x /usr/share/${PN}/compiled/linux/x64/{kerberos,node_sqlite3}.node
}
