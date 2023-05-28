local is_work = os.getenv("DOT_ENVIROMENT") == "work"

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

if not is_work then
  lvim.format_on_save = {
    enabled = true,
    pattern = { "*.lua", "*.js", "*.jsx", "*.ts", "*.tsx" },
    timeout = 3000,
  }


  local formatters = require "lvim.lsp.null-ls.formatters"
  formatters.setup {
    {
      name = "prettier",
    },
  }
end

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "eslint" },
}

lvim.use_icons = true

lvim.leader = "space"

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

lvim.builtin.which_key.mappings["<leader>"] = {
  function() require("lvim.core.telescope.custom-finders").find_project_files() end,
  "Find File",
}
lvim.builtin.which_key.mappings["f"] = {}

lvim.builtin.which_key.mappings["sw"] = { "<cmd>Telescope grep_string<cr>", "word" }
lvim.builtin.which_key.vmappings["lf"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "format" }

lvim.lsp.buffer_mappings.normal_mode["]d"] = lvim.builtin.which_key.mappings["l"]["j"]
lvim.lsp.buffer_mappings.normal_mode["[d"] = lvim.builtin.which_key.mappings["l"]["k"]

lvim.lsp.buffer_mappings.normal_mode["gd"] = { "<cmd>Telescope lsp_definitions<cr>", "Go to definition" }
lvim.lsp.buffer_mappings.normal_mode["gi"] = { "<cmd>Telescope lsp_implementations<cr>", "Go to implementations" }
lvim.lsp.buffer_mappings.normal_mode["gI"] = nil
lvim.lsp.buffer_mappings.normal_mode["gr"] = { "<cmd>Telescope lsp_references<cr>", "Go to references" }

lvim.builtin.which_key.mappings["l"]["j"] = {}
lvim.builtin.which_key.mappings["l"]["k"] = {}

local actions = require("lvim.utils.modules").require_on_exported_call "telescope.actions"
lvim.builtin.telescope.defaults.mappings.i["<C-q>"] = function(...)
  actions.smart_send_to_qflist(...)
  vim.cmd("Trouble quickfix")
end

lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

if is_work then
  lvim.builtin.dap.active = false;
  lvim.builtin.treesitter.highlight.enable = false;
  lvim.builtin.treesitter.indent.enable = false;
  lvim.builtin.indentlines.options.use_treesitter = false;
end
lvim.builtin.telescope.theme = "center";

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

lvim.lsp.installer.setup.automatic_installation = false

lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "rrethy/nvim-treesitter-textsubjects",
    dependencies = { "nvim-treesitter" }
  },
  {
    "axkirillov/hbac.nvim",
    config = function()
      require("hbac").setup({
        threshold = 5
      })
    end
  },
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Trouble",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}
