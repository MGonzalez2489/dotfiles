local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- Función para capitalizar la primera letra
local capitalize = function(str)
  return str:sub(1, 1):upper() .. str:sub(2)
end

ls.add_snippets("typescriptreact", {
  -- RFC - React Functional Component
  s(
    "rfc",
    fmt(
      [[
        export {export_type} {component_name} = ({props}) => {{
          return ({children});
        }}
      ]],
      {
        export_type = i(1, "const"),
        component_name = f(function()
          return vim.fn.expand("%:t:r")
        end),
        props = i(2, "props"),
        children = i(3, "<div>{component_name}</div>"),
      }
    )
  ),

  -- useState Hook
  s(
    "us",
    fmt(
      [[
        const [{state_name}, set{capitalized_state_name}] = useState({});
      ]],
      {
        state_name = i(1, "count"),
        capitalized_state_name = f(function(args)
          return capitalize(args[1][1])
        end, { i(1) }),
        i(2, "0"),
      }
    )
  ),

  -- useEffect Hook
  s(
    "ue",
    fmt(
      [[
        useEffect(() => {{
          {code}
        }}, [{dependencies}]);
      ]],
      {
        code = i(1),
        dependencies = i(2),
      }
    )
  ),

  -- useRef Hook
  s(
    "ur",
    fmt(
      [[
        const {ref_name} = useRef({});
      ]],
      {
        ref_name = i(1, "myRef"),
        i(2, "null"),
      }
    )
  ),
})
