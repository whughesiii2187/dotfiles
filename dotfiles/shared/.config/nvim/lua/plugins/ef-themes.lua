return {
  'oonamo/ef-themes.nvim',
  config = function()
    require('ef-themes').setup {
      dark = 'ef-deuteranopia-dark',
      transparent = true,
      modules = {
        blink = true,
        snacks = true,
        treesitter = true,
        which_key = true,
      },
      on_colors = function() end,
      on_highlights = function()
        return {}
      end,
    }
    vim.cmd.colorscheme 'ef-deuteranopia-dark'
  end,
}
