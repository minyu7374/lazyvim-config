-- AI 灰色内联候选的统一操作，同时兼容 codeium 与 copilot（原生 vim.lsp.inline_completion）
-- copilot 渲染用的 extmark namespace，用于判断当前是否有候选在显示
local copilot_ns = vim.api.nvim_create_namespace("nvim.lsp.inline_completion")

-- 当前显示 codeium 候选时返回其 virtual_text 模块，否则返回 nil
local function codeium_active()
  local ok, vt = pcall(require, "codeium.virtual_text")
  if ok and vt.get_current_completion_item() then
    return vt
  end
end

-- copilot 原生内联补全当前是否有候选在显示
local function copilot_visible()
  return #vim.api.nvim_buf_get_extmarks(0, copilot_ns, 0, -1, { limit = 1 }) > 0
end

-- 接受当前 AI 灰色候选：codeium 优先，其次 copilot；都没有则返回 nil 让 blink 走 fallback
local function ai_accept()
  local vt = codeium_active()
  if vt then
    LazyVim.create_undo()
    vim.api.nvim_input(vt.accept())
    return true
  end
  if vim.lsp.inline_completion and vim.lsp.inline_completion.get() then
    return true
  end
end

-- 切换 AI 灰色候选：codeium 优先，其次 copilot；都没有则返回 nil 让 blink 走 fallback
local function ai_cycle(n)
  local vt = codeium_active()
  if vt then
    vt.cycle_completions(n)
    return true
  end
  if vim.lsp.inline_completion and copilot_visible() then
    vim.lsp.inline_completion.select({ count = n })
    return true
  end
end

return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        -- 与普通补全逻辑一致：C-n/C-p 切换候选，回车接受
        -- 每个键先作用于 blink 补全菜单，菜单未弹出时再作用于 AI 灰色候选（codeium / copilot），最后回退默认行为
        ["<C-n>"] = {
          "select_next",
          function()
            return ai_cycle(1)
          end,
          "fallback",
        },
        ["<C-p>"] = {
          "select_prev",
          function()
            return ai_cycle(-1)
          end,
          "fallback",
        },
        ["<CR>"] = {
          "accept",
          function()
            return ai_accept()
          end,
          "fallback",
        },
        -- Tab：接受补全菜单当前/第一个候选，否则接受 AI 灰色候选（codeium / copilot），否则普通 Tab
        ["<Tab>"] = {
          "accept",
          function()
            return ai_accept()
          end,
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
  },
}
