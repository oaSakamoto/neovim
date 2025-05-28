return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  flavor = 'mocha',
  opts = {
    transparent_background = true,
    integrations = {
      telescope = false,
      fidget = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    local colors = require('catppuccin.palettes').get_palette('mocha')
    vim.api.nvim_command('colorscheme catppuccin-mocha')

    vim.api.nvim_set_hl(0, '@variable', { fg = colors.teal })
  end,
}
