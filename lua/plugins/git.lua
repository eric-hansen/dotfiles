return {
  {
    'kdheepak/lazygit.nvim',
    init = function ()
      vim.keymap.set('n', '<leader>gg', ':LazyGit<cr>', { desc = "Git" })
    end,
  },
}
