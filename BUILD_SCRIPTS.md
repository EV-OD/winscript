# SnapRun Build Scripts Reference

## 🚀 Quick Commands

### **Development**
```bash
pnpm dev              # Start development server
pnpm start            # Same as dev
```

### **Building**
```bash
pnpm run build:project    # Build complete project (frontend + Tauri)
pnpm run build:frontend   # Build only frontend
pnpm run build:tauri      # Build only Tauri backend
```

### **Release & Packaging**
```bash
pnpm run release          # Clean + Build + Inno Setup
pnpm run release:full     # Full release with all steps + info
pnpm run build:inno       # Build only Inno Setup installer
```

### **Utilities**
```bash
pnpm run clean            # Clean build directories
pnpm run package:info     # Show available installers
pnpm run test:install     # Test installation
```

## 📦 **What Each Script Does**

### **`pnpm run build:project`**
1. ✅ Builds frontend (React/TypeScript)
2. ✅ Builds Tauri backend (Rust)
3. ✅ Creates MSI installer
4. ✅ Creates NSIS installer
5. ✅ Creates standalone executable

### **`pnpm run release`**
1. ✅ Cleans previous builds
2. ✅ Runs `build:project`
3. ✅ Builds Inno Setup installer
4. ✅ Creates all 3 installer types

### **`pnpm run release:full`**
1. ✅ Cleans previous builds
2. ✅ Installs/updates dependencies
3. ✅ Runs complete build process
4. ✅ Builds all installers
5. ✅ Shows summary of created packages

## 🎯 **Output Locations**

After running release commands, you'll find:

### **Installers:**
- **MSI**: `src-tauri/target/release/bundle/msi/SnapRun_1.0.1_x64.msi`
- **NSIS**: `src-tauri/target/release/bundle/nsis/SnapRun_1.0.1_x64.exe`
- **Inno Setup**: `src-tauri/target/release/bundle/inno/SnapRun_1.0.1_x64_inno_setup.exe`

### **Executable:**
- **Standalone**: `src-tauri/target/release/tauri-app.exe`

## ⚡ **Quick Workflow**

### **For Development:**
```bash
pnpm dev
```

### **For Testing Build:**
```bash
pnpm run build:project
```

### **For Full Release:**
```bash
pnpm run release:full
```

## 📋 **Requirements**

### **Required:**
- ✅ Node.js & pnpm
- ✅ Rust & Cargo  
- ✅ Tauri CLI

### **Optional (for Inno Setup):**
- 🔧 Inno Setup 6/5 installed
- 📁 Available at: https://jrsoftware.org/isdl.php

### **Auto-Generated:**
- ✅ MSI & NSIS installers (via Tauri)
- ✅ Standalone executable

## 🔧 **Troubleshooting**

### **Build Fails:**
```bash
pnpm run clean
pnpm install
pnpm run release:full
```

### **Inno Setup Missing:**
- Install from: https://jrsoftware.org/isdl.php
- Or skip with: `pnpm run build:project`

### **Permission Issues:**
- Run PowerShell as Administrator if needed
- Check execution policy: `Set-ExecutionPolicy RemoteSigned`
