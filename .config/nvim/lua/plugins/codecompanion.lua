return {
  "olimorris/codecompanion.nvim",
  version = "^18.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", --Optional: to autocomplete in buffer
    -- "ravitemer/mcphub.nvim",
  },
  opts = {
    language = "Spanish",

    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "GEMINI_API_KEY",
          },
          schema = {
            model = {
              default = "gemini-2.5-flash",
            },
          },
        })
      end,
      -- 2. Ejemplo Anthropic (Claude 3.5 Sonnet para tareas complejas de arquitectura)
      -- anthropic = function()
      --   return require("codecompanion.adapters").extend("anthropic", {
      --     env = {
      --       api_key = "ANTHROPIC_API_KEY",
      --     },
      --     schema = {
      --       model = {
      --         default = "claude-3-5-sonnet-latest",
      --       },
      --     },
      --   })
      -- end,
    },
    -- main strategy
    strategies = {
      chat = {
        -- it setup the default model
        adapter = {
          name = "gemini",
          model = "gemini-2.5-flash",
        }, -- Modelo por defecto para el chat
        roles = { user = "Manuel", llm = "CodeCompanion" },
        opts = {
          system_prompt = function()
            local path = vim.fn.getcwd() .. "/.codecompanion/system_prompt.md"
            if vim.fn.filereadable(path) == 1 then
              local lines = vim.fn.readfile(path)
              return table.concat(lines, "\n")
            end
            return "Eres un asistente experto en programación."
          end,
        },
        slash_commands = {
          ["buffer"] = {
            opts = { contains_code = true },
            description = "Insertar el buffer actual",
          },
          ["file"] = {
            opts = { contains_code = true },
            description = "Buscar e insertar un archivo del monorepo",
          },
          ["symbols"] = {
            opts = { contains_code = true },
            description = "Insertar símbolos/funciones (Treesitter)",
          },
          ["help"] = { opts = { contains_code = false } },
        },
        keymaps = {
          change_adapter = {
            modes = { n = "ga" },
            index = 1,
            callback = "keymaps.change_adapter",
            description = "Cambiar adapter / modelo actual",
          },
        },
      },
      inline = {
        adapter = "gemini",
      },
    },
    prompt_library = {
      ["Generate a Unit Test"] = {
        strategy = "inline",
        description = "Generar pruebas unitarias para el código seleccionado",
        opts = {
          adapter = "gemini",
          index = 1,
          is_default = true,
          is_slash_cmd = false,
          modes = { "v" },
          short_name = "unittest",
        },
        prompts = {
          {
            role = "system",
            content = "Eres un experto en testing. Genera pruebas unitarias concisas utilizando Jest para NestJS o Jasmine/Jest para Angular.",
          },
          {
            role = "user",
            content = "Por favor genera las pruebas unitarias para el siguiente código:\n\n```${filetype}\n${selection}\n```",
          },
        },
      },
    },

    display = {
      diff = {
        provider = "vertical",
      },
      chat = {
        window = {
          layout = "vertical",
          width = 0.45,
        },
      },
    },
  },
}
