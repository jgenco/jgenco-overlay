# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit npm

SASS_SASS_SHA="df76115b586b048f161a7545ae5d0557b99e2a28"
SASS_SASS_DATE="20260719"

TESTING_NPMS="
	chokidar@5.0.0
	detect-libc@2.1.2
	immutable@5.1.9
	intercept-stdout@0.1.2
	is-extglob@2.1.1
	is-glob@4.0.3
	lodash._arraycopy@3.0.0
	lodash._basevalues@3.0.0
	lodash._getnative@3.9.1
	lodash.isarguments@3.1.0
	lodash.isarray@3.0.4
	lodash.keys@3.1.2
	lodash.toarray@3.0.2
	node-addon-api@7.1.1
	@parcel/watcher@2.5.6
	@parcel/watcher-android-arm64@2.5.6
	@parcel/watcher-darwin-arm64@2.5.6
	@parcel/watcher-darwin-x64@2.5.6
	@parcel/watcher-freebsd-x64@2.5.6
	@parcel/watcher-linux-arm64-glibc@2.5.6
	@parcel/watcher-linux-arm64-musl@2.5.6
	@parcel/watcher-linux-arm-glibc@2.5.6
	@parcel/watcher-linux-arm-musl@2.5.6
	@parcel/watcher-linux-x64-glibc@2.5.6
	@parcel/watcher-linux-x64-musl@2.5.6
	@parcel/watcher-win32-arm64@2.5.6
	@parcel/watcher-win32-ia32@2.5.6
	@parcel/watcher-win32-x64@2.5.6
	picomatch@4.0.5
	readdirp@5.0.0
"

DESCRIPTION="The reference implementation of Sass, written in Dart. "
HOMEPAGE="https://sass-lang.com/dart-sass"
SRC_URI="
	https://github.com/sass/dart-sass/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/sass/sass/archive/${SASS_SASS_SHA}.tar.gz -> sass-sass-${SASS_SASS_DATE}.tar.gz
	test? (
		$(npm_build_src_uri ${TESTING_NPMS})
	)
"

#egrep "(name|url|version)" pubspec.lock |sed -E -l3 '{N;N; s/ +name: ([a-z_0-9]+)\n +url: \"https:\/\/(.*)\"\n +version: \"(.*)\"/\t\2@\1@\3/}'
DART_BOARD="
	pub.dev@_fe_analyzer_shared@96.0.0
	pub.dev@analyzer@10.2.0
	pub.dev@archive@4.0.9
	pub.dev@args@2.7.0
	pub.dev@async@2.13.1
	pub.dev@boolean_selector@2.1.2
	pub.dev@charcode@1.4.0
	pub.dev@checked_yaml@2.0.4
	pub.dev@cli_config@0.2.0
	pub.dev@cli_pkg@2.15.1
	pub.dev@cli_repl@0.2.3
	pub.dev@cli_util@0.4.2
	pub.dev@collection@1.19.1
	pub.dev@convert@3.1.2
	pub.dev@coverage@1.15.1
	pub.dev@crypto@3.0.7
	pub.dev@csslib@1.0.2
	pub.dev@dart_mappable@4.8.0
	pub.dev@dart_style@3.1.7
	pub.dev@dartdoc@9.0.4
	pub.dev@ffi@2.2.0
	pub.dev@file@7.0.1
	pub.dev@fixnum@1.1.1
	pub.dev@frontend_server_client@4.0.0
	pub.dev@glob@2.1.3
	pub.dev@grinder@0.9.5
	pub.dev@html@0.15.6
	pub.dev@http@1.6.0
	pub.dev@http_multi_server@3.2.2
	pub.dev@http_parser@4.1.2
	pub.dev@io@1.0.5
	pub.dev@js@0.6.7
	pub.dev@json_annotation@4.12.0
	pub.dev@lints@6.1.0
	pub.dev@logging@1.3.0
	pub.dev@markdown@7.3.1
	pub.dev@matcher@0.12.20
	pub.dev@meta@1.19.0
	pub.dev@mime@2.0.0
	pub.dev@native_stack_traces@0.6.1
	pub.dev@native_synchronization@0.3.1
	pub.dev@node_interop@2.2.0
	pub.dev@node_preamble@2.0.2
	pub.dev@oauth2@2.0.5
	pub.dev@package_config@2.2.0
	pub.dev@path@1.9.1
	pub.dev@petitparser@7.0.2
	pub.dev@pool@1.5.2
	pub.dev@posix@6.5.0
	pub.dev@protobuf@6.0.0
	pub.dev@protoc_plugin@25.0.0
	pub.dev@pub_api_client@3.2.0
	pub.dev@pub_semver@2.2.0
	pub.dev@pubspec_parse@1.5.0
	pub.dev@retry@3.1.2
	pub.dev@shelf@1.4.2
	pub.dev@shelf_packages_handler@3.0.2
	pub.dev@shelf_static@1.1.3
	pub.dev@shelf_web_socket@3.0.0
	pub.dev@source_map_stack_trace@2.1.2
	pub.dev@source_maps@0.10.13
	pub.dev@source_span@1.10.2
	pub.dev@stack_trace@1.12.1
	pub.dev@stream_channel@2.1.4
	pub.dev@stream_transform@2.1.1
	pub.dev@string_scanner@1.4.1
	pub.dev@term_glyph@1.2.2
	pub.dev@test@1.31.1
	pub.dev@test_api@0.7.12
	pub.dev@test_core@0.6.18
	pub.dev@test_descriptor@2.0.2
	pub.dev@test_process@2.1.1
	pub.dev@type_plus@2.1.1
	pub.dev@typed_data@1.4.0
	pub.dev@vm_service@15.2.0
	pub.dev@watcher@1.2.1
	pub.dev@web@1.1.1
	pub.dev@web_socket@1.0.1
	pub.dev@web_socket_channel@3.0.3
	pub.dev@webkit_inspection_protocol@1.2.1
	pub.dev@xml@6.6.1
	pub.dev@yaml@3.1.3
