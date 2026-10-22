local herdr_backend = vim.fn.fnamemodify(vim.fn.stdpath("data"), ":h") .. "/smart-splits-herdr"
local has_herdr_backend = vim.fn.isdirectory(herdr_backend) == 1

return {
  {
    "smart-splits-nvim/smart-splits.nvim",
    version = "^3.0.0",
    lazy = false,
    init = function()
      if not has_herdr_backend then
        vim.schedule(function()
          vim.notify("未找到 smart-splits-herdr，已跳过 Herdr 集成", vim.log.levels.INFO, {
            title = "Smart Splits",
            timeout = 3000,
          })
        end)
      end
    end,
    dependencies = {
      { "smart-splits-nvim/backend-tmux", main = "smart-splits-backend-tmux" },
      { "smart-splits-nvim/backend-kitty", main = "smart-splits-backend-kitty" },
      { dir = herdr_backend, name = "smart-splits-herdr", enabled = has_herdr_backend },
    },
    opts = function()
      local backend
      if has_herdr_backend and vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
        backend = "smart-splits-backend-herdr"
      elseif vim.env.TMUX and vim.env.TMUX ~= "" then
        backend = "smart-splits-backend-tmux"
      elseif vim.env.KITTY_LISTEN_ON and vim.env.KITTY_LISTEN_ON ~= "" then
        backend = "smart-splits-backend-kitty"
      end
      return {
        ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
        ignored_buftypes = { "nofile" },
        mux = { backend = backend },
      }
    end,
    keys = {
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move to Left Window" },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move to Lower Window" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move to Upper Window" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to Right Window" },
      { "<C-\\>", "<cmd>wincmd p<cr>", desc = "Move to Previous Window" },

      { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize Window Left" },
      { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize Window Down" },
      { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize Window Up" },
      { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize Window Right" },
    },
  },
}
