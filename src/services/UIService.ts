import { invoke } from '@tauri-apps/api/core';

/**
 * Service for handling communication with Rust backend
 */
export class UIService {
  /**
   * Send UI response back to Rust backend
   */
  static async sendResponse(id: string, value: string): Promise<void> {
    try {
      await invoke('ui_response', { id, value });
    } catch (error) {
      console.error('Failed to send UI response:', error);
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
}
