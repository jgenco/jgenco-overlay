# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The reference implementation of Sass, written in Dart. "
HOMEPAGE="https://sass-lang.com/dart-sass"
SRC_URI="
https://github.com/sass/dart-sass/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
"

#egrep "(name|url|version)" pubspec.lock |sed -E -l3 '{N;N; s/ +name: ([a-z_]+)\n +url: \"https:\/\/(.*)\"\n +version: \"(.*)\"/\2@\1@\3/}'
DART_BOARD="
pub.dartlang.org@_fe_analyzer_shared@12.0.0
pub.dartlang.org@analyzer@0.40.7
pub.dartlang.org@archive@2.0.13
pub.dartlang.org@args@1.6.0
pub.dartlang.org@async@2.8.2
pub.dartlang.org@boolean_selector@2.1.0
pub.dartlang.org@charcode@1.3.1
pub.dartlang.org@checked_yaml@1.0.4
pub.dartlang.org@cli_pkg@1.2.0
pub.dartlang.org@cli_repl@0.2.2
pub.dartlang.org@cli_util@0.2.0
pub.dartlang.org@clock@1.1.0
pub.dartlang.org@collection@1.16.0
pub.dartlang.org@convert@2.1.1
pub.dartlang.org@coverage@0.15.2
pub.dartlang.org@crypto@2.1.5
pub.dartlang.org@dart_style@1.3.10
pub.dartlang.org@file@5.2.1
pub.dartlang.org@glob@1.2.0
pub.dartlang.org@grinder@0.8.6
pub.dartlang.org@http@0.12.2
pub.dartlang.org@http_multi_server@3.2.0
pub.dartlang.org@http_parser@3.1.4
pub.dartlang.org@intl@0.17.0
pub.dartlang.org@io@1.0.3
pub.dartlang.org@js@0.6.4
pub.dartlang.org@json_annotation@4.4.0
pub.dartlang.org@logging@1.0.2
pub.dartlang.org@matcher@0.12.10
pub.dartlang.org@meta@1.7.0
pub.dartlang.org@mime@1.0.0
pub.dartlang.org@mustache@1.1.1
pub.dartlang.org@node_interop@1.2.1
pub.dartlang.org@node_io@1.2.0
pub.dartlang.org@node_preamble@1.4.13
pub.dartlang.org@package_config@1.9.3
pub.dartlang.org@package_resolver@1.0.10
pub.dartlang.org@path@1.8.1
pub.dartlang.org@pedantic@1.11.1
pub.dartlang.org@petitparser@3.1.0
pub.dartlang.org@pool@1.5.0
pub.dartlang.org@pub_semver@1.4.4
pub.dartlang.org@pubspec_parse@0.1.8
pub.dartlang.org@quiver@2.1.5
pub.dartlang.org@shelf@0.7.9
pub.dartlang.org@shelf_packages_handler@2.0.1
pub.dartlang.org@shelf_static@0.2.9+2
pub.dartlang.org@shelf_web_socket@0.2.4+1
pub.dartlang.org@source_map_stack_trace@2.1.0
pub.dartlang.org@source_maps@0.10.10
pub.dartlang.org@source_span@1.8.2
pub.dartlang.org@stack_trace@1.10.0
pub.dartlang.org@stream_channel@2.1.0
pub.dartlang.org@stream_transform@2.0.0
pub.dartlang.org@string_scanner@1.1.0
pub.dartlang.org@term_glyph@1.2.0
pub.dartlang.org@test@1.16.5
pub.dartlang.org@test_api@0.2.19
pub.dartlang.org@test_core@0.3.15
pub.dartlang.org@test_descriptor@1.2.0
pub.dartlang.org@test_process@1.0.5
pub.dartlang.org@tuple@1.0.3
pub.dartlang.org@typed_data@1.3.0
pub.dartlang.org@vm_service@6.2.0
pub.dartlang.org@watcher@0.9.7+15
pub.dartlang.org@web_socket_channel@1.2.0
pub.dartlang.org@webkit_inspection_protocol@1.0.0
pub.dartlang.org@xml@4.5.1
pub.dartlang.org@yaml@2.2.1
"
build_dart_uri(){
	local BOARD=$@
	local regex='(.*)@(.*)@(.*)'
	for MODULE in ${BOARD}
	do
		[[ ${MODULE} =~ ${regex} ]]
		MODULE_HOST=${BASH_REMATCH[1]}
		MODULE_NAME=${BASH_REMATCH[2]}
		MODULE_VERSION=${BASH_REMATCH[3]}
		FILE_EXT="tar.gz"
		MODULE_FILENAME_SAVE="dart_${MODULE_NAME}@${MODULE_VERSION}.${FILE_EXT}"
		MODULE_FILENAME_JSON="dart_${MODULE_NAME}-versions.json"
		echo "https://${MODULE_HOST}/packages/${MODULE_NAME}/versions/${MODULE_VERSION}.$FILE_EXT -> ${MODULE_FILENAME_SAVE}"
	done
}
SRC_URI="${SRC_URI} $(build_dart_uri ${DART_BOARD})"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip mirror"

DEPEND="
|| (
	>=dev-lang/dart-2.12.0
	>=dev-lang/dart-bin-2.12.0
	)
"
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=(CHANGELOG.md LICENSE README.md)

src_unpack() {
	mkdir -p ${WORKDIR}/.dart || die "Failed to make .dart dir"
	cat > ${WORKDIR}/.dart/dartdev.json <<-_EOF_
{
	"disclosureShown": true,
	"firstRun": false,
	"enabled": false
}
	_EOF_
	mkdir -p ${WORKDIR}/.pub-cache/hosted || die "Failed to create hosted dir"

	local MAIN_FILENAME="${P}.tar.gz"
	local FILE=""
	local regex_pkg="dart_(.*)@(.*).tar.gz"
	for FILE in  ${A}
	do
		if [[ ${FILE} == ${MAIN_FILENAME} ]]; then
			unpack ${FILE}
		elif [[ ${FILE} =~ ${regex_pkg} ]]; then
			local PACKAGE=${BASH_REMATCH[1]}
			local VERSION=${BASH_REMATCH[2]}
			#this will need to fixed when other host are used
			local MOD_DIR="${WORKDIR}/.pub-cache/hosted/pub.dartlang.org/${PACKAGE}-${VERSION}"
			mkdir -p ${WORKDIR}/.pub-cache/hosted/pub.dartlang.org/.cache || die "Failed to create .cache dir"
			mkdir -p ${MOD_DIR} || die "Failed to create $MOD_DIR"

			pushd ${MOD_DIR} > /dev/null || die "Failed to pushinto $MOD_DIR"
			unpack ${FILE}
			popd > /dev/null
		else
			die "Regexes didn't match ${FILE}"
		fi
	done
	mkdir ${S}/.dart_tool
}
src_compile(){
	export HOME="${WORKDIR}"
	dart pub get --offline || die "Pub get failed"
	dart compile exe bin/sass.dart -o sass || die "Compile failed"
}
src_test(){
	#93 test failed mostly if not completly b/c lack of null support
	#this is a new feature of the dart language.
	export HOME="${WORKDIR}"
	dart test
	}
src_install(){
	dobin sass
	einstalldocs
}
