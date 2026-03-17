-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ===== 自动格式化 =====

-- 默认关闭保存时自动格式化
vim.g.autoformat = false

-- 通过环境变量启用（direnv 配合使用）
if vim.env.FORMAT_ON_SAVE == "true" then
  vim.g.autoformat = true
end

-- ===== vim 基础配置 =====
local opt = vim.opt

-- 缩进
-- opt.tabstop = 4
-- opt.softtabstop = 4
-- opt.shiftwidth = 4

-- 自动读写
-- opt.hidden = true -- nvim默认
-- opt.autoread = true -- nvim默认
-- opt.autowrite = true -- lazyvim 默认已开启

-- 备份和缓存
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- 自动改变当前目录
-- opt.autochdir = true
