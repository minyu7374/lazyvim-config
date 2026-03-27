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

-- 制表符&缩进 (.editorconfig细化控制，这里不做太多配置)
opt.tabstop = 4        -- 显示
-- opt.softtabstop = 4    -- 编辑
-- opt.shiftwidth = 4     -- 缩进

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

-- 拼写检查
opt.spelllang = "en,cjk"
opt.spelloptions = "camel"
opt.spellfile = {
  vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
  vim.fn.stdpath("config") .. "/spell/zh.utf-8.add",
}
