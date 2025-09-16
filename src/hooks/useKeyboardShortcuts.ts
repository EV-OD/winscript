import { onMount, onCleanup } from 'solid-js';
import { getCurrentWindow } from '@tauri-apps/api/window';

/**
 * Hook for handling global keyboard shortcuts
 */
export function useKeyboardShortcuts() {
  onMount(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      console.log('Key pressed:', event.key, 'Ctrl:', event.ctrlKey); // Debug log
      
      // Ctrl+W to close window directly
      if (event.ctrlKey && (event.key === 'w' || event.key === 'W')) {
        event.preventDefault();
        event.stopPropagation();
        console.log('Closing window with Ctrl+W');
        getCurrentWindow().close().catch(err => console.error('Failed to close window:', err));
      }
      
      // Q key (without Ctrl) to go back to main screen  
      if (!event.ctrlKey && !event.altKey && !event.shiftKey && event.key === 'q') {
        event.preventDefault();
        event.stopPropagation();
        console.log('Handling Q key - going back to main screen');
        
        if (window.onScriptComplete) {
          window.onScriptComplete();
        }
      }
      
      // Ctrl+Q for quit (force close)
      if (event.ctrlKey && (event.key === 'q' || event.key === 'Q')) {
        event.preventDefault();
        event.stopPropagation();
        console.log('Closing window with Ctrl+Q');
        getCurrentWindow().close().catch(err => console.error('Failed to close window:', err));
      }
    };

    document.addEventListener('keydown', handleKeyDown);

    onCleanup(() => {
      document.removeEventListener('keydown', handleKeyDown);
    });
  });
}
