import { Component } from 'solid-js';
import './ThemedComponents.css';

type HtmlRendererProps = {
  html: string;
};

export const HtmlRenderer: Component<HtmlRendererProps> = (props) => (
  <div class="themed-html-renderer" innerHTML={props.html} />
);
