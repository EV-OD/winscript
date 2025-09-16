import { Component, createSignal } from 'solid-js';
import { UIService } from '../services/UIService';

type GreetingScriptButtonProps = {
  class?: string;
  onScriptStart?: () => void;
};

/**
 * Button component for running the greeting script
 */
export const GreetingScriptButton: Component<GreetingScriptButtonProps> = (props) => {
  const [isRunning, setIsRunning] = createSignal(false);

  const handleGreetingScript = async () => {
    if (isRunning()) {
      console.log('🔵 GreetingScriptButton: Script already running, ignoring click');
      return;
    }

    console.log('🔵 GreetingScriptButton: Button clicked');
    setIsRunning(true);
    
    // Notify parent that script is starting
    if (props.onScriptStart) {
      console.log('🔵 GreetingScriptButton: Calling onScriptStart');
      props.onScriptStart();
    }
    
    try {
      console.log('🔵 GreetingScriptButton: Calling UIService.runGreetingScript()');
      const result = await UIService.runGreetingScript();
      console.log('🔵 GreetingScriptButton: Script completed with result:', result);
    } catch (error) {
      console.error('🔴 GreetingScriptButton: Script failed:', error);
      alert('Greeting Script failed. Check console for details.');
    } finally {
      setIsRunning(false);
    }
  };

  return (
    <button 
      onClick={handleGreetingScript}
      disabled={isRunning()}
      class={props.class}
      style={`padding: 0.5rem 1rem; background: ${isRunning() ? '#666' : '#a8e6cf'}; color: #232946; border: none; border-radius: 6px; cursor: ${isRunning() ? 'not-allowed' : 'pointer'}; transition: background 0.2s; margin-left: 0.5rem;`}
    >
      {isRunning() ? 'Running...' : 'Greeting Script'}
    </button>
  );
};
