# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1
# Using template deno.tera

EAPI=8

CRATES="
	Inflector@0.11.4
	addr2line@0.21.0
	adler@1.0.2
	aead@0.5.2
	aead-gcm-stream@0.1.0
	aes@0.8.3
	aes-gcm@0.10.3
	aes-kw@0.2.1
	ahash@0.8.6
	aho-corasick@1.1.2
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	allocator-api2@0.2.16
	ammonia@3.3.0
	android_system_properties@0.1.5
	anstream@0.6.7
	anstyle@1.0.4
	anstyle-parse@0.2.3
	anstyle-query@1.0.1
	anstyle-wincon@3.0.2
	anyhow@1.0.79
	arrayvec@0.7.4
	ash@0.37.3+1.3.251
	asn1-rs@0.5.2
	asn1-rs-derive@0.4.0
	asn1-rs-impl@0.1.0
	ast_node@0.9.6
	async-compression@0.4.5
	async-stream@0.3.5
	async-stream-impl@0.3.5
	async-trait@0.1.74
	asynchronous-codec@0.7.0
	auto_impl@1.1.0
	autocfg@1.1.0
	backtrace@0.3.69
	base16ct@0.2.0
	base32@0.4.0
	base64@0.21.6
	base64-simd@0.8.0
	base64ct@1.6.0
	bencher@0.1.5
	better_scoped_tls@0.1.1
	bincode@1.3.3
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.4.1
	block@0.1.6
	block-buffer@0.10.4
	block-padding@0.3.3
	brotli@3.4.0
	brotli-decompressor@2.5.1
	bumpalo@3.14.0
	bytemuck@1.14.0
	byteorder@1.5.0
	bytes@1.5.0
	cache_control@0.2.0
	cbc@0.1.2
	cc@1.0.83
	cfg-if@1.0.0
	chrono@0.4.31
	cipher@0.4.4
	clap@4.4.17
	clap_builder@4.4.17
	clap_complete@4.4.7
	clap_complete_fig@4.4.2
	clap_lex@0.6.0
	clipboard-win@5.0.0
	cmake@0.1.50
	codespan-reporting@0.11.1
	color-print@0.3.5
	color-print-proc-macro@0.3.5
	color_quant@1.1.0
	colorchoice@1.0.0
	comrak@0.20.0
	console_static_text@0.8.1
	const-oid@0.9.5
	convert_case@0.4.0
	cooked-waker@5.0.0
	core-foundation@0.9.4
	core-foundation-sys@0.8.6
	core-graphics-types@0.1.3
	cpufeatures@0.2.11
	crc@2.1.0
	crc-catalog@1.1.1
	crc32fast@1.3.2
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.4
	crossbeam-epoch@0.9.17
	crossbeam-queue@0.3.8
	crossbeam-utils@0.8.18
	crypto-bigint@0.5.5
	crypto-common@0.1.6
	ctr@0.9.2
	curve25519-dalek@4.1.1
	curve25519-dalek-derive@0.1.1
	d3d12@0.7.0
	darling@0.14.4
	darling_core@0.14.4
	darling_macro@0.14.4
	dashmap@5.5.3
	data-encoding@2.5.0
	data-url@0.3.0
	debugid@0.8.0
	deno_ast@0.34.0
	deno_cache_dir@0.7.1
	deno_config@0.10.0
	deno_core@0.264.0
	deno_core_icudata@0.0.73
	deno_doc@0.110.1
	deno_emit@0.38.1
	deno_graph@0.69.0
	deno_lint@0.57.1
	deno_lockfile@0.19.0
	deno_media_type@0.1.2
	deno_native_certs@0.2.0
	deno_npm@0.17.0
	deno_ops@0.140.0
	deno_semver@0.5.4
	deno_task_shell@0.14.3
	deno_terminal@0.1.1
	deno_unsync@0.1.1
	deno_unsync@0.3.2
	deno_whoami@0.1.0
	denokv_proto@0.5.0
	denokv_remote@0.5.0
	denokv_sqlite@0.5.0
	der@0.7.8
	der-parser@8.2.0
	deranged@0.3.10
	derive_builder@0.12.0
	derive_builder_core@0.12.0
	derive_builder_macro@0.12.0
	derive_more@0.99.17
	deunicode@1.4.1
	diff@0.1.13
	digest@0.10.7
	displaydoc@0.2.4
	dissimilar@1.0.4
	dlopen2@0.6.1
	dlopen2_derive@0.4.0
	dotenvy@0.15.7
	dprint-core@0.63.3
	dprint-plugin-json@0.19.1
	dprint-plugin-jupyter@0.1.2
	dprint-plugin-markdown@0.16.3
	dprint-plugin-typescript@0.89.2
	dprint-swc-ext@0.15.0
	dsa@0.6.2
	dyn-clone@1.0.16
	dynasm@1.2.3
	dynasmrt@1.2.3
	ecb@0.1.2
	ecdsa@0.16.9
	either@1.9.0
	elliptic-curve@0.13.8
	encoding_rs@0.8.33
	endian-type@0.1.2
	entities@1.0.1
	enum-as-inner@0.5.1
	env_logger@0.10.0
	equivalent@1.0.1
	errno@0.2.8
	errno@0.3.8
	errno-dragonfly@0.1.2
	error-code@3.0.0
	escape8259@0.5.2
	eszip@0.64.1
	fallible-iterator@0.2.0
	fallible-streaming-iterator@0.1.9
	fancy-regex@0.10.0
	fastrand@2.0.1
	fastwebsockets@0.6.0
	fd-lock@4.0.1
	fdeflate@0.3.3
	ff@0.13.0
	fiat-crypto@0.2.5
	filetime@0.2.23
	fixedbitset@0.4.2
	flaky_test@0.1.0
	flate2@1.0.28
	float-cmp@0.9.0
	fnv@1.0.7
	foreign-types@0.5.0
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	form_urlencoded@1.2.1
	from_variant@0.1.7
	fs3@0.5.0
	fsevent-sys@4.1.0
	fslock@0.2.1
	futf@0.1.5
	futures@0.3.29
	futures-channel@0.3.29
	futures-core@0.3.29
	futures-executor@0.3.29
	futures-io@0.3.29
	futures-macro@0.3.29
	futures-sink@0.3.29
	futures-task@0.3.29
	futures-util@0.3.29
	fwdansi@1.1.0
	generic-array@0.14.7
	getrandom@0.2.11
	ghash@0.5.0
	gimli@0.28.1
	gl_generator@0.14.0
	glibc_version@0.1.2
	glob@0.3.1
	glow@0.13.0
	glutin_wgl_sys@0.5.0
	gpu-alloc@0.6.0
	gpu-alloc-types@0.3.0
	gpu-allocator@0.23.0
	gpu-descriptor@0.2.4
	gpu-descriptor-types@0.1.2
	group@0.13.0
	h2@0.3.22
	h2@0.4.0
	halfbrown@0.2.4
	handlebars@5.0.0
	hashbrown@0.13.2
	hashbrown@0.14.3
	hashlink@0.8.4
	heck@0.4.1
	hermit-abi@0.3.3
	hex@0.4.3
	hexf-parse@0.2.1
	hkdf@0.12.3
	hmac@0.12.1
	home@0.5.5
	hostname@0.3.1
	hstr@0.2.6
	html-escape@0.2.13
	html5ever@0.26.0
	http@0.2.11
	http@1.0.0
	http-body@0.4.5
	http-body@1.0.0
	http-body-util@0.1.0
	httparse@1.8.0
	httpdate@1.0.3
	humantime@2.1.0
	hyper@0.14.27
	hyper@1.1.0
	hyper-rustls@0.24.2
	hyper-util@0.1.2
	ident_case@1.0.1
	idna@0.2.3
	idna@0.3.0
	idna@0.4.0
	if_chain@1.0.2
	image@0.24.7
	import_map@0.18.3
	indexmap@2.1.0
	inotify@0.9.6
	inotify-sys@0.1.5
	inout@0.1.3
	instant@0.1.12
	ipconfig@0.3.2
	ipnet@2.9.0
	is-docker@0.2.0
	is-macro@0.3.1
	is-terminal@0.4.9
	is-wsl@0.4.0
	itertools@0.10.5
	itoa@1.0.9
	jobserver@0.1.27
	js-sys@0.3.66
	jsonc-parser@0.23.0
	junction@0.2.0
	k256@0.13.2
	khronos-egl@6.0.0
	khronos_api@3.1.0
	kqueue@1.0.8
	kqueue-sys@1.0.4
	lazy-regex@3.1.0
	lazy-regex-proc_macros@3.1.0
	lazy_static@1.4.0
	lexical-core@0.8.5
	lexical-parse-float@0.8.5
	lexical-parse-integer@0.8.6
	lexical-util@0.8.5
	lexical-write-float@0.8.5
	lexical-write-integer@0.8.5
	libc@0.2.150
	libffi@3.2.0
	libffi-sys@2.3.0
	libloading@0.7.4
	libloading@0.8.1
	libm@0.2.8
	libsqlite3-sys@0.26.0
	libz-sys@1.1.12
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.12
	lock_api@0.4.11
	log@0.4.20
	lru-cache@0.1.2
	lsp-types@0.94.1
	mac@0.1.1
	malloc_buf@0.0.6
	maplit@1.0.2
	markup5ever@0.11.0
	match_cfg@0.1.0
	matches@0.1.10
	md-5@0.10.6
	md4@0.10.2
	memchr@2.6.4
	memmap2@0.5.10
	memmem@0.1.1
	memoffset@0.7.1
	memoffset@0.9.0
	metal@0.27.0
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	mio@0.8.10
	monch@0.5.0
	multimap@0.8.3
	naga@0.14.2
	napi-build@1.2.1
	napi-sys@2.2.2
	netif@0.1.6
	new_debug_unreachable@1.0.4
	nextest-workspace-hack@0.1.0
	nibble_vec@0.1.0
	nix@0.26.2
	nix@0.27.1
	nom@5.1.3
	nom@7.1.3
	notify@5.0.0
	ntapi@0.4.1
	num-bigint@0.4.4
	num-bigint-dig@0.8.4
	num-integer@0.1.45
	num-iter@0.1.43
	num-rational@0.4.1
	num-traits@0.2.17
	num_cpus@1.16.0
	objc@0.2.7
	objc_exception@0.1.2
	object@0.32.1
	oid-registry@0.6.1
	once_cell@1.19.0
	opaque-debug@0.3.0
	open@5.0.1
	openssl-probe@0.1.5
	ordered-float@2.10.1
	os_pipe@1.1.5
	outref@0.5.1
	p224@0.13.2
	p256@0.13.2
	p384@0.13.0
	p521@0.13.3
	parking_lot@0.11.2
	parking_lot@0.12.1
	parking_lot_core@0.8.6
	parking_lot_core@0.9.9
	password-hash@0.5.0
	paste@1.0.14
	path-clean@0.1.0
	path-dedot@3.1.1
	pathdiff@0.2.1
	pbkdf2@0.12.2
	pem-rfc7468@0.7.0
	percent-encoding@2.3.1
	pest@2.7.5
	pest_derive@2.7.5
	pest_generator@2.7.5
	pest_meta@2.7.5
	petgraph@0.6.4
	phf@0.10.1
	phf@0.11.2
	phf_codegen@0.10.0
	phf_generator@0.10.0
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.10.0
	phf_shared@0.11.2
	pin-project@1.1.3
	pin-project-internal@1.1.3
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pkcs1@0.7.5
	pkcs8@0.10.2
	pkg-config@0.3.27
	platforms@3.2.0
	pmutil@0.6.1
	png@0.17.10
	polyval@0.6.1
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	precomputed-hash@0.1.1
	presser@0.3.1
	pretty_assertions@1.4.0
	prettyplease@0.1.25
	primeorder@0.13.6
	proc-macro-error@1.0.4
	proc-macro-error-attr@1.0.4
	proc-macro-rules@0.4.0
	proc-macro-rules-macros@0.4.0
	proc-macro2@1.0.76
	profiling@1.0.11
	prost@0.11.9
	prost-build@0.11.9
	prost-derive@0.11.9
	prost-types@0.11.9
	psm@0.1.21
	pulldown-cmark@0.9.3
	quick-error@1.2.3
	quick-junit@0.3.5
	quick-xml@0.31.0
	quote@1.0.35
	radix_fmt@1.0.0
	radix_trie@0.2.1
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	range-alloc@0.1.3
	raw-window-handle@0.5.2
	rayon@1.8.0
	rayon-core@1.12.0
	redox_syscall@0.2.16
	redox_syscall@0.4.1
	ref-cast@1.0.20
	ref-cast-impl@1.0.20
	regex@1.10.2
	regex-automata@0.4.3
	regex-syntax@0.8.2
	relative-path@1.9.0
	reqwest@0.11.20
	resolv-conf@0.7.0
	rfc6979@0.4.0
	ring@0.17.7
	ripemd@0.1.3
	ron@0.8.1
	rsa@0.9.6
	rusqlite@0.29.0
	rustc-demangle@0.1.23
	rustc-hash@1.1.0
	rustc_version@0.2.3
	rustc_version@0.4.0
	rusticata-macros@4.1.0
	rustix@0.38.27
	rustls@0.21.10
	rustls-native-certs@0.6.3
	rustls-pemfile@1.0.4
	rustls-tokio-stream@0.2.17
	rustls-webpki@0.101.7
	rustversion@1.0.14
	rustyline@13.0.0
	rustyline-derive@0.7.0
	ryu@1.0.15
	ryu-js@1.0.0
	saffron@0.1.0
	salsa20@0.10.2
	same-file@1.0.6
	schannel@0.1.22
	scoped-tls@1.0.1
	scopeguard@1.2.0
	scrypt@0.11.0
	sct@0.7.1
	sec1@0.7.3
	security-framework@2.9.2
	security-framework-sys@2.9.1
	semver@0.9.0
	semver@1.0.14
	semver-parser@0.7.0
	serde@1.0.195
	serde-value@0.7.0
	serde_bytes@0.11.12
	serde_derive@1.0.195
	serde_json@1.0.111
	serde_repr@0.1.16
	serde_urlencoded@0.7.1
	serde_v8@0.173.0
	sha-1@0.10.0
	sha1@0.10.6
	sha2@0.10.8
	shell-escape@0.1.5
	signal-hook-registry@1.4.1
	signature@2.2.0
	simd-adler32@0.3.7
	simd-json@0.13.4
	simdutf8@0.1.4
	siphasher@0.3.11
	slab@0.4.9
	slotmap@1.0.7
	slug@0.1.5
	smallvec@1.11.2
	smartstring@1.0.1
	socket2@0.4.10
	socket2@0.5.5
	sourcemap@6.4.1
	sourcemap@7.0.1
	spin@0.5.2
	spin@0.9.8
	spirv@0.2.0+1.5.4
	spki@0.7.3
	stacker@0.1.15
	static_assertions@1.1.0
	string_cache@0.8.7
	string_cache_codegen@0.5.2
	string_enum@0.4.2
	strip-ansi-escapes@0.2.0
	strsim@0.10.0
	strum@0.25.0
	strum_macros@0.25.3
	subtle@2.5.0
	swc_atoms@0.6.5
	swc_bundler@0.225.6
	swc_cached@0.3.19
	swc_common@0.33.17
	swc_config@0.1.11
	swc_config_macro@0.1.3
	swc_ecma_ast@0.112.2
	swc_ecma_codegen@0.148.3
	swc_ecma_codegen_macros@0.7.4
	swc_ecma_loader@0.45.19
	swc_ecma_parser@0.143.3
	swc_ecma_transforms_base@0.137.6
	swc_ecma_transforms_classes@0.126.6
	swc_ecma_transforms_macros@0.5.4
	swc_ecma_transforms_optimization@0.198.6
	swc_ecma_transforms_proposal@0.171.6
	swc_ecma_transforms_react@0.183.6
	swc_ecma_transforms_typescript@0.188.6
	swc_ecma_utils@0.127.5
	swc_ecma_visit@0.98.2
	swc_eq_ignore_macros@0.1.3
	swc_fast_graph@0.21.17
	swc_graph_analyzer@0.22.19
	swc_macros_common@0.3.9
	swc_visit@0.5.8
	swc_visit_macros@0.5.9
	syn@1.0.109
	syn@2.0.48
	synstructure@0.12.6
	tar@0.4.40
	tempfile@3.8.1
	tendril@0.4.3
	termcolor@1.4.0
	text-size@1.1.0
	text_lines@0.6.0
	thiserror@1.0.50
	thiserror-impl@1.0.50
	time@0.3.30
	time-core@0.1.2
	time-macros@0.2.15
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio@1.36.0
	tokio-macros@2.2.0
	tokio-metrics@0.3.1
	tokio-rustls@0.24.1
	tokio-socks@0.5.1
	tokio-stream@0.1.14
	tokio-util@0.7.10
	toml@0.5.11
	tower@0.4.13
	tower-layer@0.3.2
	tower-lsp@0.20.0
	tower-lsp-macros@0.9.0
	tower-service@0.3.2
	tracing@0.1.40
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	trust-dns-client@0.22.0
	trust-dns-proto@0.22.0
	trust-dns-resolver@0.22.0
	trust-dns-server@0.22.1
	try-lock@0.2.5
	twox-hash@1.6.3
	typed-arena@2.0.1
	typenum@1.17.0
	ucd-trie@0.1.6
	unic-char-property@0.9.0
	unic-char-range@0.9.0
	unic-common@0.9.0
	unic-ucd-ident@0.9.0
	unic-ucd-version@0.9.0
	unicase@2.7.0
	unicode-bidi@0.3.14
	unicode-id@0.3.4
	unicode-ident@1.0.12
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	unicode-width@0.1.11
	unicode-xid@0.2.4
	unicode_categories@0.1.1
	universal-hash@0.5.1
	untrusted@0.9.0
	url@2.4.1
	urlpattern@0.2.0
	utf-8@0.7.6
	utf8-width@0.1.7
	utf8parse@0.2.1
	uuid@1.6.1
	v8@0.83.2
	value-trait@0.8.0
	vcpkg@0.2.15
	version_check@0.9.4
	vsimd@0.8.0
	vte@0.11.1
	vte_generate_state_changes@0.1.1
	walkdir@2.3.2
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.89
	wasm-bindgen-backend@0.2.89
	wasm-bindgen-futures@0.4.39
	wasm-bindgen-macro@0.2.89
	wasm-bindgen-macro-support@0.2.89
	wasm-bindgen-shared@0.2.89
	wasm-streams@0.3.0
	web-sys@0.3.66
	webpki-roots@0.25.3
	wgpu-core@0.18.1
	wgpu-hal@0.18.1
	wgpu-types@0.18.0
	which@4.4.2
	which@5.0.0
	whoami@1.4.1
	widestring@1.0.2
	win32job@2.0.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.51.1
	windows@0.52.0
	windows-core@0.51.1
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	winreg@0.50.0
	winres@0.1.12
	x25519-dalek@2.0.0
	x509-parser@0.15.1
	xattr@1.0.1
	xml-rs@0.8.19
	yansi@0.5.1
	zerocopy@0.7.31
	zerocopy-derive@0.7.31
	zeroize@1.7.0
	zeroize_derive@1.4.2
	zeromq@0.3.4
	zstd@0.12.4
	zstd-safe@6.0.6
	zstd-sys@2.0.9+zstd.1.5.5
