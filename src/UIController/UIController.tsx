import { createSignal, Component, Show, For, createMemo, createEffect, onMount, onCleanup } from 'solid-js';
import { UIService } from '../services/UIService';
import { HtmlRenderer } from '../ThemedComponents';

export type UIRequest = {
  id: string;
  type: 'input' | 'select' | 'html' | 'complete';
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
  const [selectedValue, setSelectedValue] = createSignal('');
  const [activeIndex, setActiveIndex] = createSignal(0);
  let selectInputRef: HTMLInputElement | undefined;
  let inputRef: HTMLInputElement | undefined;

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

  // Global click handler to maintain focus
  const handleGlobalClick = (event: MouseEvent) => {
    const request = props.request;
    if (request?.type === 'input' || request?.type === 'select') {
      // Always refocus after any click
      setTimeout(() => maintainFocus(), 10);
    }
  };

  // Set up global click listener
  onMount(() => {
    document.addEventListener('click', handleGlobalClick, true);
    document.addEventListener('focus', handleGlobalClick, true);
    document.addEventListener('blur', maintainFocus, true);
  });

  onCleanup(() => {
    document.removeEventListener('click', handleGlobalClick, true);
    document.removeEventListener('focus', handleGlobalClick, true);
    document.removeEventListener('blur', maintainFocus, true);
  });

  // Reset values when a new request comes in
  createEffect(() => {
    const request = props.request;
    if (request?.id) {
      setInputValue('');
      setSelectedValue('');
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

  // Set up global keyboard listener
  onMount(() => {
    document.addEventListener('keydown', handleGlobalKeyDown, true);
  });

  onCleanup(() => {
    document.removeEventListener('keydown', handleGlobalKeyDown, true);
  });

  return (
    <div style="width: 100vw; height: 100vh; background: #1e1e1e; display: flex; flex-direction: column; overflow: hidden;">
      <Show when={props.request}>
        <Show when={props.request?.type === 'input'}>
          {/* Input Interface */}
          <div style="padding: 20px; border-bottom: 1px solid #3c3c3c; flex-shrink: 0;">
            <input
              ref={inputRef}
              type="text"
              placeholder={props.request?.message || "Enter your response..."}
              value={inputValue()}
              onInput={(e) => setInputValue(e.currentTarget.value)}
              onKeyDown={handleKeyDown}
              onBlur={(e) => {
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
              style="width: 100%; padding: 12px 16px; font-size: 16px; background: #2d2d2d; border: 1px solid #3c3c3c; border-radius: 6px; color: #cccccc; outline: none; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; box-sizing: border-box;"
            />
          </div>
        </Show>

        <Show when={props.request?.type === 'select'}>
          {/* Select Interface */}
          <div style="padding: 20px 20px 0; border-bottom: 1px solid #3c3c3c; flex-shrink: 0;">
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
              onBlur={(e) => {
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
              style="width: 100%; padding: 12px 16px; font-size: 16px; background: #2d2d2d; border: 1px solid #3c3c3c; border-radius: 6px; color: #cccccc; outline: none; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; box-sizing: border-box;"
            />
          </div>

          {/* Options List */}
          <div style="flex: 1; overflow-y: auto; min-height: 0;">
            <For each={filteredOptions()}>
              {(option, index) => (
                <div
                  style={{
                    'padding': '12px 20px',
                    'border-bottom': '1px solid #2d2d2d',
                    'cursor': 'pointer',
                    'transition': 'background-color 0.1s ease',
                    'background': index() === activeIndex() ? '#094771' : 'transparent',
                    'display': 'flex',
                    'align-items': 'center',
                    'flex-shrink': '0'
                  }}
                  onClick={() => {
                    setActiveIndex(index());
                    handleSubmit();
                    // Don't refocus here as the input will disappear after submit
                  }}
                  onMouseEnter={() => setActiveIndex(index())}
                  onMouseDown={(e) => {
                    // Prevent blur from happening on mouse down
                    e.preventDefault();
                  }}
                >
                  <span style="margin-right: 12px; color: #ffd700; flex-shrink: 0;">📁</span>
                  <div style="font-size: 14px; color: #cccccc; font-weight: 500; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                    {option}
                  </div>
                </div>
              )}
            </For>
          </div>
        </Show>

        <Show when={props.request?.type === 'html'}>
          {/* HTML Display */}
          <div style="flex: 1; overflow-y: auto; overflow-x: hidden; padding: 20px; min-height: 0;">
            <div style="max-width: 100%; word-wrap: break-word;">
              <HtmlRenderer html={props.request?.html_content || ''} />
            </div>
          </div>
        </Show>
      </Show>

      <Show when={!props.request}>
        <div style="flex: 1; display: flex; align-items: center; justify-content: center; color: #858585; overflow: hidden;">
          <div style="text-align: center; padding: 20px;">
            <div style="font-size: 18px; margin-bottom: 12px;">Script Running...</div>
            <div style="font-size: 14px; opacity: 0.7;">Waiting for next input from the script...</div>
          </div>
        </div>
      </Show>
    </div>
  );
};
