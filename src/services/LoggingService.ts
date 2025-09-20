import { invoke } from '@tauri-apps/api/core';

export enum LogLevel {
  Info = 'info',
  Warn = 'warn',
  Error = 'error',
  Debug = 'debug',
  Trace = 'trace'
}

export class SnapRunLogger {
  private component: string;

  constructor(component: string) {
    this.component = component;
  }

  private async logToRust(level: LogLevel, message: string, scriptContext?: string) {
    try {
      await invoke('log_frontend_message', {
        level,
        component: this.component,
        message,
        scriptContext
      });
    } catch (error) {
      // Fallback to console if Rust logging fails
      console.error('Failed to log to Rust backend:', error);
      this.fallbackLog(level, message, scriptContext);
    }
  }

  private fallbackLog(level: LogLevel, message: string, scriptContext?: string) {
    const timestamp = new Date().toISOString();
    const prefix = scriptContext 
      ? `[${timestamp}] ⚛️ ${this.component} (${scriptContext})`
      : `[${timestamp}] ⚛️ ${this.component}`;
    
    switch (level) {
      case LogLevel.Info:
        console.log(`ℹ️ ${prefix} - ${message}`);
        break;
      case LogLevel.Warn:
        console.warn(`⚠️ ${prefix} - ${message}`);
        break;
      case LogLevel.Error:
        console.error(`❌ ${prefix} - ${message}`);
        break;
      case LogLevel.Debug:
        console.debug(`🔍 ${prefix} - ${message}`);
        break;
      case LogLevel.Trace:
        console.debug(`🔬 ${prefix} - ${message}`);
        break;
    }
  }

  async info(message: string, scriptContext?: string) {
    await this.logToRust(LogLevel.Info, message, scriptContext);
  }

  async warn(message: string, scriptContext?: string) {
    await this.logToRust(LogLevel.Warn, message, scriptContext);
  }

  async error(message: string, scriptContext?: string) {
    await this.logToRust(LogLevel.Error, message, scriptContext);
  }

  async debug(message: string, scriptContext?: string) {
    await this.logToRust(LogLevel.Debug, message, scriptContext);
  }

  async trace(message: string, scriptContext?: string) {
    await this.logToRust(LogLevel.Trace, message, scriptContext);
  }

  // Convenience methods for script execution logging
  async scriptStart(scriptName: string) {
    await this.info(`Starting script execution`, scriptName);
  }

  async scriptSuccess(scriptName: string, result?: any) {
    const message = result ? `Script completed successfully with result: ${JSON.stringify(result)}` : 'Script completed successfully';
    await this.info(message, scriptName);
  }

  async scriptError(scriptName: string, error: any) {
    const message = `Script failed: ${error?.message || error}`;
    await this.error(message, scriptName);
  }

  async scriptDebug(scriptName: string, debugInfo: any) {
    const message = `Debug: ${JSON.stringify(debugInfo)}`;
    await this.debug(message, scriptName);
  }
}

// Create logger instances for common components
export const appLogger = new SnapRunLogger('App');
export const scriptSearchLogger = new SnapRunLogger('ScriptSearch');
export const uiControllerLogger = new SnapRunLogger('UIController');

// Function to get logs directory from Rust
export async function getLogsDirectory(): Promise<string> {
  try {
    return await invoke<string>('get_logs_directory');
  } catch (error) {
    console.error('Failed to get logs directory:', error);
    throw error;
  }
}

// Utility function to create a logger for any component
export function createLogger(componentName: string): SnapRunLogger {
  return new SnapRunLogger(componentName);
}
