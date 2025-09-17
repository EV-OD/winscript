import { Component, createSignal, For, onMount, Show, onCleanup, createEffect } from 'solid-js';
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
  
  let searchInputRef: HTMLInputElement | undefined;

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

  // Filter scripts based on search query - ONLY BY NAME (as requested)
  const filteredScripts = () => {
    const query = searchQuery().toLowerCase();
    if (!query) return rhaiScripts();
    
    // Filter only by script name, not description or category
    return rhaiScripts().filter(script => 
      script.name.toLowerCase().includes(query)
    );
  };

  // Force focus maintenance - keep focus on search input always
  const maintainFocus = () => {
    if (searchInputRef && !isLoading()) {
      searchInputRef.focus();
    }
  };

  // Set up focus maintenance
  createEffect(() => {
    // Focus after scripts load and continuously maintain it
    if (scriptsLoaded()) {
      setTimeout(() => maintainFocus(), 10);
      
      // Set up interval to maintain focus
      const focusInterval = setInterval(maintainFocus, 100);
      
      return () => clearInterval(focusInterval);
    }
  });

  // Global event handler to maintain focus
  const handleGlobalEvent = () => {
    setTimeout(() => maintainFocus(), 10);
  };

  // Global keyboard handler for arrow keys with proper event prevention
  const handleGlobalKeyDown = (event: KeyboardEvent) => {
    const filtered = filteredScripts();
    
    if (event.key === 'ArrowDown') {
      event.preventDefault();
      event.stopPropagation();
      event.stopImmediatePropagation();
      setSelectedIndex(prev => Math.max(0, Math.min(prev + 1, filtered.length - 1)));
      maintainFocus();
      return;
    }
    
    if (event.key === 'ArrowUp') {
      event.preventDefault();
      event.stopPropagation();
      event.stopImmediatePropagation();
      setSelectedIndex(prev => Math.max(0, prev - 1));
      maintainFocus();
      return;
    }
    
    if (event.key === 'Enter') {
      event.preventDefault();
      event.stopPropagation();
      event.stopImmediatePropagation();
      if (filtered.length > 0) {
        handleScriptSelect(filtered[selectedIndex()]);
      }
      return;
    }
    
    if (event.key === 'Escape') {
      event.preventDefault();
      event.stopPropagation();
      event.stopImmediatePropagation();
      setSearchQuery('');
      setSelectedIndex(0);
      maintainFocus();
      return;
    }
  };

  // Set up global event listeners
  onMount(() => {
    document.addEventListener('click', handleGlobalEvent, true);
    document.addEventListener('focus', handleGlobalEvent, true);
    document.addEventListener('blur', maintainFocus, true);
    document.addEventListener('keydown', handleGlobalKeyDown, { capture: true });
  });

  onCleanup(() => {
    document.removeEventListener('click', handleGlobalEvent, true);
    document.removeEventListener('focus', handleGlobalEvent, true);
    document.removeEventListener('blur', maintainFocus, true);
    document.removeEventListener('keydown', handleGlobalKeyDown, { capture: true });
  });

  const handleScriptSelect = async (script: ScriptInfo) => {
    setIsLoading(true);
    try {
      console.log('📜 ScriptSearch: Executing Rhai script:', script.name);
      
      const result = await invoke('run_rhai_script', { scriptId: script.id });
      console.log('📜 ScriptSearch: Script executed successfully:', result);
      
      // Notify parent to switch to UIController
      props.onScriptSelect(script.name);
    } catch (error) {
      console.error('📜 ScriptSearch: Script execution failed:', error);
    } finally {
      setIsLoading(false);
      maintainFocus(); // Return focus after script execution
    }
  };

  const handleInputBlur = (event: FocusEvent) => {
    // Prevent blur unless we're selecting a script
    event.preventDefault();
    setTimeout(() => maintainFocus(), 1);
  };

  const handleSearchChange = (value: string) => {
    setSearchQuery(value);
    setSelectedIndex(0);
    maintainFocus();
  };

  return (
    <div style="width: 100vw; height: 100vh; background: #1e1e1e; display: flex; flex-direction: column;">
      {/* Search Header */}
      <div style="padding: 20px 20px 0; border-bottom: 1px solid #3c3c3c;">
        <div style="position: relative; display: flex; align-items: center;">
          <input
            ref={searchInputRef}
            id="script-search-input"
            type="text"
            placeholder="Search Rhai scripts..."
            value={searchQuery()}
            onInput={(e) => handleSearchChange(e.currentTarget.value)}
            onBlur={handleInputBlur}
            autofocus
            autocomplete="off"
            autocapitalize="off"
            autocorrect="off"
            spellcheck={false}
            data-gramm="false"
            data-gramm_editor="false"
            data-enable-grammarly="false"
            style="
              width: 100%; 
              height: 40px; 
              background: #2d2d30; 
              border: 1px solid #3c3c3c; 
              color: #cccccc; 
              padding: 0 12px;
              font-size: 14px;
              border-radius: 4px;
              outline: none;
            "
          />
          <Show when={isLoading()}>
            <div style="position: absolute; right: 12px; top: 50%; transform: translateY(-50%); color: #007acc;">
              Loading...
            </div>
          </Show>
        </div>
        <div style="margin-top: 8px; font-size: 12px; color: #858585;">
          {rhaiScripts().length} Rhai scripts available • Use ↑↓ to navigate, Enter to select
        </div>
      </div>

      {/* Scripts List */}
      <div style="flex: 1; overflow-y: auto; padding: 10px 0;">
        <Show when={filteredScripts().length > 0} fallback={
          <div style="padding: 20px; text-align: center; color: #858585;">
            <Show when={searchQuery()} fallback={
              <div>No Rhai scripts found</div>
            }>
              No scripts match "{searchQuery()}"
            </Show>
          </div>
        }>
          <For each={filteredScripts()}>
            {(script, index) => (
              <div
                onClick={() => handleScriptSelect(script)}
                style={`
                  padding: 12px 20px; 
                  border-bottom: 1px solid #2d2d30;
                  cursor: pointer; 
                  transition: background-color 0.1s;
                  ${index() === selectedIndex() ? 'background: #094771; border-left: 3px solid #007acc;' : ''}
                `}
                onMouseEnter={() => setSelectedIndex(index())}
              >
                <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                  <div style="flex: 1;">
                    <div style="font-weight: 600; color: #e1e1e1; margin-bottom: 4px;">
                      {script.name}
                    </div>
                    <Show when={script.description}>
                      <div style="color: #cccccc; font-size: 13px; line-height: 1.4; margin-bottom: 6px;">
                        {script.description}
                      </div>
                    </Show>
                    <Show when={script.category}>
                      <div style="font-size: 11px; color: #858585; text-transform: uppercase; letter-spacing: 0.5px;">
                        {script.category}
                      </div>
                    </Show>
                  </div>
                  <div style="color: #007acc; font-size: 11px; opacity: 0.8; margin-left: 12px;">
                    Rhai
                  </div>
                </div>
              </div>
            )}
          </For>
        </Show>
      </div>

      {/* Footer */}
      <div style="padding: 12px 20px; border-top: 1px solid #3c3c3c; background: #252526; font-size: 12px; color: #858585;">
        <div style="display: flex; justify-content: space-between; align-items: center;">
          <div>Rhai Script Runner • Enhanced with environment variable support</div>
          <div>{filteredScripts().length} scripts</div>
        </div>
      </div>
    </div>
  );
};