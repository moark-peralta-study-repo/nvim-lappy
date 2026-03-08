return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local keymap = vim.keymap
      local opts = { noremap = true, silent = true }

      -- Start / Continue
      keymap.set("n", "<F5>", dap.continue, { desc = "Debug Continue" })

      -- Step
      keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
      keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
      keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })

      -- Breakpoints
      keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Conditional Breakpoint" })

      -- Debug actions
      keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
      keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last Debug" })
      keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate Debug" })
    end,
  },

  {
    "igorlfs/nvim-dap-view",
    lazy = false,
    opts = {},
    config = function()
      local keymap = vim.keymap
      local opts = { noremap = true, silent = true }

      -- UI
      keymap.set("n", "<leader>dv", "<cmd>DapViewToggle<CR>", opts)
      keymap.set("n", "<leader>do", "<cmd>DapViewOpen<CR>", opts)
      keymap.set("n", "<leader>dc", "<cmd>DapViewClose<CR>", opts)

      -- Sections
      keymap.set("n", "<leader>ds", "<cmd>DapViewSwitch scopes<CR>", opts)
      keymap.set("n", "<leader>dB", "<cmd>DapViewSwitch breakpoints<CR>", opts)
      keymap.set("n", "<leader>dW", "<cmd>DapViewSwitch watches<CR>", opts)
      keymap.set("n", "<leader>dT", "<cmd>DapViewSwitch threads<CR>", opts)
      keymap.set("n", "<leader>dR", "<cmd>DapViewSwitch repl<CR>", opts)
      keymap.set("n", "<leader>dE", "<cmd>DapViewSwitch exceptions<CR>", opts)

      -- Watch expressions
      keymap.set("n", "<leader>da", "<cmd>DapViewAddExpr<CR>", opts)
      keymap.set("n", "<leader>dx", "<cmd>DapViewDelete<CR>", opts)
      keymap.set("n", "<leader>de", "<cmd>DapViewEval<CR>", opts)
    end,
  },
}
