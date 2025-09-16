import { Component } from 'solid-js';
import { UIService } from '../services/UIService';

type KitDemoButtonProps = {
  class?: string;
};

/**
 * Button component for starting the Kit demo
 */
export const KitDemoButton: Component<KitDemoButtonProps> = (props) => {
  const handleKitDemo = async () => {
    try {
      await UIService.startKitDemo();
    } catch (error) {
      // Error is already logged in the service
      alert('Kit Demo failed. Check console for details.');
    }
  };

  return (
    <button 
      onClick={handleKitDemo}
      class={props.class}
      style="padding: 0.5rem 1rem; background: #b4c6d8; color: #232946; border: none; border-radius: 6px; cursor: pointer; transition: background 0.2s; margin-left: 0.5rem;"
    >
      Kit Demo
    </button>
  );
};
