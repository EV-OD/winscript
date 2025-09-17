# WinScript2 - Rhai Scripting Platform

**Automate your Windows tasks with ease.** WinScript2 is a user-friendly desktop application that lets you write and run scripts to automate repetitive tasks, manage system operations, and enhance your productivity.

## What Can You Do?

### 🎯 **Everyday Automation**
- **System Information**: Get detailed hardware and software reports
- **File Operations**: Batch rename, organize, and process files
- **System Tasks**: Automate routine maintenance and monitoring
- **Custom Workflows**: Create personalized automation scripts

### ✨ **Why Choose WinScript2?**
- **Easy to Use**: Clean, intuitive interface - no command line required
- **Keyboard Friendly**: Navigate everything with arrow keys and shortcuts
- **Instant Results**: See your scripts run in real-time with visual feedback
- **Safe & Reliable**: Sandboxed script execution protects your system
- **Extensible**: Start simple, grow to complex automation as you learn

### 🚀 **Get Started in Minutes**
1. **Download & Install** - No complex setup required
2. **Browse Scripts** - Explore built-in examples and templates  
3. **Run & Customize** - Execute scripts with a single keypress
4. **Create Your Own** - Build custom automation for your needs

## User Guide

### 📋 **Basic Usage**
- **Launch the App** - Double-click to open WinScript2
- **Browse Scripts** - Use ↑/↓ arrow keys to navigate available scripts
- **Search Scripts** - Type to filter and find what you need
- **Run Scripts** - Press Enter to execute any script
- **Quick Exit** - Press Q anytime to return to the script list

### ⌨️ **Keyboard Shortcuts**
| Key | What It Does |
|-----|-------------|
| `↑/↓` | Browse through available scripts |
| `Type` | Search scripts by name |
| `Enter` | Run the selected script |
| `Q` | Stop script and return to main menu |
| `Escape` | Clear search |

### 🎛️ **Script Organization**
Scripts are automatically organized into categories:
- **Built-in Scripts**: Ready-to-use examples and utilities
- **System Scripts**: Hardware and software information tools
- **Custom Scripts**: Your personal automation scripts

---

## Technical Documentation

### 🔧 **For Developers & Advanced Users**

WinScript2 is built with modern technologies for performance, security, and extensibility.

### **Technology Stack**

#### Frontend
- **SolidJS**: Reactive JavaScript framework for responsive UI
- **TypeScript**: Type-safe development with enhanced IDE support
- **CSS**: Professional VS Code-inspired dark theme styling

#### Backend  
- **Tauri v2**: Modern desktop app framework with Rust security
- **Rust**: System-level performance and memory safety
- **Rhai v1.17**: Embedded scripting engine with sandboxed execution

#### Key Features
- **Script Management**: Custom Rust-based script discovery and categorization
- **UI Kit Integration**: Enhanced Rhai scripting capabilities with UI components
- **Event System**: Global keyboard and UI event handling with persistent focus
- **Environment Variables**: Configurable script paths via `WIN_SCRIPT2_PATH`

## Quick Start

### Prerequisites
- **Rust** (latest stable)
- **Node.js** (v18 or later)
- **pnpm** package manager

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd tauri-app
   ```

2. **Install dependencies**
   ```bash
   pnpm install
   ```

3. **Set up environment (optional)**
   ```bash
   # Run the environment setup script
   ./setup_environment.bat
   ```

4. **Start development server**
   ```bash
   pnpm tauri dev
   ```

## Environment Configuration

### Script Path Setup
The application looks for scripts in the following order:
1. `WIN_SCRIPT2_PATH` environment variable (if set)
2. `./user_scripts` directory (fallback)

### Setting WIN_SCRIPT2_PATH
```bash
# Windows
set WIN_SCRIPT2_PATH=D:\path\to\your\scripts

# Or use the provided setup script
./setup_environment.bat
```

## Script Structure

### Directory Layout
```
user_scripts/
├── built_in_scripts/
│   ├── system_info.rhai
│   ├── greeting_script.rhai
│   └── html_demo.rhai
└── custom_scripts/
    └── your_scripts.rhai
```

### Script Metadata
Scripts are automatically categorized with metadata:
- **Name**: Derived from filename
- **Description**: Auto-generated or from script comments
- **Category**: Based on directory structure
- **ID**: Unique identifier for execution

## Keyboard Shortcuts

### Global Navigation
| Key | Action |
|-----|--------|
| `↑/↓` | Navigate through scripts |
| `Enter` | Execute selected script |
| `Escape` | Clear search / Reset selection |
| `Q` | Quit script execution (immediate) |

### Script Search
- **Type to Search**: Filter scripts by name
- **Persistent Focus**: Input stays focused during navigation
- **Auto-complete Disabled**: Clean typing experience

## Technology Stack

### Frontend
- **SolidJS**: Reactive JavaScript framework
- **TypeScript**: Type-safe development
- **CSS**: Professional VS Code-inspired styling

### Backend
- **Tauri v2**: Modern desktop app framework
- **Rust**: System-level performance and security
- **Rhai v1.17**: Embedded scripting engine

### Key Libraries
- **Script Management**: Custom Rust-based script discovery
- **UI Kit Integration**: Enhanced Rhai scripting capabilities
- **Event System**: Global keyboard and UI event handling

## Development

### Project Structure
```
src/
├── components/          # UI components
│   └── ScriptSearch.tsx # Main script selection interface
├── UIController/        # Script execution interface
├── services/           # Business logic
├── hooks/             # Custom SolidJS hooks
└── App.tsx           # Main application component

src-tauri/
├── src/
│   ├── lib.rs        # Tauri commands and script execution
│   └── main.rs       # Application entry point
└── Cargo.toml       # Rust dependencies
```

### Building for Production
```bash
# Build the application
pnpm tauri build

# Output will be in src-tauri/target/release/
```

### Recommended IDE Setup
- [VS Code](https://code.visualstudio.com/) + [Tauri](https://marketplace.visualstudio.com/items?itemName=tauri-apps.tauri-vscode) + [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)

## Contributing

### Development Setup
1. Follow the Quick Start guide
2. Make your changes
3. Test with `pnpm tauri dev`
4. Build with `pnpm tauri build`

### Code Style
- **TypeScript**: Strict typing enabled
- **Rust**: Follow standard Rust conventions
- **Components**: Functional components with SolidJS patterns

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues, questions, or contributions, please use the project's issue tracker.

---

**WinScript2** - Professional Rhai scripting environment with modern desktop UI.
