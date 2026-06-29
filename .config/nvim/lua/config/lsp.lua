require('mason').setup()
require('mason-lspconfig').setup({
  automatic_enable = false,
})

vim.lsp.config('*', {
    capabilities = {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
        },
    },
})
vim.lsp.config('lua_ls', {
	root_markers = { '.luarc.json', '.git', '.hg' },
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = { 'vim' }, },
			workspace = {
				checkThirdParty = false,
				library = {
					vim.fn.expand('$VIMRUNTIME'),
					vim.fn.stdpath('config'),
					'${3rd}/luv/library', 
				},
			},
		},
		telemetry = { enable = true, },
	},
})
vim.lsp.config('gopls', {
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
    },
  },
})
vim.lsp.config('ts_ls', {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})
vim.filetype.add({
    extension = {
		h = 'c',
		c = 'c',
		vert = 'glsl',
		frag = 'glsl',
		geom = 'glsl',
		comp = 'glsl',
		tesc = 'glsl',
		tese = 'glsl',
	}
})
vim.g.c_syntax_for_h = 1

vim.lsp.enable({ "buf_ls", "clangd", "ts_ls", "gopls", "lua_ls", "zls", "glsl_analyzer" })

vim.lsp.log.set_level('off')
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})
