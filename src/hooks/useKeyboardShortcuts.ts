import { onMount, onCleanup } from 'solid-js';
import { getCurrentWindow } from '@tauri-apps/api/window';

/**
 * Hook for handling global keyboard shortcuts
 */
export function useKeyboardShortcuts() {
  onMount(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      console.log('Key pressed:', event.key, 'Ctrl:', event.ctrlKey); // Debug log
      
      // Ctrl+W to close app (check both cases)
      if (event.ctrlKey && (event.key === 'w' || event.key === 'W')) {
        event.preventDefault();
        event.stopPropagation();
        console.log('Closing window with Ctrl+W');
        getCurrentWindow().close().catch(err => console.error('Failed to close window:', err));
      }
      
      // Ctrl+Q for quit (check both cases)
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
