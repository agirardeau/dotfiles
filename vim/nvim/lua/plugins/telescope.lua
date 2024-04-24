-- TODOs
--  * Get fzf behavior more like it is on the command line
--    * individual terms not fuzzy?
--    * allow spaces?
--  * Figure out why these can't be executed with require('telescope.builtin') in keys.lua
--  * Get scroll_speed working

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<C-J>'] = 'move_selection_next',
            ['<C-K>'] = 'move_selection_previous',
            -- Common mappings
            ['<C-E>'] = 'results_scrolling_down',
            ['<C-Y>'] = 'results_scrolling_up',
            ['<C-R>'] = 'cycle_history_prev',
            ['<C-O)>'] = function()
              require('telescope.builtin').resume()
            end,
          },
          n = {
            ['<C-c>'] = 'close',
            ['<C-[>'] = 'close',
            -- Common mappings
            ['<C-E>'] = 'results_scrolling_down',
            ['<C-Y>'] = 'results_scrolling_up',
            ['<C-R>'] = 'cycle_history_prev',
            ['<C-O)>'] = function()
              require('telescope.builtin').resume()
            end,
          },
        },
        layout_config = {
          horizontal = {
            width = 0.9,
            preview_width = 80,
            scroll_speed = 18,  -- why isn't this working?
            prompt_position = 'top',
          },
        },
        path_display = 'truncate',
        sorting_strategy = 'ascending',
        scroll_strategy = 'limit',
        selection_strategy = 'follow',
      },
      pickers = {
        command_history = {
          mappings = {
            ['<CR>'] = 'edit_command_line',
          },
        },
        search_history = {
          mappings = {
            ['<CR>'] = 'edit_search_line',
          },
        },
      },
    },
  },

  { 'nvim-telescope/telescope-fzf-native.nvim' },
}


