# Contributing to SnapRun

Thank you for your interest in contributing to SnapRun! This document provides guidelines and information for contributors to help make the process smooth and effective.

## 🌟 Ways to Contribute

### 🐛 Report Bugs
- Use [GitHub Issues](https://github.com/EV-OD/winscript/issues) to report bugs
- Search existing issues before creating new ones
- Provide detailed reproduction steps
- Include system information and SnapRun version

### 💡 Suggest Features 
- Use [GitHub Discussions](https://github.com/EV-OD/winscript/discussions) for feature ideas
- Explain the use case and benefits
- Consider implementation complexity
- Gather community feedback

### 📝 Improve Documentation
- Fix typos and clarify instructions
- Add examples and tutorials
- Update API documentation
- Create user guides and walkthroughs

### 🔧 Submit Code
- Bug fixes and improvements
- New Rhai functions and APIs
- UI enhancements
- Performance optimizations

### 🎯 Create Scripts
- Example scripts for common tasks
- Educational scripts for learning Rhai
- Template scripts for different use cases
- Advanced automation examples

## 🚀 Getting Started

### Prerequisites

**Required Tools**:
- [Rust](https://rustup.rs/) (latest stable version)
- [Node.js](https://nodejs.org/) (LTS version)
- [pnpm](https://pnpm.io/) (recommended) or npm
- [Git](https://git-scm.com/)

**Optional Tools**:
- [Visual Studio Code](https://code.visualstudio.com/) with Rust extensions
- [Inno Setup](https://jrsoftware.org/isinfo.php) for building installers

### Setting Up Development Environment

1. **Fork and Clone**
   ```bash
   git clone https://github.com/yourusername/winscript.git
   cd winscript
   ```

2. **Install Dependencies**
   ```bash
   # Frontend dependencies
   pnpm install
   
   # Rust dependencies (automatically handled by Cargo)
   cd src-tauri
   cargo check
   ```

3. **Run Development Server**
   ```bash
   # From project root
   pnpm tauri dev
   ```

4. **Verify Installation**
   - Application should open with hot-reload enabled
   - Changes to frontend code should reflect immediately
   - Changes to Rust code require restart

### Project Structure

```
SnapRun/
├── src/                    # React/TypeScript frontend
│   ├── components/         # React components
│   ├── hooks/             # Custom React hooks
│   ├── services/          # Frontend services
│   └── ThemedComponents/  # UI component library
├── src-tauri/             # Rust backend
│   ├── src/
│   │   ├── lib.rs         # Main application logic
│   │   ├── script_manager.rs # Script handling
│   │   ├── fs_kit.rs      # File system operations
│   │   ├── process_kit.rs # Process management
│   │   └── rhai_engine.rs # Rhai integration
│   └── Cargo.toml         # Rust dependencies
├── public/                # Static assets
├── installer/             # Installer resources
└── scripts/               # Built-in example scripts
```

## 📋 Contribution Guidelines

### Code Style

**Rust Code**:
- Follow [Rust style guidelines](https://doc.rust-lang.org/style-guide/)
- Use `rustfmt` for formatting: `cargo fmt`
- Use `clippy` for linting: `cargo clippy`
- Write descriptive variable and function names
- Add documentation comments for public functions

```rust
/// Reads file content and returns it as a string
/// 
/// # Arguments
/// * `file_path` - Path to the file to read
/// 
/// # Returns
/// * `Result<String, String>` - File content or error message
fn read_file_content(file_path: &str) -> Result<String, String> {
    // Implementation
}
```

**TypeScript/React Code**:
- Use TypeScript for type safety
- Follow React best practices
- Use functional components with hooks
- Use meaningful component and variable names
- Add JSDoc comments for complex functions

```typescript
/**
 * Hook for managing keyboard shortcuts
 * @param shortcuts - Object mapping keys to callback functions
 */
export const useKeyboardShortcuts = (
    shortcuts: Record<string, () => void>
) => {
    // Implementation
};
```

**General Guidelines**:
- Keep functions small and focused
- Use descriptive commit messages
- Include tests when appropriate
- Update documentation for API changes

### Commit Messages

Use clear, descriptive commit messages:

```
feat: add new file encryption function to Rhai API
fix: resolve system tray icon not updating on Windows 11
docs: update API reference for process management functions
refactor: simplify script loading logic in script_manager
test: add unit tests for file system operations
```

**Format**: `type: description`

**Types**:
- `feat`: New features
- `fix`: Bug fixes
- `docs`: Documentation changes
- `style`: Formatting changes
- `refactor`: Code restructuring
- `test`: Adding/updating tests
- `chore`: Build process or tooling changes

### Pull Request Process

1. **Create Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Changes**
   - Implement your changes
   - Test thoroughly
   - Update documentation

3. **Test Your Changes**
   ```bash
   # Run development version
   pnpm tauri dev
   
   # Build and test
   pnpm tauri build
   
   # Run any tests
   cargo test
   ```

4. **Create Pull Request**
   - Push your branch to your fork
   - Create PR against `main` branch
   - Fill out PR template completely
   - Link related issues

5. **PR Review Process**
   - Maintainers will review your code
   - Address feedback and requested changes
   - Keep PR updated with main branch
   - PR will be merged when approved

### Testing

**Manual Testing**:
- Test on Windows 10 and 11 if possible
- Verify system tray functionality
- Test global shortcuts
- Validate script execution
- Check UI responsiveness

**Automated Testing**:
```bash
# Rust tests
cd src-tauri
cargo test

# Frontend tests (if available)
pnpm test
```

**Testing Checklist**:
- [ ] Feature works as expected
- [ ] No regression in existing functionality
- [ ] UI is responsive and accessible
- [ ] System tray and shortcuts work
- [ ] Scripts execute correctly
- [ ] Build process completes successfully

## 🔧 Development Tasks

### Adding New Rhai Functions

1. **Define Function in Rust**
   ```rust
   // In appropriate kit file (fs_kit.rs, process_kit.rs, etc.)
   pub fn my_new_function(param: String) -> Result<String, Box<EvalAltResult>> {
       // Implementation
       Ok("result".to_string())
   }
   ```

2. **Register Function in Rhai Engine**
   ```rust
   // In rhai_engine.rs
   engine.register_fn("my_function", my_new_function);
   ```

3. **Update Documentation**
   - Add function to [API_REFERENCE.md](API_REFERENCE.md)
   - Include usage examples
   - Update [FEATURES.md](FEATURES.md) if appropriate

4. **Create Example Script**
   ```rhai
   // In scripts/built_in_scripts/
   let result = my_function("test input");
   print("Result: " + result);
   ```

### Improving UI Components

1. **Create/Modify Component**
   ```typescript
   // In src/components/
   export const MyComponent: React.FC<Props> = ({ prop1, prop2 }) => {
       return (
           <div className="themed-component">
               {/* Component content */}
           </div>
       );
   };
   ```

2. **Update Styles**
   ```css
   /* In appropriate CSS file */
   .themed-component {
       background: var(--glass-background);
       border: 1px solid var(--glass-border);
       border-radius: 8px;
   }
   ```

3. **Test Responsiveness**
   - Test different window sizes
   - Verify glass effects work
   - Check dark theme compatibility

### Building Installers

**Development Build**:
```bash
pnpm tauri build
```

**Production Release**:
```bash
# Build all installer types
pnpm run release:full
```

**Individual Installers**:
```bash
# MSI installer
pnpm run build:msi

# NSIS installer  
pnpm run build:nsis

# Inno Setup installer
pnpm run build:inno
```

## 📚 Resources

### Documentation
- [Tauri Documentation](https://tauri.app/v1/guides/) - Framework documentation
- [Rhai Book](https://rhai.rs/book/) - Scripting language reference
- [React Documentation](https://react.dev/) - Frontend framework
- [Rust Book](https://doc.rust-lang.org/book/) - Rust programming language

### Tools
- [Visual Studio Code](https://code.visualstudio.com/) with extensions:
  - Rust Analyzer
  - ES7+ React/Redux/React-Native snippets
  - Prettier
  - GitLens
- [Rust Playground](https://play.rust-lang.org/) - Online Rust testing
- [Rhai Playground](https://rhai.rs/playground/) - Online Rhai testing

### Community
- [GitHub Discussions](https://github.com/EV-OD/winscript/discussions) - Questions and ideas
- [GitHub Issues](https://github.com/EV-OD/winscript/issues) - Bug reports and feature requests
- [Tauri Discord](https://discord.gg/tauri) - Framework support
- [Rust Community](https://www.rust-lang.org/community) - General Rust help

## 🛡️ Code of Conduct

### Our Standards

**Positive behavior includes**:
- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what's best for the community
- Showing empathy towards other community members

**Unacceptable behavior includes**:
- Harassment, discrimination, or offensive comments
- Public or private harassment
- Publishing private information without permission
- Other conduct inappropriate in a professional setting

### Enforcement

Report inappropriate behavior to the project maintainers. All complaints will be reviewed and investigated promptly and fairly.

Project maintainers who don't follow the Code of Conduct may face temporary or permanent consequences.

## 🏆 Recognition

Contributors are recognized in several ways:

### Contributors File
All contributors are listed in [CONTRIBUTORS.md](CONTRIBUTORS.md) with their contributions.

### Release Notes
Significant contributions are highlighted in release notes and changelogs.

### Special Recognition
- First-time contributors get special welcome
- Regular contributors may be invited as collaborators
- Outstanding contributions are featured in project updates

## ❓ Getting Help

### For Contributors
- Read this guide thoroughly
- Check existing issues and PRs
- Ask questions in [GitHub Discussions](https://github.com/EV-OD/winscript/discussions)
- Reach out to maintainers for guidance

### For Users
- Use [GitHub Issues](https://github.com/EV-OD/winscript/issues) for bugs
- Use [GitHub Discussions](https://github.com/EV-OD/winscript/discussions) for questions
- Check [FAQ.md](FAQ.md) for common questions
- Review documentation in [DOCS.md](DOCS.md)

## 📄 License

By contributing to SnapRun, you agree that your contributions will be licensed under the same [MIT License](LICENSE) that covers the project.

---

Thank you for contributing to SnapRun! Your efforts help make Windows automation more accessible and powerful for everyone. 🚀
