import { createSignal, Component, Show, For, createMemo, createEffect } from 'solid-js';
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

  // Filter options based on input value
  const filteredOptions = createMemo(() => {
    const options = props.request?.options || [];
    const filter = inputValue().toLowerCase();
    if (!filter) return options;
    
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

  // Auto-focus select input when it becomes visible
  createEffect(() => {
    if (props.request?.type === 'select' && selectInputRef) {
      setTimeout(() => {
        selectInputRef?.focus();
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
      response = inputValue();
      console.log('🔵 UIController: Input response:', response);
    } else if (request.type === 'select') {
      const filtered = filteredOptions();
      response = filtered[activeIndex()] || '';
      console.log('🔵 UIController: Select response:', response);
    }

    try {
      console.log('🔵 UIController: Sending response via UIService');
      await UIService.sendResponse(request.id, response);
      console.log('🔵 UIController: Response sent successfully');
      
      // Reset values for next input
      setInputValue('');
      setSelectedValue('');
      setActiveIndex(0);
      
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
        setActiveIndex((prev) => (prev + 1) % filtered.length);
      } else if (event.key === 'ArrowUp') {
        event.preventDefault();
        setActiveIndex((prev) => (prev - 1 + filtered.length) % filtered.length);
      } else if (event.key === 'Enter') {
        event.preventDefault();
        if (filtered.length > 0) {
          handleSubmit();
        }
      }
    } else if (event.key === 'Enter') {
      event.preventDefault();
      handleSubmit();
    }
  };

  return (
    <div style="width: 100vw; height: 100vh; background: #1e1e1e; display: flex; flex-direction: column; overflow: hidden;">
      <Show when={props.request}>
        <Show when={props.request?.type === 'input'}>
          {/* Input Interface */}
          <div style="padding: 20px; border-bottom: 1px solid #3c3c3c; flex-shrink: 0;">
            <input
              type="text"
              placeholder={props.request?.message || "Enter your response..."}
              value={inputValue()}
              onInput={(e) => setInputValue(e.currentTarget.value)}
              onKeyDown={handleKeyDown}
              style="width: 100%; padding: 12px 16px; font-size: 16px; background: #2d2d2d; border: 1px solid #3c3c3c; border-radius: 6px; color: #cccccc; outline: none; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; box-sizing: border-box;"
              autofocus
            />
          </div>
        </Show>

        <Show when={props.request?.type === 'select'}>
          {/* Select Interface */}
          <div style="padding: 20px 20px 0; border-bottom: 1px solid #3c3c3c; flex-shrink: 0;">
            <input
              ref={selectInputRef}
              type="text"
              placeholder={props.request?.message || "Select category or note"}
              value={inputValue()}
              onInput={(e) => {
                setInputValue(e.currentTarget.value);
                setActiveIndex(0); // Reset to first item when filtering
              }}
              onKeyDown={handleKeyDown}
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
                  }}
                  onMouseEnter={() => setActiveIndex(index())}
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
