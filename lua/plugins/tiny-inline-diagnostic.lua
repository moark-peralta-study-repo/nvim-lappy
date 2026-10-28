return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      preset = "modern",
      transparent_bg = true,
      options = {
        multilines = {
          enabled = true,
          always_show = true,
          severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
        },
        show_source = { enabled = true, if_many = true },
        overflow = { mode = "wrap" },
        enable_on_insert = true,
      },
    },
    config = function(_, opts)
      require("tiny-inline-diagnostic").setup(opts)
      -- no double display next to Neovim's own virtual text
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}