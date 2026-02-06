return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "glepnir/lspsaga.nvim", -- using Lspsaga for rename
  },
  config = function()
    local refactoring = require("refactoring")
    local telescope = require("telescope")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local conf = require("telescope.config").values

    -- Setup refactoring.nvim
    refactoring.setup({})

    -- Load telescope extension
    telescope.load_extension("refactoring")

    ----------------------------------------------------------------
    -- Refactor Menu (visual mode)
    ----------------------------------------------------------------
    vim.keymap.set("v", "<leader>r", function()
      telescope.extensions.refactoring.refactors()
    end, { desc = "Refactor Menu" })

    vim.keymap.set("n", "<A-CR>", "<Cmd>Lspsaga code_action<CR>", { desc = "Lspsaga Actions" })

    ----------------------------------------------------------------
    -- Refactor / Rename Menu (normal mode)
    ----------------------------------------------------------------
    vim.keymap.set("n", "<leader>r", function()
      local custom_actions = {
        {
          name = "Rename Symbol",
          action = function()
            vim.cmd("Lspsaga rename") -- ✅ use Lspsaga rename
          end,
        },
      }
      -- Combine with refactoring.nvim actions
      local refactor_actions = {
        "Extract Function",
        "Extract Function To File",
        "Extract Variable",
        "Inline Variable",
      }

      for _, name in ipairs(refactor_actions) do
        table.insert(custom_actions, {
          name = name,
          action = function()
            refactoring.refactor(name)
          end,
        })
      end

      pickers
        .new({}, {
          prompt_title = "Refactor / Rename",
          finder = finders.new_table({
            results = vim.tbl_map(function(x)
              return x.name
            end, custom_actions),
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(_, map)
            map("i", "<CR>", function(bufnr)
              local selection = action_state.get_selected_entry(bufnr)
              actions.close(bufnr)

              for _, a in ipairs(custom_actions) do
                if a.name == selection[1] then
                  a.action()
                end
              end
            end)
            return true
          end,
        })
        :find()
    end, { desc = "Rename / Refactor Menu" })
  end,
}
