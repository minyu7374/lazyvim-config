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
opt.tabstop = 4 -- 显示
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

-- 自动换行（LazyVim 默认关闭，这里默认开启）
opt.wrap = true

-- 拼写检查
opt.spelllang = "en,cjk"
opt.spelloptions = "camel" -- 按驼峰拆词，故 streamName / requestId 这类标识符无需入库
opt.spellfile = {
  vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
  vim.fn.stdpath("config") .. "/spell/zh.utf-8.add",
}
-- 自定义词库维护（spell/ 目录已在 .gitignore 中，属本机个人词库，不随仓库同步）
--   1. 交互添加：光标停在词上，`zg` 记为正确词（写入上面列表第一个文件），`zw` 记为错词；
--      `zug` / `zuw` 撤销。此方式会自动重新编译 .spl，无需手动生成。
--   2. 批量添加：直接编辑 spell/en.utf-8.add（每行一词，`#` 开头为注释）。
--      大写缩写用全大写（如 CDN 仅匹配 CDN）；产品/工具名用小写（如 redis 可匹配 Redis/REDIS）。
--   3. 手工编辑后生成二进制词表：`:mkspell! %`（正在编辑该 .add 文件时），
--      或 `:mkspell! ~/.config/nvim/spell/en.utf-8.add`。.add 比 .spl 新时下次用到也会自动重编。
