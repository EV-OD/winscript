import { Component, createSignal, Show } from "solid-js";
import "./App.css";
import { UIController } from "./UIController";
import { DemoButton, ScriptSearch } from "./components";
import { useKeyboardShortcuts } from "./hooks/useKeyboardShortcuts";
import { useUIEvents } from "./hooks/useUIEvents";
import type { UIRequest } from "./UIController";

// Global type declarations
declare global {
  interface Window {
    showUIRequest: (request: UIRequest) => void;
  }
}

const App: Component = () => {
  // Use custom hooks for modular functionality
  useKeyboardShortcuts();
  const { currentRequest, clearRequest } = useUIEvents();
  
  // State to control what to show
  const [showUIController, setShowUIController] = createSignal(false);

  const handleScriptSelect = (script: string) => {
    console.log('Selected script:', script);
    // For now, show the UI controller when a script is selected
    setShowUIController(true);
  };

  return (
    <main class="container">
      <div style="position: absolute; top: 10px; right: 10px;">
        <DemoButton />
      </div>

      <Show when={!showUIController() && !currentRequest()}>
        <div style="display: flex; justify-content: center; align-items: center; height: 100vh;">
          <ScriptSearch onScriptSelect={handleScriptSelect} />
        </div>
      </Show>

      <Show when={showUIController() || currentRequest()}>
        <UIController 
          request={currentRequest()} 
          onComplete={clearRequest}
        />
      </Show>
    </main>
  );
};

export default App;
