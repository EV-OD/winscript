# SnapRun - Rhai Scripting Platform

**Automate your Windows tasks with ease.** SnapRun is a user-friendly desktop application that lets you write and run scripts to automate repetitive tasks, manage system operations, and enhance your productivity.

## What Can You Do?

### 🎯 **Everyday Automation**
- **System Information**: Get detailed hardware and software reports
- **File Operations**: Batch rename, organize, and process files with comprehensive file system API
- **Markdown Documents**: Create and render rich markdown content with live preview
- **System Tasks**: Automate routine maintenance and monitoring
- **Custom Workflows**: Create personalized automation scripts

### ✨ **Why Choose SnapRun?**
- **Easy to Use**: Clean, intuitive interface - no command line required
- **Rich Content**: Built-in markdown rendering with glass-styled dark theme
- **File System Power**: Complete file and directory operations from scripts
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
- **Launch the App** - Double-click to open SnapRun
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
| `Ctrl+Shift+J` | Show SnapRun window from system tray |
| `Ctrl+W` | Hide SnapRun window to system tray |

### 📝 **Rhai Scripting Features**

#### **File System Operations**
Complete file and directory management directly from your scripts:
```rhai
// File operations
let content = read_file("path/to/file.txt");
write_file("output.txt", "Hello World!");
append_file("log.txt", "New log entry\n");

// Directory operations
create_dir_all("path/to/nested/dirs");
list_files("./documents");
file_exists("important.txt");

// Path utilities
let home = home_dir();
let docs = path_join(home, "Documents");
let filename = path_filename("/path/to/file.txt");
```

#### **Markdown Rendering**
Create rich documentation and reports with live preview:
```rhai
// Quick markdown rendering
md("# Hello World\n\nThis is **bold** text!");

// Full markdown rendering
render_markdown("
# My Report
- Item 1
- Item 2

```code
let x = 42;
```
");
```

#### **UI Interactions**
Interactive script elements with glass-styled interface:
```rhai
// Get user input
let name = ask_text("Enter your name:");
let age = ask_number("Enter your age:");
let choice = ask_select("Choose option:", ["A", "B", "C"]);

// Display results
show_message("Result", "Processing complete!");
render_html("<h1>Custom HTML Content</h1>");
```

### 🎛️ **Script Organization**
Scripts are automatically organized into categories:
- **Built-in Scripts**: Ready-to-use examples and utilities
- **System Scripts**: Hardware and software information tools
- **Custom Scripts**: Your personal automation scripts

---

## Technical Documentation

### 🔧 **For Developers & Advanced Users**

SnapRun is built with modern technologies for performance, security, and extensibility.

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
- **File System Kit**: Complete CRUD operations (read, write, create, delete files/directories)
- **Markdown Rendering**: Live markdown preview with pulldown-cmark parser and glass UI
- **UI Kit Integration**: Enhanced Rhai scripting capabilities with rich UI components
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
│   ├── system_info.rhai          # System hardware/software info
│   ├── greeting_script.rhai      # Simple greeting demo
│   ├── file_system_demo.rhai     # File operations showcase
│   ├── markdown_demo.rhai        # Comprehensive markdown examples
│   ├── quick_md_test.rhai        # Quick markdown test
│   ├── log_manager.rhai          # Log file management
│   ├── calculator.rhai           # Interactive calculator
│   ├── file_organizer.rhai       # Batch file operations
│   └── html_demo.rhai           # HTML rendering demo
└── custom_scripts/
    ├── todo_list_creator.rhai    # Task management
    └── your_scripts.rhai         # Your custom scripts
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
- **Script Management**: Custom Rust-based script discovery and categorization
- **File System Kit**: Cross-platform file operations with `dirs` crate integration
- **Markdown Parser**: `pulldown-cmark` for CommonMark-compliant rendering
- **UI Kit Integration**: Enhanced Rhai scripting with interactive UI components
- **Event System**: Global keyboard and UI event handling with focus persistence

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

## Example Scripts

### 📁 **File System Automation**
```rhai
// Organize downloads folder
print("🗂️ Organizing Downloads...");

let downloads = path_join(home_dir(), "Downloads");
let organized = path_join(downloads, "Organized");

// Create organized folders
create_dir_all(path_join(organized, "Images"));
create_dir_all(path_join(organized, "Documents"));
create_dir_all(path_join(organized, "Archives"));

// Process files
let files = list_files(downloads);
for file in files {
    if file.contains(".jpg") || file.contains(".png") {
        // Move images
        let dest = path_join(organized, "Images", path_filename(file));
        copy_file(file, dest);
    }
}

print("✅ Downloads organized successfully!");
```

### 📊 **System Report with Markdown**
```rhai
// Generate system report
print("📊 Generating System Report...");

let report = "# System Report\n\n";
report += "## Current Directory\n";
report += "📁 " + current_dir() + "\n\n";

report += "## Home Directory\n";
report += "🏠 " + home_dir() + "\n\n";

report += "## Temporary Directory\n"; 
report += "🗂️ " + temp_dir() + "\n\n";

report += "## Available Scripts\n";
let scripts = list_files("./user_scripts/built_in_scripts");
for script in scripts {
    report += "- " + path_filename(script) + "\n";
}

// Render the report
md(report);
```

### 📝 **Interactive Todo Manager**
```rhai
print("📝 Todo List Manager");

let todos = [];
loop {
    let action = ask_select("Choose action:", [
        "Add Todo", 
        "View Todos", 
        "Save to File", 
        "Exit"
    ]);
    
    if action == "Add Todo" {
        let todo = ask_text("Enter todo item:");
        todos.push("- [ ] " + todo);
        print("✅ Added: " + todo);
    }
    else if action == "View Todos" {
        let content = "# My Todo List\n\n" + todos.join("\n");
        md(content);
    }
    else if action == "Save to File" {
        let filename = ask_text("Filename (without .md):");
        let content = "# Todo List\n\n" + todos.join("\n");
        write_file(filename + ".md", content);
        print("💾 Saved to " + filename + ".md");
    }
    else {
        break;
    }
}
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

**SnapRun** - Professional Rhai scripting environment with modern desktop UI.
