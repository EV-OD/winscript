import { createSignal } from 'solid-js';
import { UIService, ScriptInfo } from '../services/UIService';

export function RhaiScriptButton() {
  const [isLoading, setIsLoading] = createSignal(false);
  const [scripts, setScripts] = createSignal<ScriptInfo[]>([]);
  const [showScripts, setShowScripts] = createSignal(false);

  const loadScripts = async () => {
    setIsLoading(true);
    try {
      const scriptList = await UIService.listRhaiScripts();
      setScripts(scriptList);
      setShowScripts(true);
      console.log('📜 RhaiScriptButton: Loaded scripts:', scriptList);
    } catch (error) {
      console.error('📜 RhaiScriptButton: Failed to load scripts:', error);
      alert(`Failed to load scripts: ${error}`);
    } finally {
      setIsLoading(false);
    }
  };

  const runScript = async (scriptId: string) => {
    setIsLoading(true);
    try {
      console.log('📜 RhaiScriptButton: Running script:', scriptId);
      const result = await UIService.runRhaiScript(scriptId);
      console.log('📜 RhaiScriptButton: Script result:', result);
      alert(`Script executed: ${result}`);
    } catch (error) {
      console.error('📜 RhaiScriptButton: Script execution failed:', error);
      alert(`Script failed: ${error}`);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div style={{
      display: 'flex',
      'flex-direction': 'column',
      gap: '10px',
      padding: '10px',
      background: '#2d2d30',
      border: '1px solid #3c3c3c',
      'border-radius': '4px',
      'font-family': 'system-ui, -apple-system, sans-serif'
    }}>
      <button
        onClick={loadScripts}
        disabled={isLoading()}
        style={{
          background: isLoading() ? '#404040' : '#0e639c',
          color: 'white',
          border: 'none',
          padding: '8px 16px',
          'border-radius': '4px',
          cursor: isLoading() ? 'not-allowed' : 'pointer',
          'font-size': '14px'
        }}
      >
        {isLoading() ? 'Loading...' : 'Load Rhai Scripts'}
      </button>

      {showScripts() && (
        <div style={{
          display: 'flex',
          'flex-direction': 'column',
          gap: '8px',
          'max-height': '300px',
          'overflow-y': 'auto'
        }}>
          <h4 style={{ 
            margin: '0', 
            color: '#cccccc', 
            'font-size': '14px',
            'border-bottom': '1px solid #3c3c3c',
            'padding-bottom': '8px'
          }}>
            Available Scripts ({scripts().length})
          </h4>
          {scripts().map((script) => (
            <div 
              style={{
                background: '#1e1e1e',
                padding: '8px',
                'border-radius': '4px',
                border: '1px solid #3c3c3c'
              }}
            >
              <div style={{ 
                display: 'flex', 
                'justify-content': 'space-between',
                'align-items': 'center',
                'margin-bottom': '4px'
              }}>
                <span style={{ color: '#cccccc', 'font-weight': 'bold' }}>
                  {script.name}
                </span>
                <button
                  onClick={() => runScript(script.id)}
                  disabled={isLoading()}
                  style={{
                    background: isLoading() ? '#404040' : '#0e7a0d',
                    color: 'white',
                    border: 'none',
                    padding: '4px 8px',
                    'border-radius': '3px',
                    cursor: isLoading() ? 'not-allowed' : 'pointer',
                    'font-size': '12px'
                  }}
                >
                  Run
                </button>
              </div>
              <div style={{ color: '#999999', 'font-size': '12px' }}>
                {script.description}
              </div>
              <div style={{ color: '#666666', 'font-size': '10px', 'margin-top': '4px' }}>
                Category: {script.category} | Type: {script.script_type}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
