# winbarbuf.nvim

A buffer list displayed in Neovim's winbar.

## Features

- Displays listed buffers in the winbar
- Click a buffer number to switch buffers
- Right-click to close buffers
- Mouse hover highlighting
- Configurable highlights
- No dependencies

## Installation

### lazy.nvim

```lua
{
    "YOUR_USERNAME/winbarbuf.nvim",
    config = function()
        require("winbarbuf").setup()
    end,
}
```

## Configuration
```lua
require("buffer_winbar").setup({
    separator = "  ",
    prefix = "b:",
    current_hl = "WinBar",
    other_hl = "WinBarOther",
    hover_hl = "WinBarHover",
    right_click = "close",
    hover = true,
})
```