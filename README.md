# My Neovim Configuration

This is my personal configuration for Neovim, a highly customizable text editor
that's great for programming and other text-based tasks.

## Requirements

To use this configuration, you'll need to have:
- [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) (Version 0.8 or Later) 
- [Nerd Font](https://github.com/ryanoasis/nerd-fonts) 

## Installation

Once you have Neovim installed, you can follow these steps to use this
configuration:

- Clone this repository to your local machine: `git clone
  https://github.com/coderxin/nvim-setup.git`
- Run `./install` script to symlink file to your Neovim configuration directory:
  - On Unix-based systems (Linux, macOS), this is usuaully `~/.config/nvim`.
- Start Neovim. After staring Neovim, plugins will be automatically installed.
- Restart Neovim after the plugins install.

## Plugins

My Neovim configuration includes a number of plugins and settings that I find
useful for my workflow. Check [`lua/coderxin/plugins-setup.lua`](https://github.com/coderxin/nvim-setup/blob/main/lua/coderxin/plugins-setup.lua#L39) for available plugins.

## Contributing

Feel free to fork this repository and make your own changes to the
configuration. If you think your changes would be useful to others, please
submit a pull request so that they can be included in the main repository.

## License

This configuration is released under the [MIT
License](https://opensource.org/licenses/MIT). Feel free to use it for any
purpose, with or without attribution.
