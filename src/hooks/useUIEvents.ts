import { createSignal, onMount, onCleanup } from 'solid-js';
import { listen, UnlistenFn } from '@tauri-apps/api/event';
import type { UIRequest } from '../UIController';

/**
 * Hook for managing UI requests from the Rust backend
 */
export function useUIEvents() {
  const [currentRequest, setCurrentRequest] = createSignal<UIRequest | null>(null);
  let unlisten: UnlistenFn | undefined;

  onMount(async () => {
    console.log('🟢 useUIEvents: Setting up event listener');

    try {
      // Listen for UI requests from Rust
      unlisten = await listen<UIRequest>('ui_request', (event) => {
        console.log('🟢 useUIEvents: Received UI request:', event.payload);
        
        // Check if this is a completion signal
        if (event.payload.type === 'complete') {
          console.log('🟢 useUIEvents: Script completion signal received');
          
          // Check if we should auto-close (smart completion)
          const shouldAutoClose = event.payload.options && event.payload.options[0] === 'true';
          console.log('🟢 useUIEvents: Should auto-close:', shouldAutoClose);
          
          if (shouldAutoClose) {
            console.log('🟢 useUIEvents: Auto-closing due to awaiting components');
            // Auto-close because script used awaiting components
            if (window.onScriptComplete) {
              window.onScriptComplete();
            }
          } else {
            console.log('🟢 useUIEvents: Keeping visible - script only used non-awaiting components (like HTML)');
            // Don't auto-close, let user manually close with Ctrl+W, Q, or Back button
            // The HTML content will remain visible
          }
          return;
        }
        
        // Always update to the latest request - this ensures we show the most recent one
        setCurrentRequest(event.payload);
        
        // Also expose to global window for direct access if needed
        if (window.showUIRequest) {
          window.showUIRequest(event.payload);
        }
      });
      console.log('🟢 useUIEvents: Event listener set up successfully');
    } catch (error) {
      console.error('🔴 useUIEvents: Failed to setup UI event listener:', error);
    }
  });

  onCleanup(() => {
    console.log('🟢 useUIEvents: Cleaning up event listener');
    if (unlisten) {
      unlisten();
    }
  });

  const clearRequest = () => {
    console.log('🟢 useUIEvents: Clearing current request');
    setCurrentRequest(null);
  };

  return {
    currentRequest,
    clearRequest
  };
}
