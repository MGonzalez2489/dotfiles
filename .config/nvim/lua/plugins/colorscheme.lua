return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      dim_inactive = true,
    },
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Everforest
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "hard",
        italics = true,
        on_highlights = function(hl, palette)
          hl["DiagnosticUnderlineWarn"] = { undercurl = true, sp = palette.yellow }
        end,
      })
    end,
  },
}
