-- local Util = require("lazy.util")

-- local M = {}

-- M.lazy_file = "lazy.lua"

-- ---@param plugin LazyPlugin
-- ---@return LazyPkg?
-- function M.get(plugin)
--   local file = Util.norm(plugin.dir .. "/" .. M.lazy_file)
--   if Util.file_exists(file) then
--     ---@type fun(): LazySpec
--     local chunk = Util.try(function()
--       local ret, err = loadfile(file)
--       return err and error(err) or ret
--     end, "`" .. M.lazy_file .. "` for **" .. plugin.name .. "** has errors:")
--     if not chunk then
--       Util.error("Invalid `" .. M.lazy_file .. "` for **" .. plugin.name .. "**")
--       return
--     end
--     return {
--       source = "lazy",
--       file = M.lazy_file,
--       code = "function()\n" .. Util.read_file(file) .. "\nend",
--     }
--   end
-- end

-- return M
-- Bootstrap lazy.nvim
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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup(
  {
  {
  'flashcodes-themayankjha/Fknotes.nvim',
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require('fknotes').setup({
      -- your configuration here
    })
  end
},
{ "nvim-tree/nvim-web-devicons", lazy = true, opts = {} },
{
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup {
      theme="doom",
      config = {
        header = {    
    "                                                                              ",
    "=================     ===============     ===============   ========  ========",
    "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
    "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
    "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
    "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
    "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||",
    "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
    "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||",
    "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
    "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
    "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
    "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
    "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
    "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
    "||   .=='    _-'          `-__\\._-'         `-_./__-'         `' |. /|  |   ||",
    "||.=='    _-'                                                     `' |  /==.||",
    "=='    _-'                        N E O V I M                         \\/   `==",
    "\\   _-'                                                                `-_   /",
    " `''                                                                      ``'  ",},
      
        center = {
            {
              icon = "  ",
              desc = "Recently Opened Files",
              key="r",
              action = "Telescope oldfiles",
            },
            {
              icon = "  ",
              desc = "New File",
              key="n",
              action = "enew",
            },
            { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q" },
            
        },
      },
    }
  end,
  dependencies = { {"nvim-tree/nvim-web-devicons"}}
},
{
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
},
{
  'nvim-telescope/telescope.nvim',
  dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' }
    }
},
   {
      "nvim-treesitter/nvim-treesitter",
      version = false,
      build = ":TSUpdate",
      lazy = false,
      opts = {
        indent = {
          enable = true,
        },
        highlight = {
          enable = true,
        },
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
      end,
    },
{
    "romus204/referencer.nvim",
    config = function()
        require("referencer").setup()
    end
},
{
  'jim-fx/sudoku.nvim',
  cmd = "Sudoku",
  config = function()
    require("sudoku").setup({
      -- configuration ...
    })
  end
},
{
  "sontungexpt/witch-line",
  dependencies = {
      "nvim-tree/nvim-web-devicons",
  },
  lazy = false, -- Almost component is lazy load by default. So you can set lazy to false
  opts = {},
},
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
},
{"eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton",},
{"rktjmp/playtime.nvim", cmd = "Playtime",},
{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
},
{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufEnter",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},
{
  "mfussenegger/nvim-dap",
  lazy = true,
  -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
  -- modified.
  config = function()
    dap = require("dap")
    dap.adapters.gdb = {
      type = "executable",
      command = "C:\\msys64\\mingw64\\bin\\gdb.exe",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }
    dap.configurations.c = {
    {
    name = "Launch file",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    
    stopAtBeginningOfMainSubprogram = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'gdb',
    request = 'launch',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
  end,

  keys = {
    {
      "<leader>b",
      function() require("dap").toggle_breakpoint() end,
      desc = "Toggle Breakpoint"
    },

    {
      "<leader>c",
      function() require("dap").continue() end,
      desc = "Continue"
    },

    {
      "<leader>l",
      function() require("dap").step_over() end,
      desc = "Next"
    },

    {
      "<leader>s",
      function() require("dap").step_into() end,
      desc = "Step"
    },

    {
      "<leader>t",
      function() require("dap").terminate() end,
      desc = "Terminate"
    },
  },
},
{
  "theHamsta/nvim-dap-virtual-text",
  config = true,
  dependencies = {
    "mfussenegger/nvim-dap",
  },
},
{
  "rcarriga/nvim-dap-ui",
  config = true,
  keys = {
    {
      "<leader>du",
      function()
        require("dapui").toggle({})
      end,
      desc = "Dap UI"
    },
  },
  dependencies = {
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
  },
},
{
  "HiPhish/rainbow-delimiters.nvim",
  event = "BufEnter",
  dependencies = {"nvim-treesitter/nvim-treesitter"},
  config = function()
    require("rainbow-delimiters.setup").setup()
  end,
},
{
    dir = "C:\\Users\\Macch\\AppData\\Local\\nvim-data\\aoc\\aoc.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    command = {"AocGetPuzzleInput", "AocGetTodayPuzzleInput"},
    lazy = true,
    opts = {session_filepath = "C:\\Users\\Macch\\AppData\\Local\\nvim-data\\aoc\\aoc.nvim\\lua\\aoc\\key.txt"}
},
{
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
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
    use_default_keymaps = false
  },
  -- Optional dependencies
  -- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
},
{
  "carlos-algms/agentic.nvim",
  opts = {
    -- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp"
    provider = "claude-agent-acp",
  },

  -- these are just suggested keymaps; customize as desired
  keys = {
    {
      "<C-\\>",
      function() require("agentic").toggle() end,
      mode = { "n", "v", "i" },
      desc = "Toggle Agentic Chat"
    },
    {
      "<C-'>",
      function() require("agentic").add_selection_or_file_to_context() end,
      mode = { "n", "v" },
      desc = "Add file or selection to Agentic to Context"
    },
    {
      "<leader>an",
      function() require("agentic").new_session() end,
      mode = { "n", "v", "i" },
      desc = "New Agentic Session"
    },
    {
      "<A-i>r", -- ai Restore
      function()
          require("agentic").restore_session()
      end,
      desc = "Agentic Restore session",
      silent = true,
      mode = { "n", "v", "i" },
    },
    {
      "<leader>ad", -- ai Diagnostics
      function()
          require("agentic").add_current_line_diagnostics()
      end,
      desc = "Add current line diagnostic to Agentic",
      mode = { "n" },
    },
    {
      "<leader>aD", -- ai all Diagnostics
      function()
          require("agentic").add_buffer_diagnostics()
      end,
      desc = "Add all buffer diagnostics to Agentic",
      mode = { "n" },
    },
  },
},




  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- automatically check for plugin updates
  checker = { enabled = true },
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

vim.cmd("colorscheme onedark")

vim.keymap.set("n", "<leader>v", ":vs<cr>", {noremap = true, silent = true,}) -- vertical split
vim.keymap.set("n", "<leader>o", ":Oil .<cr>", {noremap = true, silent = true,}) -- open file explorer
-- vim.keymap.set("n", "<leader>e", ":term<cr>", {noremap = true, silent = true,}) -- open a terminal: switch is <C-^>
-- vim.keymap.set("n", "<leader>q", ":bdelete! term://<Tab><Tab><cr>", {noremap = true, silent = true})
vim.keymap.set("t", "<C-i>", "<C-\\><C-N><C-6>", {noremap = true, silent = true})
vim.keymap.set("t", "<C-n>", "<C-\\><C-N>", {noremap = true, silent = true})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


local terms = {}
local index = 0

vim.keymap.set('n', '<leader>e', function()
	if index < 10 then
		vim.cmd("term")
		terms[index] = vim.api.nvim_buf_get_name(0)

		index = index + 1
	end
end, {noremap = true, silent = true})

vim.keymap.set("n", "<leader>r", function()
	if index >= 1 then
		vim.cmd("b! "..terms[0])
	end
end, {noremap = true, silent = true})

vim.keymap.set("n", "<leader>w1", function()
	if index >= 1 then
		vim.cmd("b! "..terms[0])
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w2", function()
	if index >= 2 then
		vim.cmd("b! "..terms[1])
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w3", function()
	if index >= 3 then
		vim.cmd("b! "..terms[2])
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w4", function()
	if index >= 4 then
		vim.cmd("b! "..terms[3])
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w5", function()
	if index >= 5 then
		vim.cmd("b! "..terms[4])
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w6", function()
	if index >= 6 then
		vim.cmd("b! "..terms[5])
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w7", function()
	if index >= 7 then
		vim.cmd("b! "..terms[6])
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w8", function()
	if index >= 8 then
		vim.cmd("b! "..terms[7])
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w9", function()
	if index >= 9 then
		vim.cmd("b! "..terms[8])
	end
end, {noremap = true, silent = true})
