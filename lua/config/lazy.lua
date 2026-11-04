vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, noremap = true }) -- this stops space from moving the cursor

require("lazy").setup(
	{
{
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- Ensure it loads first
},
{
	"sontungexpt/witch-line",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = function()
		require("witch-line").setup({
			statusline = {
				global = {
					"mode",
					"file.name",
					"file.icon",
					"file.modifier",

					"git.branch",
					"git.diff.added",
					"git.diff.removed",
					"git.diff.modified",

					"%=",

					"lsp.clients",

					-- "windsurf.neocodeium",
					-- "windsurf",

					"indent",
					-- "encoding",
					"cursor.pos",
					"cursor.progress",
				},
			},
			disabled = {
				filetypes = { "TelescopePrompt", "TelescopeResults" },
				buftypes = { "prompt" },
			},
		})
	end,
},
{
	"barrettruth/canola.nvim",
	cmd = "Oil",
	config = function() 
		require("oil").setup({
			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<CR>"] = "actions.select",
				["<C-s>"] = { "actions.select", opts = { vertical = true } },
				["<C-h>"] = { "actions.select", opts = { horizontal = true } },
				["<C-t>"] = { "actions.select", opts = { tab = true } },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = { "actions.close", mode = "n" },
				["<C-l>"] = "actions.refresh",
				["-"] = { "actions.parent", mode = "n" },
				["_"] = { "actions.open_cwd", mode = "n" },
				["`"] = { "actions.cd", mode = "n" },
				["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
			},
			view_options = {
				show_hidden = true
			},
			use_default_keymaps = false
		})
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
},
{
	"romus204/tree-sitter-manager.nvim",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	cmd = "TSManager",
	config = function()
		require("tree-sitter-manager").setup({
			
		})
	end
},
{
	"xXAbieGamingXx/myrg.nvim",
	cmd = {"Rg", "Rgcwd", "Rgff"},
},


	checker = {
		enabled = false,
	},
}
)

vim.api.nvim_create_autocmd("FileType", {
	pattern = '*',
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
		if lang then pcall(vim.treesitter.start, args.buf)
			vim.opt.foldlevel = 9
			vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.wo.foldmethod = 'expr'
			-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" idk man this breaks it
		end
		vim.opt.formatoptions:remove("r")
		vim.opt.formatoptions:remove("o")
		vim.opt.formatoptions:remove("c")
	end
})

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if vim.inspect(vim.b.editorconfig) == "" then -- check for editorconfig
			if vim.b.editorconfig.indent_style == "tab" then
				vim.opt_local.tabwidth = 8
				vim.opt_local.tabstop = 8
			else
				vim.opt_local.vartabstop = tostring(vim.o.shiftwidth) .. ":8"
			end
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function(args)
		pcall(vim.treesitter.stop, args.buf)
	end,
})

-- random
vim.keymap.set({"n", "v"}, "-", ":Oil .<cr>", {noremap = true, silent = true})
vim.keymap.set("t", "<C-n>", "<C-\\><C-N>", {noremap = true, silent = true})
vim.keymap.set("i", "<C-c>", "<Esc>", {noremap = true}) -- C-c is supposedly more dangerous

-- myrg
vim.keymap.set('n', '<leader>fg', ":Rg<cr>")
vim.keymap.set('n', '<leader>ff', ":Rgff<cr>")
vim.keymap.set('n', '<leader>ft', function()
	local root = vim.fs.root(0, {".git"})
	require("myrg").rgcwd(root)
end)


vim.keymap.set("i", "`", function()
	if vim.bo.filetype ~= "systemverilog" then
		local keys = vim.api.nvim_replace_termcodes("``<Left>", true, false, true)
		vim.api.nvim_feedkeys(keys, "n", true)
	else
		local keys = vim.api.nvim_replace_termcodes("`", true, false, true)
		vim.api.nvim_feedkeys(keys, "n", true)
	end
end)
vim.keymap.set("i", '"', '""<Left>')
vim.keymap.set("i", "'", function()
	if vim.bo.filetype ~= "systemverilog" then
		local keys = vim.api.nvim_replace_termcodes("''<Left>", true, false, true)
		vim.api.nvim_feedkeys(keys, "n", true)
	else
		local keys = vim.api.nvim_replace_termcodes("'", true, false, true)
		vim.api.nvim_feedkeys(keys, "n", true)
	end
end)
vim.keymap.set("i", "(", "()<Left>")
vim.keymap.set("i", "[", "[]<Left>")
vim.keymap.set("i", "{", " {}<Left><cr><cr><Up><Tab>")
vim.keymap.set("i", "}", "{}<Left>")


