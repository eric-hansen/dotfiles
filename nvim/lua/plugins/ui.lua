return {
    {
        "chentoast/marks.nvim",
        config = function () require 'marks'.setup {} end,
    },
    {
        "giusgad/pets.nvim",
        config = function() require 'pets'.setup {} end,
        dependencies = { "MunifTanjim/nui.nvim", "edluffy/hologram.nvim" },
    },
    {
        'tzachar/local-highlight.nvim',
        config = function()
            require('local-highlight').setup({
                file_types = { 'php', 'html', 'javascript', 'lua' }
            })
        end
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function () require('statuscol').setup {} end
    },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function ()
      require("nvim-tree").setup()
    end,
    init = function ()
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>', { desc = "Toggle File Browser" })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = {
      provider_selector = function (bufnr, filetype, buftype) return {'treesitter', 'indent'} end,
    },
  },

    {
        "rebelot/kanagawa.nvim",
        init = function () vim.cmd [[colorscheme kanagawa-dragon ]] end,
    },
  -- {
  --   "folke/tokyonight.nvim",
  --   init = function() vim.cmd[[colorscheme tokyonight]] end
  -- },
  -- better vim.notify
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>nd",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- bufferline
  -- {
  --   "akinsho/nvim-bufferline.lua",
  --   event = "BufAdd",
  --   opts = {
  --     options = {
  --       diagnostics = "nvim_lsp",
  --       always_show_bufferline = false,
  --       diagnostics_indicator = function(_, _, diag)
  --         local icons = require("config").icons.diagnostics
  --         local ret = (diag.error and icons.Error .. diag.error .. " " or "")
  --           .. (diag.warning and icons.Warn .. diag.warning or "")
  --         return vim.trim(ret)
  --       end,
  --       offsets = {
  --         {
  --           filetype = "neo-tree",
  --           text = "Neo-tree",
  --           highlight = "Directory",
  --           text_align = "left",
  --         },
  --       },
  --     },
  --   },
  -- },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(plugin)
      if plugin.override then
        require("util").deprecate("lualine.override", "lualine.opts")
      end

      local icons = require("config").icons

      local function fg(name)
        return function()
          ---@type {foreground?:number}?
          local hl = vim.api.nvim_get_hl_by_name(name, true)
          return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
        end
      end

      return {
        options = {
          -- theme = "tokyonight",
          globalstatus = true,
          disabled_filetypes = { statusline = { "lazy", "alpha" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {  },
          lualine_c = {
            -- {
            --   "diagnostics",
            --   symbols = {
            --     error = icons.diagnostics.Error,
            --     warn = icons.diagnostics.Warn,
            --     info = icons.diagnostics.Info,
            --     hint = icons.diagnostics.Hint,
            --   },
            -- },
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 3, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            { function () return require('lspsaga.symbolwinbar'):get_winbar() end, cond = function () return require('lspsaga.symbolwinbar'):get_winbar() ~= nil end },
            { 'lsp_progress', display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } }, 	spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' }, },
        -- stylua: ignore
        -- {
        --   function() return require("nvim-navic").get_location() end,
        --   cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
        -- },
          },
          lualine_x = {
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = {
            { "branch" },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "nvim-tree" },
      }
    end,
        dependencies = {
            {"arkav/lualine-lsp-progress" }
        },
  },

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
      -- char = "▏",
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  -- active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "BufReadPre",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },

  -- noicer ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward" },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward"},
    },
  },

  -- lsp symbol navigation for lualine
  {
    "SmiteshP/nvim-navic",
    init = function()
      vim.g.navic_silence = true
      require("util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = { separator = " ", highlight = true, depth_limit = 5 },
  },

  -- icons
  "nvim-tree/nvim-web-devicons",

  -- ui components
  "MunifTanjim/nui.nvim",
}
