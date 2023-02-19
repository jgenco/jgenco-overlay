# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake llvm java-pkg-2 java-ant-2 multiprocessing pam qmake-utils xdg-utils npm prefix

#####Start of ELECTRON  package list#####
ELECTRON_PACKAGE_HASH="bd35e1ea996a1f61dc888c6bc988ae25caeb7103"
ELECTRON_VERSION="22.0.0"
ELECTRON_VERSION_MAJ="$(ver_cut 1 ${ELECTRON_VERSION})"
ELECTRON_EGIT_COMMIT="b7cda611341759b290fba2d6d35b23544ba43f6c"
ELECTRON_NODEJS_DEPS="
bindings@1.5.0
file-uri-to-path@1.0.0
nan@2.17.0
node-addon-api@5.0.0
node-system-fonts@1.0.1
unix-dgram@2.0.6
"
#####End   of ELECTRON package list#####

#####Start of RMARKDOWN package list#####
#also includes ggplot2
R_RMARKDOWN_PKGS="
rlang@1.0.5
glue@1.6.2
cli@3.4.0
fastmap@1.1.0
base64enc@0.1-3
digest@0.6.29
vctrs@0.4.1
utf8@1.2.2
lifecycle@1.0.2
fansi@1.0.3
colorspace@2.0-3
lattice@0.20-45
stringi@1.7.8
magrittr@2.0.3
xfun@0.32
cachem@1.0.6
htmltools@0.5.3
rappdirs@0.3.3
R6@2.5.1
fs@1.5.2
pkgconfig@2.0.3
pillar@1.8.1
viridisLite@0.4.1
RColorBrewer@1.1-3
munsell@0.5.0
labeling@0.4.2
farver@2.1.1
Matrix@1.4-1
nlme@3.1-159
yaml@2.3.5
stringr@1.4.1
highr@0.9
evaluate@0.16
memoise@2.0.1
jquerylib@0.1.4
sass@0.4.2
jsonlite@1.8.0
withr@2.5.0
tibble@3.1.8
scales@1.2.1
mgcv@1.8-40
MASS@7.3-58.1
isoband@0.2.5
gtable@0.3.1
tinytex@0.41
knitr@1.40
bslib@0.4.0
rmarkdown@2.16
ggplot2@3.3.6
"
#####End   of RMARKDOWN package list#####
#####Start of TESTHAT   package list#####
#also includes xml2
R_TESTTHAT_PKGS="
rlang@1.0.5
glue@1.6.2
cli@3.4.0
vctrs@0.4.1
utf8@1.2.2
lifecycle@1.0.2
fansi@1.0.3
pkgconfig@2.0.3
pillar@1.8.1
magrittr@2.0.3
tibble@3.1.8
crayon@1.5.1
rprojroot@2.0.3
R6@2.5.1
ps@1.7.1
rematch2@2.1.2
diffobj@0.3.5
fs@1.5.2
desc@1.4.2
crayon@1.5.1
processx@3.7.0
withr@2.5.0
waldo@0.4.0
praise@1.0.0
pkgload@1.3.0
jsonlite@1.8.0
evaluate@0.16
ellipsis@0.3.2
digest@0.6.29
callr@3.7.2
brio@1.1.3
testthat@3.1.4
xml2@1.3.3
"
#####End   of TESTHAT   package list#####

#RSudio requires 5.12.8 but when QT 5.12.x and glibc 2.34(clone3) is used it will cause a
#sandbox violation in chromium. QT fixed this around 5.15.x(5?). Gentoo is at 5.15.3 and
#it works. I assume it was back ported or I'm wrong about the timeline.
QT_VER=5.15.3
QT_SLOT=5

SLOT="0"
KEYWORDS=""
IUSE="server electron +qt5 qt6 test debug quarto panmirror doc clang"
REQUIRED_USE="!server? ( ^^ ( electron qt5 qt6 ) )"

DESCRIPTION="IDE for the R language"
HOMEPAGE="
	https://posit.co/products/open-source/rstudio/
	https://github.com/rstudio/rstudio/"

