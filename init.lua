require("config.lazy")
vim.o.shell = "C:\\msys64\\usr\\bin\\bash.exe"
vim.opt.autochdir = true
vim.o.number = true
vim.o.shellxquote = ""
vim.o.shellcmdflag = "--login -c"
vim.o.foldenable = false



-- uneeded builtin features to speed up load time
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor_mode_plugin = 1