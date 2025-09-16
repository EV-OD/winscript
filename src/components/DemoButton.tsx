import { Component } from 'solid-js';
import { UIService } from '../services/UIService';

type DemoButtonProps = {
  class?: string;
};

/**
 * Button component for starting the UI demo
 */
export const DemoButton: Component<DemoButtonProps> = (props) => {
  const handleDemo = async () => {
    try {
      await UIService.startDemo();
    } catch (error) {
      // Error is already logged in the service
      alert('Demo failed. Check console for details.');
    }
  };

  return (
    <button 
      onClick={handleDemo}
      class={props.class}
      style="padding: 0.5rem 1rem; background: #eebbc3; color: #232946; border: none; border-radius: 6px; cursor: pointer; transition: background 0.2s;"
    >
      Start Demo
    </button>
  );
};
