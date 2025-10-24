-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } }, 
    { 'nvim-treesitter/nvim-treesitter', branch = 'master', lazy = false, build = ":TSUpdate"},
    { 'zootedb0t/citruszest.nvim', branch = 'main' },
    { import = "plugins" } 
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Theme 
vim.cmd("colorscheme citruszest")
vim.cmd("set cursorline")

-- Smart Save
vim.cmd('ca W SudaWrite')
-- Keybindings

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {desc = 'Telescope find files'})
vim.keymap.set('n', 'fg', builtin.live_grep, {desc = 'Telescope live grep'})
vim.keymap.set('n', 'fb', builtin.buffers, {desc = 'Telescope buffers'})
vim.keymap.set('n', 'fh', builtin.help_tags, {desc = 'Telescope help pages'})
vim.keymap.set('n', 'fp', '<cmd>NeovimProjectDiscover history<CR>', {desc = 'Telescope discover projects'})

vim.keymap.set('n', 'td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })

-- Comment
require('Comment').setup()

-- Line number
vim.wo.relativenumber = true
vim.wo.number = true

-- Chad tree
vim.keymap.set('n', 'ee', '<cmd>CHADopen<CR>', {desc = 'ChadTree open'})

-- Clipboard
vim.o.clipboard = 'unnamedplus'
vim.keymap.set('v', '<C-c>', '"+y')

-- LuaLine
require('lualine').setup({
  options = { theme = 'codedark' },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
	    {
		'filename',
            	path = 1,
    	    }
    },
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
})

-- Hologram 

require('hologram').setup{
    auto_display = true -- WIP automatic markdown image display, may be prone to breaking
}
