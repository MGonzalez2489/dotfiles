return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      dim_inactive = true,
    },
  },

  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "deep",
        --style = Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      })
      require("onedark").load()
    end,
  },
}
