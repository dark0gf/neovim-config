# Neovim Configuration

Personal Neovim configuration based on NvChad starter.

## Features

- Built on NvChad for a solid, extensible base
- Lazy plugin management with lazy.nvim
- LSP configuration with lspconfig
- Code formatting with conform.nvim
- Custom keybindings and autocmds

## Directory Structure

```
lua/
├── configs/          # Plugin configurations
│   ├── conform.lua   # Code formatter setup
│   ├── lazy.lua      # Plugin manager config
│   └── lspconfig.lua # LSP configuration
├── plugins/          # Plugin specifications
├── autocmds.lua      # Autocommands
├── chadrc.lua        # NvChad configuration
├── mappings.lua      # Keybindings
└── options.lua       # Neovim options
```

## Installation

Clone this repo to your Neovim config directory:

```bash
git clone https://github.com/dark0gf/neovim-config.git ~/.config/nvim
```

Then start Neovim and let lazy.nvim install plugins automatically.

## Based On

- [NvChad](https://github.com/NvChad/NvChad) - The base configuration framework
- [LazyVim](https://github.com/LazyVim/starter) - Inspiration for plugin management
