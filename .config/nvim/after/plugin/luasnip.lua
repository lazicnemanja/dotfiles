local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local extras = require 'luasnip.extras'
local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt

local function filename_to_pascal_case(_, _)
  local filename = vim.fn.expand '%:t:r'
  return filename:gsub('(%a)([%w_]+)', function(first, rest)
    return first:upper() .. rest:lower()
  end)
end

-- const function
ls.add_snippets('typescriptreact', {
  s(
    'cf',
    fmt(
      [[
const {} = () => {{
  {}
}};
      ]],
      {
        i(1, 'fname'),
        i(0),
      }
    )
  ),
})

-- component
ls.add_snippets('typescriptreact', {
  s(
    'component',
    fmt(
      [[
import React from 'react';

const {} = () => {{
  return (
    <div>
      {}
    </div>
  );
}}

export default {};
      ]],
      {
        f(filename_to_pascal_case, {}),
        i(0),
        f(filename_to_pascal_case, {}),
      }
    )
  ),
})

-- page
ls.add_snippets('typescriptreact', {
  s(
    'nextpage',
    fmt(
      [[
import {{ NextPageContext }} from 'next';

type Props = {{
  {}
}}

export async function getServerSideProps(context: NextPageContext) {{
  return {{
    props: {{
      {}
    }}
  }};
}}

function {}({{ {} }}: Props) {{
  {}
}}

export default {}
      ]],
      {
        i(1, 'prop1: string'),
        i(2, 'prop1'),
        f(filename_to_pascal_case, {}),
        i(2, 'prop1'),
        i(0),
        f(filename_to_pascal_case, {}),
      }
    )
  ),
})

-- next page with layout
ls.add_snippets('typescriptreact', {
  s(
    'nextpagelayout',
    fmt(
      [[
import {{ NextPageContext }} from 'next';

type Props = {{
  {}
}}

export async function getServerSideProps(context: NextPageContext) {{
  return {{
    props: {{
      {}
    }}
  }};
}}

function {}({{ {} }}: Props) {{
  {}
}}

{}.getLayout = function getLayout(page: React.ReactElement) {{
  return (
    {{page}}
  );
}};

export default {}
      ]],
      {
        i(1, 'prop1: string'),
        i(2, 'prop1'),
        f(filename_to_pascal_case, {}),
        i(2, 'prop1'),
        i(0),
        f(filename_to_pascal_case, {}),
        f(filename_to_pascal_case, {}),
      }
    )
  ),
})
