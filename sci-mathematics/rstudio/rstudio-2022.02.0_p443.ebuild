# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake java-pkg-2 java-ant-2 multiprocessing pam qmake-utils xdg-utils

#In node-gyp dir remove devDeps in package.json
#yarn install to create the yarn.lock file
#then add node-gyp@version
#grep resolved yarn.lock |sed "s/.*yarnpkg\.com\/\([^/]*\/\)\?\(.*\)\/-\/\(\2\)-\(.*\).*.tgz#.*/\1\2@\4/"
#copy yarn.lock to files dir
NODE_GYP_VER="9.0.0"
NODE_GYP_SKEIN="
node-gyp@9.0.0
@gar/promisify@1.1.3
@npmcli/fs@2.1.0
@npmcli/move-file@1.1.2
@tootallnate/once@2.0.0
abbrev@1.1.1
agent-base@6.0.2
agentkeepalive@4.2.1
aggregate-error@3.1.0
ansi-regex@5.0.1
aproba@2.0.0
are-we-there-yet@3.0.0
balanced-match@1.0.2
brace-expansion@1.1.11
cacache@16.0.3
chownr@2.0.0
clean-stack@2.2.0
color-support@1.1.3
concat-map@0.0.1
console-control-strings@1.1.0
debug@4.3.4
delegates@1.0.0
depd@1.1.2
emoji-regex@8.0.0
encoding@0.1.13
env-paths@2.2.1
err-code@2.0.3
fs-minipass@2.1.0
fs.realpath@1.0.0
gauge@4.0.4
glob@7.2.0
graceful-fs@4.2.10
has-unicode@2.0.1
http-cache-semantics@4.1.0
http-proxy-agent@5.0.0
https-proxy-agent@5.0.0
humanize-ms@1.2.1
iconv-lite@0.6.3
imurmurhash@0.1.4
indent-string@4.0.0
infer-owner@1.0.4
inflight@1.0.6
inherits@2.0.4
ip@1.1.5
is-fullwidth-code-point@3.0.0
is-lambda@1.0.1
isexe@2.0.0
lru-cache@6.0.0
lru-cache@7.7.3
make-fetch-happen@10.1.1
minimatch@3.1.2
minipass-collect@1.0.2
minipass-fetch@2.1.0
minipass-flush@1.0.5
minipass-pipeline@1.2.4
minipass-sized@1.0.3
minipass@3.1.6
minizlib@2.1.2
mkdirp@1.0.4
ms@2.1.2
ms@2.1.3
negotiator@0.6.3
nopt@5.0.0
npmlog@6.0.1
once@1.4.0
p-map@4.0.0
path-is-absolute@1.0.1
promise-inflight@1.0.1
promise-retry@2.0.1
readable-stream@3.6.0
retry@0.12.0
rimraf@3.0.2
safe-buffer@5.2.1
safer-buffer@2.1.2
semver@7.3.5
set-blocking@2.0.0
signal-exit@3.0.7
smart-buffer@4.2.0
socks-proxy-agent@6.1.1
socks@2.6.2
ssri@8.0.1
string-width@4.2.3
string_decoder@1.3.0
strip-ansi@6.0.1
tar@6.1.11
unique-filename@1.1.1
unique-slug@2.0.2
util-deprecate@1.0.2
which@2.0.2
wide-align@1.1.5
wrappy@1.0.2
yallist@4.0.0
"
PANMIRROR_LOCK_HASH="4a50c9962a665093093b949bb57e06c9df5c9ac5"
PANMIRROR_SKEIN="
@babel/code-frame@7.8.3
@babel/helper-module-imports@7.15.4
@babel/helper-validator-identifier@7.14.9
@babel/highlight@7.8.3
@babel/runtime@7.9.6
@babel/runtime@7.8.4
@babel/types@7.15.6
@emotion/babel-utils@0.6.10
@emotion/hash@0.6.6
@emotion/is-prop-valid@0.6.8
@emotion/memoize@0.6.6
@emotion/serialize@0.9.1
@emotion/stylis@0.7.1
@emotion/unitless@0.6.7
@emotion/utils@0.8.2
@mapbox/node-pre-gyp@1.0.5
@textlint/ast-node-types@4.4.3
@types/ace@0.0.43
@types/clipboard@2.0.7
@types/diff-match-patch@1.0.32
@types/js-yaml@4.0.3
@types/lodash.debounce@4.0.6
@types/lodash.orderby@4.6.6
@types/lodash.uniqby@4.7.6
@types/lodash@4.14.154
@types/node@14.0.4
@types/orderedmap@1.0.0
@types/parse-json@4.0.0
@types/pinyin@2.10.0
@types/prop-types@15.7.3
@types/prosemirror-commands@1.0.3
@types/prosemirror-commands@1.0.4
@types/prosemirror-dropcursor@1.0.3
@types/prosemirror-gapcursor@1.0.4
@types/prosemirror-history@1.0.3
@types/prosemirror-inputrules@1.0.4
@types/prosemirror-keymap@1.0.4
@types/prosemirror-model@1.7.2
@types/prosemirror-schema-list@1.0.3
@types/prosemirror-state@1.2.3
@types/prosemirror-tables@0.9.1
@types/prosemirror-transform@1.1.1
@types/prosemirror-view@1.11.2
@types/react-dom@17.0.9
@types/react-window@1.8.5
@types/react@16.9.32
@types/react@17.0.20
@types/scheduler@0.16.2
@types/transliteration@1.6.6
@types/unzip@0.1.1
@types/zenscroll@4.0.1
abbrev@1.1.1
accepts@1.3.7
acorn-jsx@4.1.1
acorn@5.7.3
agent-base@6.0.2
ajax-request@1.2.3
ajv@6.12.0
ansi-escapes@3.2.0
ansi-regex@2.1.1
ansi-regex@3.0.0
ansi-regex@5.0.1
ansi-styles@3.2.1
ansi-styles@4.3.0
ansi@0.3.1
anymatch@1.3.2
app-root-path@1.4.0
app-root-path@2.2.1
aproba@1.2.0
are-we-there-yet@1.1.7
arg@4.1.3
argparse@1.0.10
argparse@2.0.1
arr-diff@2.0.0
arr-diff@4.0.0
arr-flatten@1.1.0
arr-union@3.1.0
array-flatten@1.1.1
array-unique@0.2.1
array-unique@0.3.2
asn1@0.2.4
assert-plus@1.0.0
assign-symbols@1.0.0
async-each@1.0.3
asynckit@0.4.0
atob@2.1.2
aws-sign2@0.7.0
aws4@1.9.1
babel-plugin-emotion@9.2.11
babel-plugin-macros@2.8.0
babel-plugin-syntax-jsx@6.18.0
babel-runtime@6.26.0
balanced-match@1.0.0
base16@1.0.0
base64-img@1.0.4
base64-js@1.3.1
base@0.11.2
bcrypt-pbkdf@1.0.2
biblatex-csl-converter@2.0.2
binary-extensions@1.13.1
binary@0.3.0
bindings@1.5.0
body-parser@1.19.0
boundary@1.0.1
bowser@2.9.0
brace-expansion@1.1.11
braces@1.8.5
braces@2.3.2
buffer-from@1.1.1
buffers@0.1.1
builtin-modules@1.1.1
bytes@3.1.0
cache-base@1.0.1
callsites@3.1.0
caseless@0.12.0
chain-able@1.0.1
chain-able@3.0.0
chainsaw@0.1.0
chalk@2.4.2
chardet@0.4.2
chokidar@1.7.0
chownr@2.0.0
class-utils@0.3.6
clean-css@4.2.3
cli-cursor@2.1.0
cli-width@2.2.0
clipboard@2.0.8
cliui@7.0.4
code-point-at@1.1.0
collection-visit@1.0.0
color-convert@1.9.3
color-convert@2.0.1
color-name@1.1.3
color-name@1.1.4
combined-stream@1.0.8
commander@2.20.3
commander@1.1.1
component-emitter@1.3.0
concat-map@0.0.1
concat-stream@1.6.2
concat-stream@2.0.0
console-control-strings@1.1.0
content-disposition@0.5.3
content-type@1.0.4
convert-source-map@1.7.0
convert-source-map@1.8.0
cookie-signature@1.0.6
cookie@0.4.0
copy-descriptor@0.1.1
core-js@2.6.11
core-util-is@1.0.2
cosmiconfig@6.0.0
create-emotion-styled@9.2.8
create-emotion@9.2.12
create-react-context@0.1.6
csstype@2.6.10
csstype@2.6.18
csstype@3.0.9
dashdash@1.14.1
debug@2.6.9
debug@4.3.2
decode-uri-component@0.2.0
deep-is@0.1.3
define-property@0.2.5
define-property@1.0.0
define-property@2.0.2
delayed-stream@1.0.0
delegate@3.2.0
delegates@1.0.0
depd@1.1.2
destroy@1.0.4
detect-libc@1.0.3
diff-match-patch@1.0.4
diff-match-patch@1.0.5
diff@4.0.2
ecc-jsbn@0.1.2
ee-first@1.1.1
emoji-regex@8.0.0
emotion@9.2.12
encodeurl@1.0.2
error-ex@1.3.2
es6-object-assign@1.1.0
escalade@3.1.1
escape-html@1.0.3
escape-string-regexp@1.0.5
escodegen@1.14.1
esprima@4.0.1
estraverse@4.3.0
esutils@2.0.3
etag@1.8.1
exec-sh@0.2.2
expand-brackets@0.1.5
expand-brackets@2.1.4
expand-range@1.8.2
express@4.17.1
extend-shallow@2.0.1
extend-shallow@3.0.2
extend@3.0.2
external-editor@2.2.0
extglob@0.3.2
extglob@2.0.4
extsprintf@1.3.0
extsprintf@1.4.0
fast-deep-equal@3.1.1
fast-json-stable-stringify@2.1.0
fast-levenshtein@2.0.6
fast-xml-parser@3.17.1
figures@2.0.0
file-match@1.0.2
file-system@2.2.2
file-uri-to-path@1.0.0
filename-regex@2.0.1
fill-range@2.2.4
fill-range@4.0.0
finalhandler@1.1.2
find-root@1.1.0
fliplog@0.3.13
for-in@1.0.2
for-own@0.1.5
forever-agent@0.6.1
form-data@2.3.3
forwarded@0.1.2
fragment-cache@0.2.1
fresh@0.5.2
fs-extra@7.0.1
fs-minipass@2.1.0
fs.realpath@1.0.0
fsevents@1.2.11
fstream@0.1.31
fuse-box@3.7.1
fuse-concat-with-sourcemaps@1.0.5
fuse.js@6.4.6
gauge@2.7.4
get-caller-file@1.0.3
get-caller-file@2.0.5
get-value@2.0.6
getopts@2.2.5
getpass@0.1.7
glob-base@0.3.0
glob-parent@2.0.0
glob@7.1.6
good-listener@1.2.2
graceful-fs@4.2.3
graceful-fs@3.0.12
har-schema@2.0.0
har-validator@5.1.3
has-flag@3.0.0
has-unicode@2.0.1
has-value@0.3.1
has-value@1.0.0
has-values@0.1.4
has-values@1.0.0
html@1.0.0
http-errors@1.7.2
http-errors@1.7.3
http-signature@1.2.0
https-proxy-agent@5.0.0
iconv-lite@0.4.24
ie-array-find-polyfill@1.1.0
ieee754@1.1.13
import-fresh@3.2.1
inflight@1.0.6
inherits@2.0.4
inherits@2.0.3
inquirer@3.3.0
ipaddr.js@1.9.1
is-accessor-descriptor@0.1.6
is-accessor-descriptor@1.0.0
is-arrayish@0.2.1
is-binary-path@1.0.1
is-buffer@1.1.6
is-data-descriptor@0.1.4
is-data-descriptor@1.0.0
is-descriptor@0.1.6
is-descriptor@1.0.2
is-dotfile@1.0.3
is-equal-shallow@0.1.3
is-extendable@0.1.1
is-extendable@1.0.1
is-extglob@1.0.0
is-fullwidth-code-point@1.0.0
is-fullwidth-code-point@2.0.0
is-fullwidth-code-point@3.0.0
is-glob@2.0.1
is-number@2.1.0
is-number@3.0.0
is-number@4.0.0
is-plain-object@2.0.4
is-posix-bracket@0.1.1
is-primitive@2.0.0
is-promise@2.1.0
is-typedarray@1.0.0
is-windows@1.0.2
isarray@0.0.1
isarray@1.0.0
isobject@2.1.0
isobject@3.0.1
isstream@0.1.2
js-tokens@4.0.0
js-yaml@3.13.1
js-yaml@4.1.0
jsbn@0.1.1
jsesc@0.5.0
json-parse-better-errors@1.0.2
json-schema-traverse@0.4.1
json-schema@0.2.3
json-stringify-safe@5.0.1
jsondiffpatch@0.3.11
jsonfile@4.0.0
jsprim@1.4.1
keypress@0.1.0
kind-of@3.2.2
kind-of@4.0.0
kind-of@5.1.0
kind-of@6.0.3
lego-api@1.0.8
levn@0.3.0
lines-and-columns@1.1.6
lodash._getnative@3.9.1
lodash.curry@4.1.1
lodash.debounce@3.1.1
lodash.debounce@4.0.8
lodash.flow@3.5.0
lodash.orderby@4.6.0
lodash.uniqby@4.7.0
lodash@4.17.15
loose-envify@1.4.0
lru-cache@6.0.0
make-dir@3.1.0
make-error@1.3.6
map-cache@0.2.2
map-visit@1.0.0
match-stream@0.0.2
math-random@1.0.4
media-typer@0.3.0
memoize-one@5.1.1
merge-descriptors@1.0.1
merge@1.2.1
methods@1.1.2
micromatch@2.3.11
micromatch@3.1.10
mime-db@1.43.0
mime-types@2.1.26
mime@1.6.0
mimic-fn@1.2.0
minimatch@3.0.4
minimist@0.0.8
minimist@1.2.0
minimist@1.2.5
minipass@3.1.5
minizlib@2.1.2
mixin-deep@1.3.2
mkdirp@0.5.5
mkdirp@0.5.1
mkdirp@1.0.4
mock-require@3.0.3
ms@2.0.0
ms@2.1.1
ms@2.1.2
mustache@2.3.2
mute-stream@0.0.7
nan@2.14.0
nanomatch@1.2.13
nanoseconds@0.1.0
natives@1.1.6
negotiator@0.6.2
node-addon-api@3.2.1
node-fetch@2.6.5
nodejieba@2.5.2
nopt@5.0.0
nopt@1.0.10
normalize-path@2.1.1
npmlog@4.1.2
number-is-nan@1.0.1
oauth-sign@0.9.0
object-assign@4.1.1
object-copy@0.1.0
object-visit@1.0.1
object.omit@2.0.1
object.pick@1.3.0
object_values@0.1.2
on-finished@2.3.0
once@1.4.0
onetime@2.0.1
optionator@0.8.3
options@0.0.6
orderedmap@1.1.1
os-tmpdir@1.0.2
over@0.0.5
parent-module@1.0.1
parse-glob@3.0.4
parse-json@5.0.0
parseurl@1.3.3
pascalcase@0.1.1
path-is-absolute@1.0.1
path-parse@1.0.6
path-to-regexp@0.1.7
path-type@4.0.0
performance-now@2.1.0
pinyin@2.10.2
posix-character-classes@0.1.1
postcss@6.0.23
prelude-ls@1.1.2
preserve@0.2.0
prettier@1.19.1
pretty-time@0.2.0
prettysize@0.0.3
process-nextick-args@2.0.1
prop-types@15.7.2
prosemirror-changeset@2.1.2
prosemirror-commands@1.1.10
prosemirror-dev-tools@2.1.1
prosemirror-dropcursor@1.3.5
prosemirror-gapcursor@1.1.5
prosemirror-history@1.2.0
prosemirror-inputrules@1.1.3
prosemirror-keymap@1.1.3
prosemirror-keymap@1.1.4
prosemirror-model@1.9.1
prosemirror-model@1.14.3
prosemirror-schema-list@1.1.5
prosemirror-state@1.3.2
prosemirror-state@1.3.4
prosemirror-tables@1.0.0
prosemirror-tables@1.1.1
prosemirror-transform@1.2.3
prosemirror-transform@1.3.2
prosemirror-utils@0.9.6
prosemirror-view@1.14.2
prosemirror-view@1.20.1
proxy-addr@2.0.6
psl@1.7.0
pullstream@0.4.1
punycode@2.1.1
pure-color@1.3.0
qs@6.7.0
qs@6.5.2
randomatic@3.1.1
range-parser@1.2.1
raw-body@2.4.0
react-base16-styling@0.5.3
react-dock@0.2.4
react-dom@17.0.2
react-emotion@9.2.12
react-is@16.13.0
react-json-tree@0.11.2
react-window@1.8.6
react@17.0.2
readable-stream@2.3.7
readable-stream@3.6.0
readable-stream@1.0.34
readdirp@2.2.1
realm-utils@1.0.9
regenerate-unicode-properties@8.1.0
regenerate@1.4.0
regenerator-runtime@0.11.1
regenerator-runtime@0.13.3
regenerator-runtime@0.13.5
regex-cache@0.4.4
regex-not@1.0.2
regexpu-core@4.6.0
regjsgen@0.5.1
regjsparser@0.6.3
remove-trailing-separator@1.1.0
repeat-element@1.1.3
repeat-string@1.6.1
request@2.88.2
require-directory@2.1.1
resolve-from@4.0.0
resolve-url@0.2.1
resolve@1.15.1
restore-cursor@2.0.0
ret@0.1.15
rimraf@2.7.1
rimraf@3.0.2
rope-sequence@1.3.2
run-async@2.4.0
rx-lite-aggregates@4.0.8
rx-lite@4.0.8
safe-buffer@5.1.2
safe-buffer@5.2.0
safe-buffer@5.2.1
safe-regex@1.1.0
safer-buffer@2.1.2
scheduler@0.20.2
select@1.1.2
semver@5.7.1
semver@6.3.0
semver@7.3.5
send@0.17.1
sentence-splitter@3.2.2
serve-static@1.14.1
set-blocking@2.0.0
set-value@2.0.1
setimmediate@1.0.5
setprototypeof@1.1.1
shorthash@0.0.2
signal-exit@3.0.5
signal-exit@3.0.2
slice-stream@1.0.0
snapdragon-node@2.1.1
snapdragon-util@3.0.1
snapdragon@0.8.2
source-map-resolve@0.5.3
source-map-support@0.5.19
source-map-support@0.5.16
source-map-url@0.4.0
source-map@0.5.7
source-map@0.6.1
source-map@0.7.3
sourcemap-blender@1.0.5
split-string@3.1.0
sprintf-js@1.0.3
sshpk@1.16.1
static-extend@0.1.2
statuses@1.5.0
stream-browserify@2.0.2
string-width@1.0.2
string-width@2.1.1
string-width@4.2.3
string_decoder@1.3.0
string_decoder@0.10.31
string_decoder@1.1.1
strip-ansi@3.0.1
strip-ansi@4.0.0
strip-ansi@6.0.1
structured-source@3.0.2
stylis-rule-sheet@0.0.10
stylis@3.5.4
supports-color@5.5.0
tar@6.1.11
terser@4.6.4
thenby@1.3.3
through@2.3.8
tiny-emitter@2.1.0
tlite@0.1.9
tmp@0.0.33
to-fast-properties@2.0.0
to-object-path@0.3.0
to-regex-range@2.1.1
to-regex@3.0.2
toidentifier@1.0.0
touch@2.0.2
tough-cookie@2.5.0
tr46@0.0.3
transliteration@2.2.0
traverse@0.3.9
ts-node@8.10.2
tslib@1.11.1
tslint-config-prettier@1.18.0
tslint-react@5.0.0
tslint@5.20.1
tsutils@2.29.0
tsutils@3.17.1
tunnel-agent@0.6.0
tweetnacl@0.14.5
type-check@0.3.2
type-is@1.6.18
typedarray@0.0.6
typescript-tslint-plugin@0.5.5
typescript@3.8.3
uglify-js@3.8.0
ultron@1.0.2
unicode-canonical-property-names-ecmascript@1.0.4
unicode-match-property-ecmascript@1.0.4
unicode-match-property-value-ecmascript@1.1.0
unicode-property-aliases-ecmascript@1.0.5
union-value@1.0.1
universalify@0.1.2
unpipe@1.0.0
unset-value@1.0.0
unstated@2.1.1
unzip@0.1.11
uri-js@4.2.2
urix@0.1.0
use@3.1.1
util-deprecate@1.0.2
utils-extend@1.0.8
utils-merge@1.0.1
uuid@3.4.0
vary@1.1.2
verror@1.10.0
vscode-jsonrpc@4.0.0
vscode-languageserver-protocol@3.14.1
vscode-languageserver-types@3.14.0
vscode-languageserver@5.2.1
vscode-uri@1.0.8
w3c-keyname@2.2.2
watch@1.0.2
webidl-conversions@3.0.1
whatwg-url@5.0.0
wide-align@1.1.3
word-wrap@1.2.3
wrap-ansi@7.0.0
wrappy@1.0.2
ws@1.1.5
y18n@5.0.8
yallist@4.0.0
yaml@1.7.2
yargs-parser@20.2.9
yargs@16.2.0
yn@3.1.1
zenscroll@4.0.2
"

