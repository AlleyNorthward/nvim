local M = {}

function M.on_attach(client, bufnr)
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "gh", vim.lsp.buf.hover, opts)
  map("n", "gD", vim.lsp.buf.declaration, opts)
  map("n", "gi", vim.lsp.buf.implementation, opts)
  map("n", "gr", vim.lsp.buf.references, opts)

  map("n", "gp", vim.diagnostic.open_float, opts)

  map("n", "gk", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, opts)

  map("n", "gj", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, opts)

  map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
end

return M
