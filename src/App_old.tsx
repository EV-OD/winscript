import { onMount, onCleanup } from "solid-js";
import { invoke } from "@tauri-apps/api/core";
import { listen } from "@tauri-apps/api/event";
import { getCurrentWindow } from "@tauri-apps/api/window";
import "./App.css";
import { UIController } from "./UIController";
import type { UIRequest } from "./UIController";

declare global {
  interface Window {
    showUIRequest: (request: UIRequest) => void;
  }
}

function App() {
  onMount(async () => {
    // Listen for UI requests from Rust
    const unlisten = await listen<UIRequest>('ui_request', (event) => {
      if (window.showUIRequest) {
        window.showUIRequest(event.payload);
      }
    });

    // Add global hotkey listener for Ctrl+W to close app
    const handleKeyDown = (event: KeyboardEvent) => {
      if (event.ctrlKey && event.key === 'w') {
        event.preventDefault();
        getCurrentWindow().close();
      }
    };

    document.addEventListener('keydown', handleKeyDown);

    // Cleanup function
    onCleanup(() => {
      document.removeEventListener('keydown', handleKeyDown);
      unlisten();
    });

    return unlisten;
  });

  const handleUIResponse = async (id: string, value: string) => {
    try {
      await invoke("ui_response", { id, value });
    } catch (error) {
      console.error("Failed to send UI response:", error);
    }
  };

  const startDemo = async () => {
    try {
      const result = await invoke("demo_ui_controller");
      console.log("Demo result:", result);
    } catch (error) {
      console.error("Demo failed:", error);
    }
  };

  return (
    <main class="container">
      <div style="position: absolute; top: 10px; right: 10px;">
        <button 
          onClick={startDemo}
          style="padding: 0.5rem 1rem; background: #eebbc3; color: #232946; border: none; border-radius: 6px; cursor: pointer;"
        >
          Start Demo
        </button>
      </div>
      <UIController onResponse={handleUIResponse} />
    </main>
  );
}

export default App;
