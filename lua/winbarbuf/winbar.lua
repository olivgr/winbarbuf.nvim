local M = {}

local winbarbuf = require("winbarbuf")
local buffers = require("winbarbuf.buffers")

local function buffer_label(buf)
    local current = vim.api.nvim_get_current_buf()

    local hl

    if buf == winbarbuf.state.hovered then
        hl = winbarbuf.config.hover_hl
    elseif buf == current then
        hl = winbarbuf.config.current_hl
    else
        hl = winbarbuf.config.other_hl
    end

    return string.format(
        "%%#%s#%%%d@v:lua.require'winbarbuf'.mouse@%s%d%%T%%*",
        --"%%#%s#%%%d@v:lua.require('winbarbuf').mouse@%s%d%%T%%*",
        hl,
        buf,
        winbarbuf.config.prefix,
        buf
    )
end

function M.render()
    local result = {}

    local filename = ""
    if buffer_winbar.config.show_filename then
        filename = vim.fn.expand("%:t") .. "%m"
    end

    for _, buf in ipairs(buffers.list()) do
        table.insert(result, buffer_label(buf))
    end

    return filename
        .. "%m%="
        .. table.concat(result, winbarbuf.config.separator)
end

return M
