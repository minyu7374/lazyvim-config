-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- filetype添加ampl
vim.filetype.add({
  filename = {
    ["go.mod"] = "gomod",
  },
  extension = {
    mod  = "ampl",
    dat  = "ampl",
    ampl = "ampl",
  },
})

-- Go 语言强制开启自动格式化
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.b.autoformat = true
  end,
})

-- LSP体验增强，自动触发 hover
local hover_timer = nil

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    if hover_timer then
      vim.fn.timer_stop(hover_timer)
      hover_timer = nil
    end
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    if hover_timer then
      vim.fn.timer_stop(hover_timer)
    end
    -- 单独的 hover 延迟，500ms
    hover_timer = vim.fn.timer_start(500, function()
      hover_timer = nil
      local wintype = vim.fn.win_gettype()
      if wintype == "" then
        vim.lsp.buf.hover()
      end
    end)
  end,
})
