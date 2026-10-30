#!/data/data/com.termux/files/usr/bin/bash

set -eu

LINX_ROOT="$(cd "$(dirname "$0")" && pwd)"

echo "================================"
echo "       LinxOS Installer"
echo "================================"

if [ -z "${PREFIX:-}" ]; then
    echo "Fehler: Termux-Umgebung nicht erkannt."
    exit 1
fi

mkdir -p "$PREFIX/bin"

chmod +x "$LINX_ROOT/bin/linx"
chmod +x "$LINX_ROOT/core/system.sh"
chmod +x "$LINX_ROOT/core/update.sh"

ln -sfn "$LINX_ROOT/bin/linx" "$PREFIX/bin/linx"

echo
echo "LinxOS wurde installiert."
echo
echo "Starte LinxOS mit:"
echo "linx"