"

DENO_STD_VER="0.208.0"
V8_VER="0.83.2"
inherit cargo llvm multiprocessing toolchain-funcs check-reqs shell-completion

DESCRIPTION="A modern runtime for JavaScript and TypeScript"
HOMEPAGE="https://deno.land/"
SRC_URI="${CARGO_CRATE_URIS}"
SRC_URI+="
	https://github.com/denoland/deno/archive/refs/tags/v${PV}.tar.gz -> deno-${PV}.tar.gz
	test? (
		https://github.com/denoland/deno_std/archive/refs/tags/${DENO_STD_VER}.tar.gz -> deno_std@${DENO_STD_VER}.tar.gz
	)
	v8-prebuilt? (
		https://github.com/denoland/rusty_v8/releases/download/v${V8_VER}/librusty_v8_release_x86_64-unknown-linux-gnu.a ->
		librusty_v8_${V8_VER}_release_amd64.a
	)
"
LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions Artistic-2 BSD BSD-1 BSD-2 Boost-1.0 CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB openssl SSLeay"

SLOT="0"
KEYWORDS="amd64"
IUSE="v8-prebuilt test"
RESTRICT="mirror !test? ( test )"

BDEPEND="
	dev-build/gn
	dev-build/ninja
	>=virtual/rust-1.76 <virtual/rust-1.83
	test? (
		net-misc/curl
	)
