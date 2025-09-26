// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	integrations: [
		starlight({
			title: 'SnapRun Documentation',
			description: 'Professional automation scripting with 70+ built-in functions - Your ultimate productivity companion',
			logo: {
				src: './src/assets/logo.svg',
			},
			favicon: '/favicon.svg',
			head: [
				{
					tag: 'meta',
					attrs: {
						name: 'theme-color',
						content: '#3B82F6',
					},
				},
				{
					tag: 'meta',
					attrs: {
						property: 'og:type',
						content: 'website',
					},
				},
			],
			social: [
				{
					icon: 'github',
					label: 'GitHub Repository',
					href: 'https://github.com/yourusername/snaprun',
				},
			],
			editLink: {
				baseUrl: 'https://github.com/yourusername/snaprun-docs/edit/main/',
			},
			lastUpdated: true,
			customCss: [
				'./src/styles/custom.css',
			],
			components: {
				// Override default components if needed
			},
			expressiveCode: {
				themes: ['github-light', 'github-dark'],
				styleOverrides: {
					borderRadius: '0.75rem',
					frames: {
						shadowColor: 'rgba(0, 0, 0, 0.15)',
					},
				},
				defaultProps: {
					showLineNumbers: false,
					wrap: true,
				},
			},
			tableOfContents: {
				minHeadingLevel: 2,
				maxHeadingLevel: 4,
			},
			sidebar: [
				{
					label: 'Getting Started',
					items: [
						{ label: 'Introduction', slug: 'getting-started/introduction' },
						{ label: 'Installation', slug: 'getting-started/installation' },
						{ label: 'Quick Start', slug: 'getting-started/quick-start' },
					],
				},
				{
					label: 'UI Functions',
					items: [
						{ label: 'Ask Input', slug: 'ui-functions/ask_input' },
						{ label: 'Ask Select', slug: 'ui-functions/ask_select' },
						{ label: 'Editor', slug: 'ui-functions/editor' },
						{ label: 'Markdown', slug: 'ui-functions/md' },
						{ label: 'Render HTML', slug: 'ui-functions/render_html' },
					],
				},
				{
					label: 'File System',
					items: [
						{
							label: 'Files',
							items: [
								{ label: 'Read File', slug: 'file-system/read_file' },
								{ label: 'Write File', slug: 'file-system/write_file' },
								{ label: 'Append File', slug: 'file-system/append_file' },
								{ label: 'Copy File', slug: 'file-system/copy_file' },
								{ label: 'Move File', slug: 'file-system/move_file' },
								{ label: 'Remove File', slug: 'file-system/remove_file' },
								{ label: 'File Size', slug: 'file-system/file_size' },
								{ label: 'File Exists', slug: 'file-system/file_exists' },
							],
						},
						{
							label: 'Directories',
							items: [
								{ label: 'Create Directory', slug: 'file-system/create_dir' },
								{ label: 'Create Directory (All)', slug: 'file-system/create_dir_all' },
								{ label: 'Remove Directory', slug: 'file-system/remove_dir' },
								{ label: 'Remove Directory (All)', slug: 'file-system/remove_dir_all' },
								{ label: 'Directory Exists', slug: 'file-system/dir_exists' },
								{ label: 'List Directory', slug: 'file-system/list_dir' },
							],
						},
						{
							label: 'Paths',
							items: [
								{ label: 'Join', slug: 'file-system/path_join' },
								{ label: 'Parent', slug: 'file-system/path_parent' },
								{ label: 'Filename', slug: 'file-system/path_filename' },
								{ label: 'Extension', slug: 'file-system/path_extension' },
							],
						},
						{
							label: 'Special Dirs',
							items: [
								{ label: 'Home Directory', slug: 'file-system/get_home_dir' },
								{ label: 'Temp Directory', slug: 'file-system/temp_dir' },
								{ label: 'Current Directory', slug: 'file-system/current_dir' },
							],
						},
					],
				},
				{
					label: 'JSON Utilities',
					items: [
						{ label: 'Parse JSON', slug: 'json-utilities/parse_json' },
						{ label: 'To JSON', slug: 'json-utilities/to_json' },
					],
				},
				{
					label: 'Logging',
					items: [
						{ label: 'Info', slug: 'logging/info' },
						{ label: 'Print', slug: 'logging/print' },
					],
				},
				{
					label: 'Math Functions',
					items: [
						{ label: 'Math Operations', slug: 'math-functions/math-operations' },
					],
				},
				{
					label: 'Process Control',
					items: [
						{ label: 'When to use each function', slug: 'process-control/choosing-process-functions' },
						{ label: 'run_command', slug: 'process-control/run_command' },
						{ label: 'run_command_with_args', slug: 'process-control/run_command_with_args' },
						{ label: 'exec_command', slug: 'process-control/exec_command' },
						{ label: 'shell_command', slug: 'process-control/shell_command' },
						{ label: 'spawn_process', slug: 'process-control/spawn_process' },
						{ label: 'which_command', slug: 'process-control/which_command' },
						{ label: 'command_exists', slug: 'process-control/command_exists' },
					],
				},
				{
					label: 'App Control',
					items: [
						{ label: 'Exit and Hide', slug: 'app-control/exit_and_hide' },
						{ label: 'Timestamp', slug: 'app-control/timestamp' },
					],
				},
			],
		}),
	],
});