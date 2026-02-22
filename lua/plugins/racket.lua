return {
  { "wlangstroth/vim-racket", ft = { "racket" } },
  {

    "Olical/conjure",
    ft = { "racket", "scheme" },
    init = function()
      vim.g["conjure#mapping#doc_word"] = false
    end,
  },
}
