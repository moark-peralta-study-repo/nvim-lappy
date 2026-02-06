-- LazyVim: Java LSP setup
local ok, jdtls = pcall(require, "config.jdtls")
if not ok then
  vim.notify("JDTLS config not found: config/jdtls.lua", vim.log.levels.ERROR)
  return
end

jdtls.setup_jdtls()
