-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      document_color = {
        enabled = true, -- can be toggled by commands
        kind = 'inline', -- "inline" | "foreground" | "background"
        inline_symbol = '⬛', -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
      conceal = {
        enabled = false, -- can be toggled by commands
        min_length = nil, -- only conceal classes exceeding the provided length
        symbol = '⬛', -- only a single character is allowed
        highlight = { -- extmark highlight options, see :h 'highlight'
          fg = '#38BDF8',
        },
      },
      custom_filetypes = {}, -- see the extension section to learn how it works
    },
  },
  {
    'sindrets/diffview.nvim',
    config = function()
      function DiffviewToggle()
        local lib = require 'diffview.lib'
        local view = lib.get_current_view()
        if view then
          -- Current tabpage is a Diffview; close it
          vim.cmd ':DiffviewClose'
        else
          -- No open Diffview exists: open a new one
          vim.cmd ':DiffviewOpen'
        end
      end

      vim.keymap.set('n', '<leader>dv', function()
        DiffviewToggle()
      end, { desc = '[D]iff [V]iew' })
    end,
  },
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = '[A]dd file to harpoon menu' })
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Show harpoon list' })

      vim.keymap.set('n', '<A-1>', function()
        harpoon:list():select(1)
      end, { desc = 'select first file' })
      vim.keymap.set('n', '<A-2>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<A-3>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<A-4>', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-S-P>', function()
        harpoon:list():prev()
      end, { desc = 'Harpoon go to previus' })
      vim.keymap.set('n', '<C-S-N>', function()
        harpoon:list():next()
      end, { desc = 'harpoon go to next' })
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        condition = function()
          -- Ignore node_modules, .git, and other common directories
          local dirsToIgnore = {
            "node_modules",
            ".git",
            "__pycache__",
            ".mypy_cache",
            ".pytest_cache",
            ".venv",
            "venv",
            ".direnv",
            ".vscode",
          }

          local currentFile = vim.fn.expand("%:p")
          for _, dir in ipairs(dirsToIgnore) do
            if currentFile:find(dir) then
              return true
            end
          end

          return false
        end,

      })
    end,
  },
}
