require'nvim-treesitter.configs'.setup {
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
    ensure_installed = {"dockerfile", "vim", "lua", "cmake", "make", "c", "cpp", "python", "go"},
    autotag = {
        enable = true
    },
  -- 启用代码高亮功能
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  -- 启用增量选择
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    }
  },
}
-- 开启 Folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99
-- nvim-treesitter 代码格式化
-- 本地变量
local map = vim.api.nvim_set_keymap
local opt = {
	noremap = true,
	silent = true
	}
map("n", "<leader>=", "gg=G", opt)
-- require('nvim-treesitter.query')
