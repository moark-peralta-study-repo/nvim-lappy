return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },

  version = "1.*",
  opts = {
    keymap = {
      preset = "default",
      ["<CR>"] = { "fallback" },
      ["<Tab>"] = { "accept", "fallback" },
      ["S-<Tab>"] = { "select_prev", "fallback" },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    signature = { enabled = true },
  },
}