"
DART_REGEX='(.*)@(.*)@(.*)'

build_dart_uri() {
	local board=$@
	for module in ${board}
	do
		[[ ${module} =~ ${DART_REGEX} ]]
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
LICENSE="MIT Apache-2.0 BSD"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="strip mirror !test? ( test )"

BDEPEND="
	>=dev-lang/dart-bin-3.9.0
	dev-util/buf
	test? ( net-libs/nodejs )
"

DOCS=(CHANGELOG.md LICENSE README.md)
QA_FLAGS_IGNORED='.*'
src_unpack() {
	unpack ${P}.tar.gz
	mkdir "${S}/.dart_tool" || die

	mkdir -p "${S}/build/language" || die
	tar xaf "${DISTDIR}/sass-sass-${SASS_SASS_DATE}.tar.gz" --strip-components=1 -C "${S}/build/language" || die

	mkdir -p "${WORKDIR}/.pub-cache/hosted" || die "Failed to create hosted dir"
	for pkg in  ${DART_BOARD};do
		if [[ ${pkg} =~ ${DART_REGEX} ]]; then
			local host=${BASH_REMATCH[1]}
			local package=${BASH_REMATCH[2]}
			local version=${BASH_REMATCH[3]}

			local mod_dir="${WORKDIR}/.pub-cache/hosted/${host}/${package}-${version}"
			mkdir -p "${WORKDIR}/.pub-cache/hosted/${host}/.cache" || die "Failed to create .cache dir"
			mkdir -p "${mod_dir}" || die "Failed to create $mod_dir"

			pushd "${mod_dir}" > /dev/null || die "Failed to pushinto $mod_dir"
			unpack dart_${package}@${version}.tar.gz
			popd > /dev/null
		fi
	done

	if use test; then
		cp "${FILESDIR}/${P}-package-lock.json" "${S}/package-lock.json" || die
		echo "cache=${NPM_CACHE_DIR}" > "${S}/.npmrc" || die
		npm_build_cache ${TESTING_NPMS} || die
	fi
}
src_prepare(){
	export HOME="${WORKDIR}"
	dart --disable-analytics || die
	dart pub get --offline || die "Pub get failed"
	default
}
src_compile(){
	export HOME="${WORKDIR}"
	export UPDATE_SASS_SASS_REPO=false
	dart run grinder protobuf || die

	dart_envs=(
		-Dversion="${PV}"
		-Dprotocol-version="$(<build/language/spec/EMBEDDED_PROTOCOL_VERSION)"
		-Dcompiler-version="${PV}"
	)
	dart compile exe ${dart_envs[@]} bin/sass.dart -o sass || die "Compile failed"

	if use test; then
		npm install || die "Failed to node_modules"
		dart run grinder pkg-npm-dev || die "Failed to run pkg-npm-dev"
	fi
}
src_test(){
	#one test does not work - it doesn't test the binary
	#dart test test/embedded/protocol_test.dart -p vm --plain-name 'a version response is valid'
	#sass --embedded --version
	export HOME="${WORKDIR}"
	dart test || die
}
src_install(){
	dobin sass
	einstalldocs
}
