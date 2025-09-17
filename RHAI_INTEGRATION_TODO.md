# 📋 **Rhai Integration Todo - Detailed Implementation Plan**

## 🎯 **Phase 1: Foundation Setup**

### **Step 1.1: Add Rhai Dependency**
- [x] Add `rhai = "1.17"` to `Cargo.toml`
- [x] Add `tokio = { version = "1.0", features = ["rt", "macros"] }` if not present
- [x] **Verification**: `cargo check` compiles without errors

### **Step 1.2: Create Rhai Engine Module**
- [x] Create `src-tauri/src/rhai_engine.rs`
- [x] Implement basic `RhaiScriptRunner` struct
- [x] Add to `src-tauri/src/lib.rs`: `mod rhai_engine;`
- [x] **Verification**: Module compiles and can be imported

```rust
// Template for rhai_engine.rs
use rhai::{Engine, Scope, EvalAltResult};

pub struct RhaiScriptRunner {
    engine: Engine,
}

impl RhaiScriptRunner {
    pub fn new() -> Self {
        let mut engine = Engine::new();
        // Setup will be added in next steps
        Self { engine }
    }
}
```

## 🛠️ **Phase 2: Kit Integration**

### **Step 2.1: Create Sync Kit Wrappers**
- [ ] Add sync wrapper methods to `Kit` struct in `ui_kit.rs`
- [ ] Implement `ask_input_sync()`, `ask_select_sync()`, `ask_number_sync()`
- [ ] Implement `render_html_sync()`, `show_message_sync()`
- [ ] **Verification**: All sync methods compile and can block on async calls

```rust
// Template additions to Kit
impl Kit {
    pub fn ask_input_sync(&mut self, message: &str) -> String {
        // Use tokio::task::block_in_place to handle async in sync context
        tokio::task::block_in_place(|| {
            tokio::runtime::Handle::current().block_on(async {
                self.ask_input(message).await.unwrap_or_default()
            })
        })
    }
    // ... other sync methods
}
```

### **Step 2.2: Register Kit Functions with Rhai**
- [x] Create `register_kit_functions()` method in `RhaiScriptRunner`
- [x] Register all sync Kit methods with Rhai engine
- [x] Handle Rhai array conversion for select options
- [x] **Verification**: Rhai can call registered functions without panics

## 🎮 **Phase 3: Script Management**

### **Step 3.1: Script File Structure**
- [ ] Create `user_scripts/` directory in project root
- [ ] Create `built_in_scripts/` subdirectory for default scripts
- [ ] Create `custom_scripts/` subdirectory for user scripts
- [ ] **Verification**: Directory structure exists and is accessible

```
tauri-app/
├── user_scripts/
│   ├── built_in_scripts/
│   │   ├── greeting.rhai
│   │   └── html_demo.rhai
│   └── custom_scripts/
│       └── (user creates files here)
```

### **Step 3.2: Script Discovery System**
- [ ] Create `ScriptManager` struct to handle script discovery
- [ ] Implement `load_scripts()` to scan directories
- [ ] Create `ScriptMetadata` struct for script info
- [ ] **Verification**: Can discover and list available `.rhai` files

```rust
// Template for script manager
pub struct ScriptManager {
    pub scripts: Vec<ScriptInfo>,
}

pub struct ScriptInfo {
    pub id: String,
    pub name: String,
    pub description: String,
    pub file_path: PathBuf,
    pub category: String,
}
```

## 🔌 **Phase 4: Tauri Command Integration**

### **Step 4.1: Create Rhai Execution Command**
- [ ] Add `#[tauri::command] run_rhai_script()` to `src-tauri/src/lib.rs`
- [ ] Implement script loading from file system
- [ ] Add error handling for script execution
- [ ] **Verification**: Can execute simple Rhai script via Tauri command

### **Step 4.2: Script Listing Command**
- [ ] Add `#[tauri::command] list_rhai_scripts()` to `src-tauri/src/lib.rs`  
- [ ] Return available scripts with metadata
- [ ] Handle script discovery errors gracefully
- [ ] **Verification**: Frontend can receive script list

### **Step 4.3: Update Invoke Handler**
- [ ] Add new commands to `generate_handler![]` in `src-tauri/src/lib.rs`
- [ ] **Verification**: All commands are accessible from frontend

