# Milestone 1: The foundation 
**Date:** April 4, 2026
**Status:** Completed ✅

## Goal
Establish a working development ennvironment and a verified export-to-desktop pipeline

## 🛠️ Technical Setup
**Engine:** Godot 4.x (Standard)
**Workflow:** Hybrid Windows/Wsl2 (Ubuntu)
**Version Control:** Git via WSL2 Targeting a remote Github repository.

## 🚧 Challenges & Solutions

### 1. the "Template Missing" Wall
* **Problem:** Godot refused to export the `.exe` because export templates weren't found
* **Solution:** Manually managed templates through the Godot Editor to install windows build support

### 2. The MSIX Sandbox Restriction
* **Problem:** Microsoft Store version of Lively Wallpaper blocked our custom `.exe` for security reasons.
* **solution:** Switchedto the **Library/Installer** Version of lively to allow unrestricted execution of the Godot project as a wallpaper layer.

## 🎯 Key Achievements
- [x] Ceossed the `/mnt/c/` bridge from ubuntu to windows (access windows files and folder throught this path)
- [x] Successfully rendered a Godot "Blue Screen" as a funtioning desktop background.
- [x] Implemented a `.gitignore` to keep the repo clean of build artifacts.

---
*Next Step: Implementing Window Transparency and Mochi's first Sprite.*
