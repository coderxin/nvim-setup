# My Neovim Configuration

Personal Neovim setup with file search, LSP completion, diagnostics, formatting,
Git tools, and debugging controls. Space is the leader key.

## Requirements

- Neovim **0.11.3 or later**; validated with **0.11.3 and 0.12.6**.
- Git, `make`, a C compiler, `curl`, `tar`, and tree-sitter CLI **0.26.1+**.
- A Nerd Font for icons, and `ripgrep` for Telescope text search.
- Node.js/npm for JavaScript-based language servers and TypeScript tools.
- `lazygit` for `Space gg` and a clipboard provider for system copy/paste.

The committed `lazy-lock.json` pins the plugin versions tested with this config.
Use `:Lazy restore` to restore them; use `:Lazy update` only when you intend to
update and test the lockfile. Restart Neovim after upgrading its executable.

## Installation

Clone this repository, then run `./install` from its directory to link it to
`~/.config/nvim`. **Back up any existing config first: the installer replaces that
path.** Start Neovim to install plugins, then restart after installation finishes.
Tree-sitter installs the configured parsers asynchronously; highlighting becomes
available after installation and reopening the file. Run `:TSUpdate` after updating
the Tree-sitter plugin.

Mason installs the language servers listed in `lua/coderxin/plugins/lsp.lua`.
Native `vim.lsp.config` / `vim.lsp.enable` configure them, while rustaceanvim and
TypeScript Tools own their respective servers. Ruby requires `solargraph` on PATH
(for example, installed with `gem install solargraph` in your Ruby environment).
TypeScript Tools needs a project-local `typescript` package or global `tsserver`.
Python syntax highlighting and formatting are configured; a Python language server
is not installed by this config.

## Useful shortcuts

All shortcuts are in Normal mode unless stated otherwise.

| Keys | Action |
| --- | --- |
| `i`, `a`, `o` | Start editing before/after the cursor or on a new line |
| `jj` or `Esc` (Insert mode) | Return to Normal mode |
| `Space w` | Save |
| `Space ff` / `Space fs` | Find files / search project text |
| `Space fb` / `Space e` | Find open buffers / toggle file explorer |
| `Space a`, `Space 1`–`4`, `Ctrl e` | Bookmark a file, jump to a bookmark, open bookmark menu |
| `gd`, `K` | Definition / hover documentation when an LSP is attached |
| `Space vrr`, `Space vrn`, `Space vca` | References, rename, code actions |
| `[d` / `]d` | Previous / next diagnostic when an LSP is attached |
| `Space xx` / `Space xw` | Toggle project diagnostics |
| `Space xd` | Toggle current-buffer diagnostics |
| `Space xl` / `Space xq` | Toggle location list / quickfix list |
| `gR` | Toggle LSP references in Trouble |
| `Space cf` | Format buffer or Visual selection, including before the first save |
| `Space gg` | Open LazyGit |

## Formatting

Conform is the single format-on-save owner. It uses `stylua` for Lua,
`prettierd` or `prettier` for JS/TS/JSON/CSS/HTML/Markdown, `rustfmt` for Rust,
`ruff` for Python, and `shfmt` for shell scripts. Install the formatters you need
on PATH (Mason's `:Mason` can install supported tools). When no configured formatter
is available, Conform falls back to an attached LSP that supports formatting.
`:ConformInfo` shows formatter availability and logs.

Debugging shortcuts configure the DAP UI; language-specific debug adapters and
launch configurations must be supplied separately.

## Validation

Run `nvim --headless -l tests/smoke.lua` after installing the locked plugins.
The smoke test runs the config in a child Neovim process with isolated state and
checks startup, pre-save formatting, completion, diagnostics, and LSP attachment.

## Contributing

Open a pull request with the change and validation results.

## License

This configuration is released under the [MIT License](https://opensource.org/licenses/MIT).
