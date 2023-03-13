return {
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.norg.concealer"] = {},
                ["core.norg.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                        name = "[Neorg] "
                    }
                },
                ["core.norg.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/Notes"
                        }
                    }
                }
            }
        },
        dependencies = { { "nvim-lua/plenary.nvim" } },
    }
}
