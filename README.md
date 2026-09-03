# winbarbuf.nvim

Filename and buffer list displayed in Neovim's winbar.

## Screenshot
![winbarbuf.nvim.](screenshot.png)

## Features

- Displays filename and buffers in the winbar
- Click a buffer number to switch buffers
- Right-click to close buffers
- Mouse hover highlighting
- Configurable highlights
- No dependencies

## Installation

### vim-plug

Add the following to your init.vim or init.lua:
```lua
Plug 'olivgr/winbarbuf.nvim'
```
Then run:
```lua
:PlugInstall
```
Finally, add:
```lua
require("winbarbuf").setup()
```

### lazy.nvim

```lua
{
    "olivgr/winbarbuf.nvim",
    config = function()
        require("winbarbuf").setup()
    end,
}
```

## Configuration
```lua
require("winbarbuf").setup({
    separator = "  ",
    prefix = "b:",
    show_filename = true,
    current_hl = "WinBar",
    other_hl = "WinBarOther",
    hover_hl = "WinBarHover",
    right_click = "close",
    hover = true,
})
```

## Tips
- I like to map Ctrl-h to `:bprevious` and Ctrl-l to `:bnext` for easy buffer switching.
