# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
LLVM_COMPAT=( {18..20} )
LLVM_OPTIONAL=1
inherit cmake java-pkg-2 java-ant-2 llvm-r1 multiprocessing npm optfeature pam prefix xdg-utils

P_PREBUILT="${PN}-2025.08.0.242"
ELECTRON_VERSION="36.6.0"
DAILY_COMMIT="76afe55c5e0a1922e16c5e9a9516fcec33522634"
QUARTO_COMMIT="effd3a6429c8f08a10d0f74edb685e18e9ff2fcf"
QUARTO_CLI_VER="1.7.31"
QUARTO_BRANCH="main"
QUARTO_DATE="20250703"
GWT_VERSION="2.12.2"
WEBSOCKETPP_COMMIT="ee8cf4257e001d939839cff5b1766a835b749cd6"

#####Start of RMARKDOWN package list#####
#also includes ggplot2
R_RMARKDOWN_PKGS="
rlang@1.1.6
glue@1.8.0
cli@3.6.5
lifecycle@1.0.4
fastmap@1.2.0
digest@0.6.37
base64enc@0.1-3
vctrs@0.6.5
utf8@1.2.5
lattice@0.22-7
xfun@0.52
rappdirs@0.3.3
R6@2.6.1
htmltools@0.5.8.1
fs@1.6.6
cachem@1.1.0
pkgconfig@2.0.3
pillar@1.10.2
magrittr@2.0.3
fansi@1.0.6
viridisLite@0.4.2
RColorBrewer@1.1-3
labeling@0.4.3
farver@2.1.2
Matrix@1.7-3
nlme@3.1-168
yaml@2.3.10
highr@0.11
evaluate@1.0.3
sass@0.4.10
mime@0.13
memoise@2.0.1
jsonlite@2.0.0
jquerylib@0.1.4
withr@3.0.2
tibble@3.2.1
scales@1.4.0
mgcv@1.9-3
MASS@7.3-65
isoband@0.2.7
gtable@0.3.6
tinytex@0.57
knitr@1.50
fontawesome@0.5.3
bslib@0.9.0
rmarkdown@2.29
ggplot2@3.5.2
"
#####End   of RMARKDOWN package list#####
#####Start of TESTHAT   package list#####
#also includes xml2
R_TESTTHAT_PKGS="
R6@2.6.1
ps@1.9.1
cli@3.6.5
processx@3.8.6
crayon@1.5.3
desc@1.4.3
callr@3.7.6
rlang@1.1.6
glue@1.8.0
diffobj@0.3.6
withr@3.0.2
rprojroot@2.0.4
pkgbuild@1.4.7
lifecycle@1.0.4
fs@1.6.6
waldo@0.6.1
praise@1.0.0
pkgload@1.4.0
magrittr@2.0.3
jsonlite@2.0.0
evaluate@1.0.3
digest@0.6.37
brio@1.1.5
testthat@3.2.3
xml2@1.3.8
"
#####End   of TESTHAT   package list#####

DESCRIPTION="IDE for the R language"
HOMEPAGE="
	https://posit.co/products/open-source/rstudio/
	https://github.com/rstudio/rstudio/"

if [[ "${PV}" == *9999 ]];then
	inherit git-r3
else
	#P_PREBUILT=${P}
	if [[ ! -n "${DAILY_COMMIT}" ]];then
		SRC_URI="https://github.com/rstudio/rstudio/archive/v$(ver_rs 3 "+").tar.gz -> ${P}.tar.gz "
		S="${WORKDIR}/${PN}-$(ver_rs 3 "-")"
	else
		SRC_URI="https://github.com/rstudio/rstudio/archive/${DAILY_COMMIT}.tar.gz -> ${P}.tar.gz "
		S="${WORKDIR}/${PN}-${DAILY_COMMIT}"
	fi
	SRC_URI+="panmirror? ( https://github.com/quarto-dev/quarto/archive/${QUARTO_COMMIT}.tar.gz -> quarto-${QUARTO_BRANCH/release\/}-${QUARTO_DATE}.tar.gz ) "

