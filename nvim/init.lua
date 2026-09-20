vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = "%{v:lnum} %{v:relnum} "
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.exrc = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "Clear search highlights",
  silent = true,
})

vim.keymap.set("n", "<leader>e", "<cmd>Explore<CR>", {
  desc = "Browse files",
  silent = true,
})

vim.keymap.set("n", "<leader>fn", function()
  vim.ui.input({ prompt = "New file: ", completion = "file" }, function(path)
    if not path or path == "" then
      return
    end
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent ~= "." then
      vim.fn.mkdir(parent, "p")
    end
    vim.cmd.edit(vim.fn.fnameescape(path))
  end)
end, {
  desc = "Create new file",
})

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, { scope = "line" })
end, {
  desc = "Show line diagnostics",
})
-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
      vim.cmd.colorscheme("tokyonight")
    end
  },

  { "williamboman/mason.nvim", opts = { PATH = "prepend" } },
  { "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search project text" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })
    end,
  },
  { "williamboman/mason-lspconfig.nvim",
    opts = { ensure_installed = { "pyright", "powershell_es", "ols", "ts_ls" } },
  },
{ "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    -- Advertise nvim-cmp's capabilities to every LSP server (snippets, etc.)
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config("*", { capabilities = capabilities })

    -- New LSP config API (no deprecation warning)
    vim.lsp.config("pyright", {})
    vim.lsp.config("powershell_es", {})
    vim.lsp.config("ts_ls", {})
    vim.lsp.config("ols", {
      cmd = { "ols" },
      filetypes = { "odin" },
      root_markers = { "ols.json", "odin.project", ".git" },
    })

    -- Enable the servers
    vim.lsp.enable({ "pyright", "powershell_es", "ols", "ts_ls" })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local map = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, silent = true })
        end
        map("n", "gd", vim.lsp.buf.definition)
        map("n", "gD", vim.lsp.buf.declaration)
        map("n", "gr", vim.lsp.buf.references)
        map("n", "gi", vim.lsp.buf.implementation)
        map("n", "K", vim.lsp.buf.hover)
        map("n", "<leader>rn", vim.lsp.buf.rename)
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
        map("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end)
      end,
    })

    -- OLS supplies Odin formatting. Format changed Odin buffers on save.
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.odin",
      callback = function(args)
        vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 2000 })
      end,
    })
  end
},

{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },

{ "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    toggle_key = "<C-k>",
  },
},

  { "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = {
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = { { name = "nvim_lsp" } },
      })
    end
  },
{ "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "python", "lua", "markdown", "markdown_inline", "odin", "typescript", "javascript", "tsx", "json" },
      highlight = { enable = true },
    })
  end,
},

{ "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {},
},
})
