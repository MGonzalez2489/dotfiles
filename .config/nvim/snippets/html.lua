local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- return {
--   ls.snippet({ trig = "dc" }, { t('<div class="'), i(1), t('">'), i(0), t("</div>") }),
-- }

return {
  s("html", {
    t({
      "<!DOCTYPE html>",
      '<html lang="en">',
      "  <head>",
      '    <meta charset="UTF-8 /">',
      '    <meta http-equiv="X-UA-Compatible" content="IE=edge">',
      '    <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
      "    <title>",
    }),
    i(1, ""),
    t({
      "</title>",
      "  </head>",
      "  <body>",
    }),
    i(2, ""),
    t({
      "</body>",
      "</html>",
    }),
  }, { description = "Basic HTML5 Page Structure" }),
  s("linkcss", { t({ '<link rel="stylesheet" type="text/css" href="styles.css">' }) }),
  ls.snippet({ trig = "dc" }, { t('<div class="'), i(1), t('">'), i(0), t("</div>") }),
}
