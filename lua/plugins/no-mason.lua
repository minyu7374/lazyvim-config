-- mason 自己管理lsp、linter等工具，冗余安装且不便控制，全部禁用
return {
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
  -- 如果启用了 dap extra 才需要这条:
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
}
