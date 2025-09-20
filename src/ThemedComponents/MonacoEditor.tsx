import { Component, createSignal, onMount, createEffect } from 'solid-js';
import { MonacoEditor as SolidMonacoEditor } from 'solid-monaco';
import './ThemedComponents.css';

export interface MonacoEditorProps {
  initialContent?: string;
  filePath?: string;
  language?: string;
  onContentChange?: (content: string) => void;
  onSave?: (content: string) => void;
  readOnly?: boolean;
  theme?: 'vs-dark' | 'vs-light' | 'hc-black';
}

const MonacoEditor: Component<MonacoEditorProps> = (props) => {
  const [content, setContent] = createSignal(props.initialContent || '');
  const [editor, setEditor] = createSignal<any>(null);
  
  // Detect language from file extension if not provided
  const getLanguageFromPath = (filePath?: string): string => {
    if (!filePath) return 'plaintext';
    
    const extension = filePath.split('.').pop()?.toLowerCase();
    switch (extension) {
      case 'js': return 'javascript';
      case 'ts': return 'typescript';
      case 'jsx': return 'javascript';
      case 'tsx': return 'typescript';
      case 'py': return 'python';
      case 'rs': return 'rust';
      case 'rhai': return 'javascript'; // Treat Rhai as JavaScript for syntax highlighting
      case 'json': return 'json';
      case 'html': return 'html';
      case 'css': return 'css';
      case 'md': return 'markdown';
      case 'xml': return 'xml';
      case 'yaml': case 'yml': return 'yaml';
      case 'toml': return 'toml';
      case 'sh': case 'bash': return 'shell';
      case 'ps1': return 'powershell';
      case 'sql': return 'sql';
      case 'cpp': case 'cc': case 'cxx': return 'cpp';
      case 'c': return 'c';
      case 'cs': return 'csharp';
      case 'java': return 'java';
      case 'go': return 'go';
      case 'php': return 'php';
      case 'rb': return 'ruby';
      case 'swift': return 'swift';
      case 'kt': return 'kotlin';
      case 'dart': return 'dart';
      default: return 'plaintext';
    }
  };

  const language = () => props.language || getLanguageFromPath(props.filePath);

  // Handle content changes
  const handleContentChange = (newContent: string) => {
    setContent(newContent);
    props.onContentChange?.(newContent);
  };

  // Handle Ctrl+S save
  const handleSave = () => {
    props.onSave?.(content());
  };

  // Setup keyboard shortcuts
  onMount(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.ctrlKey && e.key === 's') {
        e.preventDefault();
        handleSave();
      }
    };

    document.addEventListener('keydown', handleKeyDown);
    
    return () => {
      document.removeEventListener('keydown', handleKeyDown);
    };
  });

  // Update content when initialContent prop changes
  createEffect(() => {
    if (props.initialContent !== undefined) {
      setContent(props.initialContent);
    }
  });

  return (
    <div class="monaco-editor-container">
      <div class="monaco-editor-header">
        <div class="monaco-editor-title">
          {props.filePath ? (
            <span class="file-path">
              <span class="file-icon">•</span>
              {props.filePath}
            </span>
          ) : (
            <span class="untitled-file">
              <span class="file-icon">○</span>
              Untitled
            </span>
          )}
        </div>
        <button 
          class="save-button"
          onClick={handleSave}
          title="Save (Ctrl+S)"
        >
          Save
        </button>
      </div>
      
      <SolidMonacoEditor
        value={content()}
        language={language()}
        theme="snaprun-dark"
        onChange={(value) => handleContentChange(value)}
        width="100%"
        height="calc(100% - 60px)"
        options={{
          readOnly: props.readOnly || false,
          fontSize: 14,
          fontFamily: "'Consolas', 'Monaco', 'Courier New', monospace",
          lineNumbers: 'on',
          minimap: { enabled: false },
          scrollBeyondLastLine: false,
          wordWrap: 'on',
          automaticLayout: true,
          tabSize: 2,
          insertSpaces: true,
          renderWhitespace: 'selection',
          cursorSmoothCaretAnimation: 'on',
          smoothScrolling: true,
          mouseWheelZoom: true,
          contextmenu: true,
          selectOnLineNumbers: true,
          roundedSelection: false,
          padding: { top: 16, bottom: 16 },
          scrollbar: {
            vertical: 'auto',
            horizontal: 'auto',
            useShadows: false,
            verticalHasArrows: false,
            horizontalHasArrows: false,
            verticalScrollbarSize: 8,
            horizontalScrollbarSize: 8,
          },
        }}
        onMount={(monaco, editorInstance) => {
          setEditor(editorInstance);
          
          // Define a custom dark theme that matches our app
          monaco.editor.defineTheme('snaprun-dark', {
            base: 'vs-dark',
            inherit: true,
            rules: [
              // Default text
              { token: '', foreground: 'ffffff' },
              
              // Comments
              { token: 'comment', foreground: '7c7c7c', fontStyle: 'italic' },
              
              // Keywords
              { token: 'keyword', foreground: 'c792ea' },
              { token: 'keyword.control', foreground: 'c792ea' },
              { token: 'keyword.operator', foreground: '89ddff' },
              
              // Strings
              { token: 'string', foreground: 'c3e88d' },
              
              // Numbers
              { token: 'number', foreground: 'f78c6c' },
              
              // Functions
              { token: 'identifier.function', foreground: '82aaff' },
              { token: 'entity.name.function', foreground: '82aaff' },
              
              // Variables
              { token: 'identifier', foreground: 'ffffff' },
              { token: 'variable', foreground: 'ffffff' },
              
              // Operators
              { token: 'operator', foreground: '89ddff' },
              { token: 'delimiter', foreground: '89ddff' },
              
              // Types
              { token: 'type', foreground: 'ffcb6b' },
              { token: 'type.identifier', foreground: 'ffcb6b' },
              
              // Constants
              { token: 'constant', foreground: 'f78c6c' },
              
              // Tags (for markup)
              { token: 'tag', foreground: 'f07178' },
              { token: 'attribute.name', foreground: 'c792ea' },
              { token: 'attribute.value', foreground: 'c3e88d' },
            ],
            colors: {
              'editor.background': '#121629',
              'editor.foreground': '#ffffff',
              'editorCursor.foreground': '#ffffff',
              'editor.lineHighlightBackground': '#2a2f4a',
              'editorLineNumber.foreground': '#9999ff',
              'editor.selectionBackground': '#4d5470',
              'editor.selectionHighlightBackground': '#3a3f5a',
              'scrollbarSlider.background': '#4d4d4d',
              'scrollbarSlider.hoverBackground': '#6d6d6d',
              'scrollbarSlider.activeBackground': '#8d8d8d',
            }
          });
          
          // Apply the custom theme
          monaco.editor.setTheme('snaprun-dark');
          
          // Custom save action
          editorInstance.addAction({
            id: 'save-file',
            label: 'Save File',
            keybindings: [monaco.KeyMod.CtrlCmd | monaco.KeyCode.KeyS],
            precondition: undefined,
            keybindingContext: undefined,
            contextMenuGroupId: 'modification',
            contextMenuOrder: 1.5,
            run: () => {
              handleSave();
            }
          });
        }}
      />
    </div>
  );
};

export default MonacoEditor;
