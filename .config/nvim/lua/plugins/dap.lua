return {
  "mfussenegger/nvim-dap",
  recommended = true,
  desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mxsdev/nvim-dap-vscode-js",
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },
  keys = {
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Breakpoint Condition",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Run/Continue",
    },
    {
      "<leader>da",
      function()
        require("dap").continue({ before = get_args })
      end,
      desc = "Run with Args",
    },
    {
      "<leader>dC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    {
      "<leader>dg",
      function()
        require("dap").goto_()
      end,
      desc = "Go to Line (No Execute)",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<leader>dj",
      function()
        require("dap").down()
      end,
      desc = "Down",
    },
    {
      "<leader>dk",
      function()
        require("dap").up()
      end,
      desc = "Up",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run Last",
    },
    {
      "<leader>do",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<leader>dO",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<leader>dP",
      function()
        require("dap").pause()
      end,
      desc = "Pause",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle REPL",
    },
    {
      "<leader>ds",
      function()
        require("dap").session()
      end,
      desc = "Session",
    },
    {
      "<leader>dt",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },
    {
      "<leader>dw",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Widgets",
    },
  },
  config = function()
    local dap = require("dap")
    local utils = require("dap.utils")
    dap.set_log_level("DEBUG")
    dap.set_log_level = "DEBUG"
    dap.adapters = {
      ["pwa-node"] = {
        type = "server",
        host = "::1",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = {
            "${port}",
          },
        },
      },
      ["codelldb"] = {
        type = "server",
        port = "${port}",
        executable = {
          -- command = 'codelldb',
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      },
    }
    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to process ID",
        processId = utils.pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Local NestJS (port xxxx)",
        address = "localhost",
        port = "${port}",
        cwd = "${workspaceFolder}",
        restart = true,
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "ZTO - Dockerised NestJS (port 9229)",
        address = "localhost",
        port = "${port}",
        localRoot = "${workspaceFolder}",
        remoteRoot = "usr/src/app",
        -- resolveSourceMapLocations = { '${workspaceFolder}/dist', '!**/node_modules/**' },
        restart = true,
      },
    }
    dap.configurations.typescript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to process ID",
        processId = utils.pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node", -- Asumo que 'pwa-node' es el nombre de tu adaptador, ajusta si es 'node2'
        request = "attach",
        name = "Local NestJS (dynamic port)", -- Cambié el nombre para reflejar que es dinámico
        address = "localhost",
        -- Aquí es donde haremos el cambio:
        port = function()
          -- dap.utils.input es la forma preferida para inputs en DAP
          local port_str = vim.fn.input("Enter port for NestJS: ", "9229")
          local port_num = tonumber(port_str)
          if port_num == nil then
            print("Invalid port number. Defaulting to 9229.")
            return 9229
          else
            return port_num
          end
        end,
        cwd = "${workspaceFolder}",
        restart = true,
      },
      -- {
      --   type = "pwa-node",
      --   request = "attach",
      --   name = "Local NestJS (port 3000)",
      --   address = "localhost",
      --   port = "3000",
      --   cwd = "${workspaceFolder}",
      --   restart = true,
      -- },
      -- {
      --   type = "pwa-node",
      --   request = "attach",
      --   name = "ZTO - Dockerised NestJS (port 9229)",
      --   address = "localhost",
      --   port = 9229,
      --   localRoot = "${workspaceFolder}",
      --   remoteRoot = "usr/src/app",
      --   -- resolveSourceMapLocations = { '${workspaceFolder}/dist', '!**/node_modules/**' },
      --   restart = true,
      -- },
      -- Puedes agregar más configuraciones aquí, por ejemplo para Jest, etc.
    }
  end,
}
