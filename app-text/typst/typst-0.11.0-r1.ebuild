# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	adler@1.0.2
	aho-corasick@1.1.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.13
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	approx@0.5.1
	arbitrary@1.3.2
	arrayref@0.3.7
	arrayvec@0.7.4
	autocfg@1.1.0
	az@1.2.1
	base64@0.21.7
	base64@0.22.0
	biblatex@0.9.3
	bincode@1.3.3
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.4.2
	bitvec@1.0.1
	bumpalo@3.15.4
	bytemuck@1.14.3
	byteorder@1.5.0
	cc@1.0.90
	cfg-if@1.0.0
	chinese-number@0.7.7
	chinese-variant@1.1.3
	chrono@0.4.35
	ciborium@0.2.2
	ciborium-io@0.2.2
	ciborium-ll@0.2.2
	citationberg@0.3.0
	clap@4.5.2
	clap_builder@4.5.2
	clap_complete@4.5.1
	clap_derive@4.5.0
	clap_lex@0.7.0
	clap_mangen@0.2.20
	cobs@0.2.3
	codespan-reporting@0.11.1
	color_quant@1.1.0
	colorchoice@1.0.0
	comemo@0.4.0
	comemo-macros@0.4.0
	core-foundation@0.9.4
	core-foundation-sys@0.8.6
	core_maths@0.1.0
	crc32fast@1.4.0
	crossbeam-channel@0.5.12
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crunchy@0.2.2
	csv@1.3.0
	csv-core@0.1.11
	data-url@0.3.1
	deranged@0.3.11
	dirs@5.0.1
	dirs-sys@0.4.1
	displaydoc@0.2.4
	downcast-rs@1.2.0
	ecow@0.2.1
	either@1.10.0
	embedded-io@0.4.0
	enum-ordinalize@4.3.0
	enum-ordinalize-derive@4.3.1
	env_proxy@0.4.1
	equivalent@1.0.1
	errno@0.3.8
	fancy-regex@0.11.0
	fast-srgb8@1.0.0
	fastrand@1.9.0
	fastrand@2.0.1
	fdeflate@0.3.4
	filetime@0.2.23
	flate2@1.0.28
	float-cmp@0.9.0
	fnv@1.0.7
	fontconfig-parser@0.5.6
	fontdb@0.16.2
	foreign-types@0.3.2
	foreign-types-shared@0.1.1
	form_urlencoded@1.2.1
	fs_extra@1.3.0
	fsevent-sys@4.1.0
	funty@2.0.0
	getopts@0.2.21
	getrandom@0.2.12
	gif@0.12.0
	gif@0.13.1
	half@2.4.0
	hashbrown@0.12.3
	hashbrown@0.14.3
	hayagriva@0.5.2
	heck@0.4.1
	hypher@0.1.5
	iana-time-zone@0.1.60
	iana-time-zone-haiku@0.1.2
	icu_collections@1.4.0
	icu_locid@1.4.0
	icu_locid_transform@1.4.0
	icu_locid_transform_data@1.4.0
	icu_properties@1.4.0
	icu_properties_data@1.4.0
	icu_provider@1.4.0
	icu_provider_adapters@1.4.0
	icu_provider_blob@1.4.0
	icu_provider_macros@1.4.0
	icu_segmenter@1.4.0
	icu_segmenter_data@1.4.0
	idna@0.5.0
	if_chain@1.0.2
	image@0.24.9
	imagesize@0.12.0
	indexmap@1.9.3
	indexmap@2.2.5
	indexmap-nostd@0.4.0
	inotify@0.9.6
	inotify-sys@0.1.5
	instant@0.1.12
	is-docker@0.2.0
	is-wsl@0.4.0
	itoa@1.0.10
	jobserver@0.1.28
	jpeg-decoder@0.3.1
	js-sys@0.3.69
	kamadak-exif@0.5.5
	kqueue@1.0.8
	kqueue-sys@1.0.4
	kurbo@0.9.5
	lazy_static@1.4.0
	libc@0.2.153
	libdeflate-sys@1.19.3
	libdeflater@1.19.3
	libfuzzer-sys@0.4.7
	libm@0.2.8
	libredox@0.0.1
	line-wrap@0.1.1
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.13
	lipsum@0.9.0
	litemap@0.7.2
	lock_api@0.4.11
	log@0.4.21
	lzma-sys@0.1.20
	memchr@2.7.1
	memmap2@0.9.4
	miniz_oxide@0.7.2
	mio@0.8.11
	mutate_once@0.1.1
	native-tls@0.2.11
	notify@6.1.1
	num-bigint@0.4.4
	num-conv@0.1.0
	num-integer@0.1.46
	num-traits@0.2.18
	numerals@0.1.4
	once_cell@1.19.0
	open@5.1.1
	openssl@0.10.64
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.2.3+3.2.1
	openssl-sys@0.9.101
	option-ext@0.2.0
	oxipng@9.0.0
	palette@0.7.5
	palette_derive@0.7.5
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	paste@1.0.14
	pathdiff@0.2.1
	pdf-writer@0.9.2
	percent-encoding@2.3.1
	phf@0.11.2
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.11.2
	pico-args@0.5.0
	pixglyph@0.3.0
	pkg-config@0.3.30
	plist@1.6.0
	png@0.17.13
	portable-atomic@1.6.0
	postcard@1.0.8
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	proc-macro2@1.0.78
	psm@0.1.21
	pulldown-cmark@0.9.6
	qcms@0.3.0
	quick-xml@0.31.0
	quote@1.0.35
	radium@0.7.0
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rayon@1.9.0
	rayon-core@1.12.1
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex@1.10.3
	regex-automata@0.4.6
	regex-syntax@0.8.2
	resvg@0.38.0
	rgb@0.8.37
	roff@0.2.1
	roxmltree@0.19.0
	rustc-hash@1.1.0
	rustc_version@0.4.0
	rustix@0.38.31
	rustversion@1.0.14
	rustybuzz@0.12.1
	ryu@1.0.17
	safemem@0.3.3
	same-file@1.0.6
	schannel@0.1.23
	scopeguard@1.2.0
	security-framework@2.9.2
	security-framework-sys@2.9.1
	self-replace@1.3.7
	semver@1.0.22
	serde@1.0.197
	serde_derive@1.0.197
	serde_json@1.0.114
	serde_spanned@0.6.5
	serde_yaml@0.8.26
	serde_yaml@0.9.32
	simd-adler32@0.3.7
	simplecss@0.2.1
	siphasher@0.3.11
	siphasher@1.0.0
	slotmap@1.0.7
	smallvec@1.13.1
	spin@0.9.8
	stable_deref_trait@1.2.0
	stacker@0.1.15
	strict-num@0.1.1
	strsim@0.11.0
	strum@0.26.1
	strum_macros@0.26.1
	subsetter@0.1.1
	svg2pdf@0.10.0
	svgtypes@0.13.0
	syn@2.0.52
	synstructure@0.13.1
	syntect@5.2.0
	tap@1.0.1
	tar@0.4.40
	tempfile@3.10.1
	termcolor@1.4.1
	thiserror@1.0.57
	thiserror-impl@1.0.57
	time@0.3.34
	time-core@0.1.2
	time-macros@0.2.17
	tiny-skia@0.11.4
	tiny-skia-path@0.11.4
	tinystr@0.7.5
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	toml@0.8.10
	toml_datetime@0.6.5
	toml_edit@0.22.6
	ttf-parser@0.20.0
	two-face@0.3.0
	typed-arena@2.0.2
	typst-assets@0.11.0
	unic-langid@0.9.4
	unic-langid-impl@0.9.4
	unicase@2.7.0
	unicode-bidi@0.3.15
	unicode-bidi-mirroring@0.1.0
	unicode-ccc@0.1.2
	unicode-ident@1.0.12
	unicode-math-class@0.1.0
	unicode-normalization@0.1.23
	unicode-properties@0.1.1
	unicode-script@0.5.6
	unicode-segmentation@1.11.0
	unicode-vo@0.1.0
	unicode-width@0.1.11
	unsafe-libyaml@0.2.10
	unscanny@0.1.0
	ureq@2.9.6
	url@2.5.0
	usvg@0.38.0
	usvg-parser@0.38.0
	usvg-text-layout@0.38.0
	usvg-tree@0.38.0
	utf8_iter@1.0.4
	utf8parse@0.2.1
	vcpkg@0.2.15
	version_check@0.9.4
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.92
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-shared@0.2.92
	wasmi@0.31.2
	wasmi_arena@0.4.1
	wasmi_core@0.13.0
	wasmparser-nostd@0.100.1
	weezl@0.1.8
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.4
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.4
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.4
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.4
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.4
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.4
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.4
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.4
	winnow@0.6.5
	writeable@0.5.4
	wyz@0.5.1
	xattr@1.3.1
	xmlparser@0.13.6
	xmlwriter@0.1.0
	xmp-writer@0.2.0
	xz2@0.1.7
	yaml-front-matter@0.1.0
	yaml-rust@0.4.5
	yoke@0.7.3
	yoke-derive@0.7.3
	zerofrom@0.1.3
	zerofrom-derive@0.1.3
	zerotrie@0.1.2
	zerovec@0.10.1
	zerovec-derive@0.10.1
	zip@0.6.6
	zopfli@0.8.0