```rust
// Updated lib.rs template
.invoke_handler(tauri::generate_handler![
    greet, 
    ui_response, 
    demo_ui_controller, 
    demo_kit_usage, 
    greeting_script,           // Keep existing Rust scripts
    html_demo_script,          // Keep existing Rust scripts  
    run_rhai_script,           // New Rhai execution
    list_rhai_scripts          // New Rhai discovery
])
```

## 🖥️ **Phase 5: Frontend Integration**

### **Step 5.1: Update Script Search**
- [ ] Modify `ScriptSearch.tsx` to load both Rust and Rhai scripts
- [ ] Add script type indicator (Rust vs Rhai)
- [ ] Update script execution logic to handle both types
- [ ] **Verification**: Both script types appear in search results

### **Step 5.2: Update UIService**
- [ ] Add `runRhaiScript()` method to `UIService.ts`
- [ ] Add `listRhaiScripts()` method to `UIService.ts`
- [ ] **Verification**: Frontend can call new Rhai commands

## 📝 **Phase 6: Default Rhai Scripts**

### **Step 6.1: Convert Existing Scripts**
- [ ] Create `user_scripts/built_in_scripts/greeting.rhai`
- [ ] Create `user_scripts/built_in_scripts/html_demo.rhai`
- [ ] Test scripts produce same output as Rust versions
- [ ] **Verification**: Rhai scripts work identically to Rust versions

### **Step 6.2: Create Sample Scripts**
- [ ] Create `user_scripts/built_in_scripts/simple_todo.rhai`
- [ ] Create `user_scripts/built_in_scripts/calculator.rhai`
- [ ] **Verification**: New scripts demonstrate Rhai capabilities

## 🧪 **Phase 7: Testing & Validation**

### **Step 7.1: Error Handling**
- [ ] Test Rhai syntax errors are handled gracefully
- [ ] Test file not found errors
- [ ] Test runtime errors in Rhai scripts
- [ ] **Verification**: No crashes, all errors shown to user

### **Step 7.2: Performance Testing**
- [ ] Compare Rhai vs Rust script execution time
- [ ] Test with large HTML generation
- [ ] Test with many user inputs
- [ ] **Verification**: Acceptable performance for typical use cases

### **Step 7.3: Integration Testing**
- [ ] Test script discovery after adding new files
- [ ] Test hot-reload by modifying existing script
- [ ] Test script execution with UIController flow
- [ ] **Verification**: Complete user workflow functions end-to-end

## 🚀 **Phase 8: Documentation & Polish**

### **Step 8.1: User Documentation**
- [ ] Create `USER_SCRIPTS.md` with Rhai syntax guide
- [ ] Document available Kit functions for users
- [ ] Provide script templates and examples
- [ ] **Verification**: New user can write working script from docs

### **Step 8.2: Developer Documentation**
- [ ] Document how to add new Kit functions
- [ ] Document script discovery mechanism
- [ ] Update README with Rhai integration info
- [ ] **Verification**: Developer can extend Kit following docs

## ✅ **Verification Checklist**

After completion, verify:
- [ ] **Backward Compatibility**: Original Rust scripts still work
- [ ] **New Functionality**: Users can drop `.rhai` files and run them
- [ ] **Error Handling**: Graceful failure for bad scripts
- [ ] **Performance**: Acceptable speed for interactive scripts
- [ ] **User Experience**: Seamless integration in search interface

---

## 📊 **Success Metrics**

- [ ] **Build Time**: No significant increase in compile time
- [ ] **Bundle Size**: Minimal increase in executable size
- [ ] **Runtime Memory**: Reasonable memory usage for Rhai engine
- [ ] **User Adoption**: Easy for users to create first script in <5 minutes

This todo provides step-by-step verification points to ensure each phase works before moving to the next! 🎯

---

## 🔄 **Progress Tracking**

### **Completed Phases**
- [x] Phase 1: Foundation Setup
- [x] Phase 2: Kit Integration
- [ ] Phase 3: Script Management
- [ ] Phase 3: Script Management
- [ ] Phase 4: Tauri Command Integration
- [ ] Phase 5: Frontend Integration
- [ ] Phase 6: Default Rhai Scripts
- [ ] Phase 7: Testing & Validation
- [ ] Phase 8: Documentation & Polish

### **Current Status**
- **Started**: [Date]
- **Current Phase**: Phase 1
- **Estimated Completion**: [Target Date]
- **Blockers**: None

### **Notes**
- Add any implementation notes, decisions, or issues encountered during development
- Track performance benchmarks and optimization opportunities
- Document any deviations from the original plan
