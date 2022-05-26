vim.o.fileencoding  = 'utf8'
vim.g.encoding = "UTF-8"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 搜索不要高亮
vim.o.hlsearch = false
-- 边输入边搜索
vim.o.incsearch = true
-- 命令行高为2，提供足够的显示空间
vim.o.cmdheight = 2
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 使用增强状态栏后不再需要 vim 的模式提示
vim.o.showmode = false
-- 右侧参考线，超过表示代码太长了，考虑换行
vim.wo.colorcolumn = "80"
-- 行结尾可以跳到下一行
vim.o.whichwrap = 'b,s,<,>,[,],h,l'
-- 禁止折行
vim.o.wrap = false
vim.wo.wrap = false
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true

-- ident
-- 不可见字符的显示，这里只把空格显示为一个点
-- vim.o.list = true
-- vim.o.listchars = "space:·"

-- 显示标签栏
vim.o.showtabline = 2
-- 自动补全不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"

vim.o.mouse         = 'a'       -- Enable mouse for any mode
vim.o.writebackup   = false
vim.o.termguicolors = true
vim.o.tabstop       = 4
vim.o.shiftwidth    = 4
vim.o.smartindent   = true
--vim.o.expandtab     = true
vim.o.termguicolors = true
-- Better completion

vim.wo.number       = true      -- Show line number
vim.wo.relativenumber       = true
vim.wo.cursorline   = true      -- Highlight current line number
vim.wo.signcolumn   = "yes"

vim.g.clipboard = "unnamedplus"

-- set up themes
require('doom-one').setup({
  transparent_background = true,
  plugins_integrations = {
      bufferline = true,
      gitsigns = true,
      telescope = true,
      neogit = false,
      nvim_tree = true,
      dashboard = false,
      startify = false,
      whichkey = true,
      indent_blankline = true,
      vim_illuminate = false,
      lspsaga = true,
  },
})
-- require('doom-one').setup({
--     cursor_coloring = false,
--     terminal_colors = true,
--     italic_comments = false,
--     enable_treesitter = true,
--     transparent_background = false,
--     pumblend = {
--     	enable = true,
--     	transparency_amount = 20,
-- 	},
-- 	plugins_integrations = {
--     	neorg = true,
--     	barbar = true,
--     	bufferline = false,
--     	gitgutter = false,
--     	gitsigns = true,
--     	telescope = false,
--     	neogit = true,
--     	nvim_tree = true,
--     	dashboard = true,
--     	startify = true,
--     	whichkey = true,
--     	indent_blankline = true,
--     	vim_illuminate = true,
--     	lspsaga = false,
-- 	},
-- })
require("github-theme").setup({
  theme_style = "light_colorblind",
  transparent = true,
  function_style = "italic",
  sidebars = {"qf", "vista_kind", "terminal", "packer"},

  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  colors = {hint = "orange", error = "#ff0000"},

  -- Overwrite the highlight groups
  overrides = function(c)
    return {
      htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
      DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
      -- this will remove the highlight groups
      TSField = {},
    }
  end
})
--vim.opt.background = 'light'
vim.cmd 'colorscheme github_light_colorblind'
-- setup space as leader key
vim.g.mapleader = ' '

local map = vim.api.nvim_set_keymap
local opt = 
{
    noremap = true,
    silent = true
}

map("n", "J", "9j", opt)
map("n", "K", "9k", opt)
map("n", "<C-e>", "$", opt)
map("n", "<C-a>", "^", opt)

map("i", "<C-a>", "<ESC>I", opt)
map("i", "<C-e>", "<ESC>A", opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 比例控制
map("n", "up", ":vertical resize +20<CR>", opt)
map("n", "down", ":vertical resize -20<CR>", opt)
map("n", "left", ":resize +10<CR>", opt)
map("n", "right", ":resize -10<CR>", opt)

-- alt + hjkl  窗口之间跳转
map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)
map("n", "<C-l>", "<C-w>l", opt)

-- buffer 切换
-- map("n", ",", ":bp<CR>", opt)
-- map("n", ".", ":bn<CR>", opt)

vim.o.clipboard = "unnamedplus"
vim.g.clipboard = {
	name =  "myClipboard",
	copy = {
		["+"]= os.getenv("HOME").."/.config/nvim/bin/clipboard-provider copy",
		["*"]= os.getenv("HOME").."/.config/nvim/bin/clipboard-provider copy",
	},
	paste = {
		["+"]= os.getenv("HOME").."/.config/nvim/bin/clipboard-provider paste",
		["*"]= os.getenv("HOME").."/.config/nvim/bin/clipboard-provider paste",
	},
}
vim.cmd('language en_US.UTF-8')

-- Highlight on yank
vim.cmd(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