QT_VER=5.12.8
QT_SLOT=5

DESCRIPTION="IDE for the R language"
HOMEPAGE="
	https://rstudio.com
	https://github.com/rstudio/rstudio/"

RSTUDIO_SOURCE_FILENAME="v${PV/_p/+}.tar.gz"
S="${WORKDIR}/${P/_p/-}"

SRC_URI="
	https://github.com/rstudio/rstudio/archive/${RSTUDIO_SOURCE_FILENAME} -> ${P}.tar.gz
	https://s3.amazonaws.com/rstudio-dictionaries/core-dictionaries.zip -> ${PN}-core-dictionaries.zip
"

#node-gyp and dependencies licenses
#MIT ISC BSD-3-Clause Apache-2.0 BSD-2-Clause (MIT OR CC0-1.0) BSD (AFL-2.1 OR BSD-3-Clause) (WTFPL-2 OR MIT) CC-BY-3.0 CC0-1.0 0BSD Unlicense
#panmirror and dependencies licenses
#(MIT OR Apache-2.0) Apache 2.0 Apache-2.0 BSD BSD-2-Clause BSD-3-Clause BSD* ISC LGPL-3.0 MIT Python-2.0 UNKNOWN(MIT/X11) Unlicense
#TODO fix BSD licences
LICENSE="AGPL-3 panmirror? ( AGPL-3 MIT ISC Apache-2.0 BSD Unlicense CC0-1.0  || ( AFL-2.1 BSD ) || ( WTFPL-2 MIT ) CC-BY-3.0 LGPL-3.0 Python-2.0 || ( MIT X11 ) )"

