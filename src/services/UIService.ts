import { invoke } from '@tauri-apps/api/core';

/**
 * Service for handling communication with Rust backend
 */
export class UIService {
  /**
   * Send UI response back to Rust backend
   */
  static async sendResponse(id: string, value: string): Promise<void> {
    console.log('🟡 UIService: sendResponse called with id:', id, 'value:', value);
    try {
      await invoke('ui_response', { id, value });
      console.log('🟡 UIService: Response sent successfully');
    } catch (error) {
      console.error('🔴 UIService: Failed to send UI response:', error);
      throw error;
    }
  }

  /**
   * Start the demo UI controller
   */
  static async startDemo(): Promise<string> {
    try {
      const result = await invoke('demo_ui_controller');
      console.log('Demo result:', result);
      return result as string;
    } catch (error) {
      console.error('Demo failed:', error);
      throw error;
    }
  }

  /**
   * Start the Kit usage demo
   */
  static async startKitDemo(): Promise<string> {
    try {
      const result = await invoke('demo_kit_usage');
      console.log('Kit demo result:', result);
      return result as string;
    } catch (error) {
      console.error('Kit demo failed:', error);
      throw error;
    }
  }

  /**
   * Run the greeting script
   */
  static async runGreetingScript(): Promise<string> {
    console.log('🟡 UIService: runGreetingScript() called');
    try {
      console.log('🟡 UIService: Invoking greeting_script command');
      const result = await invoke('greeting_script');
      console.log('🟡 UIService: Greeting script result:', result);
      return result as string;
    } catch (error) {
      console.error('🔴 UIService: Greeting script failed:', error);
      throw error;
    }
  }

  /**
   * Call any custom Rust command
   */
  static async invokeCommand(command: string, args: Record<string, any> = {}): Promise<any> {
    try {
      return await invoke(command, args);
    } catch (error) {
      console.error(`Failed to invoke command ${command}:`, error);
      throw error;
    }
  }

  /**
   * List all available Rhai scripts
   */
  static async listRhaiScripts(): Promise<ScriptInfo[]> {
    console.log('🟡 UIService: listRhaiScripts() called');
    try {
      const result = await invoke('list_rhai_scripts');
      console.log('🟡 UIService: Rhai scripts loaded:', result);
      return result as ScriptInfo[];
    } catch (error) {
      console.error('🔴 UIService: Failed to list Rhai scripts:', error);
      throw error;
    }
  }

  /**
   * Execute a Rhai script by its ID
   */
  static async runRhaiScript(scriptId: string): Promise<string> {
    console.log('🟡 UIService: runRhaiScript() called with ID:', scriptId);
    try {
      const result = await invoke('run_rhai_script', { scriptId });
      console.log('🟡 UIService: Rhai script execution result:', result);
      return result as string;
    } catch (error) {
      console.error('🔴 UIService: Rhai script execution failed:', error);
      throw error;
    }
  }
}

// TypeScript interface for ScriptInfo
export interface ScriptInfo {
  id: string;
  name: string;
  description: string;
  file_path: string;
  category: string;
  script_type: 'Rhai';
}
