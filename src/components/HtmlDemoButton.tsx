import { Component } from 'solid-js';
import { invoke } from '@tauri-apps/api/core';

type HtmlDemoButtonProps = {
  onScriptStart?: () => void;
};

export const HtmlDemoButton: Component<HtmlDemoButtonProps> = (props) => {
  const handleClick = async () => {
    console.log('🔵 HtmlDemoButton: Starting HTML demo script');
    try {
      // Notify parent that script is starting
      if (props.onScriptStart) {
        props.onScriptStart();
      }

      const result = await invoke('html_demo_script');
      console.log('🔵 HtmlDemoButton: HTML demo script result:', result);
    } catch (error) {
      console.error('🔴 HtmlDemoButton: HTML demo script failed:', error);
    }
  };

  return (
    <button
      onClick={handleClick}
      style={{
        position: 'absolute',
        top: '10px',
        left: '150px',
        padding: '8px 12px',
        background: '#667eea',
        color: 'white',
        border: 'none',
        'border-radius': '6px',
        cursor: 'pointer',
        'font-size': '12px',
        'z-index': 1000
      }}
    >
      HTML Demo
    </button>
  );
};
