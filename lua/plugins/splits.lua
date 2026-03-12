return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    build = './kitty/install-kittens.bash',
    opts = {
      ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
      ignored_buftypes = { "nofile" },
    },
    keys = {
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move to Left Window" },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move to Lower Window" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move to Upper Window" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to Right Window" },
      { "<C-\\>", function() require('smart-splits').move_cursor_previous() end, desc = "Move to Previous Window" },

      { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize Window Left" },
      { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize Window Down" },
      { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize Window Up" },
      { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize Window Right" },
    },
  },
}
