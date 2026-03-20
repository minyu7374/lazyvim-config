local copilot_enabled = false

local nvidia_base = {
  __inherited_from = "openai",
  endpoint = "https://integrate.api.nvidia.com/v1",
  api_key_name = "NVIDIA_NIM_API_KEY",
}
local qwen_minyu_base = {
  __inherited_from = "openai",
  endpoint = "https://openai.wminyu.top:433/qwen/v1",
  api_key_name = "QWEN_API_KEY",
}
local groq_base = {
  __inherited_from = "openai",
  endpoint = "https://api.groq.com/openai/v1",
  api_key_name = "GROQ_API_KEY",
}

return {
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    init = function()
      vim.cmd("Copilot " .. (copilot_enabled and "enable" or "disable"))
    end,
    opts = {
      suggestion = { enabled = true },
    },
    keys = {
      { "<leader>tc", "<cmd>Copilot toggle<cr>", desc = "Toggle Copilot" },
      {
        "<leader>tC",
        function()
          copilot_enabled = not copilot_enabled
          vim.cmd("Copilot " .. (copilot_enabled and "enable" or "disable"))
          vim.notify("Copilot " .. (copilot_enabled and "Enabled" or "Disabled"), vim.log.levels.INFO)
        end,
        desc = "Toggle Copilot (global)",
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
        ["gemini-preview"] = { __inherited_from = "gemini", model = "gemini-3-flash-preview" },
        ["nvidia-mimimax"] = vim.tbl_extend("force", nvidia_base, { model = "minimaxai/minimax-m2.5" }),
        ["nvidia-glm"] = vim.tbl_extend("force", nvidia_base, { model = "z-ai/glm5" }),
        ["groq"] = vim.tbl_extend("force", groq_base, { model = "qwen/qwen3-32b" }),
        ["qwen/minyu"] = vim.tbl_extend("force", qwen_minyu_base, { model = "qwen-plus" }),
        ["qwen-max/minyu"] = vim.tbl_extend("force", qwen_minyu_base, { model = "qwen-max" }),
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
    },
  },
}
