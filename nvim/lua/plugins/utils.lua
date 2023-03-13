return {
    {
  "nvim-lua/plenary.nvim"
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = {
            {"nvim-lua/plenary.nvim"}
        },
        opts = function ()
            require("telescope").load_extension('harpoon')
        end,
    }
}
