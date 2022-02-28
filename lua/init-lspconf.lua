local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>p', '<Cmd>Lspsaga preview_definition<CR>', opts)
  --buf_set_keymap('n', '<S-Up>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
  --buf_set_keymap('n', '<S-Down>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
  buf_set_keymap('n', 'rn', '<cmd>Lspsaga rename<CR>', opts)
  buf_set_keymap('n', 'ca', '<cmd>Lspsaga code_action<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<S-[>', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
  buf_set_keymap('n', '<S-]>', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = { 'clangd', 'pyright', 'gopls', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities
  })
end

-- setup for lua language server
nvim_lsp.sumneko_lua.setup({
  cmd = {'lua-language-server', '-E', '/usr/share/lua-language-server/main.lua'},
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
--[[
nvim_lsp.html.setup({
  cmd = { "vscode-html-languageserver", "--stdio" },
  filetypes = {"html", "htmldjango"},
  on_attach = on_attach,
  capabilities = capabilities
})
--]]
--[[
nvim_lsp.cssls.setup({
  cmd = { "vscode-css-languageserver", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities
})
--]]
nvim_lsp.jsonls.setup({
  cmd = { "vscode-json-languageserver", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities
})
local util = require('lspconfig').util
nvim_lsp.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
    single_file_support = true
})
--[[
nvim_lsp.ccls.setup ({
  cmd = { "ccls" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  single_file_support = false,
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
})
--]]
