return {
  "potamides/pantran.nvim",
  cmd = "Pantran",
  keys = {
    {
      "<leader>yt",
      function()
        -- motion_translate 返回 g@；补上 iw，保留普通模式直接查词。
        return require("pantran").motion_translate() .. "iw"
      end,
      expr = true,
      desc = "Translate Word",
    },
    {
      "<leader>yt",
      function()
        return require("pantran").motion_translate()
      end,
      mode = "x",
      expr = true,
      desc = "Translate Selection",
    },
  },
  opts = {
    default_engine = "google",
    engines = {
      google = {
        -- Google API 和无密钥后端的配置独立，目标语言都设为简体中文。
        default_target = "zh-CN",
        fallback = { default_target = "zh-CN" },
      },
    },
    -- 面板左右显示原文与译文，为段落阅读保留足够空间。
    ui = { width_percentage = 0.8, height_percentage = 0.6 },
  },
}
