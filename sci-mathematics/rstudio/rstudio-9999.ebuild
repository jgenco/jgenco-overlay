# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake java-pkg-2 java-ant-2 multiprocessing pam qmake-utils xdg-utils npm yarn

#####Start of GYP package list#####
NODE_GYP_VER="9.1.0"
NODE_GYP_SKEIN="
node-gyp@9.1.0
@gar/promisify@1.1.3
@npmcli/fs@2.1.2
@npmcli/move-file@2.0.1
@tootallnate/once@2.0.0
abbrev@1.1.1
agent-base@6.0.2
agentkeepalive@4.2.1
aggregate-error@3.1.0
ansi-regex@5.0.1
aproba@2.0.0
are-we-there-yet@3.0.1
balanced-match@1.0.2
brace-expansion@1.1.11
brace-expansion@2.0.1
cacache@16.1.2
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
glob@7.2.3
glob@8.0.3
graceful-fs@4.2.10
has-unicode@2.0.1
http-cache-semantics@4.1.0
http-proxy-agent@5.0.0
https-proxy-agent@5.0.1
humanize-ms@1.2.1
iconv-lite@0.6.3
imurmurhash@0.1.4
indent-string@4.0.0
infer-owner@1.0.4
inflight@1.0.6
inherits@2.0.4
ip@2.0.0
is-fullwidth-code-point@3.0.0
is-lambda@1.0.1
isexe@2.0.0
lru-cache@6.0.0
lru-cache@7.13.2
make-fetch-happen@10.2.1
minimatch@3.1.2
minimatch@5.1.0
minipass-collect@1.0.2
minipass-fetch@2.1.0
minipass-flush@1.0.5
minipass-pipeline@1.2.4
minipass-sized@1.0.3
minipass@3.3.4
minizlib@2.1.2
mkdirp@1.0.4
ms@2.1.2
ms@2.1.3
negotiator@0.6.3
nopt@5.0.0
npmlog@6.0.2
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
semver@7.3.7
set-blocking@2.0.0
signal-exit@3.0.7
smart-buffer@4.2.0
socks-proxy-agent@7.0.0
socks@2.7.0
ssri@9.0.1
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
#####End   of GYP package list#####

