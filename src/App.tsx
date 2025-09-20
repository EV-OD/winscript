import { Component, createSignal, Show, createEffect, onMount, onCleanup } from "solid-js";
import "./App.css";
import { UIController } from "./UIController";
import { ScriptSearch } from "./components";
import { useKeyboardShortcuts } from "./hooks/useKeyboardShortcuts";
import { useUIEvents } from "./hooks/useUIEvents";
import { appLogger } from "./services/LoggingService";
import type { UIRequest } from "./UIController";
import { listen } from '@tauri-apps/api/event';

// Global type declarations
declare global {
  interface Window {
    showUIRequest: (request: UIRequest) => void;
    onScriptComplete: () => void;
  }
}

const App: Component = () => {
  // Use custom hooks for modular functionality
  useKeyboardShortcuts();
  const { currentRequest, clearRequest } = useUIEvents();
  
  // State to control what to show
  const [showUIController, setShowUIController] = createSignal(false);

  // Listen for reset-to-script-search event from backend
  onMount(() => {
    const setupResetListener = async () => {
      const unlisten = await listen('reset-to-script-search', () => {
        console.log('🔄 App: Received reset-to-script-search event, returning to script search');
        setShowUIController(false);
        clearRequest();
      });
      
      onCleanup(unlisten);
    };
    
    const setupAppControlListener = async () => {
      const unlisten = await listen('app_control', (event) => {
        const payload = event.payload as { action: string };
        console.log('🔄 App: Received app_control event:', payload);
        
        switch (payload.action) {
          case 'hide':
            console.log('🔄 App: Hiding app window');
            import('@tauri-apps/api/window').then(({ getCurrentWindow }) => {
              getCurrentWindow().hide();
            });
            break;
          case 'minimize':
            console.log('🔄 App: Minimizing to tray');
            import('@tauri-apps/api/window').then(({ getCurrentWindow }) => {
              getCurrentWindow().hide();
            });
            break;
          case 'close':
            console.log('🔄 App: Closing app window');
            import('@tauri-apps/api/window').then(({ getCurrentWindow }) => {
              getCurrentWindow().close();
            });
            break;
        }
      });
      
      onCleanup(unlisten);
    };
    
    setupResetListener();
    setupAppControlListener();
  });

  // Automatically show UIController when a request is received
  createEffect(() => {
    if (currentRequest() && !showUIController()) {
      console.log('🔵 App: UI Request detected, automatically showing UIController');
      setShowUIController(true);
    }
  });

  // Enhanced script termination function
  const forceCloseUIController = () => {
    console.log('🔵 App: Force closing UIController and terminating script');
    setShowUIController(false);
    clearRequest();
    
    // Clear any pending UI requests or script state
    if (window.onScriptComplete) {
      window.onScriptComplete();
    }
  };

  const handleScriptSelect = (script: string) => {
    appLogger.info(`Selected script: ${script}`);
    appLogger.debug('Setting showUIController to true');
    setShowUIController(true);
  };

  // Set up global script completion handler
  window.onScriptComplete = () => {
    appLogger.info('Script completed, closing UIController');
    setShowUIController(false);
    clearRequest();
  };

  // Global keyboard handler for immediate quit
  createEffect(() => {
    const handleGlobalKeyDown = (event: KeyboardEvent) => {
      if (event.key === 'q' && showUIController()) {
        event.preventDefault();
        event.stopPropagation();
        console.log('🔵 App: Q pressed - immediately returning to ScriptSearch');
        forceCloseUIController();
      }
    };

    document.addEventListener('keydown', handleGlobalKeyDown, { capture: true });
    
    return () => {
      document.removeEventListener('keydown', handleGlobalKeyDown, { capture: true });
    };
  });

  return (
    <main class="container">
      <Show when={!showUIController()}>
        <ScriptSearch onScriptSelect={handleScriptSelect} />
      </Show>

      <Show when={showUIController()}>
        <UIController 
          request={currentRequest()} 
          onComplete={() => {
            // This will only be called when the script is completely finished
            console.log('🔵 App: Script completed, closing UIController');
            setShowUIController(false);
            clearRequest();
          }}
        />
      </Show>
    </main>
  );
};

export default App;