fi

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
SRC_URI+="
	https://rstudio-buildtools.s3.us-east-1.amazonaws.com/gwt/gwt-${GWT_VERSION}.tar.gz ->
		rstudio-gwt-${GWT_VERSION}.tar.gz
	https://github.com/amini-allight/websocketpp/archive/${WEBSOCKETPP_COMMIT}.tar.gz ->
		websocketpp-${WEBSOCKETPP_COMMIT:0:8}.tar.gz
	panmirror? (
		https://github.com/jgenco/jgenco-overlay-files/releases/download/${P_PREBUILT}/${P_PREBUILT}-panmirror-node_modules.tar.xz
	)
	electron? (
		https://github.com/jgenco/jgenco-overlay-files/releases/download/${P_PREBUILT}/${P_PREBUILT}-electron-node_modules.tar.xz
		https://github.com/electron/electron/releases/download/v${ELECTRON_VERSION}/electron-v${ELECTRON_VERSION}-linux-x64.zip
		https://www.electronjs.org/headers/v${ELECTRON_VERSION}/node-v${ELECTRON_VERSION}-headers.tar.gz
			-> electron-v${ELECTRON_VERSION}-headers.tar.gz
	)
	doc? ( $(build_r_src_uri ${R_RMARKDOWN_PKGS}) )
	test? ( $(build_r_src_uri ${R_TESTTHAT_PKGS}) )
"

LICENSE="
	AGPL-3 BSD MIT Apache-2.0 Boost-1.0 CC-BY-4.0 MIT OFL-1.1 GPL-3 ISC
	test? ( EPL-1.0 )
	panmirror? ( 0BSD Apache-2.0 BSD BSD-2 CC0-1.0 EPL-2.0 ISC
		|| ( LGPL-2 MIT ) LGPL-3 MIT MPL-2.0 PYTHON Unlicense )
	electron?  ( 0BSD Apache-2.0 BlueOak-1.0.0 BSD-2 BSD
		|| ( BSD GPL-2 ) CC0-1.0 CC-BY-3.0 CC-BY-4.0 ISC MIT PYTHON Unlicense )
"
SLOT="0"
KEYWORDS=""

IUSE="clang debug doc +electron panmirror quarto server test"
REQUIRED_USE="!server? ( electron ) clang? ( ${LLVM_REQUIRED_USE} )"
RESTRICT="mirror !test? ( test )"