SLOT="0"
KEYWORDS="~amd64"
IUSE="headless server test debug quarto panmirror"
REQUIRED_USE="headless? ( server )"

unravel_skein(){
	local SKEIN=$@
	local regex='((.*\/)?(.*))@(.*)'
	for YARN in ${SKEIN}
	do
		[[ ${YARN} =~ ${regex} ]]
		YARN_NAME_FULL=${BASH_REMATCH[1]}
		YARN_NAME=${BASH_REMATCH[3]}
		YARN_VER=${BASH_REMATCH[4]}
		FILE_EXT="tgz"
		YARN_FILENAME="${YARN_NAME}-${YARN_VER}.${FILE_EXT}"
		YARN_FILENAME_SAVE="yarn_${YARN_NAME_FULL}-${YARN_VER}.${FILE_EXT}"
		echo "https://registry.yarnpkg.com/${YARN_NAME_FULL}/-/${YARN_FILENAME} -> ${YARN_FILENAME_SAVE/\//-}"
	done
}
SRC_URI="${SRC_URI} panmirror? ( $(unravel_skein ${NODE_GYP_SKEIN}) $(unravel_skein ${PANMIRROR_SKEIN}) )"

# The test require an R package to be installed called `testthat`. I was able to
# install this using R itself via:
# ```sh
# $ R
# > install.packages("testthat")
# // select a CRAN mirror
# ```
# Using this locally installed "testthat", I got the following results from the
# test suite. It's unclear to me if the failures are from upstream or due to the
# gentoo packaging. I don't really have the motivation to continue improving on
# this, however I did want to leave this here for anyone who may be more
# interested in the future.
# [ FAIL 7 | WARN 6 | SKIP 2 | PASS 980 ]
RESTRICT="test mirror"