if [[ "${PV}" == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rstudio/${PN}"
	EGIT_BRANCH="main"

	RSTUDIO_BINARY_FILENAME="rstudio-2023.03.0-daily-328-amd64-debian.tar.gz"
	#rstudio-2023.03.0-daily+31
	RSTUDIO_BINARY_DIR="${WORKDIR}/${RSTUDIO_BINARY_FILENAME/daily-/daily+}"
	RSTUDIO_BINARY_DIR=${RSTUDIO_BINARY_DIR/%-amd64-debian.tar.gz}
	#https://dailies.rstudio.com/rstudio/cherry-blossom/electron/jammy-amd64-xcopy/
	SRC_URI+="panmirror? ( https://s3.amazonaws.com/rstudio-ide-build/electron/jammy/amd64/${RSTUDIO_BINARY_FILENAME} ) "
	SRC_URI+="electron?  ( https://s3.amazonaws.com/rstudio-ide-build/electron/jammy/amd64/${RSTUDIO_BINARY_FILENAME} ) "
else
	RSTUDIO_SOURCE_FILENAME="v$(ver_rs 3 "+").tar.gz"
	S="${WORKDIR}/${PN}-$(ver_rs 3 "-")"
	SRC_URI="https://github.com/rstudio/rstudio/archive/${RSTUDIO_SOURCE_FILENAME} -> ${P}.tar.gz "

	#https://posit.co/download/rstudio-desktop/
	RSTUDIO_BINARY_FILENAME="rstudio-$(ver_rs 3 "-")-x86_64-fedora.tar.gz"
	RSTUDIO_BINARY_DIR="${WORKDIR}/rstudio-$(ver_rs 3 "+")"
	SRC_URI+="panmirror? ( https://download1.rstudio.org/electron/centos7/x86_64/${RSTUDIO_BINARY_FILENAME} ) "
	SRC_URI+="electron?  ( https://download1.rstudio.org/electron/centos7/x86_64/${RSTUDIO_BINARY_FILENAME} ) "
fi

LICENSE="
	AGPL-3 BSD MIT Apache-2.0 Boost-1.0 CC-BY-4.0 MIT GPL-3 ISC
	test? ( EPL-1.0 )
	panmirror? ( || ( AFL-2.1 BSD ) || ( MIT Apache-2.0 ) 0BSD Apache-2.0 BSD BSD-2 ISC LGPL-3 MIT PYTHON Unlicense )
	electron? ( MIT Apache-2.0  BSD 0BSD BSD-2 BSD CC-BY-3.0 CC-BY-4.0 CC0-1.0 ISC PSF-2.4 || ( AFL-2.1 BSD ) || ( BSD GPL-2 ) || ( Unlicense Apache-2.0 ) )
"

build_r_src_uri() {
	for rpkg in ${@}; do
		[[ ${rpkg} =~ (.*)@(.*) ]]
		package=${BASH_REMATCH[1]}
		version=${BASH_REMATCH[2]}
		full_name=${package}_${version}
		echo "https://cloud.r-project.org/src/contrib/${full_name}.tar.gz -> R_${full_name}.tar.gz "
		echo "https://cloud.r-project.org/src/contrib/Archive/${package}/${full_name}.tar.gz -> R_${full_name}.tar.gz "
	done
}

SRC_URI+="electron?  ( $(npm_build_src_uri ${ELECTRON_NODEJS_DEPS}) ) "
SRC_URI+="doc?       ( $(build_r_src_uri ${R_RMARKDOWN_PKGS}) ) "
SRC_URI+="test?      ( $(build_r_src_uri ${R_TESTTHAT_PKGS}) ) "

#If not using system electron modify unpack also
SRC_URI+="electron?  (
		https://www.electronjs.org/headers/v${ELECTRON_VERSION}/node-v${ELECTRON_VERSION}-headers.tar.gz
			-> electron-v${ELECTRON_VERSION}-headers.tar.gz
		) "
RESTRICT="mirror !test? ( test )"

RDEPEND="
	server? (
		acct-user/rstudio-server
		acct-group/rstudio-server
		sys-libs/pam
	)
	|| (
		>=app-text/pandoc-2.18
		>=app-text/pandoc-bin-2.18
	)
	app-text/hunspell:=
	quarto? ( >=app-text/quarto-cli-1.2.269 )
	=dev-cpp/yaml-cpp-0.7.0-r2:=
	>=dev-lang/R-3.3.0
	>=dev-libs/boost-1.78:=
	>=dev-libs/libfmt-8.1.1:=
	dev-libs/openssl:=
	>=dev-libs/mathjax-2.7
	>=dev-libs/soci-4.0.3[postgres,sqlite]
	electron? (
		dev-libs/expat
		dev-libs/glib:2
		dev-libs/nspr
		dev-libs/nss
		media-libs/alsa-lib
		media-libs/fontconfig
		media-libs/mesa
		net-print/cups
		sys-apps/dbus
		x11-libs/cairo
		x11-libs/gtk+:3
		x11-libs/libX11
		x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrandr
		x11-libs/libdrm
		x11-libs/libxcb
		x11-libs/libxkbcommon
		x11-libs/pango
	)
	!electron? (
		qt5? (
			>=dev-qt/qtcore-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtdbus-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtdeclarative-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtnetwork-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtopengl-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtpositioning-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtprintsupport-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtsensors-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtsql-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtsvg-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtwebchannel-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtwebengine-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtwidgets-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtxml-${QT_VER}:${QT_SLOT}
			>=dev-qt/qtxmlpatterns-${QT_VER}:${QT_SLOT}
			~dev-qt/qtsingleapplication-2.6.1_p20171024
		)
		qt6? (
			dev-qt/qtbase:6
			dev-qt/qtwebchannel:6
			dev-qt/qtwebengine:6
			dev-qt/qt5compat
		)
	)
	electron? (
		>=net-libs/nodejs-16.14.0[npm]
	)
	clang? (
		sys-devel/clang
	)
	sys-apps/util-linux
	sys-apps/which
	sys-libs/zlib
	sys-process/lsof
	~virtual/jdk-11:=
"

DEPEND="${RDEPEND}"
BDEPEND="
	doc? ( >=app-text/quarto-cli-1.2.269 )
	dev-cpp/websocketpp
	dev-libs/rapidjson
	dev-java/aopalliance:1
	electron? ( app-arch/unzip )
	dev-java/gin:2.1
	dev-java/javax-inject
	=dev-java/validation-api-1.0*:1.0[source]
	~virtual/jdk-11:=
"
PATCHES=(
	"${FILESDIR}/${PN}-2022.07.0.548-cmake-bundled-dependencies.patch"
	"${FILESDIR}/${PN}-1.4.1717-fix-boost-version-check.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-resource-path.patch"
	"${FILESDIR}/${PN}-1.4.1106-server-paths.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-package-build.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-pandoc_path_fix.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-quarto-version.patch"
	"${FILESDIR}/${PN}-9999-node_electron_cmake.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-reenable-sandbox.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-libfmt.patch"
	"${FILESDIR}/${PN}-2022.12.0.353-hunspell.patch"
	"${FILESDIR}/${PN}-2022.12.0.353-add-support-for-RapidJSON.patch"
	"${FILESDIR}/${PN}-2022.12.0.353-system-clang.patch"
	"${FILESDIR}/${PN}-9999-panmirror_disable.patch"
)

DOCS=(CONTRIBUTING.md COPYING INSTALL NOTICE README.md version/news )

R_LIB_PATH="${WORKDIR}/r_pkgs"
install_r_packages() {
	mkdir -p ${R_LIB_PATH}
	local r_script="${S}/R_pkg_ins.R"
	echo -n 'pkgs = c("' >> ${r_script}
	echo  -n ${@}|sed 's/ /","/g;s/@/_/g' >> ${r_script}
	echo  '")' >> ${r_script}
	echo 'pkgs_files = unique(paste0("'"${DISTDIR}"'/R_",pkgs,".tar.gz"))' >> ${r_script}
	echo 'install.packages(pkgs_files,repos=NULL,Ncpus='$(makeopts_jobs)')' >> ${r_script}
	R_LIBS="${R_LIB_PATH}" Rscript ${r_script} || die "Failed to install R packages"
}
bundle_rm() {
	rm ${3} "${S}${1}" || die "Failed to remove bundled ${2}"
}
bundle_ln() {
	[[ ! -d "${EPREFIX}${1}" && ! -f "${EPREFIX}${1}" ]] && die "${EPREFIX}${1} not a directory of file"
	ln -s "${EPREFIX}${1}" "${S}${2}" || die "Failed to link bundled ${3}"
}

pkg_setup() {
	use electron && QA_PREBUILT="
	usr/share/${PN}/rstudio
	usr/share/${PN}/chrome-sandbox
	usr/share/${PN}/chrome_crashpad_handler
	usr/share/${PN}/lib*
	"
	use clang && llvm_pkg_setup
	java-pkg-2_pkg_setup
}

src_unpack() {
	if [[ "${PV}" == *9999 ]];then
		if use electron; then
			#Electron package.json changes alot. This is a known good version
			#EGIT_COMMIT=${ELECTRON_EGIT_COMMIT}
			:
		else
			#A good last commit when testing a patch
			#EGIT_COMMIT="b7cda611341759b290fba2d6d35b23544ba43f6c" # 2022-12-03
			:
		fi
		git-r3_src_unpack
	else
		unpack ${P}.tar.gz
	fi

	use panmirror || use electron && unpack ${RSTUDIO_BINARY_FILENAME}
	NPM_LOCK_FILE="${FILESDIR}/${PN}-electron-thin_package-lock.json"
	use electron  &&  npm_build_cache ${ELECTRON_NODEJS_DEPS}

	if use electron; then
		#IF bundling electron
		mkdir -p "${WORKDIR}/.electron-gyp"
		pushd    "${WORKDIR}/.electron-gyp" > /dev/null

		unpack electron-v${ELECTRON_VERSION}-headers.tar.gz
		mv node_headers ${ELECTRON_VERSION} || die "Failed to move electron headers"
		#It only been 9 so far
		echo "9" > ${ELECTRON_VERSION}/installVersion

		popd > /dev/null
	fi

	bundle_ln "/usr/share/hunspell" "/dependencies/dictionaries" "dictionaries"
}
src_prepare() {
	#fix path rstudio bin path from "${EPREFIX}/usr/rstudio" to "${EPREFIX}/usr/bin/rstudio"
	#NOTE: the actual bin is "${EPREFIX}/usr/share/rstudio/rstudio" but we symlink in src_install
	sed -i "s#/rstudio#/bin/rstudio#" src/node/desktop/resources/freedesktop/rstudio.desktop.in || \
		die "Failed to set proper path for rstudio"

	cmake_src_prepare
	java-pkg-2_src_prepare

	bundle_ln "/usr/share/mathjax" "/dependencies/mathjax-27" "mathjax"

	#SUSE has a good list of software bundled with rstudio
	#https://build.opensuse.org/package/view_file/openSUSE:Factory/rstudio/rstudio.spec
	#Remove Bundled deps ln -s to system libraries - see /src/gwt/.classpath
	#gin and aopalliance
	rm -r "${S}/src/gwt/lib/gin/2.1.2/"* || die "Failed to remove bundled jin"
	bundle_ln  "/usr/share/aopalliance-1/lib/aopalliance.jar" "/src/gwt/lib/gin/2.1.2/aopalliance.jar" \
			"aopalliance.jar"
	bundle_ln  "/usr/share/javax-inject/lib/javax-inject.jar" "/src/gwt/lib/gin/2.1.2/javax-inject.jar" \
			"javax-inject.jar"
	for jar in gin guice-assistedinject-3.0 guice-3.0 ;do
		bundle_ln "/usr/share/gin-2.1/lib/${jar}.jar" "/src/gwt/lib/gin/2.1.2/${jar}.jar" "${JAR}"
	done

	#gwt - they bundle a custom gwt build @github rstudio/gwt tree v1.4
	#validation-api
	rm "${S}/src/gwt/lib/gwt/gwt-rstudio/validation-api-"*.jar || die "Failed to remove bundled validation-api jars"
	bundle_ln "/usr/share/validation-api-1.0/lib/validation-api.jar" \
		"/src/gwt/lib/gwt/gwt-rstudio/validation-api-1.0.0.GA.jar" "validation-api.jar"
	bundle_ln "/usr/share/validation-api-1.0/sources/validation-api-src.zip" \
		"/src/gwt/lib/gwt/gwt-rstudio/validation-api-1.0.0.GA-sources.jar" "validation-api-src.zip"

	#todo lib/junit-4.9b3.jar dev-java/junit - only for testing
	#todo create elemental2

	#clang-c/websocketpp/rapidjson - inspired by SUSE
	#unbundle clang-c
	if use clang; then
		bundle_rm "/src/cpp/core/include/core/libclang/clang-c" "clang headers" "-r"
	fi
	eprefixify src/cpp/core/libclang/LibClang.cpp

	#unbundle websocketpp
	bundle_rm "/src/cpp/ext/websocketpp/" "websocketpp" "-r"
	bundle_ln "/usr/include/websocketpp" "/src/cpp/ext/websocketpp" "websocketpp"

	#unbundle rapidjson
	bundle_rm "/src/cpp/shared_core/include/shared_core/json/rapidjson/" "rapidjson" "-r"
	bundle_ln  "/usr/include/rapidjson" "/src/cpp/shared_core/include/shared_core/json/rapidjson" \
		"rapidjson"

	#unbundle hunspell
	bundle_rm "/src/cpp/core/spelling/hunspell" "hunspell" "-r"

	if ! use qt6;then
		#unbundle qtsingleapplication
		#the original ebuild had a complex grep/sed to fix library name for cmake
		#I don't know what it was but now it doesn't change anything
		bundle_rm "/src/cpp/desktop/3rdparty" "qtsingleapplication" "-r"
		eapply "${FILESDIR}/${PN}-2022.12.0.353-qtsingleapplication.patch"
	else
		#qtsingleapplication I belive needs updated for QT6 not tested.
		sed -i "s/QT5/QT6/g;s/Qt5/Qt6/g" "${S}/src/cpp/desktop/CMakeLists.txt" || die "Failed to sed to QT6"
		eapply "${FILESDIR}/rstudio-2022.12.0.353-qt6-cmake.patch" "${FILESDIR}/rstudio-2022.12.0.353-qt6-desktop.patch"
	fi

	#unbundle fmt
	bundle_rm "/src/cpp/ext/fmt" "libfmt" -r

	# make sure icons and mime stuff are with prefix
	sed -i \
		-e "s:/usr:${EPREFIX}/usr:g" \
		CMakeGlobals.txt src/{cpp,node}/desktop/CMakeLists.txt || die "Failed to change to eprefix"

	if  use electron;then
		local electron_src_hash=$(sha1sum "${S}/src/node/desktop/package.json")
		if [[ ${ELECTRON_PACKAGE_HASH} != ${electron_src_hash:0:40} ]];then
			die "Electron Hash doesn't match"
		else
			cp "${FILESDIR}/${PN}-electron-thin_package.json"      "${S}/src/node/desktop/package.json"
			cp "${FILESDIR}/${PN}-electron-thin_package-lock.json" "${S}/src/node/desktop/package-lock.json"
			#this directory is where RStudio would have put Electron and bundled JS
			mkdir -p "${S}/src/node/desktop/out/RStudio-linux-x64"
		fi
	fi

}
src_configure() {
	export PACKAGE_OS="Gentoo"
	local my_pv=${PV}
	local build_type=""
	if [[ ${PV} == "9999" ]];then
		my_pv="$(<${S}/version/CALENDAR_VERSION).0."
		local flower="$(<${S}/version/RELEASE)"
		flower=${flower,,}
		local base_commit=$(< ${S}/version/base_commit/${flower/ /-}.BASE_COMMIT)
		my_pv+="$(git rev-list ${base_commit}..HEAD --count)"
		build_type="-$(<${S}/version/BUILDTYPE)"
		export GIT_COMMIT=${EGIT_VERSION}
	fi
	export RSTUDIO_VERSION_MAJOR=$(ver_cut 1 ${my_pv})
	export RSTUDIO_VERSION_MINOR=$(ver_cut 2 ${my_pv})
	export RSTUDIO_VERSION_PATCH=$(ver_cut 3 ${my_pv})
	export RSTUDIO_VERSION_SUFFIX="${build_type,,}+$(ver_cut 4 ${my_pv})"

	CMAKE_BUILD_TYPE=$(usex debug Debug Release) #RelWithDebInfo Release
	echo "cache=${WORKDIR}/node_cache" > "${S}/src/node/desktop/.npmrc"
	echo "nodedir=${WORKDIR}/.electron-gyp/${ELECTRON_VERSION}" >> "${S}/src/node/desktop/.npmrc"
	#Instead of using RSTUDIO_TARGET set RSTUDIO_{SERVER,DESKTOP,ELECTRON} manualy
	#This allows ELECTRON with SERVER
	#RSTUDIO_TARGET is set to true to bypass a test to see if undefined
	local rstudio_server=FALSE
	local rstudio_desktop=FALSE
	local rstudio_electron=FALSE
	if use server; then
		rstudio_server=TRUE
	fi
	if use electron; then
		rstudio_electron=TRUE
	elif use qt5 || use qt6; then
		rstudio_desktop=TRUE
	fi
	# FIXME: GWT_COPY is helpful because it allows us to call ant ourselves
	# (rather than using the custom_target defined in src/gwt/CMakeLists.txt),
	# however it also installs a test script, which we probably don't want.

	#NOTE: RSTUDIO_BIN_PATH was originaly used for the dir that holds pandoc
	#it is now used also for the path for r-ldpath
	#in electron this by default is located at /usr/share/rstudio/resources/app/bin
	local mycmakeargs=(
		-DRSTUDIO_INSTALL_SUPPORTING="${EPREFIX}/usr/share/${PN}"
		-DRSTUDIO_TARGET=TRUE
		-DRSTUDIO_SERVER=${rstudio_server}
		-DRSTUDIO_DESKTOP=${rstudio_desktop}
		-DRSTUDIO_ELECTRON=${rstudio_electron}
		-DRSTUDIO_UNIT_TESTS_DISABLED=$(usex test OFF ON)
		-DRSTUDIO_USE_SYSTEM_BOOST=ON
		-DGWT_BUILD=OFF
		-DGWT_COPY=ON
		-DRSTUDIO_USE_SYSTEM_YAML_CPP=ON
		-DRSTUDIO_PACKAGE_BUILD=1
		-DRSTUDIO_BIN_PATH="${EPREFIX}/usr/bin"
		-DQUARTO_ENABLED=$(usex quarto)
		-DRSTUDIO_USE_SYSTEM_SOCI=TRUE
	)

	use clang && mycmakeargs+=( -DSYSTEM_LIBCLANG_PATH=$(get_llvm_prefix))

	if use electron; then
		mycmakeargs+=( -DRSTUDIO_INSTALL_FREEDESKTOP="ON" )
	elif use qt6 ; then
		local qmake_path="$(qt5_get_bindir)/qmake"
		mycmakeargs+=( -DQT_QMAKE_EXECUTABLE=${qmake_path/5/6}
						-DRSTUDIO_INSTALL_FREEDESKTOP="ON" )
	elif use qt5 ; then
		mycmakeargs+=( -DQT_QMAKE_EXECUTABLE="$(qt5_get_bindir)/qmake"
						-DRSTUDIO_INSTALL_FREEDESKTOP="ON" )
	fi

	if use doc; then
		sed -i "/google_analytics.html/d" docs/user/rstudio/_quarto.yml \
			|| die "Failed to remove google_analytics include"
		echo -e "buildType: ${build_type/-/}\nversion: ${my_pv}" > docs/user/rstudio/_variables.yml ||
			die "Failed to create _variables.yml"

		#disable javadoc when use doc
		EANT_DOC_TARGET=""
	fi

	# It looks like eant takes care of this for us during src_compile
	# TODO: verify with someone who knows better
	# java-ant-2_src_configure
	cmake_src_configure

}
src_compile() {
	export EANT_BUILD_XML="src/gwt/build.xml"
	export EANT_BUILD_TARGET="build"
	export ANT_OPTS="-Duser.home=${T} -Djava.util.prefs.userRoot=${T}"

	local gwt_main_module="RStudio"
	if use electron || use qt5 || use qt6; then
		if ! use server;then
			gwt_main_module="RStudioDesktop"
		fi
	else
		if  use server;then
			gwt_main_module="RStudioServer"
		fi
	fi

	local eant_extra_args=(
		# These are from src/gwt/CMakeLists.txt, grep if(GWT_BUILD)
		-Dbuild.dir="bin"
		-Dwww.dir="www"
		-Dextras.dir="extras"
		-Dlib.dir="lib"
		-Dgwt.main.module="org.rstudio.studio.${gwt_main_module}"
		-DlocalWorkers=$(makeopts_jobs)
	)

	local EANT_EXTRA_ARGS="${eant_extra_args[@]}"
	java-pkg-2_src_compile
	cmake_src_compile

	local r_pkgs=()
	use test && r_pkgs+=(${R_TESTTHAT_PKGS[@]})
	use doc  && r_pkgs+=(${R_RMARKDOWN_PKGS[@]})
	[ ${#r_pkgs[@]} -gt 0 ] && install_r_packages ${r_pkgs[@]}

	#NOTE curently not in the build system
	if use doc;then
		pushd docs/user/rstudio
		R_LIBS="${R_LIB_PATH}" quarto render || die " Quarto failed to render user quide"
		mv {_site,user_guide} || die "Failed to rename user guide"
		popd
	fi
}

src_test() {
	# It seems to run correctly and ends with BUILD SUCCESSFUL.
	export EANT_TEST_TARGET="unittest"
	java-pkg-2_src_test

	mkdir -p "${HOME}/.local/share/rstudio" || die "Failed to make .local dir"
	pushd "${BUILD_DIR}/src/cpp" || die "Failed to change to ${BUILD_DIR}/src/cpp"
	#--scope core,rserver,rsession,r
	R_LIBS="${R_LIB_PATH}" ./rstudio-tests || die
	#FAIL 1 | WARN 0 | SKIP 1 | PASS 1030
	#FAIL = probably simply need package: purr
	#SKIP = test-document-apis.R - NYI
	popd
}
src_install() {
	cmake_src_install
	if use panmirror;then
		insinto /usr/share/rstudio/www/js
		doins -r "${RSTUDIO_BINARY_DIR}/resources/app/www/js/panmirror"
	fi

	if use server ;then
		dopamd src/cpp/server/extras/pam/rstudio
		newinitd "${FILESDIR}/rstudio-server" rstudio-server
		insinto /etc/rstudio
		doins "${FILESDIR}/rserver.conf" "${FILESDIR}/rsession.conf"
	fi
	if use electron;then
		#install electron files
		insinto /usr/share/${PN}
		doins "${RSTUDIO_BINARY_DIR}/rstudio"
		doins "${RSTUDIO_BINARY_DIR}/"chrome*
		doins "${RSTUDIO_BINARY_DIR}/"*{.so*,.pak,.bin,.dat}
		doins "${RSTUDIO_BINARY_DIR}/vk_swiftshader_icd.json"
		doins "${RSTUDIO_BINARY_DIR}/chrome_crashpad_handler"
		doins -r "${RSTUDIO_BINARY_DIR}/locales"
		fperms +x /usr/share/rstudio/rstudio
		fperms +x /usr/share/rstudio/{chrome-sandbox,chrome_crashpad_handler}
		fperms +x /usr/share/rstudio/{libEGL.so,libffmpeg.so,libGLESv2.so,libvk_swiftshader.so,libvulkan.so.1}

		#install electron app files
		insinto /usr/share/${PN}/resources/app
		#removed bundled binaries
		rm -r "${RSTUDIO_BINARY_DIR}/resources/app/.webpack/main/native_modules" \
			|| die "Failed to remove bundled native_modules"
		#install prepared js
		doins -r "${RSTUDIO_BINARY_DIR}/resources/app/.webpack"
		doins "${RSTUDIO_BINARY_DIR}/resources/app/package.json"

		#install new binaries
		insinto /usr/share/${PN}/resources/app/.webpack/main/native_modules
		doins "${S}/src/node/desktop/build/Release/"{desktop,dock}.node

		insinto /usr/share/${PN}/resources/app/.webpack/main/native_modules/build/Release
		doins "${S}/src/node/desktop/node_modules/unix-dgram/build/Release/unix_dgram.node"
		doins "${S}/src/node/desktop/node_modules/node-system-fonts/build/Release/system-fonts.node"

		mkdir -p "${ED}/usr/bin"
		dosym -r /usr/share/${PN}/rstudio /usr/bin/rstudio
		#quarto-cli wants this see:src/command/render/render-shared.ts
		dosym -r /usr/share/${PN}/resources/app/bin/rserver-url /usr/bin/rserver-url
		if use server; then
			dosym -r /usr/share/${PN}/resources/app/bin/rserver /usr/bin/rserver
		fi
		dodoc "${RSTUDIO_BINARY_DIR}/"{LICENSE,LICENSES.chromium.html}
	elif use qt5 || use qt6 ; then
		# This binary name is much to generic, so we'll change it
		mv "${ED}/usr/bin/diagnostics" "${ED}/usr/bin/${PN}-diagnostics" || die "Failed to rename diagnostics"
	fi
	dodoc "${ED}/usr/share/${PN}/"{SOURCE,VERSION}
	rm "${ED}/usr/share/${PN}/"{COPYING,INSTALL,NOTICE,SOURCE,VERSION,README.md} || die "Failed to remove installed docs"

	einstalldocs

	if use doc;then
		dodoc -r  docs/user/rstudio/user_guide
	fi
}

pkg_preinst() {
	java-pkg-2_pkg_preinst
}

pkg_postinst() {
	if use electron || use qt5 || use qt6;then
		xdg_desktop_database_update
		xdg_mimeinfo_database_update
		xdg_icon_cache_update
	fi
}
