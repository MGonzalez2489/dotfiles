local ls = require("luasnip")

local t = ls.text_node
--

return {
  ls.snippet(
    { trig = "lorem" },
    { t("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...") }
  ),
}
