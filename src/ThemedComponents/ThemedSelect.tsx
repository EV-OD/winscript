import { createSignal, Component } from 'solid-js';
import './ThemedComponents.css';

type ThemedSelectProps = {
  options: string[];
  value: string;
  onChange: (val: string) => void;
  placeholder?: string;
  onEnter?: () => void;
};

export const ThemedSelect: Component<ThemedSelectProps> = (props) => {
  const [filter, setFilter] = createSignal('');
  const filtered = () => props.options.filter((opt: string) =>
    opt.toLowerCase().includes(filter().toLowerCase())
  );

  const handleKeyPress = (e: KeyboardEvent) => {
    if (e.key === 'Enter') {
      const filteredOptions = filtered();
      if (filteredOptions.length > 0) {
        props.onChange(filteredOptions[0]);
        setFilter('');
        if (props.onEnter) {
          props.onEnter();
        }
      }
    }
  };

  return (
    <div class="themed-select-container">
      <input
        class="themed-select-filter"
        type="text"
        value={filter()}
        onInput={(e) => setFilter(e.currentTarget.value)}
        onKeyPress={handleKeyPress}
        placeholder={props.placeholder || 'Filter...'}
      />
      <ul class="themed-select-list">
        {filtered().map((opt: string) => (
          <li
            class={opt === props.value ? 'selected' : ''}
            onClick={() => props.onChange(opt)}
          >
            {opt}
          </li>
        ))}
      </ul>
    </div>
  );
};
