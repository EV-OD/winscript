
import { createSignal, Component } from 'solid-js';
import './ThemedComponents.css';


type ArgsInputProps = {
  value: string;
  onChange: (val: string) => void;
  placeholder?: string;
};

export const ArgsInput: Component<ArgsInputProps> = (props) => (
  <input
    class="themed-args-input"
    type="text"
    value={props.value}
    onInput={(e) => props.onChange(e.currentTarget.value)}
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


type ThemedSelectProps = {
  options: string[];
  value: string;
  onChange: (val: string) => void;
  placeholder?: string;
};

export const ThemedSelect: Component<ThemedSelectProps> = (props) => {
  const [filter, setFilter] = createSignal('');
  const filtered = () => props.options.filter((opt: string) =>
    opt.toLowerCase().includes(filter().toLowerCase())
  );
  return (
    <div class="themed-select-container">
      <input
        class="themed-select-filter"
        type="text"
        value={filter()}
        onInput={(e) => setFilter(e.currentTarget.value)}
        placeholder={props.placeholder || 'Filter...'}
        autocomplete="off"
        autocapitalize="off"
        autocorrect="off"
        spellcheck={false}
        data-gramm="false"
        data-gramm_editor="false"
        data-enable-grammarly="false"
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


type HtmlRendererProps = {
  html: string;
};

export const HtmlRenderer: Component<HtmlRendererProps> = (props) => (
  <div class="themed-html-renderer" innerHTML={props.html} />
);
