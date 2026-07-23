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
              icon = "  ",
              desc = "Recent Projects",
              key="r",
              action = "Telescope projects",
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
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end,
},
{
  'nvim-telescope/telescope.nvim',
  -- cmd = "Telescope",
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup {}
  end,
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
  ft = {"c", "cpp"},
  config = function()
    dap = require("dap")
    dap.adapters.gdb = {
      type = "executable",
      command = "C:\\msys64\\mingw64\\bin\\gdb.exe",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }
    dap.configurations.c = {
    {
    name = "Launch file (native)",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    
    stopAtBeginningOfMainSubprogram = true,
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
  ft = {"c", "cpp"},
  config = true,
  dependencies = {
    "mfussenegger/nvim-dap",
  },
},
{
  "rcarriga/nvim-dap-ui",
  ft = {"c", "cpp"},
  config = function()
    require("dapui").setup({
      layouts = {
        {
          -- Only displays the console / terminal output window at the bottom
          elements = {
            { id = "console", size = 1.0 } 
          },
          position = "bottom",
          size = 15,
        },
      },
    })
  end,
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
    "xXAbieGamingXx/a",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    command = {"AocGetPuzzleInput", "AocGetTodayPuzzleInput"},
    opts = {session_filepath = "C:\\Users\\Macch\\AppData\\Local\\nvim-data\\aoc\\aoc.nvim\\lua\\aoc\\key.txt"}
},
{
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  cmd = "Oil",
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
    view_options = {
      show_hidden = true
    },
    use_default_keymaps = false
  },
  -- Optional dependencies
  -- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
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
  "Apeiros-46B/qalc.nvim",
  cmd = {"Qalc", "QalcAttach"},
  config = function()
    require("qalc").setup({})
  end,
},
{
  "jbyuki/venn.nvim", -- this is an epic plugin look up when you want to actually use it xd
  
},
{
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons' },
    ft = "markdown",
    opts = {
      render_modes = { 'n', 'c', 't', 'i' },
      latex = {
        enabled = false,
        converter = 'latex2text',
      },
    },
},
{
  "hat0uma/csvview.nvim",
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = { comments = { "#", "//" } },
    keymaps = {
      -- Text objects for selecting fields
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      -- Excel-like navigation:
      -- Use <Tab> and <S-Tab> to move horizontally between fields.
      -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
      -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      jump_next_row = { "<Enter>", mode = { "n", "v" } },
      jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
    },
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
},
{
    "DamianVCechov/hexview.nvim",
    config = function()
        require("hexview").setup()
    end,
    cmd = {"Hex", "UnHex", "HexSet"},
},
{
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    lazy = false,
    opts = {
      html = {
        enable = false,
      },
      latex = {
        enable = true,
      },
      markdown = {
        enable = false,
      },
      markdown_inline = {
        enable = false,
      },
      preview = {
        enable = true,
        modes = {'n', 'i', 'v', 'c', 't'},
      },
      typst = {
        enable = false,
      },
      yaml = {
        enable = false,
      }
    }
},
{
  "sindrets/diffview.nvim",
  cmd = "DiffviewOpen"
},
{
  "swaits/scratch.nvim",
  lazy = true,
  cmd = {
    "Scratch",
    "ScratchSplit",
  },
  opts = {},
},
{
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { 
        "nvim-telescope/telescope-live-grep-args.nvim" ,
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
    },
  },
  config = function()
    local telescope = require("telescope")

    -- first setup telescope
    telescope.setup({
        -- your config
    })

    -- then load the extension
    telescope.load_extension("live_grep_args")
  end
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

in_spaces = false

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

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {"*.pio"},
  callback = function()
    vim.bo.filetype = "pioasm" -- idk why but this is the parsers filetype requirement
  end,
})

vim.cmd("colorscheme onedark")
require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')