vim.keymap.set({'n', 'v'}, 'J', "5j", {noremap = true, silent = true})
vim.keymap.set({'n', 'v'}, 'K', "5k", {noremap = true, silent = true})
vim.keymap.set({'n', 'v'}, 'L', "5l", {noremap = true, silent = true})
vim.keymap.set({'n', 'v'}, 'H', "5h", {noremap = true, silent = true})


vim.cmd("colorscheme onedark")


local terms = {}
local index = 0
local previous_buffer

vim.keymap.set('n', '<leader>e', function()
	if index < 10 then
		if vim.bo.buftype ~= "terminal" then
			previous_buffer = vim.api.nvim_get_current_buf()
		end
		vim.cmd("term")
		terms[index] = vim.api.nvim_get_current_buf()

		index = index + 1
	end
end, {noremap = true, silent = true})

vim.keymap.set("n", "<leader>r", function()
	if index >= 1 then
		if vim.bo.buftype ~= "terminal" then
			previous_buffer = vim.api.nvim_get_current_buf()
		end
		if vim.api.nvim_buf_is_valid(terms[0]) then
			vim.cmd("b! "..terms[0])
		else
			vim.cmd("term")
			terms[0] = vim.api.nvim_get_current_buf()
		end
	end
end, {noremap = true, silent = true})

vim.keymap.set("n", "<leader>w2", function()
	if index >= 2 then
		if vim.api.nvim_buf_is_valid(terms[1]) then
			vim.cmd("b! "..terms[1])
		else
			vim.cmd("term")
			terms[1] = vim.api.nvim_get_current_buf()
		end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w3", function()
	if index >= 3 then
		if vim.bo.buftype ~= "terminal" then
			previous_buffer = vim.api.nvim_get_current_buf()
		end
		if vim.api.nvim_buf_is_valid(terms[2]) then
			vim.cmd("b! "..terms[2])
		else
			vim.cmd("term")
			terms[2] = vim.api.nvim_get_current_buf()
		end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w4", function()
	if index >= 4 then
		if vim.bo.buftype ~= "terminal" then
			previous_buffer = vim.api.nvim_get_current_buf()
		end
		if vim.api.nvim_buf_is_valid(terms[3]) then
			vim.cmd("b! "..terms[3])
		else
			vim.cmd("term")
			terms[3] = vim.api.nvim_get_current_buf()
		end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w5", function()
	if index >= 5 then
		if vim.bo.buftype ~= "terminal" then
			previous_buffer = vim.api.nvim_get_current_buf()
		end
		if vim.api.nvim_buf_is_valid(terms[4]) then
			vim.cmd("b! "..terms[4])
		else
			vim.cmd("term")
			terms[4] = vim.api.nvim_get_current_buf()
		end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w6", function()
	if index >= 6 then
		if vim.bo.buftype ~= "terminal" then
			previous_buffer = vim.api.nvim_get_current_buf()
		end
		if vim.api.nvim_buf_is_valid(terms[5]) then
			vim.cmd("b! "..terms[5])
		else
			vim.cmd("term")
			terms[5] = vim.api.nvim_get_current_buf()
		end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w7", function()
	if index >= 7 then
		if vim.bo.buftype ~= "terminal" then
			previous_buffer = vim.api.nvim_get_current_buf()
		end
		if vim.api.nvim_buf_is_valid(terms[6]) then
			vim.cmd("b! "..terms[6])
		else
			vim.cmd("term")
			terms[6] = vim.api.nvim_get_current_buf()
		end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w8", function()
	if index >= 8 then
		if vim.bo.buftype ~= "terminal" then
			previous_buffer = vim.api.nvim_get_current_buf()
		end
		if vim.api.nvim_buf_is_valid(terms[7]) then
			vim.cmd("b! "..terms[7])
		else
			vim.cmd("term")
			terms[7] = vim.api.nvim_get_current_buf()
		end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w9", function()
	if index >= 9 then
		if vim.bo.buftype ~= "terminal" then
			previous_buffer = vim.api.nvim_get_current_buf()
		end
		if vim.api.nvim_buf_is_valid(terms[8]) then
			vim.cmd("b! "..terms[8])
		else
			vim.cmd("term")
			terms[8] = vim.api.nvim_get_current_buf()
		end
	end
end, {noremap = true, silent = true})


vim.keymap.set("t", "<C-k>", function()
	vim.cmd("b! "..previous_buffer)
end, {noremap = true, silent = true})
