local M = {}
local function set_keymap(mode, key, action, desc)
    vim.keymap.set(mode, key, action, { noremap = true, silent = true, desc = desc })
end

M.map = function(keymaps)
    for _, keymap in ipairs(keymaps) do
        set_keymap(keymap.mode, keymap.key, keymap.action, keymap.desc)
    end
end

return M
