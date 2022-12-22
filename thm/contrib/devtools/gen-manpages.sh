#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

THMD=${THMD:-$SRCDIR/thmd}
THMCLI=${THMCLI:-$SRCDIR/thm-cli}
THMTX=${THMTX:-$SRCDIR/thm-tx}
THMQT=${THMQT:-$SRCDIR/qt/thm-qt}

[ ! -x $THMD ] && echo "$THMD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
THMVER=($($THMCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for thmd if --version-string is not set,
# but has different outcomes for thm-qt and thm-cli.
echo "[COPYRIGHT]" > footer.h2m
$THMD --version | sed -n '1!p' >> footer.h2m

for cmd in $THMD $THMCLI $THMTX $THMQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${THMVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${THMVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
