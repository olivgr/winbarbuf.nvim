local M = {}

function M.valid(buf)
    return vim.api.nvim_buf_is_valid(buf)
        and vim.api.nvim_buf_is_loaded(buf)
        and vim.bo[buf].buflisted
end

function M.list()
    local result = {}

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if M.valid(buf) then
            table.insert(result, buf)
        end
    end

    return result
end

return M