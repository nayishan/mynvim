-- require('vim-interestingwords')

vim.api.nvim_set_keymap(
  'n', '<leader>k', ":call InterestingWords('n')<CR>",
  {
    noremap = true,
    silent = true
  }
)
vim.api.nvim_set_keymap(
  'v', '<leader>k', ":call InterestingWords('v')<CR>",
  {
    noremap = true,
    silent = true
  }
)
vim.api.nvim_set_keymap(
  'n', '<leader>K', ':call UncolorAllWords()<CR>',
  {
    noremap = true,
    silent = true
  }
)
vim.api.nvim_set_keymap(
  'n', 'n', ':call WordNavigation(1)<CR>',
  {
    noremap = true,
    silent = true
  }
)
vim.api.nvim_set_keymap(
  'n', 'N', ':call WordNavigation(1)<CR>',
  {
    noremap = true,
    silent = true
  }
)
