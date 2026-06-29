vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 100,
		})
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "haskell",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function()
		vim.opt_local.cinoptions = "l1"
	end,
})

-- treesitter
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd('packadd nvim-treesitter')

        -- main branch: setup() takes minimal/no config
        require('nvim-treesitter').setup({})

        -- install parsers via the install() function (async)
        require('nvim-treesitter').install({ "c", "make", "lua", "zig" })
    end,
})

-- highlighting is started per-buffer, NOT via a config flag
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'make', 'lua', 'zig' },
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
