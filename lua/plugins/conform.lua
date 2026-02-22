return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>F",
      function()
        require("conform").format({
          async = true,
          lsp_fallback = true,
        })
      end,
      desc = "Format code",
    },
  },

  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "biome" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
      javascriptreact = { "biome" },
      html = { "biome" },
      json = { "biome" },
      jsonc = { "biome" },
      css = { "biome" },
      java = { "google_java_format" },
      racket = { "raco_fmt" },
    },

    formatters = {
      stylua = {
        command = "stylua",
        args = {
          "--search-parent-directories",
          "--stdin-filepath",
          "$FILENAME",
          "-",
        },
      },
      biome = {
        inherit = false,
        command = "biome",
        args = { "format", "--stdin-file-path", "$FILENAME" },
        stdin = true,
      },
    },
  },
}
