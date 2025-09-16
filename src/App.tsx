import { Component, createSignal, Show } from "solid-js";
import "./App.css";
import { UIController } from "./UIController";
import { DemoButton, KitDemoButton, GreetingScriptButton, HtmlDemoButton, ScriptSearch } from "./components";
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

  return (
    <main class="container">
      <div style="position: absolute; top: 10px; right: 10px;">
        <DemoButton />
        <KitDemoButton />
        <GreetingScriptButton onScriptStart={() => setShowUIController(true)} />
        <HtmlDemoButton onScriptStart={() => setShowUIController(true)} />
      </div>

      <Show when={!showUIController() && !currentRequest()}>
        <div style="display: flex; justify-content: center; align-items: center; height: 100vh;">
          <ScriptSearch onScriptSelect={handleScriptSelect} />
        </div>
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

      <Show when={currentRequest() && !showUIController()}>
        <div style="padding: 2rem; text-align: center;">
          <h2>UI Request received but UIController not shown</h2>
          <p>showUIController: {showUIController() ? 'true' : 'false'}</p>
          <p>currentRequest: {currentRequest() ? 'present' : 'null'}</p>
          <button onClick={() => setShowUIController(true)}>Show UIController</button>
        </div>
      </Show>
    </main>
  );
};

export default App;
