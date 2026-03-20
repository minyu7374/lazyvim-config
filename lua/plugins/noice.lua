-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- cmdline = {
    --   view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    -- },
    views = {
      cmdline_popup = {
        position = {
          row = "35%",
          col = "50%",
        },
        size = {
          width = "48%",
          height = "auto",
        },
      },
    },
  },
}
