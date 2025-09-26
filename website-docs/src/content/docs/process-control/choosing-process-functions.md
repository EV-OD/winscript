---
title: "When to use each process function"
description: "Practical guidance for choosing run_command, exec_command, shell_command, spawn_process, which_command, and command_exists"
---

# When to use each process function

Use this quick guide to pick the right function for your task. No code examples, just real-world scenarios.

## run_command (aka run_cmd)
- Best for simple commands where you just need stdout as a string.
- Use when you don’t need the exit code or stderr separately.
- Real-world: printing OS info, getting the current user, listing a folder, quick one-liners without shell features.

## run_command_with_args (aka run_cmd_args)
- Pass arguments safely without worrying about quoting/escaping.
- Use for CLIs that take structured flags and params.
- Real-world: calling git, curl, ping, or any CLI with multiple flags or paths that may contain spaces.

## exec_command (aka exec)
- Get full outcome details: stdout, stderr, exit_code, success.
- Use when you must branch on success/failure or display error details.
- Real-world: installers, health checks, pre-flight validations, or any step where you must handle failures explicitly.

## shell_command (aka sh)
- Leverage shell features like pipes, redirection, operators, and environment expansion.
- Cross-platform wrapper (Windows: cmd /C; Unix: sh -c).
- Real-world: chaining tools with pipes, redirecting output to files, using shell built-ins (dir/cd) for quick maintenance tasks.

## spawn_process (aka start_process)
- Fire-and-forget: start a process and continue without waiting.
- No output collection; ideal for background or GUI apps.
- Real-world: launching Notepad, starting a local dev server, kicking off a watcher or daemon alongside other work.

## which_command (aka which)
- Get the absolute path of an executable if it exists in PATH.
- Use to locate tools before invoking them or for diagnostics.
- Real-world: confirming where node, git, or python is installed to display to the user.

## command_exists
- Lightweight boolean check for tool availability.
- Use to guard code paths or show actionable messages when prerequisites are missing.
- Real-world: verifying git exists before running a repo task; checking 7zip is installed before attempting compression.

## Quick picks
- Need only stdout quickly → run_command / run_command_with_args
- Need exit code and stderr too → exec_command
- Need pipes/redirection/shell built-ins → shell_command
- Don’t wait for completion → spawn_process
- Need to find or verify a tool → which_command / command_exists