RDEPEND="
	dev-db/postgresql:*
	dev-db/sqlite
	dev-java/aopalliance:1
	dev-java/gin:2.1
	dev-java/javax-inject
	=dev-java/validation-api-1.0*:1.0[source]
	>=dev-lang/R-3.0.1
	>=dev-libs/boost-1.69:=
	>=dev-libs/mathjax-2.7
	app-text/pandoc
	dev-libs/soci[postgres]
	net-libs/nodejs
	sys-process/lsof
	>=virtual/jdk-1.8:=
	>=dev-cpp/yaml-cpp-0.7.0_p1
	headless? (
		acct-user/rstudio-server
		acct-group/rstudio-server
	)
	server? (
		acct-user/rstudio-server
		acct-group/rstudio-server
	)
	!headless? (
		>=dev-qt/qtcore-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtdbus-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtdeclarative-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtnetwork-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtopengl-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtpositioning-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtsensors-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtsql-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtsvg-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtwebchannel-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtwebengine-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtxml-${QT_VER}:${QT_SLOT}
		>=dev-qt/qtxmlpatterns-${QT_VER}:${QT_SLOT}
	)
	quarto? ( app-text/quarto-cli )
	panmirror? ( sys-apps/yarn )
	"
DEPEND="${RDEPEND}"
BDEPEND="
	app-arch/unzip
