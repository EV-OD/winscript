import { Component, createSignal, Show, createEffect } from "solid-js";
import "./App.css";
import { UIController } from "./UIController";
import { ScriptSearch } from "./components";
import { useKeyboardShortcuts } from "./hooks/useKeyboardShortcuts";
import { useUIEvents } from "./hooks/useUIEvents";
import type { UIRequest } from "./UIController";

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
    console.log('🔵 App: Selected script:', script);
    console.log('🔵 App: Setting showUIController to true');
    setShowUIController(true);
  };

  // Set up global script completion handler
  window.onScriptComplete = () => {
    console.log('🔵 App: Script completed, closing UIController');
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
