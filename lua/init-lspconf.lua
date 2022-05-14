local nvim_lsp = require('lspconfig')



local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end



	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }
	-- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	--buf_set_keymap('n', '<leader>d', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '<leader>d', '<Cmd>Telescope lsp_definitions theme=dropdown<CR>', opts)
	buf_set_keymap('n', '<leader>p', '<Cmd>Lspsaga preview_definition<CR>', opts)
	--buf_set_keymap('n', '<S-Up>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
	--buf_set_keymap('n', '<S-Down>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
	buf_set_keymap('n', 'rn', '<cmd>Lspsaga rename<CR>', opts)
	buf_set_keymap('n', 'ca', '<cmd>Lspsaga code_action<CR>', opts)
	buf_set_keymap('n', '<leader>r', '<cmd>Telescope lsp_references theme=dropdown<CR>', opts)
	buf_set_keymap('n', '<S-[>', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
	buf_set_keymap('n', '<S-]>', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
	-- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
		hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
		hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
		hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
		augroup lsp_document_highlight
		autocmd! * <buffer>
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
		]], false)
	end
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
local sumneko_root_path = os.getenv("HOME") .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/"
nvim_lsp.sumneko_lua.setup({
	cmd = {sumneko_root_path .. 'lua-language-server', '-E', sumneko_root_path .. 'main.lua'},
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

local function switch_source_header_splitcmd(bufnr, splitcmd)
	bufnr = nvim_lsp.util.validate_bufnr(bufnr)
	local params = {uri = vim.uri_from_bufnr(bufnr)}
	vim.lsp.buf_request(bufnr, "textDocument/switchSourceHeader", params,
	function(err, result)
		if err then error(tostring(err)) end
		if not result then
			print("Corresponding file can’t be determined")
			return
		end
		vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
	end)
end


local util = require('lspconfig').util
nvim_lsp.clangd.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
	single_file_support = true
})

--require'lspconfig'.clangd.switch_source_header_splitcmd = switch_source_header_splitcmd

require'lspconfig'.clangd.setup {
	-----snip------
	commands = {
		ClangdSwitchSourceHeader = {
			function() switch_source_header_splitcmd(0, "edit") end;
			description = "Open source/header in a new vsplit";
		},
		ClangdSwitchSourceHeaderVSplit = {
			function() switch_source_header_splitcmd(0, "vsplit") end;
			description = "Open source/header in a new vsplit";
		},
		ClangdSwitchSourceHeaderSplit = {
			function() switch_source_header_splitcmd(0, "split") end;
			description = "Open source/header in a new split";
		}
	}
}

vim.api.nvim_set_keymap(
  'n', '<lead>h', ":ClangdSwitchSourceHeaderVSplit<CR>",
  {
    noremap = true,
    silent = true
  }
)

local gopls_root_path = os.getenv("HOME") .. "/.local/share/nvim/lsp_servers/go/"
nvim_lsp.gopls.setup {
	cmd = {gopls_root_path .. "gopls", "serve"},
	filetypes = {"go", "gomod"},
	capabilities = capabilities,
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
	on_attach = on_attach,
}
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
function goimports(timeoutms)
	local context = { source = { organizeImports = true } }
	vim.validate { context = { context, "t", true } }
	local params = vim.lsp.util.make_range_params()
	params.context = context
	-- See the implementation of the textDocument/codeAction callback
	-- (lua/vim/lsp/handler.lua) for how to do this properly.
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
	if not result or next(result) == nil then return end
	local actions = result[1].result
	if not actions then return end
	local action = actions[1]
	-- textDocument/codeAction can return either Command[] or CodeAction[]. If it
	-- is a CodeAction, it can have either an edit, a command or both. Edits
	-- should be executed first.
	if action.edit or type(action.command) == "table" then
		if action.edit then
			vim.lsp.util.apply_workspace_edit(action.edit)
		end
		if type(action.command) == "table" then
			vim.lsp.buf.execute_command(action.command)
		end
	else
		vim.lsp.buf.execute_command(action)
	end
end
--
-- Set autocommands conditional on server_capabilities
-- augroup GO_LSP
-- 	autocmd!
-- 	autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()
-- 	autocmd BufWritePre *.go :silent! lua org_imports(3000)
-- augroup END
-- autocmd BufWritePre *.go  lua vim.lsp.buf.formatting()
-- autocmd BufWritePre *.go  lua goimports(1000)
vim.cmd(
[[
autocmd BufWritePre *.go  lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go  lua goimports(1000)
]])
