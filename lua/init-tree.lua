require('nvim-tree').setup({
  update_focused_file = {
    enable = true
  },
  view = {
    auto_resize = true
  },
  actions = {
    open_file = {
       quit_on_open = true,
	},
  },
  filters = {
    custom = {'.git', 'node_modules'}
  },
})

-- Mappings for nvimtree
vim.api.nvim_set_keymap(
  'n', '<F3>', ':NvimTreeToggle<CR>',
  {
    noremap = true,
    silent = true
  }
)

