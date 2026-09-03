local M = {}

M.config = {
    separator = "  ",
    prefix = "",

    show_filename = true,

    -- Highlight for the current buffer.
    current_hl = "WinBar",

    -- Highlight for buffers that aren't current.
    other_hl = "WinBarOther",

    -- Highlight while the mouse is over a buffer number.
    hover_hl = "WinBarHover",

    -- Right-click action.
    -- "close" closes the buffer.
    -- "none" does nothing.
    right_click = "close",

    -- Enable mouse hover highlighting.
    hover = true,
}

M.state = {
    hovered = nil,
}

function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})

    -- Enable mouse
    vim.opt.mouse = "a"

    -- Default highlights.
    vim.api.nvim_set_hl(0, "WinBarOther", {
        link = "Comment",
    })

    vim.api.nvim_set_hl(0, "WinBarHover", {
        link = "Identifier",
    })

    -- Enable the winbar.
    vim.opt.winbar =
        "%!v:lua.require('winbarbuf').winbar()"

    if M.config.hover then
        vim.opt.mousemoveevent = true

        vim.keymap.set(
            { "n", "v", "i", "c" },
            "<MouseMove>",
            function()
                require("winbarbuf").mouse_move()
            end,
            {
                silent = true,
                desc = "Buffer Winbar mouse hover",
            }
        )
    end
end

function M.winbar()
    return require("winbarbuf.winbar").render()
end

function M.mouse(...)
    return require("winbarbuf.mouse").mouse(...)
end

function M.mouse_move(...)
    return require("winbarbuf.mouse").mouse_move(...)
end

function M.close_buffer(...)
    return require("winbarbuf.mouse").close_buffer(...)
end

return M
