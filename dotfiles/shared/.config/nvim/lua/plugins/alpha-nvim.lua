return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-mini/mini.icons',
    'nvim-lua/plenary.nvim',
  },
  priority = 1000,
  config = function()
    require('alpha').setup(require('alpha.themes.theta').config)
  end,
}
