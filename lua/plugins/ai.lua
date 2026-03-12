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
