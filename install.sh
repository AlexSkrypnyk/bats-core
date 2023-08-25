#!/usr/bin/env bash

set -e

BATS_ROOT="${0%/*}"
PREFIX="${1%/}"
LIBDIR="${2:-lib}"

if [[ -z "$PREFIX" ]]; then
  printf '%s\n' \
    "usage: $0 <prefix> [base_libdir]" \
    "  e.g. $0 /usr/local" \
    "       $0 /usr/local lib64" >&2
  exit 1
fi

install -d -m 755 "$PREFIX"/{bin,libexec/bats-core,"${LIBDIR}"/bats-core,share/{bats,man/man{1,7}}}

install -m 755 "$BATS_ROOT/bin"/* "$PREFIX/bin"
install -m 755 "$BATS_ROOT/libexec/bats-core"/* "$PREFIX/libexec/bats-core"
install -m 755 "$BATS_ROOT/lib/bats-core"/* "$PREFIX/${LIBDIR}/bats-core"
install -m 644 "$BATS_ROOT/man/bats.1" "$PREFIX/share/man/man1"
install -m 644 "$BATS_ROOT/man/bats.7" "$PREFIX/share/man/man7"

sed -i "s#^\(BATS_BASE_LIBDIR=\).*#\1${LIBDIR}#" "$PREFIX/bin/bats"

echo "Installed Bats to $PREFIX/bin/bats"
