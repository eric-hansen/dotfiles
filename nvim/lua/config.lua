---@type LazyVimConfig
local M = {}

M.lazy_version = ">=9.1.0"

---@class LazyVimConfig
local defaults = {
  -- colorscheme can be a string like `catppuccin` or a function that will load the colorscheme
  ---@type string|fun()
    colorscheme = function()
        -- require("tokyonight").load()
        require 'kanagawa'.setup {
            undercurl = false,
            commentStyle = { italic = false },
            keywordStyle = { italic = false },
            statementStyle = { italic = false },
            dimInactive = true,
            theme = 'dragon'
        }
    end,
    -- icons used by other plugins
    icons = {
        diagnostics = {
            Error = " ",
            Warn = " ",
            Hint = " ",
            Info = " ",
        },
        git = {
            added = " ",
            modified = " ",
            removed = " ",
        },
        arrows = {
            right = "➜",
        },
        kinds = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "ﰠ",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "",
            Array = " ",
            Boolean = " ",
            Key = "",
            Namespace = " ",
            Null = "ﳠ ",
            Number = " ",
            Object = " ",
            Package = " ",
            String = " ",
        },
    },
}
---@type LazyVimConfig
local options

---@param opts? LazyVimConfig
function M.setup(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {})
  if not M.has() then
    require("lazy.core.util").error(
      "**LazyVim** needs **lazy.nvim** version "
        .. M.lazy_version
        .. " to work properly.\n"
        .. "Please upgrade **lazy.nvim**",
      { title = "LazyVim" }
    )
  end

  -- autocmds and keymaps can wait to load
--  vim.api.nvim_create_autocmd("User", {
--    group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
--    pattern = "VeryLazy",
--    callback = function()
      M.load("plugins.autocmds")
      M.load("keymaps")
--    end,
--  })

  require("lazy.core.util").try(function()
    if type(M.colorscheme) == "function" then
      M.colorscheme()
    else
      vim.cmd.colorscheme(M.colorscheme)
    end
  end, {
    msg = "Could not load your colorscheme",
    on_error = function(msg)
      require("lazy.core.util").error(msg)
      vim.cmd.colorscheme("habamax")
    end,
  })
end

---@param range? string
function M.has(range)
  local Semver = require("lazy.manage.semver")
  return Semver.range(range or M.lazy_version):matches(require("lazy.core.config").version or "0.0.0")
end

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
  local Util = require("lazy.core.util")
  -- always load lazyvim, then user file
  for _, mod in ipairs({ "lazyvim.config." .. name, "config." .. name, name }) do
    local err, pkg = pcall(require, mod)

    if not err then return end
  end

  print('Unable to load module: ' .. name .. ': ' .. err)
end

setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      M.setup()
    end
    ---@cast options LazyVimConfig
    return options[key]
  end,
})

return M