"

PATCHES=(
	"${FILESDIR}/${PN}-2022.02.0_p443-ant-system-node.patch"
	"${FILESDIR}/${PN}-1.4.1717-boost-imports-and-namespaces.patch"
	"${FILESDIR}/${PN}-2022.02.0_p443-cmake-bundled-dependencies.patch"
	"${FILESDIR}/${PN}-1.4.1717-fix-boost-version-check.patch"
	"${FILESDIR}/${PN}-2021.09.1_p372-resource-path.patch"
	"${FILESDIR}/${PN}-1.4.1106-server-paths.patch"
	"${FILESDIR}/${PN}-1.4.1106-soci-cmake-find_library.patch"
	"${FILESDIR}/${PN}-2021.09.1_p372-package-build.patch"
	"${FILESDIR}/${PN}-2022.02.0_p443-pandoc_path_fix.patch"
	"${FILESDIR}/${PN}-2022.02.0_p443-toggle_quarto.patch"
	"${FILESDIR}/${PN}-2022.02.0_p443-mathjaxfix.patch"
)

src_unpack() {
	local ARCHIVE=""
	mkdir ${WORKDIR}/.yarn_files
	mkdir -p ${S}/dependencies/dictionaries
	# rstudio's build-system expects these dictionary files to exist, but does
	# not ship them in the release tarball. Therefore, they are fetched in
	# `SRC_URI`, and here we unpack and move them to the correct place.
	for ARCHIVE in ${A} ;do
		case ${ARCHIVE} in
			(${P}.tar.gz)
				unpack ${ARCHIVE};;
			(${PN}-core-dictionaries.zip)
				pushd "${S}/dependencies/dictionaries" > /dev/null
				unpack ${ARCHIVE}
				popd > /dev/null > /dev/null ;;
			(yarn_node-gyp*)
				unpack ${ARCHIVE}
				mv package node_gyp
				patch -d node_gyp -p1 < ${FILESDIR}/node-gyp-9.0.0-remove-devDep.patch
				ln -s ${FILESDIR}/node-gyp-9.0.0-yarn.lock node_gyp/yarn.lock
				ln -s ${DISTDIR}/${ARCHIVE} ${WORKDIR}/.yarn_files/${ARCHIVE#yarn_};;
			(yarn_*)
				ln -s ${DISTDIR}/${ARCHIVE} ${WORKDIR}/.yarn_files/${ARCHIVE#yarn_};;
			(*) die "No valid case for ${ARCHIVE}";;
		esac
	done
}

src_prepare() {
	cmake_src_prepare
	java-pkg-2_src_prepare

	# make sure icons and mime stuff are with prefix
	sed -i \
		-e "s:/usr:${EPREFIX}/usr:g" \
		CMakeGlobals.txt src/cpp/desktop/CMakeLists.txt || die

	PANMIRROR_SRC_HASH=`sha1sum ${S}/src/gwt/panmirror/src/editor/yarn.lock`
	if  use panmirror  && [[ ${PANMIRROR_LOCK_HASH} != ${PANMIRROR_SRC_HASH:0:40} ]];then
		die "Panmirror Hash doesn't match"
	fi
}

src_configure() {
	export PACKAGE_OS="Gentoo"
	export RSTUDIO_VERSION_MAJOR=$(ver_cut 1)
	export RSTUDIO_VERSION_MINOR=$(ver_cut 2)
	export RSTUDIO_VERSION_PATCH=$(ver_cut 3)
	export RSTUDIO_VERSION_SUFFIX="+$(ver_cut 5)"

	CMAKE_BUILD_TYPE=$(usex debug Debug Release) #RelWithDebInfo Release

	# The cmake configurations allow installing either or both of a Desktop
	# component (i.e. a graphical front-end written in Qt) or a Server component
	# (i.e. a background process that is accessed remotely, via a browser or
	# some such).
	local RSTUDIO_TARGET=""
	if use headless; then
		RSTUDIO_TARGET="Server"
	else
		# the "Development" target will install both
		RSTUDIO_TARGET=$(usex server Development Desktop)
	fi

	# FIXME: GWT_COPY is helpful because it allows us to call ant ourselves
	# (rather than using the custom_target defined in src/gwt/CMakeLists.txt),
	# however it also installs a test script, which we probably don't want.

	local mycmakeargs=(
		-DRSTUDIO_INSTALL_SUPPORTING=${EPREFIX}/usr/share/${PN}
		-DRSTUDIO_TARGET=${RSTUDIO_TARGET}
		-DRSTUDIO_UNIT_TESTS_DISABLED=$(usex test OFF ON)
		-DRSTUDIO_USE_SYSTEM_BOOST=ON
		-DGWT_BUILD=OFF
		-DGWT_COPY=ON
		-DRSTUDIO_USE_SYSTEM_YAML_CPP=ON
		-DRSTUDIO_PACKAGE_BUILD=1
		-DRSTUDIO_PANDOC_PATH=${EPREFIX}/usr/bin
		-DQUARTO_ENABLED=$(usex quarto TRUE FALSE)
		-DRSTUDIO_DEPENDENCIES_MATHJAX_DIR=${EPREFIX}/usr/share/mathjax
	)

	if ! use headless; then
		mycmakeargs+=( -DQT_QMAKE_EXECUTABLE="$(qt5_get_bindir)/qmake"
			       -DRSTUDIO_INSTALL_FREEDESKTOP="$(usex !headless "ON" "OFF")")
	fi

	# It looks like eant takes care of this for us during src_compile
	# TODO: verify with someone who knows better
	# java-ant-2_src_configure
	cmake_src_configure

}

src_compile() {
	if use panmirror;then
		# Building node-gyp
		# Setting up variables
		local NODE_GYP_DIR=${WORKDIR}/node_gyp
		local YARN_FILES_DIR=${WORKDIR}/.yarn_files
		local YARN_CACHE_DIR=${WORKDIR}/.yarn_cache
		local YARN_CONFIG=${WORKDIR}/.yarnrc

		# Building NODE-GYP
		einfo "Building node-gyp"
		pushd ${NODE_GYP_DIR}
		echo "yarn-offline-mirror \"${YARN_FILES_DIR}\"" > ${YARN_CONFIG}
		local YARN_CMD_OPTIONS="--cache-folder ${YARN_CACHE_DIR} --use-yarnrc ${YARN_CONFIG}  --non-interactive --offline"
		npm_config_build_from_source=true npm_config_nodedir=/usr/include/node yarn install ${YARN_CMD_OPTIONS}  < /dev/null 2>&1 |cat
		assert "NODE_GYP failed"
		popd > /dev/null
		# Finished Building node-gyp

		# Building PANMIRROR
		einfo "Building PANMIRROR"
		pushd ${S}/src/gwt/panmirror/src/editor > /dev/null
		yarn config set ignore-engines true ${YARN_CMD_OPTIONS} < /dev/null 2>&1 |cat
		npm_config_build_from_source=true npm_config_nodedir=/usr/include/node npm_config_node_gyp=${NODE_GYP_DIR}/bin/node-gyp.js yarn install ${YARN_CMD_OPTIONS} < /dev/null 2>&1 |cat
		assert "Panmirror failed"
		popd > /dev/null
		#Finished Building PANMIRROR
	fi


	export EANT_BUILD_XML="src/gwt/build.xml"
	export EANT_BUILD_TARGET="build"
	export ANT_OPTS="-Duser.home=${T} -Djava.util.prefs.userRoot=${T}"

	# FIXME: isn't there a variable we can use in one of the java eclasses that
	# will take care of some of the dependency and path stuff for us?
	local eant_extra_args=(
		# These are from src/gwt/CMakeLists.txt, grep if(GWT_BUILD)
		-Dbuild.dir="bin"
		-Dwww.dir="www"
		-Dextras.dir="extras"
		-Dlib.dir="lib"
		-Dgwt.main.module="org.rstudio.studio.RStudio"
		# These are added by me, to make things work
		-Dnode.bin="${EPREFIX}/bin/node"
		-Daopalliance.sdk="${EPREFIX}/share/aopalliance-1/lib"
		-Dgin.sdk="${EPREFIX}/share/gin-2.1/lib"
		-Djavax.inject="${EPREFIX}/share/javax-inject/lib"
		-Dvalidation.api="${EPREFIX}/share/validation-api-1.0/lib"
		-Dvalidation.api.sources="${EPREFIX}/share/validation-api-1.0/sources"
		# These are added as improvements, but are not strictly necessary
		# -Dgwt.extra.args='-incremental' # actually, it fails to build with # this
		-DlocalWorkers=$(makeopts_jobs)
	)

	local EANT_EXTRA_ARGS="${eant_extra_args[@]}"
	java-pkg-2_src_compile

	cmake_src_compile
}

src_install() {
	cmake_src_install

	if use server;then
		dopamd src/cpp/server/extras/pam/rstudio
		newinitd "${FILESDIR}/rstudio-server" rstudio-server
		insinto /etc/rstudio
		doins "${FILESDIR}/rserver.conf" "${FILESDIR}/rsession.conf"
	fi

	# This binary name is much to generic, so we'll change it
	mv "${ED}/usr/bin/diagnostics" "${ED}/usr/bin/${PN}-diagnostics"
}

src_test() {
	# There is a gwt test suite, but it seems to require network access
	# export EANT_TEST_TARGET="unittest"
	# java-pkg-2_src_test

	mkdir -p ${HOME}/.local/share/rstudio || die
	cd ${BUILD_DIR}/src/cpp || die
	./rstudio-tests || die
}

pkg_preinst() {
	java-pkg-2_pkg_preinst
}

pkg_postinst() {
	use headless || { xdg_desktop_database_update
		xdg_mimeinfo_database_update
		xdg_icon_cache_update ;}
}
