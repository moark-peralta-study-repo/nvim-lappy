return {
  -- vim tmux switching
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-mini/mini.hipatterns",
    event = "BufReadPre",
    opts = function()
      local hipatterns = require("mini.hipatterns")
      return {
        highlighters = {
          todo = {
            pattern = "%f[%w]()TODO()%f[%W]", -- matches TODO in comments/code
            group = "Todo", -- links to existing 'Todo' highlight group
          },
          fixme = {
            pattern = "%f[%w]()FIXME()%f[%W]",
            group = "Todo",
          },
        },
      }
    end,
    config = function(_, opts)
      require("mini.hipatterns").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    priority = 1000,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    opts = {},
    keys = function()
      local builtin = require("telescope.builtin")

      return {
        {
          ";f",
          function()
            builtin.find_files({ no_ignore = false, hidden = true })
          end,
          desc = "Find files (respects .gitignore)",
        },
        {
          ";r",
          builtin.live_grep,
          desc = "Live grep in cwd",
        },
        {
          "\\\\",
          builtin.buffers,
          desc = "List open buffers",
        },
        {
          ";;",
          builtin.resume,
          desc = "Resume previous picker",
        },
        {
          ";s",
          builtin.treesitter,
          desc = "Treesitter symbols",
        },
        {
          ";b",
          function()
            local telescope = require("telescope")
            local function telescope_buffer_dir()
              return vim.fn.expand("%:p:h")
            end
            telescope.extensions.file_browser.file_browser({
              path = "%:p:h",
              cwd = telescope_buffer_dir(),
              respect_gitignore = false,
              hidden = true,
              grouped = true,
              previewer = false,
              initial_mode = "normal",
              layout_config = { height = 40 },
            })
          end,
          desc = "Open File Browser at buffer path",
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      -- FIX: provide fallback {} if opts.defaults is nil
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
      })

      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = { preview_cutoff = 9999 },
        },
      }

      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          mappings = {
            n = {
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["<C-u>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
            },
          },
        },
      }

      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        hijack_netrw_behavior = "disabled",
        filtered_items = {
          hide_dottfiles = false,
          hide_gitignored = false,
          visible = true,
        },
      },
    },

    default_component_configs = {
      preview = {
        enabled = false,
      },
    },

    init = function()
      pcall(vim.api.nvim_del_augroup_by_name, "LazyAutoStartNeoTree")

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          require("neo-tree.command").execute({
            action = "show",
            source = "filesystem",
            position = "left",
            reveal = true,
          })
        end,
      })
    end,
  },
}
