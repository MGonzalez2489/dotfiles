return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Quita un lenguaje para evitar que se instale automáticamente
        "json", -- Ejemplo: Si ya no trabajas con JSON, quítalo
        -- Deja los que sí usas:
        "lua",
        "javascript",
        "typescript",
        "html",
        "css",
        "jsdoc",
        "tsx",
        "xml",
      },
    },
  },
}