#####Start of Panmirror package list#####
PANMIRROR_PACKAGE_HASH="01870a825d8ff1afede4893aec445ee5fa254314"
PANMIRROR_SKEIN="
@babel/code-frame@7.18.6
@babel/helper-module-imports@7.18.6
@babel/helper-validator-identifier@7.18.6
@babel/highlight@7.18.6
@babel/runtime@7.18.6
@babel/types@7.18.7
@emotion/babel-utils@0.6.10
@emotion/hash@0.6.6
@emotion/is-prop-valid@0.6.8
@emotion/memoize@0.6.6
@emotion/serialize@0.9.1
@emotion/stylis@0.7.1
@emotion/unitless@0.6.7
@emotion/utils@0.8.2
@mapbox/node-pre-gyp@1.0.9
@textlint/ast-node-types@4.4.3
@types/ace@0.0.43
@types/diff-match-patch@1.0.32
@types/js-yaml@4.0.5
@types/lodash.debounce@4.0.7
@types/lodash.orderby@4.6.7
@types/lodash.uniqby@4.7.7
@types/lodash@4.14.182
@types/node@18.0.0
@types/node@14.18.21
@types/orderedmap@1.0.0
@types/parse-json@4.0.0
@types/pinyin@2.10.0
@types/prop-types@15.7.5
@types/prosemirror-commands@1.0.4
@types/prosemirror-dropcursor@1.0.3
@types/prosemirror-gapcursor@1.0.4
@types/prosemirror-history@1.0.3
@types/prosemirror-inputrules@1.0.4
@types/prosemirror-keymap@1.0.4
@types/prosemirror-model@1.16.2
@types/prosemirror-schema-list@1.0.3
@types/prosemirror-state@1.3.0
@types/prosemirror-transform@1.4.2
@types/prosemirror-view@1.23.3
@types/react-dom@17.0.17
@types/react-window@1.8.5
@types/react@18.0.14
@types/react@17.0.47
@types/scheduler@0.16.2
@types/unzip@0.1.1
@types/zenscroll@4.0.1
abbrev@1.1.1
accepts@1.3.8
acorn-jsx@4.1.1
acorn@5.7.4
agent-base@6.0.2
ajax-request@1.2.3
ajv@6.12.6
ansi-escapes@3.2.0
ansi-regex@3.0.1
ansi-regex@5.0.1
ansi-styles@3.2.1
ansi-styles@4.3.0
ansi@0.3.1
anymatch@1.3.2
app-root-path@1.4.0
app-root-path@2.2.1
aproba@2.0.0
are-we-there-yet@2.0.0
arg@4.1.3
argparse@2.0.1
arr-diff@2.0.0
arr-diff@4.0.0
arr-flatten@1.1.0
arr-union@3.1.0
array-flatten@1.1.1
array-unique@0.2.1
array-unique@0.3.2
asn1@0.2.6
assert-plus@1.0.0
assign-symbols@1.0.0
async-each@1.0.3
asynckit@0.4.0
atob@2.1.2
aws-sign2@0.7.0
aws4@1.11.0
babel-plugin-emotion@9.2.11
babel-plugin-macros@2.8.0
babel-plugin-syntax-jsx@6.18.0
babel-runtime@6.26.0
balanced-match@1.0.2
base16@1.0.0
base64-img@1.0.4
base64-js@1.5.1
base@0.11.2
bcrypt-pbkdf@1.0.2
biblatex-csl-converter@2.0.4
binary-extensions@1.13.1
binary@0.3.0
bindings@1.5.0
body-parser@1.20.0
boundary@1.0.1
bowser@2.11.0
brace-expansion@1.1.11
braces@1.8.5
braces@2.3.2
buffer-from@1.1.2
buffers@0.1.1
bytes@3.1.2
cache-base@1.0.1
call-bind@1.0.2
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
clean-css@4.2.4
cli-cursor@2.1.0
cli-width@2.2.1
clipboard@2.0.11
cliui@7.0.4
collection-visit@1.0.0
color-convert@1.9.3
color-convert@2.0.1
color-name@1.1.3
color-name@1.1.4
color-support@1.1.3
combined-stream@1.0.8
commander@2.20.3
commander@1.1.1
component-emitter@1.3.0
concat-map@0.0.1
concat-stream@1.6.2
concat-stream@2.0.0
console-control-strings@1.1.0
content-disposition@0.5.4
content-type@1.0.4
convert-source-map@1.8.0
cookie-signature@1.0.6
cookie@0.5.0
copy-descriptor@0.1.1
core-js@2.6.12
core-util-is@1.0.2
core-util-is@1.0.3
cosmiconfig@6.0.0
create-emotion-styled@9.2.8
create-emotion@9.2.12
create-react-context@0.1.6
csstype@2.6.20
csstype@3.1.0
dashdash@1.14.1
debug@2.6.9
debug@4.3.4
decode-uri-component@0.2.0
deep-is@0.1.4
define-property@0.2.5
define-property@1.0.0
define-property@2.0.2
delayed-stream@1.0.0
delegate@3.2.0
delegates@1.0.0
depd@2.0.0
destroy@1.2.0
detect-libc@2.0.1
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
escodegen@1.14.3
esprima@4.0.1
estraverse@4.3.0
esutils@2.0.3
etag@1.8.1
exec-sh@0.2.2
expand-brackets@0.1.5
expand-brackets@2.1.4
expand-range@1.8.2
express@4.18.1
extend-shallow@2.0.1
extend-shallow@3.0.2
extend@3.0.2
external-editor@2.2.0
extglob@0.3.2
extglob@2.0.4
extsprintf@1.3.0
extsprintf@1.4.1
fast-deep-equal@3.1.3
fast-json-stable-stringify@2.1.0
fast-levenshtein@2.0.6
fast-xml-parser@3.21.1
figures@2.0.0
file-match@1.0.2
file-system@2.2.2
file-uri-to-path@1.0.0
filename-regex@2.0.1
fill-range@2.2.4
fill-range@4.0.0
finalhandler@1.2.0
find-root@1.1.0
fliplog@0.3.13
for-in@1.0.2
for-own@0.1.5
forever-agent@0.6.1
form-data@2.3.3
forwarded@0.2.0
fragment-cache@0.2.1
fresh@0.5.2
fs-extra@7.0.1
fs-minipass@2.1.0
fs.realpath@1.0.0
fsevents@1.2.13
fstream@0.1.31
function-bind@1.1.1
fuse-box@3.7.1
fuse-concat-with-sourcemaps@1.0.5
fuse.js@6.6.2
gauge@3.0.2
get-caller-file@2.0.5
get-intrinsic@1.1.2
get-value@2.0.6
getopts@2.3.0
getpass@0.1.7
glob-base@0.3.0
glob-parent@2.0.0
glob@7.2.3
good-listener@1.2.2
graceful-fs@4.2.10
graceful-fs@3.0.12
har-schema@2.0.0
har-validator@5.1.5
has-flag@3.0.0
has-symbols@1.0.3
has-unicode@2.0.1
has-value@0.3.1
has-value@1.0.0
has-values@0.1.4
has-values@1.0.0
has@1.0.3
html@1.0.0
http-errors@2.0.0
http-signature@1.2.0
https-proxy-agent@5.0.1
iconv-lite@0.4.24
ie-array-find-polyfill@1.1.0
ieee754@1.2.1
import-fresh@3.3.0
inflight@1.0.6
inherits@2.0.4
inquirer@3.3.0
ipaddr.js@1.9.1
is-accessor-descriptor@0.1.6
is-accessor-descriptor@1.0.0
is-arrayish@0.2.1
is-binary-path@1.0.1
is-buffer@1.1.6
is-core-module@2.9.0
is-data-descriptor@0.1.4
is-data-descriptor@1.0.0
is-descriptor@0.1.6
is-descriptor@1.0.2
is-dotfile@1.0.3
is-equal-shallow@0.1.3
is-extendable@0.1.1
is-extendable@1.0.1
is-extglob@1.0.0
is-fullwidth-code-point@2.0.0
is-fullwidth-code-point@3.0.0
is-glob@2.0.1
is-number@2.1.0
is-number@3.0.0
is-number@4.0.0
is-plain-object@2.0.4
is-posix-bracket@0.1.1
is-primitive@2.0.0
is-typedarray@1.0.0
is-windows@1.0.2
isarray@0.0.1
isarray@1.0.0
isobject@2.1.0
isobject@3.0.1
isstream@0.1.2
js-tokens@4.0.0
js-yaml@4.1.0
jsbn@0.1.1
jsesc@0.5.0
json-parse-even-better-errors@2.3.1
json-schema-traverse@0.4.1
json-schema@0.4.0
json-stringify-safe@5.0.1
jsondiffpatch@0.3.11
jsonfile@4.0.0
jsprim@1.4.2
keypress@0.1.0
kind-of@3.2.2
kind-of@4.0.0
kind-of@5.1.0
kind-of@6.0.3
lego-api@1.0.8
levn@0.3.0
lines-and-columns@1.2.4
lodash._getnative@3.9.1
lodash.curry@4.1.1
lodash.debounce@3.1.1
lodash.debounce@4.0.8
lodash.flow@3.5.0
lodash.orderby@4.6.0
lodash.uniqby@4.7.0
lodash@4.17.21
loose-envify@1.4.0
lru-cache@6.0.0
make-dir@3.1.0
make-error@1.3.6
map-cache@0.2.2
map-visit@1.0.0
match-stream@0.0.2
math-random@1.0.4
media-typer@0.3.0
memoize-one@5.2.1
merge-descriptors@1.0.1
merge@1.2.1
methods@1.1.2
micromatch@2.3.11
micromatch@3.1.10
mime-db@1.52.0
mime-types@2.1.35
mime@1.6.0
mimic-fn@1.2.0
minimatch@3.1.2
minimist@1.2.6
minipass@3.3.4
minizlib@2.1.2
mixin-deep@1.3.2
mkdirp@0.5.6
mkdirp@1.0.4
ms@2.0.0
ms@2.1.2
ms@2.1.3
mustache@2.3.2
mute-stream@0.0.7
nan@2.16.0
nanomatch@1.2.13
nanoseconds@0.1.0
natives@1.1.6
negotiator@0.6.3
node-addon-api@3.2.1
node-fetch@2.6.7
nodejieba@2.5.2
nopt@5.0.0
nopt@1.0.10
normalize-path@2.1.1
npmlog@5.0.1
oauth-sign@0.9.0
object-assign@4.1.1
object-copy@0.1.0
object-inspect@1.12.2
object-visit@1.0.1
object.omit@2.0.1
object.pick@1.3.0
object_values@0.1.2
on-finished@2.4.1
once@1.4.0
onetime@2.0.1
optionator@0.8.3
options@0.0.6
orderedmap@1.1.1
orderedmap@1.1.8
orderedmap@2.0.0
os-tmpdir@1.0.2
over@0.0.5
parent-module@1.0.1
parse-glob@3.0.4
parse-json@5.2.0
parseurl@1.3.3
pascalcase@0.1.1
path-is-absolute@1.0.1
path-parse@1.0.7
path-to-regexp@0.1.7
path-type@4.0.0
performance-now@2.1.0
pinyin@2.11.2
posix-character-classes@0.1.1
postcss@6.0.23
prelude-ls@1.1.2
preserve@0.2.0
pretty-time@0.2.0
prettysize@0.0.3
process-nextick-args@2.0.1
prop-types@15.8.1
prosemirror-changeset@2.1.2
prosemirror-commands@1.1.10
prosemirror-dev-tools@2.1.1
prosemirror-dropcursor@1.3.5
prosemirror-gapcursor@1.1.5
prosemirror-history@1.2.0
prosemirror-inputrules@1.1.3
prosemirror-keymap@1.1.4
prosemirror-keymap@1.2.0
prosemirror-model@1.14.3
prosemirror-model@1.18.1
prosemirror-schema-list@1.1.5
prosemirror-state@1.3.4
prosemirror-state@1.4.1
prosemirror-tables@1.1.1
prosemirror-transform@1.3.2
prosemirror-transform@1.6.0
prosemirror-utils@0.9.6
prosemirror-view@1.20.1
prosemirror-view@1.26.3
proxy-addr@2.0.7
psl@1.8.0
pullstream@0.4.1
punycode@2.1.1
pure-color@1.3.0
qs@6.10.3
qs@6.5.3
randomatic@3.1.1
range-parser@1.2.1
raw-body@2.5.1
react-base16-styling@0.5.3
react-dock@0.2.4
react-dom@17.0.2
react-emotion@9.2.12
react-is@16.13.1
react-json-tree@0.11.2
react-window@1.8.7
react@17.0.2
readable-stream@2.3.7
readable-stream@3.6.0
readable-stream@1.0.34
readdirp@2.2.1
realm-utils@1.0.9
regenerate-unicode-properties@9.0.0
regenerate@1.4.2
regenerator-runtime@0.11.1
regenerator-runtime@0.13.9
regex-cache@0.4.4
regex-not@1.0.2
regexpu-core@4.8.0
regjsgen@0.5.2
regjsparser@0.7.0
remove-trailing-separator@1.1.0
repeat-element@1.1.4
repeat-string@1.6.1
request@2.88.2
require-directory@2.1.1
resolve-from@4.0.0
resolve-url@0.2.1
resolve@1.22.1
restore-cursor@2.0.0
ret@0.1.15
rimraf@2.7.1
rimraf@3.0.2
rope-sequence@1.3.3
run-async@2.4.1
rx-lite-aggregates@4.0.8
rx-lite@4.0.8
safe-buffer@5.2.1
safe-buffer@5.1.2
safe-regex@1.1.0
safer-buffer@2.1.2
scheduler@0.20.2
select@1.1.2
semver@6.3.0
semver@7.3.7
send@0.18.0
sentence-splitter@3.2.2
serve-static@1.15.0
set-blocking@2.0.0
set-value@2.0.1
setimmediate@1.0.5
setprototypeof@1.2.0
shorthash@0.0.2
side-channel@1.0.4
signal-exit@3.0.7
slice-stream@1.0.0
snapdragon-node@2.1.1
snapdragon-util@3.0.1
snapdragon@0.8.2
source-map-resolve@0.5.3
source-map-support@0.5.21
source-map-url@0.4.1
source-map@0.5.7
source-map@0.6.1
source-map@0.7.4
sourcemap-blender@1.0.5
split-string@3.1.0
sshpk@1.17.0
static-extend@0.1.2
statuses@2.0.1
stream-browserify@2.0.2
string-width@4.2.3
string-width@2.1.1
string_decoder@1.3.0
string_decoder@0.10.31
string_decoder@1.1.1
strip-ansi@4.0.0
strip-ansi@6.0.1
strnum@1.0.5
structured-source@3.0.2
stylis-rule-sheet@0.0.10
stylis@3.5.4
supports-color@5.5.0
supports-preserve-symlinks-flag@1.0.0
tar@6.1.11
terser@4.8.0
thenby@1.3.4
through@2.3.8
tiny-emitter@2.1.0
tlite@0.1.9
tmp@0.0.33
to-fast-properties@2.0.0
to-object-path@0.3.0
to-regex-range@2.1.1
to-regex@3.0.2
toidentifier@1.0.1
touch@2.0.2
tough-cookie@2.5.0
tr46@0.0.3
transliteration@2.2.0
traverse@0.3.9
ts-node@8.10.2
tslib@1.14.1
tunnel-agent@0.6.0
tweetnacl@0.14.5
type-check@0.3.2
type-is@1.6.18
typedarray@0.0.6
typescript@3.8.3
uglify-js@3.16.1
ultron@1.0.2
unicode-canonical-property-names-ecmascript@2.0.0
unicode-match-property-ecmascript@2.0.0
unicode-match-property-value-ecmascript@2.0.0
unicode-property-aliases-ecmascript@2.0.0
union-value@1.0.1
universalify@0.1.2
unpipe@1.0.0
unset-value@1.0.0
unstated@2.1.1
unzip@0.1.11
uri-js@4.4.1
urix@0.1.0
use@3.1.1
util-deprecate@1.0.2
utils-extend@1.0.8
utils-merge@1.0.1
uuid@3.4.0
vary@1.1.2
verror@1.10.0
w3c-keyname@2.2.2
w3c-keyname@2.2.4
watch@1.0.2
webidl-conversions@3.0.1
whatwg-url@5.0.0
wide-align@1.1.5
word-wrap@1.2.3
wrap-ansi@7.0.0
wrappy@1.0.2
ws@1.1.5
y18n@5.0.8
yallist@4.0.0
yaml@1.10.2
yargs-parser@20.2.9
yargs@16.2.0
yn@3.1.1
zenscroll@4.0.2
"
#####End   of PANMIRROR package list#####

