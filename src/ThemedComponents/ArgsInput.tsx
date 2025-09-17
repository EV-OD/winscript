import { Component } from 'solid-js';
import './ThemedComponents.css';

type ArgsInputProps = {
  value: string;
  onChange: (val: string) => void;
  placeholder?: string;
  onEnter?: () => void;
};

export const ArgsInput: Component<ArgsInputProps> = (props) => {
  const handleKeyPress = (e: KeyboardEvent) => {
    if (e.key === 'Enter' && props.onEnter) {
      props.onEnter();
    }
  };

  return (
    <input
      class="themed-args-input"
      type="text"
      value={props.value}
      onInput={(e) => props.onChange(e.currentTarget.value)}
      onKeyPress={handleKeyPress}
      placeholder={props.placeholder || 'Enter argument...'}
      autocomplete="off"
      autocapitalize="off"
      autocorrect="off"
      spellcheck={false}
      data-gramm="false"
      data-gramm_editor="false"
      data-enable-grammarly="false"
    />
  );
};
