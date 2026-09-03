local M = {}

local winbarbuf = require("winbarbuf")
local buffers = require("winbarbuf.buffers")

function M.mouse(minwid, clicks, button, modifiers)
    local buf = tonumber(minwid)

    if not buf or not buffers.valid(buf) then
        return
    end

    if button == "l" then
        vim.api.nvim_set_current_buf(buf)

    elseif button == "r" then
        if winbarbuf.config.right_click == "close" then
            M.close_buffer(buf)
        end
    end
end

function M.close_buffer(buf)
    if not buffers.valid(buf) then
        return
    end

    -- Don't force-close a modified buffer.
    if vim.bo[buf].modified then
        vim.notify(
            "Buffer " .. buf .. " has unsaved changes",
            vim.log.levels.WARN
        )
        return
    end

    vim.api.nvim_buf_delete(buf, {})
end

local function winbar_position(win)
    local pos = vim.api.nvim_win_get_position(win)

    -- Winbar is immediately above the window's text area.
    return pos[1], pos[2]
end

function M.mouse_move()
    local mouse = vim.fn.getmousepos()

    if not mouse.winid or mouse.winid == 0 then
        if winbarbuf.state.hovered ~= nil then
            winbarbuf.state.hovered = nil
            vim.cmd("redrawstatus")
        end
        return
    end

    local win = mouse.winid

    if not vim.api.nvim_win_is_valid(win) then
        return
    end

    local win_row, win_col = winbar_position(win)
    local win_width = vim.api.nvim_win_get_width(win)

    -- Mouse coordinates are 1-based.
    -- win_col from nvim_win_get_position() is 0-based.
    local mouse_col = mouse.screencol
    local right_edge = win_col + win_width

    local bufs = buffers.list()

    -- Calculate the width occupied by the buffer list.
    local labels = {}

    for _, buf in ipairs(bufs) do
        table.insert(
            labels,
            winbarbuf.config.prefix .. buf
        )
    end

    local buffer_text = table.concat(
        labels,
        winbarbuf.config.separator
    )

    local buffer_width = vim.fn.strdisplaywidth(buffer_text)

    -- The buffer list is right-aligned because of %=
    local buffer_start = right_edge - buffer_width + 1

    local hovered = nil
    local x = buffer_start

    for i, buf in ipairs(bufs) do
        local label = winbarbuf.config.prefix .. buf
        local width = vim.fn.strdisplaywidth(label)

        local label_start = x
        local label_end = x + width - 1

        if mouse_col >= label_start and mouse_col <= label_end then
            hovered = buf
            break
        end

        x = x + width

        if i < #bufs then
            x = x + vim.fn.strdisplaywidth(
                winbarbuf.config.separator
            )
        end
    end

    if hovered ~= winbarbuf.state.hovered then
        winbarbuf.state.hovered = hovered
        vim.cmd("redrawstatus")
    end
end

return M