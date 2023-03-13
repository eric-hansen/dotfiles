require('options')
require('keymaps')

local vim_plugins = {
  "netrw"
}

for _, vimPlugin in ipairs(vim_plugins) do
  vim.g[vimPlugin] = 1
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup("plugins")

vim.keymap.set('n', '<leader>p', ':Lazy<cr>', { desc = "Package Manager" })
