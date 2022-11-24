nvim_treesitter_configs = require('nvim-treesitter.configs')
nvim_treesitter_configs.setup({
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'diff',
    'gitattributes',
    'gitignore',
    'help',
    'html',
    'javascript',
    'json',
    'lua',
    'make',
    'markdown',
    'python',
    'rust',
    'sql',
    'toml',
    'vim',
    'yaml',
  },

  disable = function(lang, buf)
    local max_filesize = 500 * 1024 -- 500 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end
  end,

  highlight = {
    enable = true,
  },
})

