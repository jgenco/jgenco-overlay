# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

IUSE="test"
RESTRICT="!test? ( test )"

DESCRIPTION="A new way of working with Protocol Buffers."
HOMEPAGE="https://buf.build/"

EGO_SUM=(
	"google.golang.org/protobuf v1.31.0"
	"google.golang.org/protobuf v1.31.0/go.mod"
	"connectrpc.com/connect v1.11.1"
	"connectrpc.com/connect v1.11.1/go.mod"
	"connectrpc.com/otelconnect v0.6.0"
	"connectrpc.com/otelconnect v0.6.0/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"go.uber.org/zap v1.26.0"
	"go.uber.org/zap v1.26.0/go.mod"
	"golang.org/x/term v0.13.0"
	"golang.org/x/term v0.13.0/go.mod"
	"go.opentelemetry.io/otel v1.19.0"
	"go.opentelemetry.io/otel v1.19.0/go.mod"
	"go.opentelemetry.io/otel/trace v1.19.0"
	"go.opentelemetry.io/otel/trace v1.19.0/go.mod"
	"go.uber.org/multierr v1.11.0"
	"go.uber.org/multierr v1.11.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	"go.uber.org/atomic v1.11.0"
	"go.uber.org/atomic v1.11.0/go.mod"
	"github.com/spf13/cobra v1.7.0"
	"github.com/spf13/cobra v1.7.0/go.mod"
	"github.com/google/go-containerregistry v0.16.1"
	"github.com/google/go-containerregistry v0.16.1/go.mod"
	"golang.org/x/net v0.17.0"
	"golang.org/x/net v0.17.0/go.mod"
	"github.com/pkg/browser v0.0.0-20210911075715-681adbf594b8"
	"github.com/pkg/browser v0.0.0-20210911075715-681adbf594b8/go.mod"
	"github.com/pkg/profile v1.7.0"
	"github.com/pkg/profile v1.7.0/go.mod"
	"go.opentelemetry.io/otel/metric v1.19.0"
	"go.opentelemetry.io/otel/metric v1.19.0/go.mod"
	"github.com/bufbuild/protocompile v0.6.0"
	"github.com/bufbuild/protocompile v0.6.0/go.mod"
	"github.com/jdx/go-netrc v1.0.0"
	"github.com/jdx/go-netrc v1.0.0/go.mod"
	"golang.org/x/sys v0.13.0"
	"golang.org/x/sys v0.13.0/go.mod"
	"github.com/klauspost/compress v1.17.2"
	"github.com/klauspost/compress v1.17.2/go.mod"
	"github.com/klauspost/pgzip v1.2.6"
	"github.com/klauspost/pgzip v1.2.6/go.mod"
	"github.com/go-logr/logr v1.2.4"
	"github.com/go-logr/logr v1.2.4/go.mod"
	"golang.org/x/mod v0.13.0"
	"golang.org/x/mod v0.13.0/go.mod"
	"github.com/tetratelabs/wazero v1.5.0"
	"github.com/tetratelabs/wazero v1.5.0/go.mod"
	"golang.org/x/crypto v0.14.0"
	"golang.org/x/crypto v0.14.0/go.mod"
	"github.com/docker/docker v24.0.6+incompatible"
	"github.com/docker/docker v24.0.6+incompatible/go.mod"
	"github.com/docker/cli v24.0.6+incompatible"
	"github.com/docker/cli v24.0.6+incompatible/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"golang.org/x/sync v0.4.0"
	"golang.org/x/sync v0.4.0/go.mod"
	"github.com/docker/distribution v2.8.3+incompatible"
	"github.com/docker/distribution v2.8.3+incompatible/go.mod"
	"github.com/opencontainers/go-digest v1.0.0"
	"github.com/opencontainers/go-digest v1.0.0/go.mod"
	"github.com/go-chi/chi/v5 v5.0.10"
	"github.com/go-chi/chi/v5 v5.0.10/go.mod"
	"github.com/rs/cors v1.10.1"
	"github.com/rs/cors v1.10.1/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.3"
	"github.com/cpuguy83/go-md2man/v2 v2.0.3/go.mod"
	"go.opentelemetry.io/otel/sdk v1.19.0"
	"go.opentelemetry.io/otel/sdk v1.19.0/go.mod"
	"github.com/felixge/fgprof v0.9.3"
	"github.com/felixge/fgprof v0.9.3/go.mod"
	"github.com/gofrs/uuid/v5 v5.0.0"
	"github.com/gofrs/uuid/v5 v5.0.0/go.mod"
	"github.com/go-logr/stdr v1.2.2"
	"github.com/go-logr/stdr v1.2.2/go.mod"
	"github.com/docker/go-connections v0.4.0"
	"github.com/docker/go-connections v0.4.0/go.mod"
	"github.com/docker/go-units v0.5.0"
	"github.com/docker/go-units v0.5.0/go.mod"
	"github.com/opencontainers/image-spec v1.1.0-rc5"
	"github.com/opencontainers/image-spec v1.1.0-rc5/go.mod"
	"github.com/moby/term v0.5.0"
	"github.com/moby/term v0.5.0/go.mod"
	"github.com/morikuni/aec v1.0.0"
	"github.com/morikuni/aec v1.0.0/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/sirupsen/logrus v1.9.3"
	"github.com/sirupsen/logrus v1.9.3/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/google/pprof v0.0.0-20230926050212-f7f687d19a98"
	"github.com/google/pprof v0.0.0-20230926050212-f7f687d19a98/go.mod"
	"golang.org/x/text v0.13.0"
	"golang.org/x/text v0.13.0/go.mod"
	"github.com/distribution/reference v0.5.0"
	"github.com/distribution/reference v0.5.0/go.mod"
	"github.com/docker/docker-credential-helpers v0.8.0"
	"github.com/docker/docker-credential-helpers v0.8.0/go.mod"
	"github.com/containerd/stargz-snapshotter/estargz v0.14.3"
	"github.com/containerd/stargz-snapshotter/estargz v0.14.3/go.mod"
	"github.com/gogo/protobuf v1.3.2"
	"github.com/gogo/protobuf v1.3.2/go.mod"
	"github.com/vbatts/tar-split v0.11.5"
	"github.com/vbatts/tar-split v0.11.5/go.mod"

	"google.golang.org/protobuf v1.31.0"
	"google.golang.org/protobuf v1.31.0/go.mod"
	"github.com/stretchr/testify v1.8.4"
	"github.com/stretchr/testify v1.8.4/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/jhump/protoreflect v1.15.3"
	"github.com/jhump/protoreflect v1.15.3/go.mod"
	"golang.org/x/tools v0.14.0"
	"golang.org/x/tools v0.14.0/go.mod"
	"golang.org/x/exp v0.0.0-20231006140011-7918f672742d"
	"golang.org/x/exp v0.0.0-20231006140011-7918f672742d/go.mod"
	"github.com/gofrs/flock v0.8.1"
	"github.com/gofrs/flock v0.8.1/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/bufbuild/buf/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="Apache-2.0 MIT BSD BSD-2 CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	test? (
		dev-vcs/git
	)
"
DOCS=( CHANGELOG.md LICENSE README.md )

src_configure(){
	#the test phase d/l and installs various programs
	#They are installed in ${HOME}/.cache/buf/Linux/x86_64/bin
	sed -i '/dep_proto/d;/dep_minisign/d' make/buf/all.mk || die
	default
}
src_compile(){
	GOBIN="${S}/bin" go install ./cmd/{buf,protoc-gen-buf-breaking,protoc-gen-buf-lint} || die
	./bin/buf completion bash > buf
	./bin/buf completion fish > buf.fish
	./bin/buf completion zsh  > _buf
}

src_install(){
	dobin "${S}/bin/"{buf,protoc-gen-buf-breaking,protoc-gen-buf-lint}
	einstalldocs
	dobashcomp buf
	dofishcomp buf.fish
	dozshcomp  _buf
}

src_test(){
	#TODO: some test don't pass b/c of the missing programs
	git init || die
	git config user.email "you@example.com" || die
	git config user.name "Your Name" || die
	git add . && git commit -m "init" > /dev/null || die
	emake test
}
