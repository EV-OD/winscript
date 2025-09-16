import { onMount, onCleanup } from 'solid-js';
import { getCurrentWindow } from '@tauri-apps/api/window';

/**
 * Hook for handling global keyboard shortcuts
 */
export function useKeyboardShortcuts() {
  onMount(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      // Ctrl+W to close app
      if (event.ctrlKey && event.key === 'w') {
        event.preventDefault();
        getCurrentWindow().close();
      }
      
      // Add more shortcuts here as needed
      // Ctrl+Q for quit
      if (event.ctrlKey && event.key === 'q') {
        event.preventDefault();
        getCurrentWindow().close();
      }
    };

    document.addEventListener('keydown', handleKeyDown);

    onCleanup(() => {
      document.removeEventListener('keydown', handleKeyDown);
    });
  });
}
