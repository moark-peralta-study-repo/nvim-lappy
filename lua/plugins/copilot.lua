return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      debug = false,
    },

    config = function(_, opts)
      require("CopilotChat").setup(opts)

      pcall(vim.keymap.del, "n", "<leader>aa")
      vim.keymap.set("n", "<leader>aa", "gg<S-v>G", { desc = "Select all" })
    end,

    keys = {
      { ";aa", "<cmd>CopilotChat<cr>", desc = "Copilot Chat" },
      { ";ce", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
      { ";ct", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
      { ";cr", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
      { ";cf", "<cmd>CopilotChatFix<cr>", desc = "Fix code" },
    },
  },
}
