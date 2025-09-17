import { Component, createSignal, For, onMount, Show } from 'solid-js';
import { invoke } from '@tauri-apps/api/core';
import { UIService, ScriptInfo } from '../services/UIService';

type ScriptSearchProps = {
  onScriptSelect: (script: string) => void;
};

export const ScriptSearch: Component<ScriptSearchProps> = (props) => {
  const [searchQuery, setSearchQuery] = createSignal('');
  const [selectedIndex, setSelectedIndex] = createSignal(0);
  const [isLoading, setIsLoading] = createSignal(false);
  const [rhaiScripts, setRhaiScripts] = createSignal<ScriptInfo[]>([]);
  const [scriptsLoaded, setScriptsLoaded] = createSignal(false);

  // Load Rhai scripts on mount
  onMount(async () => {
    try {
      setIsLoading(true);
      const scripts = await UIService.listRhaiScripts();
      setRhaiScripts(scripts);
      setScriptsLoaded(true);
      console.log('📜 ScriptSearch: Loaded Rhai scripts:', scripts);
    } catch (error) {
      console.error('📜 ScriptSearch: Failed to load Rhai scripts:', error);
    } finally {
      setIsLoading(false);
    }
  });

  // Filter scripts based on search query
  const filteredScripts = () => {
    const query = searchQuery().toLowerCase();
    if (!query) return rhaiScripts();
    
    return rhaiScripts().filter(script => 
      script.name.toLowerCase().includes(query) ||
      script.description.toLowerCase().includes(query) ||
      (script.category && script.category.toLowerCase().includes(query))
    );
  };

  const handleKeyDown = (event: KeyboardEvent) => {
    const filtered = filteredScripts();
    
    switch (event.key) {
      case 'ArrowDown':
        event.preventDefault();
        setSelectedIndex(prev => (prev + 1) % filtered.length);
        break;
      case 'ArrowUp':
        event.preventDefault();
        setSelectedIndex(prev => (prev - 1 + filtered.length) % filtered.length);
        break;
      case 'Enter':
        event.preventDefault();
        if (filtered.length > 0) {
          handleScriptSelect(filtered[selectedIndex()]);
        }
        break;
      case 'Escape':
        setSearchQuery('');
        setSelectedIndex(0);
        break;
    }
  };

  const handleScriptSelect = async (script: ScriptInfo) => {
    setIsLoading(true);
    try {
      console.log('🔵 ScriptSearch: Executing Rhai script:', script.id);
      
      // Notify parent component FIRST to show UIController
      props.onScriptSelect(script.id);
      
      // Execute the Rhai script
      const result = await UIService.runRhaiScript(script.id);
      console.log('🔵 ScriptSearch: Rhai script completed:', result);
      
    } catch (error) {
      console.error('🔴 ScriptSearch: Failed to execute Rhai script:', error);
      alert(`Script execution failed: ${error}`);
      setIsLoading(false);
    }
  };

  // Reset selected index when search changes
  const handleSearchChange = (value: string) => {
    setSearchQuery(value);
    setSelectedIndex(0);
  };

  onMount(() => {
    // Focus the search input on mount
    const input = document.getElementById('script-search-input') as HTMLInputElement;
    if (input) {
      input.focus();
    }
  });

  return (
    <div style="width: 100vw; height: 100vh; background: #1e1e1e; display: flex; flex-direction: column;">
      {/* Search Header */}
      <div style="padding: 20px 20px 0; border-bottom: 1px solid #3c3c3c;">
        <div style="position: relative; display: flex; align-items: center;">
          <input
            id="script-search-input"
            type="text"
            placeholder="Search scripts..."
            value={searchQuery()}
            onInput={(e) => handleSearchChange(e.currentTarget.value)}
            onKeyDown={handleKeyDown}
            disabled={isLoading()}
            style="width: 100%; padding: 12px 16px; font-size: 16px; background: #2d2d2d; border: 1px solid #3c3c3c; border-radius: 6px; color: #cccccc; outline: none; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;"
          />
          <Show when={isLoading()}>
            <div style="position: absolute; right: 16px; color: #007acc; font-size: 14px;">
              Running...
            </div>
          </Show>
        </div>
      </div>

      {/* Results Container */}
      <div style="flex: 1; overflow-y: auto;">
        <Show when={filteredScripts().length > 0} fallback={
          <div style="padding: 40px 20px; text-align: center; color: #858585;">
            <Show when={!scriptsLoaded()}>
              <div>Loading Rhai scripts...</div>
            </Show>
            <Show when={scriptsLoaded() && filteredScripts().length === 0}>
              <div>No scripts found</div>
              <div style="font-size: 12px; margin-top: 8px; opacity: 0.7;">Try a different search term</div>
            </Show>
          </div>
        }>
          {/* Results Header */}
          <div style="padding: 12px 20px 8px; border-bottom: 1px solid #3c3c3c; background: #252526;">
            <span style="font-size: 12px; color: #858585; text-transform: uppercase; font-weight: 600;">
              RHAI SCRIPTS ({filteredScripts().length})
            </span>
          </div>
          
          {/* Results List */}
          <div>
            <For each={filteredScripts()}>
              {(script, index) => (
                <div
                  style={{
                    'padding': '12px 20px',
                    'border-bottom': '1px solid #2d2d2d',
                    'cursor': 'pointer',
                    'transition': 'background-color 0.1s ease',
                    'background': index() === selectedIndex() ? '#094771' : 'transparent',
                    'display': 'flex',
                    'justify-content': 'space-between',
                    'align-items': 'flex-start'
                  }}
                  onClick={() => handleScriptSelect(script)}
                  onMouseEnter={() => setSelectedIndex(index())}
                >
                  <div>
                    <div style="font-size: 14px; color: #cccccc; font-weight: 500; margin-bottom: 4px;">
                      {script.name}
                    </div>
                    <div style="font-size: 12px; color: #858585; margin-bottom: 4px;">
                      {script.description}
                    </div>
                  </div>
                  <Show when={script.category}>
                    <div style="font-size: 11px; color: #007acc; text-transform: uppercase; font-weight: 600; margin-left: 16px; flex-shrink: 0;">
                      {script.category}
                    </div>
                  </Show>
                </div>
              )}
            </For>
          </div>
        </Show>
      </div>
    </div>
  );
};
