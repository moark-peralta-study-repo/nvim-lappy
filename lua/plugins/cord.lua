return {
  "vyfor/cord.nvim",
  event = "VeryLazy",
  opts = {
    text = {
      editing = function(opts)
        return "Editing: " .. opts.filename
      end,
      workspace = "Bilat",
    },
  },
}