vim.keymap.set("n", "<leader>v", ":vs<cr>", {noremap = true, silent = true,}) -- vertical split
vim.keymap.set({"n", "v"}, "<leader>o", ":Oil .<cr>", {noremap = true, silent = true,}) -- open file explorer
vim.keymap.set("t", "<C-i>", "<C-\\><C-N><C-6>", {noremap = true, silent = true})
vim.keymap.set("t", "<C-n>", "<C-\\><C-N>", {noremap = true, silent = true})
vim.keymap.set("v", "<leader>b", ":VBox", {noremap = true}) -- set ve=all
vim.keymap.set('n', '<leader>m', ":lua require('nabla').popup()<cr>", {noremap = true, silent = true})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files({ search_dirs = { vim.fs.root(0, { '.git' }) }, path_display = {"smart"} })
end, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', function()
  require("telescope").extensions.live_grep_args.live_grep_args({ search_dirs = { vim.fs.root(0, { '.git' }) }, path_display = {"smart"} })
end, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set({'n', 'v'}, 'J', "5j", {noremap = true, silent = true})
vim.keymap.set({'n', 'v'}, 'K', "5k", {noremap = true, silent = true})
vim.keymap.set({'n', 'v'}, 'L', "5l", {noremap = true, silent = true})
vim.keymap.set({'n', 'v'}, 'H', "5h", {noremap = true, silent = true})



local floating = false

vim.keymap.set({'n', 'v'}, '<leader>p', function()
  if floating then
    vim.cmd("set ve=none")
    float = false
  else
    vim.cmd("set ve=all")
    float = true
  end
end, {noremap = true, silent = true})

local terms = {}
local index = 0

vim.keymap.set('n', '<leader>e', function()
	if index < 10 then
		vim.cmd("term")
		terms[index] = vim.api.nvim_get_current_buf()

		index = index + 1
	end
end, {noremap = true, silent = true})

vim.keymap.set("n", "<leader>r", function()
	if index >= 1 then
    if vim.api.nvim_buf_is_valid(terms[0]) then
		  vim.cmd("b! "..terms[0])
    else
      vim.cmd("term")
		  terms[0] = vim.api.nvim_buf_get_name(0)
    end
	end
end, {noremap = true, silent = true})

vim.keymap.set("n", "<leader>w2", function()
	if index >= 2 then
    if vim.api.nvim_buf_is_valid(terms[1]) then
		  vim.cmd("b! "..terms[1])
    else
      vim.cmd("term")
		  terms[1] = vim.api.nvim_buf_get_name(0)
    end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w3", function()
	if index >= 3 then
    if vim.api.nvim_buf_is_valid(terms[2]) then
		  vim.cmd("b! "..terms[2])
    else
      vim.cmd("term")
		  terms[2] = vim.api.nvim_buf_get_name(0)
    end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w4", function()
	if index >= 4 then
    if vim.api.nvim_buf_is_valid(terms[3]) then
		  vim.cmd("b! "..terms[3])
    else
      vim.cmd("term")
		  terms[3] = vim.api.nvim_buf_get_name(0)
    end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w5", function()
	if index >= 5 then
    if vim.api.nvim_buf_is_valid(terms[4]) then
		  vim.cmd("b! "..terms[4])
    else
      vim.cmd("term")
		  terms[4] = vim.api.nvim_buf_get_name(0)
    end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w6", function()
	if index >= 6 then
    if vim.api.nvim_buf_is_valid(terms[5]) then
		  vim.cmd("b! "..terms[5])
    else
      vim.cmd("term")
		  terms[5] = vim.api.nvim_buf_get_name(0)
    end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w7", function()
	if index >= 7 then
    if vim.api.nvim_buf_is_valid(terms[6]) then
		  vim.cmd("b! "..terms[6])
    else
      vim.cmd("term")
		  terms[6] = vim.api.nvim_buf_get_name(0)
    end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w8", function()
	if index >= 8 then
    if vim.api.nvim_buf_is_valid(terms[7]) then
		  vim.cmd("b! "..terms[7])
    else
      vim.cmd("term")
		  terms[7] = vim.api.nvim_buf_get_name(0)
    end
	end
end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>w9", function()
	if index >= 9 then
    if vim.api.nvim_buf_is_valid(terms[8]) then
		  vim.cmd("b! "..terms[8])
    else
      vim.cmd("term")
		  terms[8] = vim.api.nvim_buf_get_name(0)
    end
	end
end, {noremap = true, silent = true})
