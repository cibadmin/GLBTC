#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

GLOBALBITCOIND=${GLOBALBITCOIND:-$BINDIR/globalbitcoind}
GLOBALBITCOINCLI=${GLOBALBITCOINCLI:-$BINDIR/globalbitcoin-cli}
GLOBALBITCOINTX=${GLOBALBITCOINTX:-$BINDIR/globalbitcoin-tx}
GLOBALBITCOINQT=${GLOBALBITCOINQT:-$BINDIR/qt/globalbitcoin-qt}

[ ! -x $GLOBALBITCOIND ] && echo "$GLOBALBITCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
GLBTCVER=($($GLOBALBITCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for globalbitcoind if --version-string is not set,
# but has different outcomes for globalbitcoin-qt and globalbitcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$GLOBALBITCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $GLOBALBITCOIND $GLOBALBITCOINCLI $GLOBALBITCOINTX $GLOBALBITCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${GLBTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${GLBTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
