vim.api.nvim_create_autocmd("BufAdd", {
  callback = function(args)
    local buf = args.buf
    local name = vim.api.nvim_buf_get_name(buf)

    if name == "." or vim.fn.isdirectory(name) == 1 then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end)
    end
  end,
})
