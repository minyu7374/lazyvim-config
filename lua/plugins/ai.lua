-- root 用户下 AI extras 已在 config/lazy.lua 被 cond 跳过，这里直接不加载任何覆盖配置
if vim.loop.getuid() == 0 then
  return {}
end

local copilot_enabled = false
local nvidia_base = {
  __inherited_from = "openai",
  endpoint = "https://integrate.api.nvidia.com/v1",
  api_key_name = "NVIDIA_NIM_API_KEY",
}
local groq_base = {
  __inherited_from = "openai",
  endpoint = "https://api.groq.com/openai/v1",
  api_key_name = "GROQ_API_KEY",
}

return {
  -- Copilot（copilot.lua 迁移改用为 copilot-native extra 的原生 LSP 内联补全）
  -- 默认开关由顶层 copilot_enabled 控制，<leader>tc 手动开关（原生内联补全状态是全局的，不再区分 session/global）
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- copilot-native extra 会在 setup 时自动开启内联补全，这里在 copilot 首次 attach 后重置为 copilot_enabled 指定的默认值
      local initialized = false
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Copilot 内联补全默认状态",
        callback = function(args)
          if initialized then
            return
          end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "copilot" then
            initialized = true
            -- 延迟到 extra 的 enable() 之后执行，确保最终为 copilot_enabled 指定的状态
            vim.schedule(function()
              vim.lsp.inline_completion.enable(copilot_enabled)
            end)
          end
        end,
      })
    end,
    opts = {
      servers = {
        copilot = {
          keys = {
            {
              "<leader>tc",
              function()
                copilot_enabled = not copilot_enabled
                vim.lsp.inline_completion.enable(copilot_enabled)
                vim.notify("Copilot 补全 " .. (copilot_enabled and "已开启" or "已关闭"))
              end,
              desc = "Toggle Copilot",
              mode = { "n" },
            },
          },
        },
      },
    },
  },
  -- Codeium
  {
    "Exafunction/codeium.nvim",
    keys = {
      { "<leader>tm", "<cmd>Codeium Toggle<cr>", desc = "Toggle Codeium" },
    },
  },
  -- Avante
  {
    "yetone/avante.nvim",
    opts = {
      providers = {
        -- ["gemini-preview"] = { __inherited_from = "gemini", model = "gemini-3-flash-preview" },
        ["nvidia-deepseek"] = vim.tbl_extend("force", nvidia_base, { model = "deepseek-ai/deepseek-v4-pro" }),
        ["nvidia-glm"] = vim.tbl_extend("force", nvidia_base, { model = "z-ai/glm-5.1" }),
        ["nvidia-mimimax"] = vim.tbl_extend("force", nvidia_base, { model = "minimaxai/minimax-m3" }),
        ["nvidia-kimi"] = vim.tbl_extend("force", nvidia_base, { model = "moonshotai/kimi-k2.6" }),
        ["groq"] = vim.tbl_extend("force", groq_base, { model = "qwen/qwen3-32b" }),
      },
    },
    keys = {
      { "<leader>ta", "<cmd>AvanteToggle<cr>", desc = "Toggle Avante" },
    },
  },
  -- Claude
  {
    "claudecode.nvim",
    keys = {
      { "<leader>tl", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Focus" },
      { "<leader>tL", "<cmd>ClaudeCode --resume<cr>", desc = "Claude Resume" },
    },
  },
}
