import { createSignal, Component, Show, For, createMemo, createEffect, onMount, onCleanup } from 'solid-js';
import { invoke } from '@tauri-apps/api/core';
import { UIService } from '../services/UIService';
import { HtmlRenderer } from '../ThemedComponents';
import { MonacoEditor } from '../ThemedComponents/index';

export type UIRequest = {
  id: string;
  type: 'input' | 'select' | 'html' | 'complete' | 'editor';
  message: string;
  options?: string[];
  html_content?: string;
};

type UIControllerProps = {
  request: UIRequest | null;
  onComplete?: () => void;
};

export const UIController: Component<UIControllerProps> = (props) => {
  console.log('🔵 UIController: Component rendered with props:', props);
  console.log('🔵 UIController: props.request =', props.request);
  const [inputValue, setInputValue] = createSignal('');
  const [activeIndex, setActiveIndex] = createSignal(0);
  const [platform, setPlatform] = createSignal('unknown');
  let selectInputRef: HTMLInputElement | undefined;
  let inputRef: HTMLInputElement | undefined;

  // Detect platform for styling
  onMount(async () => {
    try {
      const platformName = await invoke('get_platform');
      setPlatform(platformName as string);
      console.log('🔵 UIController: Platform detected:', platformName);
    } catch (error) {
      console.error('Failed to detect platform:', error);
    }
  });

  // Handle editor save action
  const handleEditorSave = async (content: string) => {
    const request = props.request;
    if (!request) return;

    // Check if this is a persistent editor (doesn't need to send response)
    let isPersistent = false;
    try {
      const data = JSON.parse(request.html_content || '{}');
      isPersistent = data.persistent === 'true';
    } catch {
      // Not persistent mode if parsing fails
    }

    if (isPersistent) {
      console.log('🔵 UIController: Persistent editor save - no response sent to backend');
      // In persistent mode, we don't send response back
      // The editor stays open for continued use
      return;
    }

    try {
      console.log('🔵 UIController: Sending editor content back to backend');
      await UIService.sendResponse(request.id, content);
      console.log('🔵 UIController: Editor content sent successfully');
    } catch (error) {
      console.error('🔴 UIController: Failed to send editor content:', error);
    }
  };

  // Filter options based on input value - ONLY BY NAME
  const filteredOptions = createMemo(() => {
    const options = props.request?.options || [];
    const filter = inputValue().toLowerCase();
    if (!filter) return options;
    
    // Filter only by option name, not description
    return options.filter(option => 
      option.toLowerCase().includes(filter)
    );
  });

  // Reset active index when filtered options change
  createMemo(() => {
    const filtered = filteredOptions();
    if (filtered.length > 0 && activeIndex() >= filtered.length) {
      setActiveIndex(0);
    }
  });

  // Force focus management - keep focus on input elements always
  const maintainFocus = () => {
    const request = props.request;
    if (!request) return;

    if (request.type === 'input' && inputRef) {
      inputRef.focus();
    } else if (request.type === 'select' && selectInputRef) {
      selectInputRef.focus();
    }
  };

  // Set up focus maintenance on mount and request changes
  createEffect(() => {
    const request = props.request;
    if (request?.type === 'input' || request?.type === 'select') {
      // Focus immediately
      setTimeout(() => maintainFocus(), 10);
      
      // Set up interval to maintain focus
      const focusInterval = setInterval(maintainFocus, 100);
      
      // Clean up on next effect run
      return () => clearInterval(focusInterval);
    }
  });

  // Global event handler to maintain focus
  const handleGlobalEvent = () => {
    setTimeout(() => maintainFocus(), 10);
  };

  // Set up global event listeners
  onMount(() => {
    document.addEventListener('click', handleGlobalEvent, true);
    document.addEventListener('focus', handleGlobalEvent, true);
    document.addEventListener('blur', maintainFocus, true);
  });

  onCleanup(() => {
    document.removeEventListener('click', handleGlobalEvent, true);
    document.removeEventListener('focus', handleGlobalEvent, true);
    document.removeEventListener('blur', maintainFocus, true);
  });

  // Reset values when a new request comes in
  createEffect(() => {
    const request = props.request;
    if (request?.id) {
      setInputValue('');
      setActiveIndex(0);
      console.log('🔵 UIController: Reset values for new request:', request.id);
    }
  });

  // Auto-focus inputs when they become visible (track request ID to ensure it runs for new requests)
  createEffect(() => {
    const request = props.request;
    // Track both the request ID and type to ensure effect runs for each new request
    if (request?.id && request?.type === 'select' && selectInputRef) {
      setTimeout(() => {
        selectInputRef?.focus();
      }, 50);
    } else if (request?.id && request?.type === 'input' && inputRef) {
      setTimeout(() => {
        inputRef?.focus();
      }, 50);
    }
  });

  const handleSubmit = async () => {
    console.log('🔵 UIController: handleSubmit called');
    const request = props.request;
    if (!request) {
      console.log('🔴 UIController: No request found in props');
      return;
    }

    let response = '';
    if (request.type === 'input') {
      response = inputValue().trim();
      console.log('🔵 UIController: Input response:', response);
      // Don't send empty responses for input
      if (!response) {
        console.log('🟡 UIController: Empty input response, ignoring');
        return;
      }
    } else if (request.type === 'select') {
      const filtered = filteredOptions();
      response = filtered[activeIndex()] || '';
      console.log('🔵 UIController: Select response:', response);
      // Don't send empty responses for select
      if (!response) {
        console.log('🟡 UIController: Empty select response, ignoring');
        return;
      }
    }

    try {
      console.log('🔵 UIController: Sending response via UIService');
      await UIService.sendResponse(request.id, response);
      console.log('🔵 UIController: Response sent successfully');
      
      // Don't call onComplete here - let the script continue its flow
      // onComplete should only be called when the entire script is finished
      console.log('🔵 UIController: Response sent, waiting for next request from script');
    } catch (error) {
      console.error('🔴 UIController: Failed to submit response:', error);
    }
  };

  // Expose method to handle requests globally (for backward compatibility)
  (window as any).showUIRequest = (request: UIRequest) => {
    // This is now handled by the parent component
    console.log('Global showUIRequest called:', request);
  };

  const handleKeyDown = (event: KeyboardEvent) => {
    if (props.request?.type === 'select') {
      const filtered = filteredOptions();
      
      if (event.key === 'ArrowDown') {
        event.preventDefault();
        event.stopPropagation();
        setActiveIndex((prev) => {
          const newIndex = (prev + 1) % filtered.length;
          return newIndex;
        });
        // Maintain focus after arrow key
        setTimeout(() => maintainFocus(), 10);
      } else if (event.key === 'ArrowUp') {
        event.preventDefault();
        event.stopPropagation();
        setActiveIndex((prev) => {
          const newIndex = (prev - 1 + filtered.length) % filtered.length;
          return newIndex;
        });
        // Maintain focus after arrow key
        setTimeout(() => maintainFocus(), 10);
      } else if (event.key === 'Enter') {
        event.preventDefault();
        event.stopPropagation();
        if (filtered.length > 0) {
          handleSubmit();
        }
      }
    } else if (event.key === 'Enter') {
      event.preventDefault();
      event.stopPropagation();
      handleSubmit();
    }
    
    // Always maintain focus after any key event
    setTimeout(() => maintainFocus(), 10);
  };

  // Enhanced global keyboard handler for arrow keys
  const handleGlobalKeyDown = (event: KeyboardEvent) => {
    const request = props.request;
    if (request?.type === 'select') {
      if (event.key === 'ArrowDown' || event.key === 'ArrowUp') {
        // Ensure the select input has focus and handle the key
        maintainFocus();
        handleKeyDown(event);
      }
    }
  };

  // Get glass effect class based on platform
  const getGlassClass = () => {
    const base = 'glass-container';
    const platformClass = `glass-${platform()}`;
    return `${base} ${platformClass}`;
  };

  // Set up global keyboard listener
  onMount(() => {
    document.addEventListener('keydown', handleGlobalKeyDown, true);
  });

  onCleanup(() => {
    document.removeEventListener('keydown', handleGlobalKeyDown, true);
  });

  return (
    <div class={getGlassClass()} style="width: 100vw; height: 100vh; display: flex; flex-direction: column; overflow: hidden;">
      <Show when={props.request}>
        <Show when={props.request?.type === 'input'}>
          {/* Input Interface with enhanced glass effect */}
          <div style="
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            flex-shrink: 0;
          ">
            <div style="position: relative; display: flex; align-items: center;">
              <input
                ref={inputRef}
                type="text"
                placeholder={props.request?.message || "Enter your response..."}
                value={inputValue()}
                onInput={(e) => setInputValue(e.currentTarget.value)}
                onKeyDown={handleKeyDown}
                onBlur={() => {
                  // Prevent loss of focus by refocusing
                  setTimeout(() => maintainFocus(), 10);
                }}
                onFocus={() => {
                  console.log('🔵 Input focused');
                }}
                autofocus={true}
                autocomplete="off"
                autocapitalize="off"
                autocorrect="off"
                spellcheck={false}
                data-gramm="false"
                data-gramm_editor="false"
                data-enable-grammarly="false"
                style="
                  flex: 1; 
                  height: 50px; 
                  background: #403c4a; 
                  color: #cccccc; 
                  padding: 10px 20px;
                  font-size: 20px;
                  border-radius: 0px!important;
                  outline: none;
                  border: none;
                "
              />
              {/* Draggable area on the right */}
              <div 
                data-tauri-drag-region
                style="
                  width: 40px;
                  height: 50px;
                  background: rgba(255, 255, 255, 0.03);
                  border-left: 1px solid rgba(255, 255, 255, 0.08);
                  display: flex;
                  align-items: center;
                  justify-content: center;
                  cursor: grab;
                  transition: all 0.2s ease;
                  font-size: 12px;
                  color: rgba(255, 255, 255, 0.3);
                  opacity: 0.6;
                "
                onMouseDown={(e) => e.currentTarget.style.cursor = 'grabbing'}
                onMouseUp={(e) => e.currentTarget.style.cursor = 'grab'}
                onMouseLeave={(e) => e.currentTarget.style.cursor = 'grab'}
                title="Drag to move window"
              >
                ⋮⋮
              </div>
            </div>
            <div style="margin-top: 8px; margin-left: 22px; font-size: 12px; color: #858585;">
              Enter your response and press Enter to submit
            </div>
          </div>
        </Show>

        <Show when={props.request?.type === 'select'}>
          {/* Select Interface with enhanced glass effect */}
          <div style="
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            flex-shrink: 0;
          ">
            <div style="position: relative; display: flex; align-items: center;">
              <input
                ref={selectInputRef}
                type="text"
                placeholder={props.request?.message || "Type to filter options..."}
                value={inputValue()}
                onInput={(e) => {
                  setInputValue(e.currentTarget.value);
                  setActiveIndex(0); // Reset to first item when filtering
                }}
                onKeyDown={handleKeyDown}
                onBlur={() => {
                  // Prevent loss of focus by refocusing
                  setTimeout(() => maintainFocus(), 10);
                }}
                onFocus={() => {
                  console.log('🔵 Select input focused');
                }}
                autofocus={true}
                autocomplete="off"
                autocapitalize="off"
                autocorrect="off"
                spellcheck={false}
                data-gramm="false"
                data-gramm_editor="false"
                data-enable-grammarly="false"
                style="
                  flex: 1; 
                  height: 50px; 
                  background: #403c4a; 
                  color: #cccccc; 
                  padding: 10px 20px;
                  font-size: 20px;
                  border-radius: 0px!important;
                  outline: none;
                  border: none;
                "
              />
              {/* Draggable area on the right */}
              <div 
                data-tauri-drag-region
                style="
                  width: 40px;
                  height: 50px;
                  background: rgba(255, 255, 255, 0.03);
                  border-left: 1px solid rgba(255, 255, 255, 0.08);
                  display: flex;
                  align-items: center;
                  justify-content: center;
                  cursor: grab;
                  transition: all 0.2s ease;
                  font-size: 12px;
                  color: rgba(255, 255, 255, 0.3);
                  opacity: 0.6;
                "
                onMouseDown={(e) => e.currentTarget.style.cursor = 'grabbing'}
                onMouseUp={(e) => e.currentTarget.style.cursor = 'grab'}
                onMouseLeave={(e) => e.currentTarget.style.cursor = 'grab'}
                title="Drag to move window"
              >
                ⋮⋮
              </div>
            </div>
            <div style="margin-top: 8px; margin-left: 22px; font-size: 12px; color: #858585;">
              {filteredOptions().length} options available • Use ↑↓ to navigate, Enter to select
            </div>
          </div>

          {/* Options List */}
          <div style="flex: 1; overflow-y: auto; padding: 0 0;">
            <For each={filteredOptions()}>
              {(option, index) => (
                <div
                  onClick={() => {
                    setActiveIndex(index());
                    handleSubmit();
                  }}
                  style={`
                    padding: 12px 20px; 
                    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                    cursor: pointer; 
                    transition: all 0.2s ease;
                    backdrop-filter: blur(5px);
                    ${index() === activeIndex() ? 
                      'background: rgba(0, 122, 204, 0.3); border-left: 3px solid #007acc; box-shadow: inset 0 0 20px rgba(0, 122, 204, 0.1);' : 
                      'hover:background: rgba(255, 255, 255, 0.05);'
                    }
                  `}
                  onMouseEnter={() => setActiveIndex(index())}
                  onMouseDown={(e) => {
                    // Prevent blur from happening on mouse down
                    e.preventDefault();
                  }}
                >
                  <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                    <div style="flex: 1;">
                      <div style="font-weight: 600; color: #e1e1e1; margin-bottom: 4px;">
                        {option}
                      </div>
                    </div>
                    <div style="color: #007acc; font-size: 11px; opacity: 0.8; margin-left: 12px;">
                      Option
                    </div>
                  </div>
                </div>
              )}
            </For>
          </div>
        </Show>

        <Show when={props.request?.type === 'html'}>
          {/* HTML Display with glass panel */}
          <div style="flex: 1; overflow-y: auto; overflow-x: hidden; padding: 20px; min-height: 0;">
            <div class="glass-panel" style="
              max-width: 100%; 
              word-wrap: break-word;
              padding: 20px;
            ">
              <HtmlRenderer html={props.request?.html_content || ''} />
            </div>
          </div>
        </Show>

        <Show when={props.request?.type === 'editor'}>
          {/* Monaco Editor - Direct integration without extra wrapper */}
          <div style="flex: 1; overflow: hidden; padding: 0; min-height: 0; height: 100%;">
            <MonacoEditor 
              initialContent={(() => {
                try {
                  const data = JSON.parse(props.request?.html_content || '{}');
                  return data.content || '';
                } catch {
                  return props.request?.html_content || '';
                }
              })()}
              filePath={(() => {
                try {
                  const data = JSON.parse(props.request?.html_content || '{}');
                  return data.filePath;
                } catch {
                  return undefined;
                }
              })()}
              onSave={(content: string) => handleEditorSave(content)}
            />
          </div>
        </Show>
      </Show>

      <Show when={!props.request}>
        <div style="flex: 1; display: flex; align-items: center; justify-content: center; color: #858585; overflow: hidden;">
          <div class="glass-panel" style="
            text-align: center; 
            padding: 40px;
            margin: 20px;
          ">
            <div style="font-size: 18px; margin-bottom: 12px; color: #e1e1e1;">Script Running...</div>
            <div style="font-size: 14px; opacity: 0.7;">Waiting for next input from the script...</div>
          </div>
        </div>
      </Show>

      {/* Footer with glass effect */}
      <div style="
        padding: 12px 20px; 
        border-top: 1px solid rgba(255, 255, 255, 0.1); 
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(10px);
        font-size: 12px; 
        color: #858585;
      ">
        <div style="display: flex; justify-content: space-between; align-items: center;">
          <div>SnapRun made by Rabin</div>
          <Show when={props.request?.type === 'select'}>
            <div>{filteredOptions().length} options</div>
          </Show>
        </div>
      </div>
    </div>
  );
};
