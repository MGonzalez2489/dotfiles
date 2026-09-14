return {
  "folke/snacks.nvim",
  -- @type snacks.Config
  opts = {
    animate = {
      enabled = false,
    },
    explorer = {
      replace_netrw = true,
    },
    -- Documentation for the picker
    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
    picker = {
      sources = {
        explorer = {
          auto_close = false,
          focus = "list",
        },
      },
      layout = {
        preset = "telescope",
        -- preset = "vscode",
        -- When reaching the bottom of the results in the picker, I don't want
        -- it to cycle and go back to the top
        cycle = false,
      },
      layouts = {
        telescope = {
          reverse = true,
          layout = {
            box = "horizontal",
            backdrop = true,
            width = 0.8,
            height = 0.9,
            border = "none",
            {
              box = "vertical",
              {
                win = "list",
                title = " Results ",
                title_pos = "center",
                border = "rounded",
              },
              {
                win = "input",
                height = 1,
                border = "rounded",
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
            },
            {
              win = "preview",
              title = "{preview:Preview}",
              width = 0.59,
              border = "rounded",
              title_pos = "center",
            },
          },
        },
        vscode = {
          preview = true,
          layout = {
            backdrop = true,
          },
        },
      },
      matcher = {
        frecency = true,
      },
      win = {
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            -- I'm used to scrolling like this in LazyGit
            ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
            ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
            ["<a-w>"] = false,
            ["O"] = { "cycle_win", mode = { "i", "n" } },
            ["<C-n>"] = { "focus_preview", mode = { "i", "n" } },
          },
        },
        preview = {
          keys = {
            ["O"] = { "cycle_win", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["O"] = { "cycle_win", mode = { "i", "n" } },
          },
        },
      },
      formatters = {
        file = {
          -- filename_first = true, -- display filename before the file path
          -- truncate = 80,
          filename_first = false,
          fields = { "icon", "file", "ext" },
          icon_width = 2,
        },
      },
    },
    dashboard = {
      preset = {
        -- header = [[wasaaaaaaaaaaaaaaaaa]],
      },
      enabled = false,
    },
  },
  keys = {
    -- find files
    { "<C-p>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    {
      "<C-S-F>",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    -- Open git log in vertical view
    -- {
    --   "<leader>gl",
    --   function()
    --     Snacks.picker.git_log({
    --       finder = "git_log",
    --       format = "git_log",
    --       preview = "git_show",
    --       confirm = "git_checkout",
    --       layout = "vertical",
    --     })
    --   end,
    --   desc = "Git Log",
    -- },
  },
}
