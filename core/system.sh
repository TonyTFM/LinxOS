#!/data/data/com.termux/files/usr/bin/bash

linx_system() {
    echo
    echo "========== SYSTEM =========="
    echo "System: Android"
    echo "Architektur: $(uname -m)"
    echo "Kernel: $(uname -r)"
    echo "Shell: $SHELL"

    if command -v getprop >/dev/null 2>&1; then
        echo "Android-Version: $(getprop ro.build.version.release)"
        echo "Gerät: $(getprop ro.product.model)"
    fi

    echo "============================"
}