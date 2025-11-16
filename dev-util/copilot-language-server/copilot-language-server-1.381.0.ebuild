# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )

inherit python-any-r1

#grep -Eo '${pkg}"?:"[0-9.^]+' main.js
#kerberos@2.2.0; sqlite3@5.1.7
#@vscode/policy-watcher@1.3.2
DEPS_VER="1.387.0"

DESCRIPTION="GitHub Copilot Language Server"
HOMEPAGE="https://github.com/features/copilot"
SRC_URI="
	https://github.com/github/${PN}-release/releases/download/${PV}/${PN}-js-${PV}.zip -> ${P}-js.zip
	https://github.com/jgenco/jgenco-overlay-files/releases/download/${PN}-${DEPS_VER}/${PN}-${DEPS_VER}_deps.tar.xz
"

S="${WORKDIR}/${PN}"
LICENSE="MIT"
LICENSE+=" Apache-2.0 BSD || ( BSD MIT Apache-2.0 ) ISC MIT || ( MIT WTFPL-2 ) "
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	app-arch/unzip
	app-crypt/mit-krb5
	dev-db/sqlite
	dev-libs/icu
	net-libs/nodejs
	sys-apps/ripgrep
	sys-libs/zlib
"
BDEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

SYS_ARCH="linux/x64"

NODE_FILES=(
	kerberos
	node_sqlite3
	vscode-policy-watcher
)
NODE_PKGS=(
	kerberos
	sqlite3
	@vscode/policy-watcher
)
src_unpack() {
	unpack ${PN}-${DEPS_VER}_deps.tar.xz
	mkdir -p ${PN} && cd ${PN} || die
	unpack ${P}-js.zip
}
src_prepare() {
	default
	for node in ${NODE_FILES[@]} ; do
		rm compiled/${SYS_ARCH}/${node}.node|| die "missing ${node}"
	done
	rm bin/${SYS_ARCH}/rg crypt32{,-arm64}.node || die "missing files(s)"
	rmdir {bin,compiled}/${SYS_ARCH} || die "nonempty dir(s)"
	rm -r bin  compiled || die
	rm policy-templates/{darwin,win32} -r || die
	rmdir policy-templates || die "Not empty"
	mkdir -p {bin,compiled}/${SYS_ARCH} || die "can't create binary dirs"

	cd "../copilot_${DEPS_VER}_deps" || die
	local install_version="$(grep installVersion \
		"${EPREFIX}/usr/$(get_libdir)/node_modules/npm/node_modules/node-gyp/package.json" |\
		sed -E 's/.* ([0-9]+),/\1/')"
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

	for pkg in ${NODE_PKGS[@]} ; do
		einfo "Configuring ${pkg}"
		cd "${NODE_MODULES}/${pkg}" || die
		local conf_opts=""
		[[ ${pkg} == sqlite3 ]] && conf_opts="-sqlite=${EPREFIX}/usr/include"
		"${NODE_GYP}" configure -v ${conf_opts} || die
	done
}

src_compile() {
	for pkg in ${NODE_PKGS[@]} ; do
		einfo "Building ${pkg}"
		cd "${NODE_MODULES}/${pkg}"|| die
		"${NODE_GYP}" build -v || die
	done
}

src_install() {
	#replace with newly compiled nodes files
	for i in "${!NODE_FILES[@]}"; do
		cp "${NODE_MODULES}/${NODE_PKGS[$i]}/build/Release/${NODE_FILES[$i]}.node" \
		"${S}/compiled/${SYS_ARCH}" || die
	done

	newbin - ${PN} <<-EOF
	#!/bin/sh
	node "${EPREFIX}/usr/share/${PN}/main.js" "\$@"
	EOF

	insinto /usr/share/
	doins -r "${S}"
	for node in ${NODE_FILES[@]} ; do
		fperms +x /usr/share/${PN}/compiled/${SYS_ARCH}/${node}.node
	done
	dosym -r /usr/bin/rg /usr/share/${PN}/bin/${SYS_ARCH}/rg
}
