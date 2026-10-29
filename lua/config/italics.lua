local function set_italics()
  local groups = {
    "Comment",
    "@comment",
    "@keyword",
    "@keyword.modifier",
    "@keyword.return",
    "@keyword.exception",
    "@keyword.function",
    "@variable.member.rust",
  }

  for _, group in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, {
      name = group,
      link = false,
    })

    hl.italic = true

    vim.api.nvim_set_hl(0, group, hl)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_italics,
})

set_italics()
