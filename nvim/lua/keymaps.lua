local s = vim.keymap.set

local f = function (modes, key, cmd, opts)
    opts = opts or {silent = true, noremap = true}

    s(modes, key, cmd, opts)
end

s('n', '<C-s>', ':w!<cr>', { desc = "Save changes" })
s('i', '<C-s>', ':w!<cr>', { desc = "Save changes" })
s('t', '<esc>', '<C-\\><C-n>', { silent = true, desc = "Escape Terminal Mode" })
f('n', '=', ':vert resize +5<cr>', { desc = "Make window vertically bigger" })
f('n', '-', ':vert resize -5<cr>', { desc = "Make window vertically smaller" })
f('n', '+', ':horizontal resize +5<cr>', { desc = "Make window horizontally wider" })
f('n', '_', ':horizontal resize -5<cr>', { desc = "Make window horizontally thinner" })
f('n', '<C-h>', '<C-w>h')
f('n', '<C-j>', '<C-w>j')
f('n', "<C-k>", "<C-w>k")
f('n', '<C-l>', '<C-w>l')
f('v', '>', '>gv')
f('v', '<', '<gv')
