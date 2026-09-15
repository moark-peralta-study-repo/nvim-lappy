return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },

    opts = {
      history = true,
      delete_check_events = "TextChanged",
      updateevents = "TextChanged,TextChangedI",

      enable_autosnippets = true,
    },

    config = function(_, opts)
      local ls = require("luasnip")

      ls.config.set_config(opts)

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Optional: load custom snippets
      require("luasnip.loaders.from_lua").lazy_load({
        paths = "~/.config/nvim/snippets",
      })

      -- Expand / jump mappings
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      -- Choice node navigation
      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  },

  {
    "rafamadriz/friendly-snippets",
  },
}
