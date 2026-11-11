<div align="center">

# ⚡ LinxOS (Godmode Edition)
*High-Performance Termux & Linux Environment for Android*

[![GitHub Release](https://img.shields.io/badge/Status-Active-brightgreen?style=flat-square)]()
[![OS](https://img.shields.io/badge/Termux-Android-blue?style=flat-square)]()
[![Access](https://img.shields.io/badge/Privileges-Root%20%2F%20Godmode-red?style=flat-square)]()

</div>

---

## 🚀 Overview
**LinxOS** is a custom-tailored, highly optimized terminal and script environment designed to run natively inside **Termux** on Android devices with root privileges. Built by **GN9**, it brings desktop-grade workflow stability, custom shell aesthetics (GitHub Dark Theme), and utility scripts directly to mobile hardware.

---

## 🛠️ Features & Core Utilities (`~/LinxOS/bin`)
The environment includes custom shell scripts housed in `~/LinxOS/bin` for rapid management:
* **`sync`** — Synchronizes dotfiles and repository states with GitHub.
* **`pack`** — Packages project structures and archives.
* **`info`** — Displays system metrics and environment info.
* **`clean`** — Purges package caches and temp storage to save space.
* **`spacewars`** — Launches the internal PHP-based retro minigame engine.

---

## 🎨 Shell & Godmode Configuration
LinxOS uses a custom GitHub Dark Blue prompt scheme combined with an instant high-privilege root trigger:

* **Standard Prompt:** Clean GitHub Dark Blue palette (`[GN9@Apex ~]$`).
* **Godmode:** Instant privilege escalation mapping with a striking red-themed root prompt (`[ROOT@SEEGURKE:/#]`).

---

## 📦 Repository Structure
```text
~/LinxOS/
├── bin/          # Core execution scripts (sync, pack, info, clean, spacewars)
├── .bashrc       # Custom GitHub Dark Theme & Aliases
└── README.md     # Project documentation
