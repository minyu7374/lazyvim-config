return {
  "folke/snacks.nvim",
  init = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- 无参数启动时，按当前目录打开 explorer
        if vim.fn.argc() == 0 and vim.fn.has("stdin") == 0 and not vim.o.readonly then
          -- Snacks.explorer()
          Snacks.explorer({ cwd = LazyVim.root() })
        end
      end,
    })
  end,
  opts = {
    picker = {
      sources = {
        command_history = {
          layout = {
            preset = "select",
          },
        },
      },
    },
    image = {
      enabled = true,
    },
  },
  keys = {
    { "<leader>tt", function() Snacks.explorer({ cwd = LazyVim.root() }) end, desc = "Toggle Explorer (root dir)" },
    { "<leader>tT", function() Snacks.explorer() end, desc = "Toggle Explorer (cwd)" },
  },
}
