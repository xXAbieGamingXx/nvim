local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

vim.opt.autochdir = true
vim.o.number = true
vim.o.shellxquote = ""
vim.o.shellcmdflag = "--login -c"
vim.o.foldenable = false
vim.o.shiftwidth = 8
vim.o.tabstop = 8
vim.o.expandtab = false
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.laststatus = 3

vim.diagnostic.enable(false)

-- config for vimscript plugins
vim.g.rg_map_keys = 0

-- uneeded builtin features to speed up load time
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor_mode_plugin = 1

require("config.lazy")