"
PATCHES=(
	"${FILESDIR}/deno-1.41.0-fix_disable_tests.patch"
)
DOCS=(Releases.md LICENSE.md README.md)
function find_crate() {
	[[ ${#} -ne 1 ]] && die "No crate name provided"
	for crate in ${CRATES};do
		[[ ${crate} =~ ${1} ]] && echo "${crate/@/-}" && return
	done
	die "Crate $1 not found"
}

function patch_crate() {
	pushd "${ECARGO_VENDOR}/$(find_crate ${1})" > /dev/null || die "${1} crate folder not found"
	shift
	eapply ${@}
	popd > /dev/null
}
pkg_pretend() {
	#This used 7.6GB using 8G for safety
	CHECKREQS_DISK_BUILD="8G"
	check-reqs_pkg_pretend
	}

pkg_setup() {
	CHECKREQS_DISK_BUILD="8G"
	check-reqs_pkg_setup
	}
src_unpack() {
	cargo_src_unpack
	if use test; then
		rmdir "${S}/tests/util/std" || die "Failed to remove ${S}/tests/util/std"
		mv "${WORKDIR}/std-${DENO_STD_VER}/" "${S}/tests/util/std" || die "Failed to move deno-std into position"
	fi
}
src_prepare() {
	patch_crate ^v8@ "${FILESDIR}/v8-0.43.1-lockfile.patch"\
		"${FILESDIR}/v8-0.42.0-disable-auto-ccache.patch"\
		"${FILESDIR}/v8-0.40.2-jobfix.patch"
	patch_crate deno_core "${FILESDIR}/core-735.patch"
	patch_crate serde_v8 "${FILESDIR}/serde_v8-735.patch"
	patch_crate ^time@ "${FILESDIR}/time_rust-1.80.patch"

	default
}
src_configure() {
	cd cli || die "Failed to change dir cli"
	local myfeatures=(
		__vendored_zlib_ng
	)
	cargo_src_configure --no-default-features
}
src_compile() {
	#inspired by www-client/chromium
	#GCC-12 issued warnings and caused it to fail
	local gn_conf="treat_warnings_as_errors=false"
	if tc-is-clang; then
		einfo "Clang version: $(clang-fullversion) - $(get_llvm_prefix)"
		gn_conf+=" is_clang=true"
	else
		export DISABLE_CLANG=true
		einfo "GCC version: $(gcc-fullversion)"
		gn_conf+=" use_custom_libcxx=false"
	fi

	if tc-ld-is-lld && tc-is-clang;then
		gn_conf+=" use_lld=true"
	elif tc-ld-is-gold;then
		gn_conf+=" use_lld=false use_gold=true"
	else
		gn_conf+=" use_lld=false use_gold=false"
	fi

	#They didn't include the pgo files tools/builtins-pgo/{x64,arm64}.profile
	#https://github.com/denoland/rusty_v8/pull/1063
	#https://github.com/Homebrew/homebrew-core/pull/108838
	gn_conf+=" v8_builtins_profiling_log_file=\"\""

	if use v8-prebuilt;then
		export RUSTY_V8_ARCHIVE="${DISTDIR}/librusty_v8_${V8_VER}_release_amd64.a"
	else
		export V8_FROM_SOURCE=1
	fi
	#export SCCACHE=
	#export CCACHE=
	export GN="${EPREFIX}/usr/bin/gn"
	export NINJA="${EPREFIX}/usr/bin/ninja"
	export CLANG_BASE_PATH=$(get_llvm_prefix)
	export NINJA_JOBS=$(makeopts_jobs)
	#support gn-.2077
	export NO_PRINT_GN_ARGS=true
	export GN_ARGS="${gn_conf}"
	#export EXTRA_GN_ARGS=
	einfo "GN_ARGS=${GN_ARGS}"

	pushd cli > /dev/null || die "Failed to change dir cli"
	cargo_src_compile -vv
	popd > /dev/null

	if use test;then
		pushd tests/util/server > /dev/null || die "Failed to change dir to tests/util/server"
		#it dosn't like __vendored_zlib_ng - hope this is correct
		cargo_env cargo build $(usex debug "" --release) || die
		popd > /dev/null
	fi

	"$(cargo_target_dir)"/deno completions bash > deno.sh   || die "Failed to create bash completion file"
	"$(cargo_target_dir)"/deno completions fish > deno.fish || die "Failed to create fish completion file"
	"$(cargo_target_dir)"/deno completions zsh  > _deno     || die "Failed to create zsh completion file"
}

src_install() {
	cargo_src_install --path cli
	einstalldocs

	newbashcomp deno.sh deno
	dofishcomp deno.fish
	dozshcomp _deno
}

pkg_postinst() {
	if ! tc-is-clang ; then
		#--When cargo_src_compile -vv
		#QA Check notes gcc warns about return-local-addr for the following file
		#${ECARGO_VENDOR}/${v8_dir}/third_party/icu/source/i18n/formattedvalue.cpp:212
		#https://github.com/unicode-org/icu/blob/main/icu4c/source/i18n/formattedvalue.cpp#L212
		#the source code mentions this is a false positive
		#come up with some text to inform the user
		#TODO unbundle third party libs(ICU,zlib) if possible
		:
	fi
}
