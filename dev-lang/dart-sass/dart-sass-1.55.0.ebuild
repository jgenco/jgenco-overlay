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
pub.dartlang.org@_fe_analyzer_shared@47.0.0
pub.dartlang.org@analyzer@4.7.0
pub.dartlang.org@archive@3.3.6
pub.dartlang.org@args@2.3.1
pub.dartlang.org@async@2.9.0
pub.dartlang.org@boolean_selector@2.1.1
pub.dartlang.org@charcode@1.3.1
pub.dartlang.org@checked_yaml@2.0.1
pub.dartlang.org@cli_pkg@2.2.0
pub.dartlang.org@cli_repl@0.2.3
pub.dartlang.org@cli_util@0.3.5
pub.dartlang.org@collection@1.17.0
pub.dartlang.org@convert@3.1.0
pub.dartlang.org@coverage@1.6.2
pub.dartlang.org@crypto@3.0.2
pub.dartlang.org@csslib@0.17.2
pub.dartlang.org@dart_style@2.2.4
pub.dartlang.org@dartdoc@6.1.1
pub.dartlang.org@file@6.1.4
pub.dartlang.org@frontend_server_client@2.1.3
pub.dartlang.org@glob@2.1.1
pub.dartlang.org@grinder@0.9.3
pub.dartlang.org@html@0.15.1
pub.dartlang.org@http@0.13.5
pub.dartlang.org@http_multi_server@3.2.1
pub.dartlang.org@http_parser@4.0.2
pub.dartlang.org@io@1.0.4
pub.dartlang.org@js@0.6.5
pub.dartlang.org@json_annotation@4.7.0
pub.dartlang.org@lints@2.0.1
pub.dartlang.org@logging@1.1.0
pub.dartlang.org@markdown@6.0.1
pub.dartlang.org@matcher@0.12.12
pub.dartlang.org@meta@1.9.0
pub.dartlang.org@mime@1.0.3
pub.dartlang.org@node_interop@2.1.0
pub.dartlang.org@node_preamble@2.0.1
pub.dartlang.org@oauth2@2.0.1
pub.dartlang.org@package_config@2.1.0
pub.dartlang.org@path@1.8.3
pub.dartlang.org@petitparser@5.0.0
pub.dartlang.org@pointycastle@3.6.2
pub.dartlang.org@pool@1.5.1
pub.dartlang.org@pub_api_client@2.3.0
pub.dartlang.org@pub_semver@2.1.3
pub.dartlang.org@pubspec@2.3.0
pub.dartlang.org@pubspec_parse@1.2.1
pub.dartlang.org@quiver@3.2.1
pub.dartlang.org@retry@3.1.0
pub.dartlang.org@shelf@1.4.0
pub.dartlang.org@shelf_packages_handler@3.0.1
pub.dartlang.org@shelf_static@1.1.1
pub.dartlang.org@shelf_web_socket@1.0.3
pub.dartlang.org@source_map_stack_trace@2.1.1
pub.dartlang.org@source_maps@0.10.10
pub.dartlang.org@source_span@1.9.1
pub.dartlang.org@stack_trace@1.10.0
pub.dartlang.org@stream_channel@2.1.1
pub.dartlang.org@stream_transform@2.1.0
pub.dartlang.org@string_scanner@1.1.1
pub.dartlang.org@term_glyph@1.2.1
pub.dartlang.org@test@1.21.4
pub.dartlang.org@test_api@0.4.12
pub.dartlang.org@test_core@0.4.16
pub.dartlang.org@test_descriptor@2.0.1
pub.dartlang.org@test_process@2.0.3
pub.dartlang.org@tuple@2.0.1
pub.dartlang.org@typed_data@1.3.1
pub.dartlang.org@uri@1.0.0
pub.dartlang.org@vm_service@9.4.0
pub.dartlang.org@watcher@1.0.2
pub.dartlang.org@web_socket_channel@2.3.0
pub.dartlang.org@webkit_inspection_protocol@1.2.0
pub.dartlang.org@xml@5.4.1
pub.dartlang.org@yaml@3.1.1
"
build_dart_uri(){
	local board=$@
	local regex='(.*)@(.*)@(.*)'
	for module in ${board}
	do
		[[ ${module} =~ ${regex} ]]
		local module_host=${BASH_REMATCH[1]}
		local module_name=${BASH_REMATCH[2]}
		local module_version=${BASH_REMATCH[3]}
		local file_ext="tar.gz"
		local module_filename_save="dart_${module_name}@${module_version}.${file_ext}"
		#module_filename_json="dart_${module_name}-versions.json"
		echo "https://${module_host}/packages/${module_name}/versions/${module_version}.$file_ext -> ${module_filename_save}"
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

	local main_filename="${P}.tar.gz"
	local file=""
	local regex_pkg="dart_(.*)@(.*).tar.gz"
	for file in  ${A}
	do
		if [[ ${file} == ${main_filename} ]]; then
			unpack ${file}
		elif [[ ${file} =~ ${regex_pkg} ]]; then
			local package=${BASH_REMATCH[1]}
			local version=${BASH_REMATCH[2]}
			#this will need to fixed when other host are used
			local mod_dir="${WORKDIR}/.pub-cache/hosted/pub.dartlang.org/${package}-${version}"
			mkdir -p ${WORKDIR}/.pub-cache/hosted/pub.dartlang.org/.cache || die "Failed to create .cache dir"
			mkdir -p ${mod_dir} || die "Failed to create $mod_dir"

			pushd ${mod_dir} > /dev/null || die "Failed to pushinto $mod_dir"
			unpack ${file}
			popd > /dev/null
		else
			die "Regexes didn't match ${file}"
		fi
	done
	mkdir ${S}/.dart_tool
}
src_compile(){
	export HOME="${WORKDIR}"
	dart pub get --offline || die "Pub get failed"
	dart compile exe -Dversion="${PV}" bin/sass.dart -o sass || die "Compile failed"
}
src_test(){
	# 7 test failed it suggest to run dart run grinder pkg-npm-dev
	export HOME="${WORKDIR}"
	dart test
}
src_install(){
	dobin sass
	einstalldocs
}