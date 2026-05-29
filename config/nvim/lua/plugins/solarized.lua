return {
  -- add Lua-scriptable solarized color scheme
  { "f-person/auto-dark-mode.nvim" },
  {
    "maxmx03/solarized.nvim",
    branch = "main",
    lazy = false,
    name = "solarized",
    main = "solarized",
    priority = 1000,
    -- Display colors in a new buffer with command: `:Solarized colors`
    -- See: https://www.lazyvim.org/configuration/plugins#%EF%B8%8F-customizing-plugin-specs
    opts = {
      -- See: https://github.com/maxmx03/solarized.nvim/blob/main/lua/solarized/palette.lua
      palette = "selenized",
      variant = "spring",
      -- See: https://github.com/maxmx03/solarized.nvim?tab=readme-ov-file#default-config
      styles = {
        keywords = { bold = false },
      },
    },
    config = function(plugin, opts)
      require(plugin.main).setup(opts)
      vim.cmd.colorscheme = "solarized"
    end,
  },

  -- configure LazyVim to load solarized
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },
}
