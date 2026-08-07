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
    {
      "<leader>tp",
      function()
        -- 按需把当前文件在浮窗里渲染成图片：placement.new 直接走 convert，不查 image.formats，
        -- 所以 svg 平时仍当纯文本编辑，需要时按键预览（矢量图经 rsvg-convert/magick 转换）
        local src = vim.api.nvim_buf_get_name(0)
        if src == "" then
          return vim.notify("当前 buffer 无文件", vim.log.levels.WARN)
        end
        -- snacks 的转换缓存只按文件路径命名、存在即跳过转换，改了 svg 不会重转。
        -- 预览前按文件名通配删掉当前文件的缓存，强制重转（不耦合其内部哈希算法）
        local base = vim.fn.fnamemodify(src, ":t:r"):gsub("[^%w%.]+", "-")
        for _, f in ipairs(vim.fn.glob(Snacks.image.config.cache .. "/*" .. base .. "*", true, true)) do
          vim.fn.delete(f)
        end
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
          row = math.floor(vim.o.lines * 0.1),
          col = math.floor(vim.o.columns * 0.1),
          border = "rounded",
          style = "minimal",
        })
        Snacks.image.placement.new(buf, src, { auto_resize = true })
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, nowait = true })
      end,
      desc = "预览当前文件为图片",
    },
  },
}
