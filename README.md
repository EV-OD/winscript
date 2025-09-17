# WinScript2 - Rhai Scripting Platform

A modern desktop application built with Tauri and SolidJS that provides a professional scripting environment using the Rhai scripting language.

## Features

### 🚀 **Core Functionality**
- **Rhai Script Execution**: Run Rhai scripts with full language support
- **Interactive UI**: Dynamic user interface components for script interaction
- **Environment Variables**: Configurable script paths via `WIN_SCRIPT2_PATH`
- **Script Discovery**: Automatic detection and categorization of scripts

### ⚡ **Enhanced User Experience**
- **Keyboard Navigation**: Full keyboard control with arrow keys
- **Persistent Focus Management**: Inputs stay focused for seamless navigation
- **Auto-complete Disabled**: Clean input fields without browser suggestions
- **Instant Script Termination**: Press `Q` to immediately return to script selection

### 🎨 **Professional Interface**
- **VS Code Dark Theme**: Consistent professional styling
- **Script Search**: Type-to-filter script discovery
- **Real-time Feedback**: Loading states and execution status
- **Responsive Design**: Clean, modern UI components

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
