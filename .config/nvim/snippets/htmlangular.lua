local ls = require("luasnip")

local t = ls.text_node

return {
  ls.snippet({ trig = "dc" }, { t('<div class="'), i(1), t('">'), i(0), t("</div>") }),
}