#####Start of ELECTRON  package list#####
ELECTRON_PACKAGE_HASH="c3fa66142e1cd58603c86c085b4d04123b58df39"
ELECTRON_VERSION="19.0.10"
ELECTRON_VERSION_MAJ="19"
ELECTRON_EGIT_COMMIT="febae33db0b6d4aaa83edafa20b74df64eab2801"
RELECTRON_NODEJS_DEPS="
abbrev@1.1.1
accepts@1.3.8
acorn@8.8.0
acorn-import-assertions@1.8.0
acorn-walk@8.2.0
agent-base@6.0.2
agentkeepalive@4.2.1
aggregate-error@3.1.0
ajv@6.12.6
ajv@8.11.0
ajv-formats@2.1.1
ajv-keywords@3.5.2
ajv-keywords@5.1.0
ansi-colors@4.1.1
ansi-colors@4.1.3
ansi-escapes@4.3.2
ansi-html-community@0.0.8
ansi-regex@2.1.1
ansi-regex@5.0.1
ansi-styles@3.2.1
ansi-styles@4.3.0
anymatch@3.1.2
any-promise@1.3.0
aproba@2.0.0
are-we-there-yet@3.0.1
arg@4.1.3
argparse@2.0.1
array-flatten@1.1.1
array-flatten@2.1.2
asar@3.2.0
asn1@0.2.6
assertion-error@1.1.0
assert-plus@1.0.0
async@3.2.4
asynckit@0.4.0
at-least-node@1.0.0
atomically@1.7.0
author-regex@1.0.0
aws4@1.11.0
aws-sign2@0.7.0
@babel/code-frame@7.18.6
@babel/helper-validator-identifier@7.18.6
@babel/highlight@7.18.6
@babel/runtime@7.18.9
balanced-match@1.0.2
base64-js@1.5.1
batch@0.6.1
@bcherny/json-schema-ref-parser@9.0.9
bcrypt-pbkdf@1.0.2
big.js@5.2.2
binary-extensions@2.2.0
bindings@1.5.0
bl@4.1.0
bluebird@3.7.2
body-parser@1.20.0
bonjour-service@1.0.13
boolbase@1.0.0
boolean@3.2.0
brace-expansion@1.1.11
brace-expansion@2.0.1
braces@3.0.2
browserslist@4.21.3
browser-stdout@1.3.1
buffer@5.7.1
buffer@6.0.3
buffer-alloc@1.2.0
buffer-alloc-unsafe@1.1.0
buffer-crc32@0.2.13
buffer-equal@1.0.0
buffer-fill@1.0.0
buffer-from@1.1.2
bytes@3.0.0
bytes@3.1.2
cacache@16.1.2
cacheable-lookup@5.0.4
cacheable-request@6.1.0
cacheable-request@7.0.2
call-bind@1.0.2
call-me-maybe@1.0.1
callsites@3.1.0
camel-case@4.1.2
camelcase@6.3.0
caniuse-lite@1.0.30001379
caseless@0.12.0
chai@4.3.6
chalk@2.4.2
chalk@4.1.2
chardet@0.7.0
check-error@1.0.2
chokidar@3.5.3
chownr@2.0.0
chrome-trace-event@1.0.3
chromium-pickle-js@0.2.0
clean-css@5.3.1
clean-stack@2.2.0
cli-color@2.0.3
cli-cursor@3.1.0
cli-spinners@2.7.0
cliui@7.0.4
cli-width@3.0.0
clone@1.0.4
clone-deep@4.0.1
clone-response@1.0.3
code-point-at@1.1.0
color@3.2.1
color-convert@1.9.3
color-convert@2.0.1
colorette@2.0.19
color-name@1.1.3
color-name@1.1.4
colors@1.0.3
@colors/colors@1.5.0
colorspace@1.1.4
color-string@1.9.1
color-support@1.1.3
combined-stream@1.0.8
commander@2.20.3
commander@2.9.0
commander@4.1.1
commander@5.1.0
commander@8.3.0
compare-version@0.1.2
compress-brotli@1.3.8
compressible@2.0.18
compression@1.7.4
concat-map@0.0.1
concat-stream@1.6.2
conf@10.2.0
config-chain@1.1.13
connect-history-api-fallback@2.0.0
console-control-strings@1.1.0
content-disposition@0.5.4
content-type@1.0.4
cookie@0.5.0
cookie-signature@1.0.6
copy-webpack-plugin@11.0.0
core-util-is@1.0.2
core-util-is@1.0.3
cosmiconfig@6.0.0
crc@4.1.1
create-require@1.1.1
cross-spawn@6.0.5
cross-spawn@7.0.3
cross-spawn-windows-exe@1.2.0
@cspotcode/source-map-support@0.8.1
cssesc@3.0.0
css-loader@6.7.1
css-select@4.3.0
css-what@6.1.0
d@1.0.1
@dabh/diagnostics@2.0.3
dashdash@1.14.1
debounce-fn@4.0.0
debug@2.6.9
debug@3.2.7
debug@4.3.3
debug@4.3.4
decamelize@4.0.0
decompress-response@3.3.0
decompress-response@6.0.0
deep-eql@3.0.1
deepmerge@4.2.2
default-gateway@6.0.3
defaults@1.0.3
defer-to-connect@1.1.3
defer-to-connect@2.0.1
define-lazy-prop@2.0.0
define-properties@1.1.4
delayed-stream@1.0.0
delegates@1.0.0
depd@1.1.2
depd@2.0.0
destroy@1.2.0
detect-libc@2.0.1
detect-node@2.1.0
diff@4.0.2
diff@5.0.0
dir-compare@2.4.0
dir-glob@3.0.1
dns-equal@1.0.0
dns-packet@5.4.0
dom-converter@0.2.0
domelementtype@2.3.0
domhandler@4.3.1
dom-serializer@1.4.1
domutils@2.8.0
dom-walk@0.1.2
dot-case@3.0.4
dot-prop@6.0.1
duplexer3@0.1.5
ecc-jsbn@0.1.2
ee-first@1.1.1
electron@19.0.10
@electron-forge/async-ora@6.0.0-beta.64
@electron-forge/cli@6.0.0-beta.64
@electron-forge/core@6.0.0-beta.64
@electron-forge/installer-base@6.0.0-beta.64
@electron-forge/installer-darwin@6.0.0-beta.64
@electron-forge/installer-deb@6.0.0-beta.64
@electron-forge/installer-dmg@6.0.0-beta.64
@electron-forge/installer-exe@6.0.0-beta.64
@electron-forge/installer-linux@6.0.0-beta.64
@electron-forge/installer-rpm@6.0.0-beta.64
@electron-forge/installer-zip@6.0.0-beta.64
@electron-forge/maker-base@6.0.0-beta.64
@electron-forge/plugin-base@6.0.0-beta.64
@electron-forge/plugin-webpack@6.0.0-beta.64
@electron-forge/publisher-base@6.0.0-beta.64
@electron-forge/shared-types@6.0.0-beta.64
@electron-forge/template-base@6.0.0-beta.64
@electron-forge/template-typescript@6.0.0-beta.64
@electron-forge/template-typescript-webpack@6.0.0-beta.64
@electron-forge/template-webpack@6.0.0-beta.64
@electron-forge/web-multi-logger@6.0.0-beta.64
@electron/get@1.14.1
electron-mocha@11.0.2
electron-notarize@1.2.1
electron-osx-sign@0.5.0
electron-packager@15.5.1
electron-rebuild@3.2.9
electron-squirrel-startup@1.0.0
electron-store@8.1.0
electron-to-chromium@1.4.225
@electron/universal@1.3.0
electron-window@0.8.1
emoji-regex@8.0.0
emojis-list@3.0.0
enabled@2.0.0
encodeurl@1.0.2
encoding@0.1.13
end-of-stream@1.4.4
enhanced-resolve@5.10.0
entities@2.2.0
env-paths@2.2.1
err-code@2.0.3
error-ex@1.3.2
es5-ext@0.10.62
es6-error@4.1.1
es6-iterator@2.0.3
es6-symbol@3.1.3
es6-weak-map@2.0.3
escalade@3.1.1
escape-html@1.0.3
escape-string-regexp@1.0.5
escape-string-regexp@4.0.0
eslint-scope@5.1.1
es-module-lexer@0.9.3
esrecurse@4.3.0
estraverse@4.3.0
estraverse@5.3.0
etag@1.8.1
event-emitter@0.3.5
eventemitter3@4.0.7
events@3.3.0
execa@1.0.0
execa@5.1.1
expand-tilde@2.0.2
express@4.18.1
express-ws@5.0.2
ext@1.6.0
extend@3.0.2
external-editor@3.1.0
extract-zip@1.7.0
extract-zip@2.0.1
extsprintf@1.3.0
fast-deep-equal@3.1.3
fast-glob@3.2.11
fast-json-stable-stringify@2.1.0
fastq@1.13.0
fast-zlib@2.0.1
faye-websocket@0.11.4
fd-slicer@1.1.0
fecha@4.2.3
figures@3.2.0
filename-reserved-regex@2.0.0
filenamify@4.3.0
file-stream-rotator@0.6.1
file-uri-to-path@1.0.0
fill-range@7.0.1
finalhandler@1.2.0
find-up@2.1.0
find-up@3.0.0
find-up@4.1.0
find-up@5.0.0
flat@5.0.2
flora-colossus@1.0.1
fn.name@1.1.0
follow-redirects@1.15.1
forever-agent@0.6.1
fork-ts-checker-webpack-plugin@6.4.0
form-data@2.3.3
forwarded@0.2.0
fresh@0.5.2
fsevents@2.3.2
fs-extra@10.1.0
fs-extra@4.0.3
fs-extra@7.0.1
fs-extra@8.1.0
fs-extra@9.1.0
fs-minipass@2.1.0
fs-monkey@1.0.3
fs.realpath@1.0.0
function-bind@1.1.1
galactus@0.2.1
@gar/promisify@1.1.3
gauge@4.0.4
get-caller-file@2.0.5
get-func-name@2.0.0
get-installed-path@2.1.1
get-intrinsic@1.1.2
get-package-info@1.0.0
getpass@0.1.7
get-stdin@8.0.0
get-stream@4.1.0
get-stream@5.2.0
get-stream@6.0.1
glob@7.2.0
glob@7.2.3
glob@8.0.3
global@4.4.0
global-agent@3.0.0
global-modules@1.0.0
global-prefix@1.0.2
globalthis@1.0.3
global-tunnel-ng@2.7.1
globby@13.1.2
glob-parent@5.1.2
glob-parent@6.0.2
glob-promise@4.2.2
glob-to-regexp@0.4.1
got@11.8.5
got@9.6.0
graceful-fs@4.2.10
graceful-readlink@1.0.1
growl@1.10.5
handle-thing@2.0.1
har-schema@2.0.0
har-validator@5.1.5
has@1.0.3
has-flag@3.0.0
has-flag@4.0.0
has-property-descriptors@1.0.0
has-symbols@1.0.3
has-unicode@2.0.1
he@1.2.0
homedir-polyfill@1.0.3
hosted-git-info@2.8.9
hpack.js@2.1.6
html-entities@2.3.3
html-minifier-terser@6.1.0
htmlparser2@6.1.0
html-webpack-plugin@5.5.0
http2-wrapper@1.0.3
http-cache-semantics@4.1.0
http-deceiver@1.2.7
http-errors@1.6.3
http-errors@2.0.0
http-parser-js@0.5.8
http-proxy@1.18.1
http-proxy-agent@5.0.0
http-proxy-middleware@2.0.6
http-signature@1.2.0
https-proxy-agent@5.0.1
humanize-ms@1.2.1
human-signals@2.1.0
i18next@21.9.0
iconv-lite@0.4.24
iconv-lite@0.6.3
icss-utils@5.1.0
ieee754@1.2.1
ignore@5.2.0
import-fresh@3.3.0
imurmurhash@0.1.4
indent-string@4.0.0
infer-owner@1.0.4
inflight@1.0.6
inherits@2.0.3
inherits@2.0.4
ini@1.3.8
inquirer@8.2.4
ip@2.0.0
ipaddr.js@1.9.1
ipaddr.js@2.0.1
isarray@0.0.1
isarray@1.0.0
is-arrayish@0.2.1
is-arrayish@0.3.2
isbinaryfile@3.0.3
is-binary-path@2.1.0
is-core-module@2.10.0
is-docker@2.2.1
is-electron-renderer@2.0.1
isexe@2.0.0
is-extglob@2.1.1
is-fullwidth-code-point@1.0.0
is-fullwidth-code-point@3.0.0
is-glob@4.0.3
is-interactive@1.0.0
is-lambda@1.0.1
is-number@7.0.0
is-obj@2.0.0
isobject@3.0.1
is-plain-obj@2.1.0
is-plain-obj@3.0.0
is-plain-object@2.0.4
is-promise@2.2.2
isstream@0.1.2
is-stream@1.1.0
is-stream@2.0.1
is-typedarray@1.0.0
is-unicode-supported@0.1.0
is-windows@1.0.2
is-wsl@2.2.0
jest-worker@27.5.1
@jridgewell/gen-mapping@0.3.2
@jridgewell/resolve-uri@3.1.0
@jridgewell/set-array@1.1.2
@jridgewell/source-map@0.3.2
@jridgewell/sourcemap-codec@1.4.14
@jridgewell/trace-mapping@0.3.15
@jridgewell/trace-mapping@0.3.9
jsbn@0.1.1
@jsdevtools/ono@7.1.3
json@11.0.0
json5@2.2.1
json-buffer@3.0.0
json-buffer@3.0.1
jsonfile@4.0.0
jsonfile@6.1.0
json-parse-even-better-errors@2.3.1
json-schema@0.4.0
json-schema-to-typescript@11.0.2
json-schema-traverse@0.4.1
json-schema-traverse@1.0.0
json-schema-typed@7.0.3
json-stringify-safe@5.0.1
jsprim@1.4.2
js-tokens@4.0.0
js-yaml@4.1.0
junk@3.1.0
just-extend@4.2.1
keyv@3.1.0
keyv@4.3.3
kind-of@6.0.3
kuler@2.0.0
@leichtgewicht/ip-codec@2.0.4
line-reader@0.4.0
lines-and-columns@1.2.4
loader-runner@4.3.0
loader-utils@2.0.2
load-json-file@2.0.0
locate-path@2.0.0
locate-path@3.0.0
locate-path@5.0.0
locate-path@6.0.0
lodash@4.17.21
lodash.debounce@4.0.8
lodash.get@4.4.2
logform@2.4.2
log-symbols@4.1.0
loupe@2.3.4
lower-case@2.0.2
lowercase-keys@1.0.1
lowercase-keys@2.0.0
lru-cache@6.0.0
lru-cache@7.14.0
lru-queue@0.1.0
lzma-native@8.0.6
make-error@1.3.6
make-fetch-happen@10.2.1
@malept/cross-spawn-promise@1.1.1
@malept/cross-spawn-promise@2.0.0
map-age-cleaner@0.1.3
matcher@3.0.0
media-typer@0.3.0
mem@4.3.0
memfs@3.4.7
memoizee@0.4.15
merge2@1.4.1
merge-descriptors@1.0.1
merge-stream@2.0.0
methods@1.1.2
micromatch@4.0.5
mime@1.6.0
mime-db@1.52.0
mime-types@2.1.35
mimic-fn@2.1.0
mimic-fn@3.1.0
mimic-response@1.0.1
mimic-response@3.1.0
min-document@2.19.0
minimalistic-assert@1.0.1
minimatch@3.0.4
minimatch@3.1.2
minimatch@4.2.1
minimatch@5.1.0
minimist@1.2.6
minipass@3.3.4
minipass-collect@1.0.2
minipass-fetch@2.1.1
minipass-flush@1.0.5
minipass-pipeline@1.2.4
minipass-sized@1.0.3
minizlib@2.1.2
mkdirp@0.5.6
mkdirp@1.0.4
mocha@9.2.2
moment@2.29.4
ms@2.0.0
ms@2.1.2
ms@2.1.3
msgpackr@1.6.2
msgpackr-extract@2.1.2
@msgpackr-extract/msgpackr-extract-darwin-arm64@2.1.2
@msgpackr-extract/msgpackr-extract-darwin-x64@2.1.2
@msgpackr-extract/msgpackr-extract-linux-arm@2.1.2
@msgpackr-extract/msgpackr-extract-linux-arm64@2.1.2
@msgpackr-extract/msgpackr-extract-linux-x64@2.1.2
@msgpackr-extract/msgpackr-extract-win32-x64@2.1.2
multicast-dns@7.2.5
mute-stream@0.0.8
mz@2.7.0
nan@2.16.0
nanoid@3.3.1
nanoid@3.3.4
negotiator@0.6.3
neo-async@2.6.2
net-ipc@2.0.1
next-tick@1.1.0
nice-try@1.0.5
nise@5.1.1
no-case@3.0.4
node-abi@3.24.0
node-addon-api@3.2.1
node-addon-api@5.0.0
node-api-version@0.1.4
node-fetch@2.6.7
node-forge@1.3.1
node-gyp@9.1.0
node-gyp-build@4.5.0
node-gyp-build-optional-packages@5.0.3
@nodelib/fs.scandir@2.1.5
@nodelib/fs.stat@2.0.5
@nodelib/fs.walk@1.2.8
node-loader@2.0.0
node-releases@2.0.6
node-system-fonts@1.0.1
nopt@5.0.0
normalize-package-data@2.5.0
normalize-path@3.0.0
normalize-url@4.5.1
normalize-url@6.1.0
@npmcli/fs@2.1.2
@npmcli/move-file@2.0.1
npm-conf@1.1.3
npmlog@6.0.2
npm-run-path@2.0.2
npm-run-path@4.0.1
nth-check@2.1.1
nugget@2.0.2
number-is-nan@1.0.1
oauth-sign@0.9.0
object-assign@4.1.1
object-hash@2.2.0
object-inspect@1.12.2
object-keys@0.4.0
object-keys@1.1.1
obuf@1.1.2
once@1.4.0
one-time@1.0.0
onetime@5.1.2
on-finished@2.4.1
on-headers@1.0.2
open@8.4.0
ora@5.4.1
os-tmpdir@1.0.2
param-case@3.0.4
parent-module@1.0.1
parse-author@2.0.0
parse-json@2.2.0
parse-json@5.2.0
parse-ms@2.1.0
parse-passwd@1.0.0
parseurl@1.3.3
pascal-case@3.1.2
path-exists@3.0.0
path-exists@4.0.0
path-is-absolute@1.0.1
path-key@2.0.1
path-key@3.1.1
path-parse@1.0.7
path-to-regexp@0.1.7
path-to-regexp@1.8.0
path-type@2.0.0
path-type@4.0.0
pathval@1.1.1
p-cancelable@1.1.0
p-cancelable@2.1.1
p-defer@1.0.0
pend@1.2.0
performance-now@2.1.0
p-finally@1.0.0
picocolors@1.0.0
picomatch@2.3.1
pify@2.3.0
pify@3.0.0
p-is-promise@2.1.0
pkg-dir@4.2.0
pkg-up@3.1.0
p-limit@1.3.0
p-limit@2.3.0
p-limit@3.1.0
plist@3.0.6
p-locate@2.0.0
p-locate@3.0.0
p-locate@4.1.0
p-locate@5.0.0
p-map@4.0.0
postcss@8.4.16
postcss-modules-extract-imports@3.0.0
postcss-modules-local-by-default@4.0.0
postcss-modules-scope@3.0.0
postcss-modules-values@4.0.0
postcss-selector-parser@6.0.10
postcss-value-parser@4.2.0
prepend-http@2.0.0
p-retry@4.6.2
prettier@2.7.1
pretty-bytes@4.0.2
pretty-error@4.0.0
pretty-ms@7.0.1
process@0.11.10
process-nextick-args@2.0.1
progress@2.0.3
progress-stream@1.2.0
promise-inflight@1.0.1
promise-retry@2.0.1
properties-reader@2.2.0
proto-list@1.2.4
proxy-addr@2.0.7
psl@1.9.0
p-try@1.0.0
p-try@2.2.0
pump@3.0.0
punycode@2.1.1
qs@6.10.3
qs@6.5.3
queue-microtask@1.2.3
quick-lru@5.1.1
randombytes@2.1.0
range-parser@1.2.1
raw-body@2.5.1
rcedit@3.0.1
readable-stream@1.1.14
readable-stream@2.3.7
readable-stream@3.6.0
readdirp@3.6.0
read-pkg@2.0.0
read-pkg-up@2.0.0
regenerator-runtime@0.13.9
relateurl@0.2.7
renderkid@3.0.0
request@2.88.2
require-directory@2.1.1
require-from-string@2.0.2
requires-port@1.0.0
resolve@1.22.1
resolve-alpn@1.2.1
resolve-dir@1.0.1
resolve-from@4.0.0
resolve-package@1.0.1
responselike@1.0.2
responselike@2.0.1
restore-cursor@3.1.0
retry@0.12.0
retry@0.13.1
reusify@1.0.4
rimraf@3.0.2
roarr@2.15.4
run-async@2.4.1
run-parallel@1.2.0
rxjs@7.5.6
safe-buffer@5.1.2
safe-buffer@5.2.1
safer-buffer@2.1.2
safe-stable-stringify@2.3.1
schema-utils@2.7.0
schema-utils@3.1.1
schema-utils@4.0.0
select-hose@2.0.0
selfsigned@2.0.1
semver@5.7.1
semver@6.3.0
semver@7.3.7
semver-compare@1.0.0
send@0.18.0
serialize-error@7.0.1
serialize-javascript@6.0.0
serve-index@1.9.1
serve-static@1.15.0
set-blocking@2.0.0
setprototypeof@1.1.0
setprototypeof@1.2.0
shallow-clone@3.0.1
shebang-command@1.2.0
shebang-command@2.0.0
shebang-regex@1.0.0
shebang-regex@3.0.0
side-channel@1.0.4
signal-exit@3.0.7
simple-swizzle@0.2.2
@sindresorhus/is@0.14.0
@sindresorhus/is@4.6.0
single-line-log@1.1.2
sinon@14.0.0
@sinonjs/commons@1.8.3
@sinonjs/fake-timers@9.1.2
@sinonjs/samsam@6.1.1
@sinonjs/text-encoding@0.7.2
slash@4.0.0
smart-buffer@4.2.0
sockjs@0.3.24
socks@2.7.0
socks-proxy-agent@7.0.0
source-map@0.6.1
source-map-js@1.0.2
source-map-support@0.5.21
spdx-correct@3.1.1
spdx-exceptions@2.3.0
spdx-expression-parse@3.0.1
spdx-license-ids@3.0.11
spdy@4.0.2
spdy-transport@3.0.0
speedometer@0.1.4
sprintf-js@1.1.2
sshpk@1.17.0
ssri@9.0.1
stack-trace@0.0.10
statuses@1.5.0
statuses@2.0.1
string_decoder@0.10.31
string_decoder@1.1.1
string-width@1.0.2
string-width@4.2.3
strip-ansi@3.0.1
strip-ansi@6.0.1
strip-bom@3.0.0
strip-eof@1.0.0
strip-final-newline@2.0.0
strip-json-comments@3.1.1
strip-outer@1.0.1
style-loader@3.3.1
sudo-prompt@9.2.1
sumchecker@3.0.1
supports-color@5.5.0
supports-color@7.2.0
supports-color@8.1.1
supports-preserve-symlinks-flag@1.0.0
@szmarczak/http-timer@1.1.2
@szmarczak/http-timer@4.0.6
tapable@1.1.3
tapable@2.2.1
tar@6.1.11
terser@5.14.2
terser-webpack-plugin@5.3.5
text-hex@1.0.0
thenify@3.3.1
thenify-all@1.6.0
throttleit@0.0.2
through2@0.2.3
through@2.3.8
thunky@1.1.0
timers-ext@0.1.7
tmp@0.0.33
toidentifier@1.0.1
@tootallnate/once@2.0.0
to-readable-stream@1.0.0
to-regex-range@5.0.1
tough-cookie@2.5.0
tr46@0.0.3
trim-repeated@1.0.0
triple-beam@1.3.0
@tsconfig/node10@1.0.9
@tsconfig/node12@1.0.11
@tsconfig/node14@1.0.3
@tsconfig/node16@1.0.3
tslib@2.4.0
ts-loader@9.3.1
ts-node@10.9.1
tunnel@0.0.6
tunnel-agent@0.6.0
tweetnacl@0.14.5
type@1.2.0
type@2.7.2
typedarray@0.0.6
type-detect@4.0.8
type-fest@0.13.1
type-fest@0.21.3
type-fest@2.18.1
type-is@1.6.18
@types/body-parser@1.19.2
@types/bonjour@3.5.10
@types/cacheable-request@6.0.2
@types/chai@4.3.3
@types/connect@3.4.35
@types/connect-history-api-fallback@1.3.5
@types/crc@3.8.0
typescript@4.7.4
@types/eslint@8.4.6
@types/eslint-scope@3.7.4
@types/estree@0.0.51
@types/express@4.17.13
@types/express-serve-static-core@4.17.30
@types/glob@7.2.0
@types/html-minifier-terser@6.1.0
@types/http-cache-semantics@4.0.1
@types/http-proxy@1.17.9
@types/json-buffer@3.0.0
@types/json-schema@7.0.11
@types/keyv@3.1.4
@types/line-reader@0.0.34
@types/lodash@4.14.184
@types/lodash.debounce@4.0.7
@types/mime@3.0.1
@types/minimatch@3.0.5
@types/mocha@9.1.1
@types/node@16.11.51
@types/node@16.11.7
@types/parse-json@4.0.0
@types/prettier@2.7.0
@types/properties-reader@2.1.1
@types/qs@6.9.7
@types/range-parser@1.2.4
@types/responselike@1.0.0
@types/retry@0.12.0
@types/serve-index@1.9.1
@types/serve-static@1.15.0
@types/sinon@10.0.13
@types/sinonjs__fake-timers@8.1.2
@types/sockjs@0.3.33
@types/uuid@8.3.4
@types/ws@8.5.3
@types/yauzl@2.10.0
@ungap/promise-all-settled@1.1.2
unique-filename@1.1.1
unique-slug@2.0.2
universalify@0.1.2
universalify@2.0.0
unpipe@1.0.0
update-browserslist-db@1.0.5
uri-js@4.4.1
url-parse-lax@3.0.0
username@5.1.0
utila@0.4.0
util-deprecate@1.0.2
utils-merge@1.0.1
uuid@3.4.0
uuid@8.3.2
v8-compile-cache-lib@3.0.1
validate-npm-package-license@3.0.4
vary@1.1.2
@vercel/webpack-asset-relocator-loader@1.7.3
verror@1.10.0
watchpack@2.4.0
wbuf@1.7.3
wcwidth@1.0.1
@webassemblyjs/ast@1.11.1
@webassemblyjs/floating-point-hex-parser@1.11.1
@webassemblyjs/helper-api-error@1.11.1
@webassemblyjs/helper-buffer@1.11.1
@webassemblyjs/helper-numbers@1.11.1
@webassemblyjs/helper-wasm-bytecode@1.11.1
@webassemblyjs/helper-wasm-section@1.11.1
@webassemblyjs/ieee754@1.11.1
@webassemblyjs/leb128@1.11.1
@webassemblyjs/utf8@1.11.1
@webassemblyjs/wasm-edit@1.11.1
@webassemblyjs/wasm-gen@1.11.1
@webassemblyjs/wasm-opt@1.11.1
@webassemblyjs/wasm-parser@1.11.1
@webassemblyjs/wast-printer@1.11.1
webidl-conversions@3.0.1
webpack@5.74.0
webpack-dev-middleware@5.3.3
webpack-dev-server@4.10.0
webpack-merge@5.8.0
webpack-sources@3.2.3
websocket-driver@0.7.4
websocket-extensions@0.1.4
whatwg-url@5.0.0
which@1.3.1
which@2.0.2
wide-align@1.1.5
wildcard@2.0.0
winston@3.8.1
winston-daily-rotate-file@4.7.1
winston-transport@4.5.0
workerpool@6.2.0
wrap-ansi@7.0.0
wrappy@1.0.2
ws@7.5.9
ws@8.8.1
xmlbuilder@15.1.1
xtend@2.1.2
xterm@4.19.0
xterm-addon-fit@0.5.0
xterm-addon-search@0.8.2
@xtuc/ieee754@1.2.0
@xtuc/long@4.2.2
y18n@5.0.8
yallist@4.0.0
yaml@1.10.2
yargs@16.2.0
yargs@17.5.1
yargs-parser@20.2.4
yargs-parser@20.2.9
yargs-parser@21.1.1
yargs-unparser@2.0.0
yarn-or-npm@3.0.1
yauzl@2.10.0
yn@3.1.1
yocto-queue@0.1.0
"
#####End   of NODEJS package list#####

