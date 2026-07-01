-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ===== 输入兼容 =====

-- 全角冒号（中文输入法场景）
map({ "n", "v", "o" }, "：", ":", { desc = "Compatible Full-width Colon" })

-- 插入原生 <Tab>（绕过补全插件）
map("i", "<S-Tab>", "<C-v><Tab>", { desc = "Insert Literal Tab" })

-- ===== Evil/Emacs 兼容 =====

-- emacs vterm 中 vim/evil 冲突，C-Q 退出插入/命令模式
map({ "i", "c" }, "<C-Q>", "<Esc>", { desc = "Escape (Evil compat)" })

-- emacs 占用 C-A/C-X，改用 g=/g- 作为数字增减，这里也和 eamcs 保持一致
map({ "n", "v", "o" }, "g=", "<C-a>", { desc = "Increment Number" })
map({ "n", "v", "o" }, "g-", "<C-x>", { desc = "Decrement Number" })

-- ===== 编辑操作 =====

-- 插入空行，不进入插入模式
map("n", "<leader>o", "o<Esc>k", { nowait = true, desc = "Insert Line Below" })
map("n", "<leader>O", "O<Esc>j", { nowait = true, desc = "Insert Line Above" })

-- 插入当前时间戳
map("n", "<leader>it", function()
  local t = os.date("%Y/%m/%d %H:%M")
  vim.cmd("normal! a" .. t)
end, { desc = "Insert Current Timestamp" })

-- ===== 搜索 =====

-- * 搜索高亮但不跳转
map("n", "*", function()
  vim.fn.setreg("/", "\\<" .. vim.fn.expand("<cword>") .. "\\>")
  vim.opt.hlsearch = true
end, { silent = true, desc = "Search Word (No Jump)" })

map("n", "g*", function()
  vim.fn.setreg("/", vim.fn.expand("<cword>"))
  vim.opt.hlsearch = true
end, { silent = true, desc = "Search Word (Original Behavior)" })

-- 全局搜索，借鉴doomemacs
map("n", "<leader>*", "<leader>sw", { remap = true, desc = "Search Word (Root Dir)" })

-- ===== 文件操作 =====

-- sudo 保存
map("n", "<leader>W", ":w !sudo tee %<CR>", { silent = true, desc = "Sudo Save" })

-- 强制退出
map("n", "<leader>Q", ":q!<CR>", { silent = true, desc = "Force Quit" })

-- cd 到当前文件所在目录
map("n", "<leader>fd", function()
  vim.cmd("cd " .. vim.fn.expand("%:p:h"))
  print(vim.fn.getcwd())
end, { desc = "CD to File Directory" })

-- ===== Tab 操作 =====

map("n", "<M-t>", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("i", "<M-t>", "<Esc><cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<C-t>", "<cmd>tabnext<CR>", { desc = "Next Tab" })
map("i", "<C-t>", "<Esc><cmd>tabnext<CR>", { desc = "Next Tab" })
-- map("n", "<M-d>", "<cmd>tabclose<CR>", { desc = "Close Tab" })
-- map("i", "<M-d>", "<Esc><cmd>tabclose<CR>", { desc = "Close Tab" })

for i = 1, 9 do
  map("n", "<leader>" .. i, i .. "gt", { desc = "Jump to Tab " .. i })
end
map("n", "<leader>0", "<cmd>tablast<CR>", { desc = "Jump to Last Tab" })

-- ===== 复制粘贴 =====

-- 全选 + 系统剪贴板复制/粘贴
map({ "n", "v", "o" }, "<M-a>", 'ggVG"+y', { desc = "Select All & Copy to Clipboard" })
map({ "i", "c" }, "<M-a>", '<Esc>ggVG"+y', { desc = "Select All & Copy to Clipboard" })
map({ "n", "v", "o" }, "<M-v>", 'ggVG"+p', { desc = "Select All & Paste from Clipboard" })
map({ "i", "c" }, "<M-v>", '<Esc>ggVG"+p', { desc = "Select All & Paste from Clipboard" })

-- paste 模式快速切换（nopaste/paste）
vim.keymap.set("n", "<leader>ty", function()
  vim.opt.paste = not vim.opt.paste:get()
  vim.notify("Paste mode: " .. (vim.opt.paste:get() and "ON" or "OFF"))
end, { desc = "Toggle Paste Mode" })

-- ===== 阅读体验 =====

-- wrap 自动换行快速切换（nowrap/wrap，默认开启见 options.lua）
vim.keymap.set("n", "<leader>tw", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  vim.notify("Wrap mode: " .. (vim.opt.wrap:get() and "ON" or "OFF"))
end, { desc = "Toggle Wrap Mode" })

-- ===== 注释 =====
map("n", "<leader>c<leader>", "gcc", { remap = true, desc = "Toggle Comment" })
map("v", "<leader>c<leader>", "gc", { remap = true, desc = "Toggle Comment" })
