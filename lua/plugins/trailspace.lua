return {
  {
    "nvim-mini/mini.trailspace",
    event = "BufReadPost",
    config = function()
      require("mini.trailspace").setup()

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          require("mini.trailspace").trim()
        end,
      })
    end,
  },
}
