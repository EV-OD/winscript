import { createSignal, Component, Show } from 'solid-js';
import { ArgsInput, ThemedSelect, HtmlRenderer } from '../ThemedComponents';
import { UIService } from '../services/UIService';

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
            />
          </Show>

          <Show when={props.request?.type === 'select'}>
            <ThemedSelect
              options={props.request?.options || []}
              value={selectedValue()}
              onChange={setSelectedValue}
              placeholder="Search and select..."
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
          <h2>Script Running...</h2>
          <p>Waiting for next input from the script...</p>
          <div style="margin-top: 2rem;">
            <button 
              onClick={() => window.location.reload()}
              style="padding: 0.5rem 1rem; background: #d64570; color: white; border: none; border-radius: 6px; cursor: pointer;"
            >
              Cancel Script & Go Back
            </button>
          </div>
        </div>
      </Show>
    </div>
  );
};
