#!/data/data/com.termux/files/usr/bin/bash

LINX_ROOT="$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")"

echo
echo "========== LINXOS UPDATE =========="

if ! command -v git >/dev/null 2>&1; then
    echo "Git ist nicht installiert."
    echo "Bitte zuerst Git in Termux installieren."
    exit 1
fi

if [ ! -d "$LINX_ROOT/.git" ]; then
    echo "Kein Git-Repository gefunden."
    echo "Bitte LinxOS zuerst aus GitHub klonen."
    exit 1
fi

git -C "$LINX_ROOT" pull --ff-only

echo
echo "LinxOS Update abgeschlossen."