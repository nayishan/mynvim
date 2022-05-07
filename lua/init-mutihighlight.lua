-- require('vim-interestingwords')

vim.api.nvim_set_keymap(
  'n', '<F1>', ":call InterestingWords('n')<CR>",
  {
    noremap = true,
    silent = true
  }
)
vim.api.nvim_set_keymap(
  'v', '<F1>', ":call InterestingWords('v')<CR>",
  {
    noremap = true,
    silent = true
  }
)
vim.api.nvim_set_keymap(
  'n', '<leader><F1>', ':call UncolorAllWords()<CR>',
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
  'n', 'N', ':call WordNavigation(0)<CR>',
  {
    noremap = true,
    silent = true
  }
)