"

declare -A GIT_CRATES=(
	[typst-dev-assets]="https://github.com/typst/typst-dev-assets;e0ef7ad46f28a440c41bc8e78563ace86cc02678;typst-dev-assets-%commit%"
)

RUST_MIN_VER="1.74.0"
RUST_MAX_VER="1.81.0" #1.82.0 failes 4 test

inherit cargo shell-completion

DESCRIPTION="A new markup-based typesetting system that is powerful and easy to learn."
HOMEPAGE="
	https://typst.app/
	https://github.com/typst/typst
"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/typst/typst/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"
LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB SSLeay openssl UoI-NCSA"
LICENSE+=" embed-fonts? ( OFL-1.1 GFL BitstreamVera )"

SLOT="0"
KEYWORDS="amd64"
IUSE="doc embed-fonts test"
RESTRICT="mirror !test? ( test )"

DOCS=(LICENSE NOTICE README.md docs/changelog.md)

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"
src_prepare() {
	sed -i "s/^strip = true$/strip = false/" Cargo.toml || die
	eapply -d "${WORKDIR}/cargo_home/gentoo/time-0.3.34" -- "${FILESDIR}/time_rust-1.80.patch"
	default
}

src_configure() {
	local myfeatures=(
		$(usev embed-fonts)
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	export GEN_ARTIFACTS="${S}/artifacts"
	local typst_hash="$(gunzip -c "${DISTDIR}/typst-${PV}.tar.gz" |git get-tar-commit-id)"
	assert "Failed to get commit hash"
	export TYPST_VERSION="${PV} (${typst_hash:0:8})"
	cargo_src_compile
}

src_test() {
	cargo_src_test --all
}

src_install() {
	cargo_src_install --path crates/typst-cli

	pushd ${GEN_ARTIFACTS} || die
	newbashcomp typst.bash typst
	dofishcomp typst.fish
	dozshcomp _typst
	doman *.1
	popd

	einstalldocs
	use doc && dodoc -r docs/{guides,reference,tutorial}
}