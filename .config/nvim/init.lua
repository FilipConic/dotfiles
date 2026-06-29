vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
vim.opt.scrolloff = 10

vim.opt.runtimepath:append(vim.fn.stdpath('config') .. '/lua')
vim.keymap.set('n', '<leader>ww', "<Cmd>lua vim.diagnostic.open_float()<Enter>")

vim.pack.add({
	{ src = "https://github.com/EdenEast/nightfox.nvim" },
	{ src = "https://github.com/rose-pine/neovim", as = "rose-pine" },
	{ src = "https://github.com/shaunsingh/nord.nvim" },

	{ src = "https://github.com/iamcco/markdown-preview.nvim" },

	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },

	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },

	{ src = "https://github.com/akinsho/toggleterm.nvim" },

	{ src = "https://github.com/mikavilpas/yazi.nvim" },

	{ src = "https://github.com/nvim-lualine/lualine.nvim" },

	{ src = "https://github.com/kevinhwang91/promise-async" },
	{ src = "https://github.com/kevinhwang91/nvim-ufo" },

	{ src = "https://github.com/lervag/vimtex" },
})

vim.cmd("colorscheme rose-pine")

-- lsp configs
require('luasnip.loaders.from_vscode').lazy_load()
require('config.lsp')

-- vimtex
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'tectonic'

-- treesitter
vim.keymap.set('n', '<leader>tr', function()
    local ok, parser = pcall(vim.treesitter.get_parser, 0)
    if ok and parser then
        parser:parse(true)
        vim.notify('Treesitter reparsed')
    else
        vim.notify('No treesitter parser for this buffer', vim.log.levels.WARN)
    end
end, { desc = 'Force treesitter reparse' })

-- lualine
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16,
			events = {
				'WinEnter',
				'BufEnter',
				'BufWritePost',
				'SessionLoadPost',
				'FileChangedShellPost',
				'VimResized',
				'Filetype',
				'CursorMoved',
				'CursorMovedI',
				'ModeChanged',
			},
		}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

-- yazi
require("yazi").setup({
	open_for_directories = true,
	floating_window_scaling_factor = 0.95,
	yazi_floating_window_border = "double",
	yazi_floating_window_winblend = 10,
	highlight_hovered_buffers_in_same_directory = false,
})

vim.keymap.set("n", "<leader>e", "<Cmd>Yazi<CR>")

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })

-- ufo
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.keymap.set("n", "zR", function()
	require("ufo").openAllFolds()
end)
vim.keymap.set("n", "zM", function()
	require("ufo").closeAllFolds()
end)
require('ufo').setup({
    provider_selector = function(_, _, _)
        return { 'treesitter', 'indent' }
    end,
})

-- blink
require('blink.cmp').setup({
	keymap = {
		preset = 'default',
		['<Tab>'] = { 'snippet_forward', 'select_and_accept', 'fallback' },
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = 'mono',
	},
	signature = { enabled = true },
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
})

require('config.autocmd')
