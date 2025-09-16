import { createSignal, Component, Show } from 'solid-js';
import { Search } from 'lucide-solid';
import './ScriptSearch.css';

// Dummy script data
const DUMMY_SCRIPTS = [
  'File Organizer - Organize files by type and date',
  'System Cleanup - Clean temporary files and cache',
  'Backup Manager - Create automated backups',
  'Network Scanner - Scan network for devices', 
  'Password Generator - Generate secure passwords',
  'Image Resizer - Batch resize images',
  'Log Analyzer - Analyze system logs',
  'Disk Usage - Check disk space usage',
  'Process Monitor - Monitor running processes',
  'Environment Setup - Setup development environment',
  'Database Backup - Backup database files',
  'Text Replacer - Find and replace in multiple files'
];

type ScriptSearchProps = {
  onScriptSelect?: (script: string) => void;
};

export const ScriptSearch: Component<ScriptSearchProps> = (props) => {
  const [searchValue, setSearchValue] = createSignal('');
  const [showResults, setShowResults] = createSignal(false);

  const filteredScripts = () => {
    const query = searchValue().toLowerCase().trim();
    if (!query) return [];
    return DUMMY_SCRIPTS.filter(script =>
      script.toLowerCase().includes(query)
    );
  };

  const handleInput = (value: string) => {
    setSearchValue(value);
    setShowResults(value.trim().length > 0);
  };

  const handleSelectScript = (script: string) => {
    setSearchValue(script.split(' - ')[0]); // Set just the script name
    setShowResults(false);
    if (props.onScriptSelect) {
      props.onScriptSelect(script);
    }
  };

  const handleSearch = () => {
    const scripts = filteredScripts();
    if (scripts.length > 0) {
      handleSelectScript(scripts[0]);
    }
  };

  const handleKeyPress = (e: KeyboardEvent) => {
    if (e.key === 'Enter') {
      handleSearch();
    }
    if (e.key === 'Escape') {
      setShowResults(false);
    }
  };

  return (
    <div class="script-search-container">
      <div class="search-input-wrapper">
        <input
          class="script-search-input"
          type="text"
          value={searchValue()}
          onInput={(e) => handleInput(e.currentTarget.value)}
          onKeyPress={handleKeyPress}
          onFocus={() => searchValue().trim() && setShowResults(true)}
          placeholder="Search for scripts..."
        />
        <button 
          class="search-button"
          onClick={handleSearch}
          title="Search"
        >
          <Search size={20} />
        </button>
      </div>

      <Show when={showResults() && filteredScripts().length > 0}>
        <div class="search-results">
          {filteredScripts().map((script) => (
            <div
              class="search-result-item"
              onClick={() => handleSelectScript(script)}
            >
              <div class="script-name">{script.split(' - ')[0]}</div>
              <div class="script-description">{script.split(' - ')[1]}</div>
            </div>
          ))}
        </div>
      </Show>
    </div>
  );
};