RDEPEND="
	server? (
		acct-user/rstudio-server
		acct-group/rstudio-server
		sys-libs/pam
	)
	|| (
		app-text/pandoc-cli
		<app-text/pandoc-3
		app-text/pandoc-bin
	)
	app-text/hunspell:=
	quarto? (
		|| (
			>=app-text/quarto-cli-${QUARTO_CLI_VER}
			>=app-text/quarto-cli-bin-${QUARTO_CLI_VER}
		)
	)
	dev-cpp/expected
	dev-cpp/gsl-lite
	>=dev-cpp/yaml-cpp-0.8.0:=
	>=dev-lang/R-3.3.0[png]
	dev-libs/boost:=
	>=dev-libs/libfmt-8.1.1:=
	dev-libs/openssl:=
	>=dev-libs/mathjax-2.7
	>=dev-libs/soci-4.0.3[sqlite]
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
	clang? ( $(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}
	') )
	sys-apps/util-linux
	sys-apps/which
	sys-libs/zlib
	sys-process/lsof
	>=virtual/jdk-17:=
"

DEPEND="${RDEPEND}"
BDEPEND="
	doc? (
		|| (
			>=app-text/quarto-cli-${QUARTO_CLI_VER}
			>=app-text/quarto-cli-bin-${QUARTO_CLI_VER}
		)
	)
	dev-libs/rapidjson
	dev-java/aopalliance:1
	dev-java/injection-api
	dev-java/error-prone-annotations
	dev-java/guava
	dev-java/javax-inject
	=dev-java/validation-api-1.0*:1.0[source]
	panmirror? (
		<dev-util/esbuild-0.17
		net-libs/nodejs[npm]
		sys-apps/yarn
	)
	electron? (
		app-arch/unzip
		net-libs/nodejs[npm]
	)
	>=virtual/jdk-17:=
"
PATCHES=(
	"${FILESDIR}/${PN}-9999-cmake-bundled-dependencies.patch"
	"${FILESDIR}/${PN}-2024.09.0.375-resource-path.patch"
	"${FILESDIR}/${PN}-2024.04.0.735-server-paths.patch"
	"${FILESDIR}/${PN}-2024.12.0.467-package-build.patch"
	"${FILESDIR}/${PN}-2025.05.0.496-pandoc_path_fix.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-quarto-version.patch"
	"${FILESDIR}/${PN}-9999-node_electron_cmake.patch"
	"${FILESDIR}/${PN}-2022.12.0.353-add-support-for-RapidJSON.patch"
	"${FILESDIR}/${PN}-2022.12.0.353-system-clang.patch"
	"${FILESDIR}/${PN}-2024.12.0.467-disable-panmirror.patch"
	"${FILESDIR}/${PN}-2023.12.1.402-node_path_fix.patch"
	"${FILESDIR}/${PN}-2025.05.0.496-copilot.patch"
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

pkg_setup() {
	use electron && QA_PREBUILT="
	usr/share/${PN}/rstudio
	usr/share/${PN}/chrome-sandbox
	usr/share/${PN}/chrome_crashpad_handler
	usr/share/${PN}/lib*
	"
	use clang && llvm-r1_pkg_setup
	java-pkg-2_pkg_setup
}

src_unpack() {
	if [[ "${PV}" == *9999 ]];then
		EGIT_REPO_URI="https://github.com/rstudio/${PN}"
		EGIT_BRANCH="main"
		git-r3_src_unpack
	else
		unpack ${P}.tar.gz
	fi
	unpack websocketpp-${WEBSOCKETPP_COMMIT:0:8}.tar.gz

	mkdir "${S}/dependencies/common/gwtproject"
	pushd "${S}/dependencies/common/gwtproject" > /dev/null || die
	unpack rstudio-gwt-${GWT_VERSION}.tar.gz
	popd > /dev/null

	if use panmirror;then
		pushd "${S}/src/gwt/lib" > /dev/null|| die
		if [[ "${PV}" == *9999 ]];then
			EGIT_REPO_URI="https://github.com/quarto-dev/quarto"
			EGIT_BRANCH="${QUARTO_BRANCH}"
			EGIT_CHECKOUT_DIR="${S}/src/gwt/lib/quarto"
			git-r3_src_unpack
		else
			unpack quarto-${QUARTO_BRANCH/release\/}-${QUARTO_DATE}.tar.gz
			mv quarto-${QUARTO_COMMIT} quarto || die
		fi
		cd quarto || die
		unpack ${P_PREBUILT}-panmirror-node_modules.tar.xz
		popd > /dev/null
	fi

	if use panmirror || use electron; then
		local install_version="$(grep installVersion \
			"${EPREFIX}/usr/$(get_libdir)/node_modules/npm/node_modules/node-gyp/package.json" |\
			sed -E 's/.* ([0-9]+),/\1/')"
		[[ ${install_version} =~ ^[0-9]+$ ]] || die
	fi

	if use electron; then
		#prepare electron node_modules
		mkdir "${S}/src/node/desktop-build-x86_64"
		pushd "${S}/src/node/desktop-build-x86_64" > /dev/null|| die
		unpack ${P_PREBUILT}-electron-node_modules.tar.xz
		sed -i "s/npm ci && //" ../desktop/package.json || die
		popd > /dev/null

		#prepare electron binaries
		local electron_url_hash=$(echo -n \
			"https://github.com/electron/electron/releases/download/v${ELECTRON_VERSION}" |\
			sha256sum |cut -f1 -d\ )
		assert
		local electron_hash=$(sha256sum "${DISTDIR}/electron-v${ELECTRON_VERSION}-linux-x64.zip" |cut -f1 -d\ )
		assert
		mkdir -p "${WORKDIR}/.cache/electron/${electron_url_hash}" || die
		echo "${electron_hash} *electron-v${ELECTRON_VERSION}-linux-x64.zip" >> \
			"${WORKDIR}/.cache/electron/${electron_url_hash}/SHASUMS256.txt" || die
		ln -s "${DISTDIR}/electron-v${ELECTRON_VERSION}-linux-x64.zip" \
			"${WORKDIR}/.cache/electron/${electron_url_hash}/electron-v${ELECTRON_VERSION}-linux-x64.zip" || die

		#prepare electron headers
		mkdir -p "${WORKDIR}/.electron-gyp" || die
		pushd    "${WORKDIR}/.electron-gyp" > /dev/null || die

		unpack electron-v${ELECTRON_VERSION}-headers.tar.gz
		mv node_headers ${ELECTRON_VERSION} || die "Failed to move electron headers"
		echo "${install_version}" > "${ELECTRON_VERSION}/installVersion" ||die

		popd > /dev/null
	fi
	if use panmirror || use electron ;then
		#prepare node headers
		local nodejs_version=$(node -v) || die "Node version not found"
		nodejs_version=${nodejs_version#v}
		mkdir -p "${WORKDIR}/.cache/node-gyp/${nodejs_version}/include" || die
		ln -s "${EPREFIX}/usr/include/node" "${WORKDIR}/.cache/node-gyp/${nodejs_version}/include/node" || die
		#This tells it the headers where installed
		echo "${install_version}" > "${WORKDIR}/.cache/node-gyp/${nodejs_version}/installVersion" || die
	fi
}
src_prepare() {
	#SUSE has a good list of software bundled with rstudio
	#https://build.opensuse.org/package/view_file/openSUSE:Factory/rstudio/rstudio.spec
	#gwt - they bundle a custom gwt build github.com/rstudio/gwt tree v1.4#
	local gwt_loc="/dependencies/common/gwtproject"
	local debundles=(
		"${gwt_loc}/gin/2.1.2/aopalliance-1.0.jar:/usr/share/aopalliance-1/lib/aopalliance.jar"
		"${gwt_loc}/gin/2.1.2/jakarta.inject-api-2.0.1.jar:/usr/share/injection-api/lib/injection-api.jar"
		"${gwt_loc}/gin/2.1.2/javax.inject.jar:/usr/share/javax-inject/lib/javax-inject.jar"
#		"${gwt_loc}/gin/2.1.2/gin-2.1.2.jar:/usr/share/gin-2.1/lib/gin.jar"
#		guice-assistedinject-6.0.0.jar - dev-java/guice
#		"${gwt_loc}/gin/2.1.2/guice-assistedinject-3.0.jar:/usr/share/gin-2.1/lib/guice-assistedinject-3.0.jar"
#		"${gwt_loc}/gin/2.1.2/guice-3.0.jar:/usr/share/gin-2.1/lib/guice-3.0.jar" #guice-6.0.0.jar - dev-java/guice
		"${gwt_loc}/gin/2.1.2/guava-32.1.3-jre.jar:/usr/share/guava/lib/guava.jar"
		"${gwt_loc}/gin/2.1.2/error_prone_annotations-2.23.0.jar:/usr/share/error-prone-annotations/lib/error-prone-annotations.jar"
#		"${gwt_loc}/gin/2.1.2/failureaccess-1.0.2.jar:/usr/share/failureaccess/lib/failureaccess.jar"
		"${gwt_loc}/gwt/gwt-rstudio/validation-api-1.0.0.GA.jar:/usr/share/validation-api-1.0/lib/validation-api.jar"
		"${gwt_loc}/gwt/gwt-rstudio/validation-api-1.0.0.GA-sources.jar:/usr/share/validation-api-1.0/sources/validation-api-src.zip"
	)

	#clang-c - inspired by SUSE
	if use clang; then
		debundles+=("/src/cpp/core/include/core/libclang/clang-c/:")
	fi

	for entry in ${debundles[@]};do
		local bundle_path="${entry%:*}"
		local local_path="${entry#*:}"
		[[ ${bundle_path} == "" ]] && die "Missing bundle_path"
		if [[ ${bundle_path:(-1)} == "/" ]];then
			( rm -r "${S}${bundle_path}" || die "Failed to remove dir ${bundle_path}" )
		else
			( rm "${S}${bundle_path}" || die "Failed to remove file ${bundle_path}" )
		fi
		[[ ${local_path} != "" ]] &&
			( ln -s "${EPREFIX}${local_path}" "${S}${bundle_path%/}" \
			|| die "Failed to link ${local_path} -> ${bundle_path}" )
	done

	ln -s "${EPREFIX}/usr/share/mathjax" "${S}/dependencies/mathjax-27" || die
	#/usr/share/hunspell might not exist if no dictionary is installed so no need to die
	ln -s "${EPREFIX}/usr/share/hunspell" "${S}/dependencies/dictionaries"

	if use panmirror;then
		pushd src/gwt/lib/quarto > /dev/null || die
		eapply panmirror.patch

		local esbuild_version="$(esbuild --version)" || die
		sed -i "s/0.15.18/${esbuild_version}/g" \
			node_modules/vite/node_modules/esbuild/lib/main.js || die

		ln -s "${EPREFIX}/usr/bin/esbuild" node_modules/vite/node_modules/esbuild-linux-64/bin/esbuild || die
		ln -s "${EPREFIX}/usr/bin/esbuild" node_modules/esbuild-linux-64/bin/esbuild || die
		popd
	fi

	if use electron; then
		#this allows the checking SHASUM256.txt file - easier way?
		sed -i "s/ElectronDownloadCacheMode.Bypass/ElectronDownloadCacheMode.ReadOnly/" \
			src/node/desktop-build-x86_64/node_modules/@electron/get/dist/cjs/index.js || die
	fi
	sed "s/NO_DEFAULT_PATH//" -i src/node/CMakeNodeTools.txt || die

	#fix path rstudio bin path from "${EPREFIX}/usr/rstudio" to "${EPREFIX}/usr/bin/rstudio"
	#NOTE: the actual bin is "${EPREFIX}/usr/share/rstudio/rstudio" but we symlink in src_install
	sed -i "s#/rstudio#/bin/rstudio#" src/node/desktop/resources/freedesktop/rstudio.desktop.in || \
		die "Failed to set proper path for rstudio"

	# make sure icons and mime stuff are with prefix
	sed -i -e "s:/usr:${EPREFIX}/usr:g" \
		cmake/globals.cmake src/node/desktop/CMakeLists.txt || die "Failed to change to eprefix"

	eprefixify src/cpp/core/libclang/LibClang.cpp

	cmake_src_prepare
	java-pkg-2_src_prepare
	mkdir "${BUILD_DIR}/_deps" || die
	ln -s  "${WORKDIR}/websocketpp-${WEBSOCKETPP_COMMIT}" "${BUILD_DIR}/_deps/websocketpp-src" || die
}
src_configure() {
	export PACKAGE_OS="Gentoo"
	local my_pv=${PV}
	local build_type="$(<${S}/version/BUILDTYPE)"
	if [[ ${PV} == "9999" ]];then
		my_pv="$(<${S}/version/CALENDAR_VERSION).$(<${S}/version/PATCH)."
		local flower="$(<${S}/version/RELEASE)"
		flower=${flower,,}
		local base_commit=$(< ${S}/version/base_commit/${flower/ /-}.BASE_COMMIT)
		my_pv+="$(git rev-list ${base_commit}..HEAD --count || echo "999")"
		export GIT_COMMIT=${EGIT_VERSION}
	else
		export GIT_COMMIT="$(gunzip -c "${DISTDIR}/rstudio-${PV}.tar.gz" |git get-tar-commit-id)"
	fi
	export RSTUDIO_VERSION_MAJOR=$(ver_cut 1 ${my_pv})
	export RSTUDIO_VERSION_MINOR=$(ver_cut 2 ${my_pv})
	export RSTUDIO_VERSION_PATCH=$(ver_cut 3 ${my_pv})
	export RSTUDIO_VERSION_SUFFIX="-${build_type,,}+$(ver_cut 4 ${my_pv})"

	sed -i "3s/RStudio/rstudio/" src/node/desktop/package.json || die
	sed -i "4s/9999.99.9-dev+1.test9/$(ver_cut 1-3)${RSTUDIO_VERSION_SUFFIX}/" src/node/desktop/package.json || die
	CMAKE_BUILD_TYPE=$(usex debug Debug Release) #RelWithDebInfo Release
	echo "cache=${WORKDIR}/node_cache" > "${S}/src/node/desktop/.npmrc"
	echo "nodedir=${WORKDIR}/.electron-gyp/${ELECTRON_VERSION}" >> "${S}/src/node/desktop/.npmrc"
	# FIXME: GWT_COPY is helpful because it allows us to call ant ourselves
	# (rather than using the custom_target defined in src/gwt/CMakeLists.txt),
	# however it also installs a test script, which we probably don't want.

	#NOTE: RSTUDIO_BIN_PATH was originaly used for the dir that holds pandoc
	#it is now used also for the path for r-ldpath
	#in electron this by default is located at /usr/share/rstudio/resources/app/bin
	local mycmakeargs=(
		-DRSTUDIO_INSTALL_SUPPORTING="${EPREFIX}/usr/share/${PN}"
		-DRSTUDIO_TARGET=TRUE
		-DRSTUDIO_SERVER=$(usex server)
		-DRSTUDIO_ELECTRON=$(usex electron)
		-DRSTUDIO_UNIT_TESTS_DISABLED=$(usex test OFF ON)
		#note RSTUDIO_USE_SYSTEM_DEPENDENCIES exist
		-DRSTUDIO_USE_SYSTEM_TL_EXPECTED=ON
		-DRSTUDIO_USE_SYSTEM_FMT=ON
		-DRSTUDIO_USE_SYSTEM_GSL_LITE=ON
		-DRSTUDIO_USE_SYSTEM_HUNSPELL=ON
		-DRSTUDIO_USE_SYSTEM_RAPIDJSON=ON
		-DRSTUDIO_USE_SYSTEM_WEBSOCKETPP=OFF
		-DRSTUDIO_USE_SYSTEM_YAML_CPP=ON
		-DRSTUDIO_USE_SYSTEM_BOOST=ON

		-DGWT_BUILD=OFF
		-DGWT_COPY=ON
		-DRSTUDIO_USE_SYSTEM_YAML_CPP=ON
		-DRSTUDIO_PACKAGE_BUILD=1
		-DRSTUDIO_BIN_PATH="${EPREFIX}/usr/bin"
		-DQUARTO_ENABLED=$(usex quarto)
		-DRSTUDIO_USE_SYSTEM_SOCI=TRUE
		-DRSTUDIO_DISABLE_CHECK_FOR_UPDATES=1
		-DRSTUDIO_INSTALL_FREEDESKTOP=$(usex electron)
		-DRSTUDIO_BOOST_REQUESTED_VERSION=1.85.0
	)

	use clang && mycmakeargs+=( -DSYSTEM_LIBCLANG_PATH=$(get_llvm_prefix))

	if use doc; then
		#if docs/news is built remove "_ga-" lines from  docs/news/_quarto.yml
		sed -i "/_ga-\S\+-tag.html/d" docs/user/rstudio/_quarto.yml \
			|| die "Failed to remove google_analytics include"
		echo -e "buildType: ${build_type}\nversion: ${my_pv}" > docs/user/rstudio/_variables.yml ||
			die "Failed to create _variables.yml"
		#Quarto-Cli likes a certain version of pandoc this trys both
		quarto check 2> quarto-check.first || export QUARTO_PANDOC="${EPREFIX}/usr/bin/pandoc-bin"
		quarto check 2> quarto-check.second || die "Quarto Cli failed check"

		#disable javadoc when use doc
		EANT_DOC_TARGET=""
	fi

	cmake_src_configure

}
src_compile() {
	local gyp_rebuild_folders=""
	if use panmirror;then
		gyp_rebuild_folders+=" $(find src/gwt/lib/quarto  -name binding.gyp |sed "s/\/binding.gyp//")"
	fi
	if use electron; then
		gyp_rebuild_folders+=" $(find src/node/desktop-build-x86_64 -name binding.gyp |sed "s/\/binding.gyp//")"
		pushd src/node/desktop-build-x86_64 >/dev/null || die
		einfo "Running ts-node"
		npx ts-node scripts/generate.ts || die "Failed to run ts-node"
		popd
	fi
	for folder in ${gyp_rebuild_folders};do
		einfo "Rebuilding ${folder}"
		pushd ${folder}> /dev/null || die
		HOME="${WORKDIR}" XDG_CACHE_HOME="${WORKDIR}/.cache" \
			"${EPREFIX}/usr/$(get_libdir)/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js" rebuild \
			|| die "Failed to rebuild ${folder}"
		popd
	done
	if use panmirror;then
		einfo "Building Panmirror"
		pushd src/gwt/lib/quarto/apps/panmirror >/dev/null || die
		PANMIRROR_OUTDIR="${S}/src/gwt/www/js/panmirror" yarn build || die
		popd
	fi
	export EANT_BUILD_XML="src/gwt/build.xml"
	export EANT_BUILD_TARGET="build"
	export ANT_OPTS="-Duser.home=${T} -Djava.util.prefs.userRoot=${T}"

	local gwt_main_module="RStudio"
	if use electron; then
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
		-Dgwt.main.module="org.rstudio.studio.${gwt_main_module}"
		-DlocalWorkers=$(makeopts_jobs)
	)

	local EANT_EXTRA_ARGS="${eant_extra_args[@]}"
	local JAVA_PKG_BSFIX=OFF
	java-ant-2_src_configure
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
	#NOTE: a bug introduced by resource-path.patch make this use the
	#INSTALLED files instead of TO BE INSTALLED files:(
	JENKINS_URL="false" R_LIBS="${R_LIB_PATH}" ./rstudio-tests || die
	#FAIL 1 | WARN 0 | SKIP 1 | PASS 1030
	#FAIL = probably simply need package: purr
	#SKIP = test-document-apis.R - NYI
	popd
}
src_install() {
	cmake_src_install
	if use server ;then
		dopamd src/cpp/server/extras/pam/rstudio
		newinitd "${FILESDIR}/rstudio-server" rstudio-server
		insinto /etc/rstudio
		doins "${FILESDIR}/rserver.conf" "${FILESDIR}/rsession.conf"
	fi
	if use electron;then
		mkdir -p "${ED}/usr/bin"
		dosym -r /usr/share/${PN}/rstudio /usr/bin/rstudio
		#quarto-cli wants this see:src/command/render/render-shared.ts
		dosym -r /usr/share/${PN}/resources/app/bin/rserver-url /usr/bin/rserver-url
		if use server; then
			dosym -r /usr/share/${PN}/resources/app/bin/rserver /usr/bin/rserver
		fi
		dodoc "${ED}/usr/share/rstudio/"{LICENSE,LICENSES.chromium.html}
		rm "${ED}/usr/share/rstudio/"{LICENSE,LICENSES.chromium.html} || die
	fi
	dodoc "${ED}/usr/share/${PN}/"{SOURCE,VERSION}
	rm "${ED}/usr/share/${PN}/"{COPYING,INSTALL,NOTICE,SOURCE,VERSION,README.md} || die "Failed to remove installed docs"

	einstalldocs

	if use doc;then
		docompress -x usr/share/doc/${P}/user_guide
		dodoc -r  docs/user/rstudio/user_guide
	fi
}

pkg_preinst() {
	java-pkg-2_pkg_preinst
}

pkg_postinst() {
	if use electron ;then
		xdg_desktop_database_update
		xdg_mimeinfo_database_update
		xdg_icon_cache_update
	fi
	optfeature "GitHub's Copilot language server" dev-util/copilot-language-server
	if [[ ! -d "${EPREFIX}/usr/share/hunspell" ]];then
		elog ""
		elog "RStudio's spell check needs at least one"
		elog "app-dicts/myspell-* dictionary to be installed."
		elog ""
		elog "or set the L10N variable in /etc/portage/make.conf"
		elog "see https://wiki.gentoo.org/wiki/Localization"
	fi
}
