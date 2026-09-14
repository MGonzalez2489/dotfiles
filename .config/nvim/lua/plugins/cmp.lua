return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    local mapping = opts.mapping.insert

    -- Define nuevos mapeos
    mapping["<CR>"] = cmp.mapping.confirm({ select = true })

    -- Opcional: Deshabilita el mapeo <C-y> si no lo quieres
    mapping["<C-y>"] = nil

    -- Sobreescribe el objeto 'mapping' en la configuración de opts
    opts.mapping.insert = mapping
  end,
}
