return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tailwindcss-language-server",
        "angular-language-server",
        "typescript-language-server",
        "css-lsp",
        "html-lsp",
      })
    end,
  },
}
