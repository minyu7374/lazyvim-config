return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false, -- 改为默认关闭，<leader>uh 手动开启
      },
      servers = {
        ["*"] = {
          keys = {
            { "gk", vim.lsp.buf.hover, desc = "Hover" },
          },
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        hover = {
          silent = true, -- 光标不在 LSP symbol 上时静默
        },
      },
    },
  },
}
