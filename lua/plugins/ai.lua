return {
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    init = function()
      -- 启动时禁用 copilot
      vim.cmd("Copilot disable")
      vim.g.copilot_enabled = false
    end,
    opts = {
      suggestion = { enabled = true },
    },
    keys = {
      { "<leader>tc", "<cmd>Copilot toggle<cr>", desc = "Toggle Copilot" },
      {
        "<leader>tC",
        function()
          if vim.g.copilot_enabled then
            vim.cmd("Copilot disable")
            vim.g.copilot_enabled = false
            vim.notify("Copilot Disabled", vim.log.levels.INFO)
          else
            vim.cmd("Copilot enable")
            vim.g.copilot_enabled = true
            vim.notify("Copilot Enabled", vim.log.levels.INFO)
          end
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
        ["gemini-preview"] = {
          __inherited_from = "gemini",
          model = "gemini-3-flash-preview",
        },
        ["nvidia-mimimax"] = {
          __inherited_from = "openai",
          endpoint = "https://integrate.api.nvidia.com/v1",
          api_key_name = "NVIDIA_NIM_API_KEY",
          model = "minimaxai/minimax-m2.5",
        },
        ["nvidia-glm"] = {
          __inherited_from = "openai",
          endpoint = "https://integrate.api.nvidia.com/v1",
          api_key_name = "NVIDIA_NIM_API_KEY",
          model = "z-ai/glm5",
        },
        ["groq"] = {
          __inherited_from = "openai",
          endpoint = "https://api.groq.com/openai/v1",
          api_key_name = "GROQ_API_KEY",
          model = "qwen/qwen3-32b",
        },
        ["qwen/minyu"] = {
          __inherited_from = "openai",
          endpoint = "https://openai.wminyu.top:433/qwen/v1",
          api_key_name = "QWEN_API_KEY",
          model = "qwen-plus",
        },
        ["qwen-max/minyu"] = {
          __inherited_from = "openai",
          endpoint = "https://openai.wminyu.top:433/qwen/v1",
          api_key_name = "QWEN_API_KEY",
          model = "qwen-max",
        },
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
