return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  event = "VeryLazy",
  opts = {
    display = {
      show_time = false,
      show_repository = false,
      show_cursor_position = false,
    },

    text = {
      editing = "Tite.jsx",
      viewing = "Tite.jsx",
      workspace = "In Tite",
    },

    icons = {
      enable = true,
    },

    idle = {
      enabled = true,
      timeout = 300000,
      text = "hehe xd",
    },
  },
}