#RSudio requires 5.12.8 but when QT 5.12.x and glibc 2.34(clone3) is used it will cause a
#sandbox violation in chromium. QT fixed this around 5.15.x(5?). Gentoo is at 5.15.3 and
#it works. I assume it was back ported or I'm wrong about the timeline.
QT_VER=5.15.3
QT_SLOT=5

SLOT="0"
KEYWORDS=""
IUSE="server electron +qt5 test debug quarto panmirror"
REQUIRED_USE="!server? ( ^^ ( electron qt5 ) )"

DESCRIPTION="IDE for the R language"
HOMEPAGE="
	https://rstudio.com
	https://github.com/rstudio/rstudio/"

if [[ "${PV}" == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rstudio/${PN}"
	EGIT_BRANCH="main"

else
	RSTUDIO_SOURCE_FILENAME="v$(ver_rs 3 "+").tar.gz"
	S="${WORKDIR}/${PN}-$(ver_rs 3 "-")"
	SRC_URI="https://github.com/rstudio/rstudio/archive/${RSTUDIO_SOURCE_FILENAME} -> ${P}.tar.gz"
fi

#node_gyp and panmirror are seperate lines
#buffers@0.1.1 = MIT/X11
LICENSE="AGPL-3 BSD MIT Apache-2.0 Boost-1.0 CC-BY-4.0
panmirror? ( BSD-2 ISC MIT )
panmirror? ( || ( AFL-2.1 BSD ) || ( MIT Apache-2.0 ) 0BSD Apache-2.0 BSD BSD-2 ISC LGPL-3 MIT PYTHON Unlicense )"
SRC_URI="${SRC_URI} panmirror? ( $(npm_build_src_uri ${NODE_GYP_SKEIN}) $(npm_build_src_uri ${PANMIRROR_SKEIN}) )"
SRC_URI="${SRC_URI} electron?  ( $(npm_build_src_uri ${RELECTRON_NODEJS_DEPS}) )"

#If not using system electron modify unpack also
SRC_URI="${SRC_URI} electron?  (
		https://www.electronjs.org/headers/v${ELECTRON_VERSION}/node-v${ELECTRON_VERSION}-headers.tar.gz    -> electron-v${ELECTRON_VERSION}-headers.tar.gz
		amd64? ( https://github.com/electron/electron/releases/download/v${ELECTRON_VERSION}/electron-v${ELECTRON_VERSION}-linux-x64.zip -> electron-v${ELECTRON_VERSION}-linux-x64.zip )
		) "
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

DEPEND=""
RDEPEND="
	>=dev-lang/R-3.3.0
	>=dev-libs/boost-1.78:=
	>=dev-libs/mathjax-2.7
	>=app-text/pandoc-2.18
	>=dev-libs/soci-4.0.3[postgres,sqlite]
	>=dev-libs/libfmt-8.1.1
	sys-process/lsof
	>=dev-cpp/yaml-cpp-0.7.0_p1
	<=virtual/jdk-11:=
	server? (
		acct-user/rstudio-server
		acct-group/rstudio-server
	)
	!electron? (
		qt5? (
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
	)
	quarto? ( >=app-text/quarto-cli-0.9.230 )
	panmirror? (
		sys-apps/yarn
		>=net-libs/nodejs-16.14.0
	)
	electron? (
		>=net-libs/nodejs-16.14.0[npm]
	)
	app-text/hunspell
	"

DEPEND="${RDEPEND}"
BDEPEND="
	dev-java/aopalliance:1
	dev-java/gin:2.1
	dev-java/javax-inject
	=dev-java/validation-api-1.0*:1.0[source]
	<=virtual/jdk-11:=
"
PV_RELEASE="2022.07.0.548"
PATCHES=(
	"${FILESDIR}/${PN}-1.4.1717-boost-imports-and-namespaces.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-cmake-bundled-dependencies.patch"
	"${FILESDIR}/${PN}-1.4.1717-fix-boost-version-check.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-resource-path.patch"
	"${FILESDIR}/${PN}-1.4.1106-server-paths.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-package-build.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-pandoc_path_fix.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-node_path.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-quarto-version.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-electron_path.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-reenable-sandbox.patch"
	"${FILESDIR}/${PN}-2022.07.0.548-libfmt.patch"
	"${FILESDIR}/${PN}-9999-hunspell.patch"
)
DOCS=(CONTRIBUTING.md COPYING INSTALL NEWS.md NOTICE README.md SOURCE
	VERSION version/news )
src_unpack(){
	if [[ "${PV}" == *9999 ]];then
		if use electron; then
			#Electron package.json changes alot. This is a known good version
			EGIT_COMMIT=${ELECTRON_EGIT_COMMIT}
			:
		else
			#A good last commit when testing a patch
			#EGIT_COMMIT="febae33db0b6d4aaa83edafa20b74df64eab2801" # 2022-08-19
			:
		fi
		git-r3_src_unpack
	else
		unpack ${P}.tar.gz
	fi

	npm_src_unpack
	use panmirror && yarn_build_cache ${NODE_GYP_SKEIN} ${PANMIRROR_SKEIN}
	use electron  &&  npm_build_cache ${RELECTRON_NODEJS_DEPS}

	if use electron; then
		#IF bundling electron
		mkdir -p ${WORKDIR}/.electron-gyp
		pushd    ${WORKDIR}/.electron-gyp > /dev/null

		unpack electron-v${ELECTRON_VERSION}-headers.tar.gz
		mv node_headers ${ELECTRON_VERSION} || die
		#It only been 9 so far
		echo "9" > ${ELECTRON_VERSION}/installVersion

		popd > /dev/null

		#IF bundling electron
		local ELECTRON_HASH=$(echo -n "https://github.com/electron/electron/releases/download/v${ELECTRON_VERSION}" |sha256sum |sed "s/ .*//")
		mkdir -p ${WORKDIR}/.cache/electron/${ELECTRON_HASH}
		#NOTE  might need to create ${WORKDIR}/.cache/electron/${ELECTRON_HASH}/SHASUMS256.txt in the future
		ln -s ${DISTDIR}/electron-v${ELECTRON_VERSION}-linux-x64.zip ${WORKDIR}/.cache/electron/${ELECTRON_HASH}/electron-v${ELECTRON_VERSION}-linux-x64.zip

#		This is commented out b/c commit 821341dd0fcf1f6376b74f0647c8fee7eb68a977
#		breaks seperating electron from R saving this code for the future
#		#If using system electron
#		mkdir -p ${WORKDIR}/.electron-gyp/${ELECTRON_VERSION}
#		pushd    ${WORKDIR}/.electron-gyp/${ELECTRON_VERSION} > /dev/null
#
#		ln -s /usr/include/electron-${ELECTRON_VERSION_MAJ} include || die
#		#It only been 9 so far
#		echo "9" > installVersion
#
#		popd > /dev/null
#
#		#so far it seems happy to have only the file electron which it will rename
#		local ELECTRON_HASH=$(echo -n "https://github.com/electron/electron/releases/download/v${ELECTRON_VERSION}" |sha256sum |sed "s/ .*//")
#		mkdir -p ${WORKDIR}/.cache/electron/${ELECTRON_HASH}
#		touch electron
#		zip -0 ${WORKDIR}/.cache/electron/${ELECTRON_HASH}/electron-v${ELECTRON_VERSION}-linux-x64.zip electron

		local NODEJS_VERSION=$(node -v) || die "Node version not found"
		NODEJS_VERSION=${NODEJS_VERSION#v}
		mkdir -p ${WORKDIR}/.cache/node-gyp/${NODEJS_VERSION}/include
		ln -s /usr/include/node ${WORKDIR}/.cache/node-gyp/${NODEJS_VERSION}/include/node
		#This tells it the headers where installed
		#Don't know what 9 is
		echo "9" > ${WORKDIR}/.cache/node-gyp/${NODEJS_VERSION}/installVersion
	fi

	ln -s ${EPREFIX}/usr/share/hunspell ${S}/dependencies/dictionaries || die "Failed to link dictionaries"
}
src_prepare(){
	cmake_src_prepare
	java-pkg-2_src_prepare

	ln -s ${EPREFIX}/usr/share/mathjax ${S}/dependencies/mathjax-27

	#Remove Bundled deps ln -s to system libraries - see /src/gwt/.classpath
	#gin and aopalliance
	rm ${S}/src/gwt/lib/gin/2.1.2/* -R
	ln -s ${EPREFIX}/usr/share/aopalliance-1/lib/aopalliance.jar ${S}/src/gwt/lib/gin/2.1.2/aopalliance.jar || die "linking to aopalliance.jar failed"
	ln -s ${EPREFIX}/usr/share/javax-inject/lib/javax-inject.jar ${S}/src/gwt/lib/gin/2.1.2/javax-inject.jar || die "linking to javax-inject.jar failed"
	for JAR in gin guice-assistedinject-3.0 guice-3.0 ;do
		ln -s ${EPREFIX}/usr/share/gin-2.1/lib/${JAR}.jar ${S}/src/gwt/lib/gin/2.1.2/${JAR}.jar || die "linking to ${JAR} failed"
	done
	#gwt - they bundle a custom gwt build @github rstudio/gwt tree v1.4
	#validation-api
	rm ${S}/src/gwt/lib/gwt/gwt-rstudio/validation-api-*.jar
	ln -s ${EPREFIX}/usr/share/validation-api-1.0/lib/validation-api.jar ${S}/src/gwt/lib/gwt/gwt-rstudio/validation-api-1.0.0.GA.jar || die "linking to validation-api.jar"
	ln -s ${EPREFIX}/usr/share/validation-api-1.0/sources/validation-api-src.zip ${S}/src/gwt/lib/gwt/gwt-rstudio/validation-api-1.0.0.GA-sources.jar || die "linking to validation-api-src.zip"
	#todo lib/junit-4.9b3.jar dev-java/junit - only for testing
	#todo create elemental2

	# make sure icons and mime stuff are with prefix
	sed -i \
		-e "s:/usr:${EPREFIX}/usr:g" \
		CMakeGlobals.txt src/cpp/desktop/CMakeLists.txt || die

	if  use panmirror;then
		PANMIRROR_SRC_HASH=$(sha1sum ${S}/src/gwt/panmirror/src/editor/package.json)
		if [[ ${PANMIRROR_PACKAGE_HASH} != ${PANMIRROR_SRC_HASH:0:40} ]];then
			die "Panmirror Hash doesn't match"
		else
			yarn_src_prepare_gyp ${FILESDIR}/node-gyp-${NODE_GYP_VER}-9999-yarn.lock

			patch                        -p1 < ${FILESDIR}/${PN}-${PV_RELEASE}-panmirror-package.patch || die "Panmirror patch failed"
			#npm_fix_lock_path  "${FILESDIR}/${PN}-${PV_RELEASE}-panmirror-yarn.lock" "${S}/src/gwt/panmirror/src/editor/yarn.lock" "Panmirror's"
			#this is a temporary patch; next release build w/o __GENTOO_PATH__ use native urls
			#caution this could pick up base64 with the pattern ++/
			sed  -E  "s#file://__GENTOO_PATH__/((@[^+]+)\+)?(.*)@(.*).tgz#https://registry.yarnpkg.com/\2++/\3/-/\3-\4.tgz#; s#/\+\+/#++/#;s#\+\+/#/#" \
				${FILESDIR}/rstudio-${PV_RELEASE}-panmirror-yarn.lock > "${S}/src/gwt/panmirror/src/editor/yarn.lock"
		fi
	fi

	if  use electron;then
		ELECTRON_SRC_HASH=$(sha1sum ${S}/src/node/desktop/package.json)
		if [[ ${ELECTRON_PACKAGE_HASH} != ${ELECTRON_SRC_HASH:0:40} ]];then
			die "Electron Hash doesn't match"
		else
			patch -p1 < "${FILESDIR}/${PN}-${PV}-electron-package.patch" || die "Electron patch failed"
			patch -p1 < "${FILESDIR}/${PN}-${PV}-electron-package-lock.json.patch" || die "Electron lock file patch failed"
		fi
	fi
}
src_configure() {
	export PACKAGE_OS="Gentoo"
	if [[ ${PV} == "9999" ]];then
		export RSTUDIO_VERSION_MAJOR=""
		export RSTUDIO_VERSION_MINOR=""
		export RSTUDIO_VERSION_PATCH=""
		export RSTUDIO_VERSION_SUFFIX=""
		export GIT_COMMIT=$(git log -n1 --format=%H)
	else
		export RSTUDIO_VERSION_MAJOR=$(ver_cut 1)
		export RSTUDIO_VERSION_MINOR=$(ver_cut 2)
		export RSTUDIO_VERSION_PATCH=$(ver_cut 3)
		export RSTUDIO_VERSION_SUFFIX="+$(ver_cut 4)"
	fi

	CMAKE_BUILD_TYPE=$(usex debug Debug Release) #RelWithDebInfo Release
	mkdir -p  ${WORKDIR}/.cache
	mkdir -p "${WORKDIR}/.npm"
	echo "cache=${WORKDIR}/node_cache" > ${S}/src/node/desktop/.npmrc
	#Instead of using RSTUDIO_TARGET set RSTUDIO_{SERVER,DESKTOP,ELECTRON} manualy
	#This allows ELECTRON with SERVER
	#RSTUDIO_TARGET is set to true to bypass a test to see if undefined
	RSTUDIO_SERVER=FALSE
	RSTUDIO_DESKTOP=FALSE
	RSTUDIO_ELECTRON=FALSE
	if use server; then
		RSTUDIO_SERVER=TRUE
	fi
	if use electron; then
		RSTUDIO_ELECTRON=TRUE
	elif use qt5; then
		RSTUDIO_DESKTOP=TRUE
	fi
	# FIXME: GWT_COPY is helpful because it allows us to call ant ourselves
	# (rather than using the custom_target defined in src/gwt/CMakeLists.txt),
	# however it also installs a test script, which we probably don't want.

	#NOTE: RSTUDIO_BIN_PATH was originaly used for the dir that holds pandoc
	#it is now used also for the path for r-ldpath
	#in electron this by default is located at /usr/share/rstudio/resources/app/bin
	local mycmakeargs=(
		-DRSTUDIO_INSTALL_SUPPORTING=${EPREFIX}/usr/share/${PN}
		-DRSTUDIO_TARGET=TRUE
		-DRSTUDIO_SERVER=${RSTUDIO_SERVER}
		-DRSTUDIO_DESKTOP=${RSTUDIO_DESKTOP}
		-DRSTUDIO_ELECTRON=${RSTUDIO_ELECTRON}
		-DRSTUDIO_UNIT_TESTS_DISABLED=$(usex test OFF ON)
		-DRSTUDIO_USE_SYSTEM_BOOST=ON
		-DGWT_BUILD=OFF
		-DGWT_COPY=ON
		-DRSTUDIO_USE_SYSTEM_YAML_CPP=ON
		-DRSTUDIO_PACKAGE_BUILD=1
		-DRSTUDIO_BIN_PATH=${EPREFIX}/usr/bin
		-DQUARTO_ENABLED=$(usex quarto)
		-DRSTUDIO_USE_SYSTEM_SOCI=TRUE
	)
	if use electron; then
		mycmakeargs+=( -DRSTUDIO_INSTALL_FREEDESKTOP="ON" )
	elif use qt5 ; then
		mycmakeargs+=( -DQT_QMAKE_EXECUTABLE="$(qt5_get_bindir)/qmake"
						-DRSTUDIO_INSTALL_FREEDESKTOP="ON" )
	fi
	# It looks like eant takes care of this for us during src_compile
	# TODO: verify with someone who knows better
	# java-ant-2_src_configure
	cmake_src_configure
}
src_compile(){
	if use panmirror;then
		# Building NODE-GYP
		yarn_src_compile_gyp
		# Finished Building node-gyp

		# Building PANMIRROR
		einfo "Building PANMIRROR"
		pushd ${S}/src/gwt/panmirror/src/editor > /dev/null
		yarn_set_config ignore-engines true
		yarn_src_compile
		popd > /dev/null
		#Finished Building PANMIRROR
	else
		patch -p1 < "${FILESDIR}/${PN}-2022.07.0.548.panmirror_disable.patch" || die "Couldn't apply panmirror disable patch"
	fi

	export EANT_BUILD_XML="src/gwt/build.xml"
	export EANT_BUILD_TARGET="build"
	export ANT_OPTS="-Duser.home=${T} -Djava.util.prefs.userRoot=${T}"

	local GWT_MAIN_MODULE="RStudio"
	if use electron || use qt5; then
		if ! use server;then
			GWT_MAIN_MODULE="RStudioDesktop"
		fi
	else
		if  use server;then
			GWT_MAIN_MODULE="RStudioServer"
		fi
	fi

	# FIXME: isn't there a variable we can use in one of the java eclasses that
	# will take care of some of the dependency and path stuff for us?
	local eant_extra_args=(
		# These are from src/gwt/CMakeLists.txt, grep if(GWT_BUILD)
		-Dbuild.dir="bin"
		-Dwww.dir="www"
		-Dextras.dir="extras"
		-Dlib.dir="lib"
		-Dgwt.main.module="org.rstudio.studio.${GWT_MAIN_MODULE}"
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

	if use server ;then
		dopamd src/cpp/server/extras/pam/rstudio
		newinitd "${FILESDIR}/rstudio-server" rstudio-server
		insinto /etc/rstudio
		doins "${FILESDIR}/rserver.conf" "${FILESDIR}/rsession.conf"
	fi
	if use electron;then
		mkdir -p "${ED}/usr/bin"
		dosym -r /usr/share/${PN}/rstudio /usr/bin/rstudio
		sed -i "s#/usr/#/usr/bin/#" "${ED}/usr/share/applications/rstudio.desktop"
		if use server; then
			dosym -r /usr/share/${PN}/resources/app/bin/rserver /usr/bin/rserver
		fi
		#see src_prepare for more info
#		cat << _EOF_ | sed 's/ARGS/$@/' > ${PN}
#!/bin/bash
#This overides the electron function app.isPackaged()
#ELECTRON_FORCE_IS_PACKAGED=true electron-${ELECTRON_VERSION_MAJ} ${EPREFIX}/usr/share/${PN}/resources/app ARGS
#_EOF_
#		dobin ${PN}
		dodoc ${ED}/usr/share/${PN}/{LICENSE,LICENSES.chromium.html}
		rm ${ED}/usr/share/${PN}/{COPYING,INSTALL,LICENSE,LICENSES.chromium.html,NOTICE,SOURCE}
	else
		# This binary name is much to generic, so we'll change it
		mv "${ED}/usr/bin/diagnostics" "${ED}/usr/bin/${PN}-diagnostics"
	fi
	einstalldocs
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
	if use electron || use qt5;then
		xdg_desktop_database_update
		xdg_mimeinfo_database_update
		xdg_icon_cache_update
	fi
}
