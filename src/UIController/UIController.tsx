import { createSignal, Component, Show } from 'solid-js';
import { ArgsInput, ThemedSelect, HtmlRenderer } from '../ThemedComponents';
import { UIService } from '../services/UIService';

export type UIRequest = {
  id: string;
  type: 'input' | 'select' | 'html';
  message: string;
  options?: string[];
  html_content?: string;
};

type UIControllerProps = {
  request: UIRequest | null;
  onComplete?: () => void;
};

export const UIController: Component<UIControllerProps> = (props) => {
  const [inputValue, setInputValue] = createSignal('');
  const [selectedValue, setSelectedValue] = createSignal('');

  const handleSubmit = async () => {
    const request = props.request;
    if (!request) return;

    let response = '';
    if (request.type === 'input') {
      response = inputValue();
    } else if (request.type === 'select') {
      response = selectedValue();
    }

    try {
      await UIService.sendResponse(request.id, response);
      
      // Reset values
      setInputValue('');
      setSelectedValue('');
      
      // Notify parent component
      if (props.onComplete) {
        props.onComplete();
      }
    } catch (error) {
      console.error('Failed to submit response:', error);
    }
  };

  // Expose method to handle requests globally (for backward compatibility)
  (window as any).showUIRequest = (request: UIRequest) => {
    // This is now handled by the parent component
    console.log('Global showUIRequest called:', request);
  };

  return (
    <div style="padding: 2rem;">
      <Show when={props.request}>
        <div class="ui-request-container">
          <h3>{props.request?.message}</h3>
          
          <Show when={props.request?.type === 'input'}>
            <ArgsInput
              value={inputValue()}
              onChange={setInputValue}
              placeholder="Enter your response..."
              onEnter={handleSubmit}
            />
          </Show>

          <Show when={props.request?.type === 'select'}>
            <ThemedSelect
              options={props.request?.options || []}
              value={selectedValue()}
              onChange={setSelectedValue}
              placeholder="Search and select..."
              onEnter={handleSubmit}
            />
          </Show>

          <Show when={props.request?.type === 'html'}>
            <HtmlRenderer html={props.request?.html_content || ''} />
          </Show>

          <div style="margin-top: 1rem;">
            <button 
              onClick={handleSubmit}
              style="padding: 0.5rem 1rem; background: #eebbc3; color: #232946; border: none; border-radius: 6px; cursor: pointer;"
            >
              Submit
            </button>
          </div>
        </div>
      </Show>

      <Show when={!props.request}>
        <div style="text-align: center; color: #eebbc3;">
          <h2>UI Controller Ready</h2>
          <p>Waiting for requests from Rust backend...</p>
        </div>
      </Show>
    </div>
  );
};
