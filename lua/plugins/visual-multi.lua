return {
  "terryma/vim-multiple-cursors",
  init = function()
    vim.g.multi_cursor_use_default_mapping = 0
    vim.g.multi_cursor_parse_keymaps = 0

    vim.g.multi_cursor_start_word_key = "mp" -- start on word under cursor
    vim.g.multi_cursor_select_all_word_key = "<A-S-n>" -- select all occurrences of word
    vim.g.multi_cursor_next_key = "<A-n>" -- add next occurrence
    vim.g.multi_cursor_prev_key = "<A-p>" -- add previous occurrence
    vim.g.multi_cursor_skip_key = "<A-x>" -- skip occurrence
    vim.g.multi_cursor_quit_key = "<Esc>" -- quit multi-cursor mode
  end,
}
