return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "glepnir/lspsaga.nvim",
    "lewis6991/async.nvim",
  },
  config = function()
    local refactoring = require("refactoring")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local conf = require("telescope.config").values

    refactoring.setup({})

    local function open_refactor_picker()
      local refactor_actions = {
        {
          name = "Extract Function",
          action = function()
            refactoring.refactor("Extract Function")
          end,
        },
        {
          name = "Extract Function To File",
          action = function()
            refactoring.refactor("Extract Function To File")
          end,
        },
        {
          name = "Extract Variable",
          action = function()
            refactoring.refactor("Extract Variable")
          end,
        },
        {
          name = "Inline Variable",
          action = function()
            refactoring.refactor("Inline Variable")
          end,
        },
      }

      pickers
        .new({}, {
          prompt_title = "Refactor",
          finder = finders.new_table({
            results = vim.tbl_map(function(item)
              return item.name
            end, refactor_actions),
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(_, map)
            local run_selection = function(bufnr)
              local selection = action_state.get_selected_entry()
              actions.close(bufnr)

              if not selection then
                return
              end

              for _, item in ipairs(refactor_actions) do
                if item.name == selection[1] then
                  item.action()
                  return
                end
              end
            end

            map("i", "<CR>", run_selection)
            map("n", "<CR>", run_selection)
            return true
          end,
        })
        :find()
    end

    vim.keymap.set("v", "<leader>r", open_refactor_picker, { desc = "Refactor Menu" })

    vim.keymap.set("n", "<A-CR>", "<Cmd>Lspsaga code_action<CR>", { desc = "Lspsaga Actions" })

    vim.keymap.set("n", "<leader>r", function()
      local custom_actions = {
        {
          name = "Rename Symbol",
          action = function()
            vim.cmd("Lspsaga rename")
          end,
        },
        {
          name = "Extract Function",
          action = function()
            refactoring.refactor("Extract Function")
          end,
        },
        {
          name = "Extract Function To File",
          action = function()
            refactoring.refactor("Extract Function To File")
          end,
        },
        {
          name = "Extract Variable",
          action = function()
            refactoring.refactor("Extract Variable")
          end,
        },
        {
          name = "Inline Variable",
          action = function()
            refactoring.refactor("Inline Variable")
          end,
        },
      }

      pickers
        .new({}, {
          prompt_title = "Rename / Refactor",
          finder = finders.new_table({
            results = vim.tbl_map(function(item)
              return item.name
            end, custom_actions),
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(_, map)
            local run_selection = function(bufnr)
              local selection = action_state.get_selected_entry()
              actions.close(bufnr)

              if not selection then
                return
              end

              for _, item in ipairs(custom_actions) do
                if item.name == selection[1] then
                  item.action()
                  return
                end
              end
            end

            map("i", "<CR>", run_selection)
            map("n", "<CR>", run_selection)
            return true
          end,
        })
        :find()
    end, { desc = "Rename / Refactor Menu" })
  end,
}
