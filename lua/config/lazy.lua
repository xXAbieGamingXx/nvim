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
{ "nvim-tree/nvim-web-devicons", opts = {} },
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
  dependencies = { 'nvim-lua/plenary.nvim' }
},
   {
      "nvim-treesitter/nvim-treesitter",
      version = false,
      build = ":TSUpdate",
      lazy = false,
      opts = {
        -- ... your treesitter options
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
    opts = {session_filepath = "C:\\Users\\Macch\\AppData\\Local\\nvim-data\\aoc\\aoc.nvim\\lua\\aoc\\key.txt"}
},





  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- automatically check for plugin updates
  checker = { enabled = true },
}
)

require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true, -- enable syntax highlighting
  }
}
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt_local.formatoptions:remove("r")
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.tabstop = 8
    vim.opt.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.tabstop = 8
    vim.opt.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "tabstop",
  callback = function()
    vim.opt.tabstop = 8
  end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "expandtab",
  callback = function()
    vim.opt.expandtab = false
  end,
})

vim.cmd("colorscheme onedark")


vim.keymap.set("n", "<leader>e", ":term<cr>", {noremap = true, silent = true,}) -- open a terminal: switch is <C-^>
vim.keymap.set("n", "<leader>r", ":b term://<cr>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>q", ":bdelete term://<cr>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>a", ":ascii<cr>", {noremap = true, silent = true}) -- ascii value of cursor
vim.keymap.set("t", "<C-i>", "<C-\\><C-N><C-6>", {noremap = true, silent = true})