
vim.o.list = true


-- simple
require('indent_blankline').setup({
    char = '┊',
    buftype_exclude = { 'terminal' }
})
--[[
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
--]]
