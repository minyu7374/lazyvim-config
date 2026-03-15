return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    keys = {
      -- Add or skip cursor above/below
      { "<up>",           function() require("multicursor-nvim").lineAddCursor(-1) end,  mode = { "n", "x" }, desc = "MC Add Cursor Above" },
      { "<down>",         function() require("multicursor-nvim").lineAddCursor(1) end,   mode = { "n", "x" }, desc = "MC Add Cursor Below" },
      { "<leader><up>",   function() require("multicursor-nvim").lineSkipCursor(-1) end, mode = { "n", "x" }, desc = "MC Skip Cursor Above" },
      { "<leader><down>", function() require("multicursor-nvim").lineSkipCursor(1) end,  mode = { "n", "x" }, desc = "MC Skip Cursor Below" },
      -- Match word/selection (gz prefix, aligns with evil-mc)
      { "gzm",            function() require("multicursor-nvim").matchAddCursor(1) end,  mode = { "n", "x" }, desc = "MC Match Add Next" },
      { "gzs",            function() require("multicursor-nvim").matchSkipCursor(1) end, mode = { "n", "x" }, desc = "MC Match Skip Next" },
      { "gzM",            function() require("multicursor-nvim").matchAddCursor(-1) end, mode = { "n", "x" }, desc = "MC Match Add Prev" },
      { "gzS",            function() require("multicursor-nvim").matchSkipCursor(-1) end,mode = { "n", "x" }, desc = "MC Match Skip Prev" },
      -- Mouse
      { "<c-leftmouse>",   function() require("multicursor-nvim").handleMouse() end,        mode = "n", desc = "MC Mouse Toggle" },
      { "<c-leftdrag>",    function() require("multicursor-nvim").handleMouseDrag() end,    mode = "n", desc = "MC Mouse Drag" },
      { "<c-leftrelease>", function() require("multicursor-nvim").handleMouseRelease() end, mode = "n", desc = "MC Mouse Release" },
      -- Toggle cursor at point (aligns with evil-mc gzz)
      { "gzz",            function() require("multicursor-nvim").toggleCursor() end,     mode = { "n", "x" }, desc = "MC Toggle Cursor" },
      -- Toggle mirroring on/off (aligns with evil-mc gzt)
      { "gzt",            function()
          local mc = require("multicursor-nvim")
          if mc.cursorsEnabled() then mc.disableCursors() else mc.enableCursors() end
        end,                                                                              mode = { "n", "x" }, desc = "MC Toggle Enable" },
    },
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor
        layerSet({ "n", "x" }, "<left>",     mc.prevCursor,   { desc = "MC Prev Cursor" })
        layerSet({ "n", "x" }, "<right>",    mc.nextCursor,   { desc = "MC Next Cursor" })
        -- Delete the main cursor
        layerSet({ "n", "x" }, "gzx", mc.deleteCursor, { desc = "MC Delete Cursor" })
        -- Enable and clear cursors using escape
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then mc.enableCursors() else mc.clearCursors() end
        end, { desc = "MC Enable/Clear Cursors" })
      end)

      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor",         { reverse = true })
      hl(0, "MultiCursorVisual",         { link = "Visual" })
      hl(0, "MultiCursorSign",           { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview",   { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign",   { link = "SignColumn" })
    end,
  },
}
