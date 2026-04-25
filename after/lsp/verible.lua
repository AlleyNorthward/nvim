return {
  cmd = { 'verible-verilog-ls' },
  filetypes = { 'systemverilog', 'verilog' },
  root_markers = { '.git' },
    on_attach = function(client, bufnr)
    require("keymap-config.keymap_interface").lsp_map.on_attach(client, bufnr)
  end

}












