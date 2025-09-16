import { createSignal, Component, Show, For } from 'solid-js';
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
      response = selectedValue();
      console.log('🔵 UIController: Select response:', response);
    }

    try {
      console.log('🔵 UIController: Sending response via UIService');
      await UIService.sendResponse(request.id, response);
      console.log('🔵 UIController: Response sent successfully');
      
      // Reset values for next input
      setInputValue('');
      setSelectedValue('');
      
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
    if (event.key === 'Enter') {
      event.preventDefault();
      handleSubmit();
    }
  };

  return (
    <div style="width: 100vw; height: 100vh; background: #1e1e1e; display: flex; flex-direction: column;">
      <Show when={props.request}>
        <Show when={props.request?.type === 'input'}>
          {/* Input Interface */}
          <div style="padding: 20px 20px 0; border-bottom: 1px solid #3c3c3c;">
            <input
              type="text"
              placeholder={props.request?.message || "Enter your response..."}
              value={inputValue()}
              onInput={(e) => setInputValue(e.currentTarget.value)}
              onKeyDown={handleKeyDown}
              style="width: 100%; padding: 12px 16px; font-size: 16px; background: #2d2d2d; border: 1px solid #3c3c3c; border-radius: 6px; color: #cccccc; outline: none; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;"
              autofocus
            />
          </div>
        </Show>

        <Show when={props.request?.type === 'select'}>
          {/* Select Interface */}
          <div style="padding: 20px 20px 0; border-bottom: 1px solid #3c3c3c;">
            <input
              type="text"
              placeholder={props.request?.message || "Select category or note"}
              value={selectedValue()}
              onInput={(e) => setSelectedValue(e.currentTarget.value)}
              onKeyDown={handleKeyDown}
              style="width: 100%; padding: 12px 16px; font-size: 16px; background: #2d2d2d; border: 1px solid #3c3c3c; border-radius: 6px; color: #cccccc; outline: none; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;"
              autofocus
            />
          </div>

          {/* Options List */}
          <div style="flex: 1; overflow-y: auto;">
            <For each={props.request?.options || []}>
              {(option, index) => (
                <div
                  style={{
                    'padding': '12px 20px',
                    'border-bottom': '1px solid #2d2d2d',
                    'cursor': 'pointer',
                    'transition': 'background-color 0.1s ease',
                    'background': selectedValue() === option ? '#094771' : 'transparent',
                    'display': 'flex',
                    'align-items': 'center'
                  }}
                  onClick={() => {
                    setSelectedValue(option);
                    handleSubmit();
                  }}
                  onMouseEnter={() => setSelectedValue(option)}
                >
                  <span style="margin-right: 12px; color: #ffd700;">📁</span>
                  <div style="font-size: 14px; color: #cccccc; font-weight: 500;">
                    {option}
                  </div>
                </div>
              )}
            </For>
          </div>
        </Show>

        <Show when={props.request?.type === 'html'}>
          {/* HTML Display */}
          <div style="flex: 1; overflow-y: auto; padding: 20px;">
            <HtmlRenderer html={props.request?.html_content || ''} />
          </div>
        </Show>
      </Show>

      <Show when={!props.request}>
        <div style="width: 100vw; height: 100vh; background: #1e1e1e; display: flex; align-items: center; justify-content: center; color: #858585;">
          <div style="text-align: center;">
            <div style="font-size: 18px; margin-bottom: 12px;">Script Running...</div>
            <div style="font-size: 14px; opacity: 0.7;">Waiting for next input from the script...</div>
          </div>
        </div>
      </Show>
    </div>
  );
};
