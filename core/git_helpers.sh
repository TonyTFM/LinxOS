#!/usr/bin/env bash

# Schnell-Commit und Push in einem Befehl
gquick() {
    if [ -z "$1" ]; then
        echo "Fehler: Bitte eine Commit-Nachricht angeben!"
        echo "Nutzung: gquick \"Deine Nachricht\""
        return 1
    fi
    git add .
    git commit -m "$1"
    git push origin main
}

alias gst='git status'
alias gpl='git pull origin main'