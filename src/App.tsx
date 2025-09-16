import { Component } from "solid-js";
import "./App.css";
import { UIController } from "./UIController";
import { DemoButton } from "./components/DemoButton";
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

  return (
    <main class="container">
      <div style="position: absolute; top: 10px; right: 10px;">
        <DemoButton />
      </div>

      <UIController 
        request={currentRequest()} 
        onComplete={clearRequest}
      />
    </main>
  );
};

export default App;
