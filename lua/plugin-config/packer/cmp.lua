local cmp = require("cmp")
local luasnip = require("luasnip")
local lsp_signature = require("lsp_signature")

cmp.setup({
  snippet = {
    -- 告诉 cmp 如何展开 snippet
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),           -- 上翻文档
    ['<C-f>'] = cmp.mapping.scroll_docs(4),            -- 下翻文档
    ['<C-n>'] = cmp.mapping.complete(),                -- 手动触发补全
    ['<C-e>'] = cmp.mapping.abort(),                   -- 取消补全
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 回车确认
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- LSP 补全
    { name = 'luasnip' },  -- snippet 补全
  }, {
    { name = 'buffer' },   -- buffer 补全
    { name = 'path' },     -- 路径补全
  }),
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false
local lsp_data = require("data.plugin_data").lsp_data
local servers = lsp_data

for _, lsp in ipairs(servers) do
  if lsp == "html" then
    local caps = vim.deepcopy(capabilities)
    caps.textDocument.completion.completionItem.snippetSupport = true
    vim.lsp.config(lsp, { capabilities = caps })
  else
    vim.lsp.config(lsp, { capabilities = capabilities })
  end
end

lsp_signature.setup({
  bind = true,
  floating_window = true,
  hint_enable = false,
  floating_window_above_cur_line = true,
  handler_opts = { border = "rounded" },
})
