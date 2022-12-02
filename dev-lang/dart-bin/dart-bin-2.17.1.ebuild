# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dart is a cohesive, scalable platform for building apps"
HOMEPAGE="https://dart.dev/"
#signing key: https://dl-ssl.google.com/linux/linux_signing_key.pub
#wget https://storage.googleapis.com/download.dartlang.org/linux/debian/dists/stable/Release{,.gpg}
#https://storage.googleapis.com/download.dartlang.org/linux/debian/dists/stable/main/binary-amd64/Packages
SRC_URI="https://storage.googleapis.com/download.dartlang.org/linux/debian/pool/main/d/dart/dart_${PV}-1_amd64.deb"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
src_unpack(){
	default
	mkdir ${S}
	tar xaf data.tar.xz -C ${S}
	}
src_install(){
	insinto /opt/dart
	doins -r usr
	mkdir ${D}/opt/bin
	ln -s  /opt/dart/usr/bin/dart ${D}/opt/bin
	chmod +x ${D}/opt/dart/usr/lib/dart/bin/dart*
	chmod +x ${D}/opt/dart/usr/lib/dart/bin/utils/gen_snapshot
}
