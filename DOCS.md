# SnapRun Documentation

SnapRun is a powerful Windows automation platform that combines the simplicity of Rhai scripting with advanced system integration capabilities. Built with Tauri, Rust, and React, it provides a modern, secure, and efficient environment for automating Windows tasks.

## 📚 Quick Navigation

- [Features Overview](FEATURES.md) - Complete list of capabilities
- [Getting Started](GETTING_STARTED.md) - Installation and first steps
- [User Guide](USER_GUIDE.md) - How to use SnapRun
- [Script Reference](SCRIPT_REFERENCE.md) - Available functions and examples
- [API Documentation](API_REFERENCE.md) - Complete function reference
- [Installation Guide](INSTALLATION.md) - Detailed setup instructions
- [FAQ](FAQ.md) - Common questions and answers
- [Contributing](CONTRIBUTING.md) - How to contribute to the project
- [Changelog](CHANGELOG.md) - Version history and updates

## 🚀 What is SnapRun?

SnapRun transforms Windows automation from complex batch scripts and PowerShell into simple, readable Rhai scripts. Whether you're a system administrator, developer, or power user, SnapRun makes automation accessible and powerful.

### Key Benefits

- **🎯 Simple Syntax**: Rhai's Rust-like syntax is easy to learn and read
- **🔒 Secure**: Sandboxed execution environment with controlled system access
- **⚡ Fast**: Native performance with Rust backend
- **🎨 Modern UI**: Glass-effect interface with dark theme support
- **🔧 Extensible**: Rich API with file system, process, and UI functions
- **📦 Portable**: Single executable with optional system integration

## 🛠️ Core Components

### Rhai Scripting Engine
- **Language**: Rhai (Rust-like syntax)
- **Features**: Variables, functions, control flow, error handling
- **Safety**: Sandboxed execution with resource limits

### System Integration
- **File System**: Read, write, organize, and manage files
- **Process Management**: Execute commands, start applications
- **UI Automation**: Show dialogs, render markdown, capture input
- **Environment**: Access variables, system information

### Modern Interface
- **Glass Effects**: Windows 10+ transparency with blur effects
- **System Tray**: Background operation with global shortcuts
- **Script Management**: Discover, organize, and run scripts easily
- **Real-time Output**: Live script execution feedback

## 📋 System Requirements

### Minimum Requirements
- **OS**: Windows 10 version 1809 (build 17763) or later
- **RAM**: 256 MB available memory
- **Storage**: 50 MB free disk space
- **Architecture**: x64 (64-bit)

### Recommended Requirements
- **OS**: Windows 11 or Windows 10 21H2+
- **RAM**: 512 MB available memory
- **Storage**: 100 MB free disk space
- **Permissions**: User-level (admin not required for basic usage)

## 🎯 Use Cases

### System Administration
- **Log Management**: Rotate, compress, and archive log files
- **System Monitoring**: Check disk space, memory usage, services
- **Backup Automation**: Automated file backup and synchronization
- **Cleanup Scripts**: Remove temporary files, clear caches

### Development Workflows
- **Build Automation**: Compile projects, run tests, deploy applications
- **File Organization**: Organize downloads, sort project files
- **Environment Setup**: Configure development environments
- **Code Generation**: Generate boilerplate code and configurations

### Personal Productivity
- **File Organization**: Sort photos, documents, and downloads
- **System Maintenance**: Clean temporary files, optimize storage
- **Daily Tasks**: Automated routine computer tasks
- **Document Processing**: Batch process text files, generate reports

### Content Management
- **Markdown Processing**: Convert and render markdown documents
- **File Conversion**: Batch convert file formats
- **Data Processing**: Parse CSV, JSON, and text files
- **Report Generation**: Create automated status reports

## 🔧 Architecture Overview

### Frontend (React/TypeScript)
```
src/
├── App.tsx                 # Main application component
├── components/            # UI components
│   ├── ScriptSearch.tsx   # Script discovery and search
│   ├── DemoButton.tsx     # Built-in script launchers
│   └── ...
├── services/              # Frontend services
└── assets/                # Static resources
```

### Backend (Rust/Tauri)
```
src-tauri/src/
├── main.rs                # Application entry point
├── lib.rs                 # System tray and window management
├── script_manager.rs      # Script discovery and management
├── rhai_engine.rs         # Rhai scripting engine integration
├── fs_kit.rs              # File system operations
├── process_kit.rs         # Process execution
└── kits/                  # Function modules
```

### Script Locations
```
Built-in Scripts:          C:\Program Files\SnapRun\Scripts\built_in_scripts\
User Scripts:              C:\Users\{user}\Documents\SnapRun\Scripts\
Environment Variables:     SnapRun_HOME, SnapRun_SCRIPTS
```

## 📦 Installation Options

SnapRun provides three installer packages to suit different deployment needs:

1. **MSI Installer** - Windows Installer package for enterprise deployment
2. **NSIS Installer** - Compact installer with custom options
3. **Inno Setup Installer** - Feature-rich installer with advanced configuration
4. **Portable Executable** - Standalone executable requiring no installation

All installers include:
- Complete application with dependencies
- 12 built-in example scripts
- Sample custom scripts
- Environment variable setup
- File association for `.rhai` files
- Desktop and Start Menu shortcuts

## 🔗 Related Resources

- **Rhai Language**: [Official Documentation](https://rhai.rs/)
- **Tauri Framework**: [Tauri Documentation](https://tauri.app/)
- **Rust Language**: [The Rust Programming Language](https://doc.rust-lang.org/)
- **React Library**: [React Documentation](https://reactjs.org/)

## 📞 Support and Community

- **Issues**: Report bugs and request features on [GitHub Issues](https://github.com/EV-OD/winscript/issues)
- **Discussions**: Join conversations on [GitHub Discussions](https://github.com/EV-OD/winscript/discussions)
- **Documentation**: This documentation is continuously updated
- **Examples**: Check the `user_scripts/built_in_scripts/` directory for examples

## 📄 License

SnapRun is released under the MIT License. See [LICENSE](LICENSE) file for details.

---

**Next**: [Features Overview](FEATURES.md) | [Getting Started](GETTING_STARTED.md)
