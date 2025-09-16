import { createSignal, onMount, onCleanup } from 'solid-js';
import { listen, UnlistenFn } from '@tauri-apps/api/event';
import type { UIRequest } from '../UIController';

/**
 * Hook for managing UI requests from the Rust backend
 */
export function useUIEvents() {
  const [currentRequest, setCurrentRequest] = createSignal<UIRequest | null>(null);

  onMount(async () => {
    let unlisten: UnlistenFn;

    try {
      // Listen for UI requests from Rust
      unlisten = await listen<UIRequest>('ui_request', (event) => {
        setCurrentRequest(event.payload);
        
        // Also expose to global window for direct access if needed
        if (window.showUIRequest) {
          window.showUIRequest(event.payload);
        }
      });
    } catch (error) {
      console.error('Failed to setup UI event listener:', error);
    }

    onCleanup(() => {
      if (unlisten) {
        unlisten();
      }
    });
  });

  const clearRequest = () => {
    setCurrentRequest(null);
  };

  return {
    currentRequest,
    clearRequest
  };
}
