# WinScript2 Script Locations Guide

## 📁 Where to Create Your Scripts

### **User Scripts Location:**
```
C:\Users\{YourUsername}\Documents\WinScript2\Scripts\
```
- ✅ **Create your custom `.rhai` scripts here**
- ✅ **No admin rights required**
- ✅ **Automatically discovered by WinScript2**
- ✅ **Survives app updates**
- ✅ **Easy to backup and share**

### **Built-in Scripts Location:**
```
C:\Program Files\WinScript2\Scripts\built_in_scripts\
```
- ℹ️ **System-provided scripts (read-only)**
- ℹ️ **Updated when you update WinScript2**
- ❌ **Do not modify these files**

## 🚀 How to Create Scripts

### **Method 1: File Explorer**
1. Open File Explorer
2. Navigate to: `Documents\WinScript2\Scripts\`
3. Create new file: `my_script.rhai`
4. Edit with any text editor (Notepad, VS Code, etc.)
5. Open WinScript2 - your script appears automatically!

### **Method 2: Quick Start Template**
Create a new file in `Documents\WinScript2\Scripts\` with this template:

```rhai
// My Custom Script
// Description: What this script does

print("Hello from my custom script!");

// Your automation code here...
```

## 📋 Environment Variables (Set automatically during installation)

- **WINSCRIPT2_HOME**: Points to app installation directory
- **WINSCRIPT2_SCRIPTS**: Points to `Documents\WinScript2\Scripts\`

## 🔄 Script Discovery

WinScript2 automatically searches for scripts in this order:

1. **Environment Variable**: `WINSCRIPT2_SCRIPTS` (if set)
2. **Documents Folder**: `Documents\WinScript2\Scripts\` (default)
3. **Built-in Scripts**: `Program Files\WinScript2\Scripts\built_in_scripts\`

## 💡 Tips

- **File Extension**: Always use `.rhai` extension
- **File Names**: Use descriptive names like `backup_files.rhai`
- **Organization**: You can create subfolders in your Scripts directory
- **Testing**: Scripts appear immediately when you refresh WinScript2
- **Backup**: Your scripts folder is in Documents, so it's included in regular backups

## 🛠 Troubleshooting

**Script not appearing?**
- Check file extension is `.rhai`
- Make sure it's in the correct Documents folder
- Refresh WinScript2 or restart the app

**Permission errors?**
- Don't try to modify files in Program Files
- Always create scripts in your Documents folder
