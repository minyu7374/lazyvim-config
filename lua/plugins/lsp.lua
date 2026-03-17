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
  {
    -- 自动悬浮展示doc
    name = "auto-hover",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    config = function()
      local hover_timer = nil
      local hover_delay = 500 -- 500ms延时
      local autocmd_ids = {}
      local enabled = false -- 默认先不开启

      local function register()
        autocmd_ids[1] = vim.api.nvim_create_autocmd(
          { "CursorMoved", "InsertEnter", "BufLeave", "CmdlineEnter", "CmdwinEnter" },
          {
            callback = function()
              if hover_timer then
                vim.fn.timer_stop(hover_timer)
                hover_timer = nil
              end
            end,
          }
        )
        autocmd_ids[2] = vim.api.nvim_create_autocmd("CursorHold", {
          callback = function()
            if hover_timer then
              vim.fn.timer_stop(hover_timer)
            end
            hover_timer = vim.fn.timer_start(hover_delay, function()
              hover_timer = nil
              if vim.fn.win_gettype() == "" then
                local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/hover" })
                if #clients > 0 then
                  vim.lsp.buf.hover()
                end
              end
            end)
          end,
        })
      end

      local function unregister()
        for _, id in ipairs(autocmd_ids) do
          pcall(vim.api.nvim_del_autocmd, id)
        end
        autocmd_ids = {}
        if hover_timer then
          vim.fn.timer_stop(hover_timer)
          hover_timer = nil
        end
      end

      local function toggle()
        if enabled then
          unregister()
          enabled = false
          vim.notify("Auto hover disabled")
        else
          register()
          enabled = true
          vim.notify("Auto hover enabled")
        end
      end

      if enabled then register() end
      vim.keymap.set("n", "<leader>th", toggle, { desc = "Toggle auto hover" })
    end,
  },
}
