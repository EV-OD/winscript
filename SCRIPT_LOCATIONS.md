# SnapRun Script Locations Guide

## 📁 Where to Create Your Scripts

### **User Scripts Location:**
```
C:\Users\{YourUsername}\Documents\SnapRun\Scripts\
```
- ✅ **Create your custom `.rhai` scripts here**
- ✅ **No admin rights required**
- ✅ **Automatically discovered by SnapRun**
- ✅ **Survives app updates**
- ✅ **Easy to backup and share**

### **Built-in Scripts Location:**
```
C:\Program Files\SnapRun\Scripts\built_in_scripts\
```
- ℹ️ **System-provided scripts (read-only)**
- ℹ️ **Updated when you update SnapRun**
- ❌ **Do not modify these files**

## 🚀 How to Create Scripts

### **Method 1: File Explorer**
1. Open File Explorer
2. Navigate to: `Documents\SnapRun\Scripts\`
3. Create new file: `my_script.rhai`
4. Edit with any text editor (Notepad, VS Code, etc.)
5. Open SnapRun - your script appears automatically!

### **Method 2: Quick Start Template**
Create a new file in `Documents\SnapRun\Scripts\` with this template:

```rhai
// My Custom Script
// Description: What this script does

print("Hello from my custom script!");

// Your automation code here...
```

## 📋 Environment Variables (Set automatically during installation)

- **SnapRun_HOME**: Points to app installation directory
- **SnapRun_SCRIPTS**: Points to `Documents\SnapRun\Scripts\`

## 🔄 Script Discovery

SnapRun automatically searches for scripts in this order:

1. **Environment Variable**: `SnapRun_SCRIPTS` (if set)
2. **Documents Folder**: `Documents\SnapRun\Scripts\` (default)
3. **Built-in Scripts**: `Program Files\SnapRun\Scripts\built_in_scripts\`

## 💡 Tips

- **File Extension**: Always use `.rhai` extension
- **File Names**: Use descriptive names like `backup_files.rhai`
- **Organization**: You can create subfolders in your Scripts directory
- **Testing**: Scripts appear immediately when you refresh SnapRun
- **Backup**: Your scripts folder is in Documents, so it's included in regular backups

## 🛠 Troubleshooting

**Script not appearing?**
- Check file extension is `.rhai`
- Make sure it's in the correct Documents folder
- Refresh SnapRun or restart the app

**Permission errors?**
- Don't try to modify files in Program Files
- Always create scripts in your Documents folder
