-- Packer
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

vim.cmd("packadd packer.nvim")

-- Install packer if needed
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

require("packer").init({
  -- /home/stef/.local/share/nvim/site/pack/packer/start/packer.nvim/packer_compiled.lua
  compile_path = install_path .. "/packer_compiled.lua",
})

return require("packer").startup(function(use)
  -- Plugin manager
  use("wbthomason/packer.nvim")

  -- Required libs
  use("nvim-lua/plenary.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("nvim-treesitter/nvim-treesitter-textobjects")
  -- Annotations generator
  use({
    "danymat/neogen",
    tag = "*", -- Only follow stable versions
  })
  -- Auto pairs
  use({ "windwp/nvim-autopairs", wants = "nvim-cmp" })

  -- LSP
  use("neovim/nvim-lspconfig")
  use("jose-elias-alvarez/null-ls.nvim")

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
  })

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("nvim-telescope/telescope-file-browser.nvim")

  -- Snippets
  use("L3MON4D3/LuaSnip")

  -- Git
  use({
    "TimUntersberger/neogit",
    "lewis6991/gitsigns.nvim",
    "sindrets/diffview.nvim",
  })

  -- Todo comments
  use("folke/todo-comments.nvim")

  -- Comments
  use("scrooloose/nerdcommenter")

  -- Higlighting for log files
  -- TODO: Check if there's log highlighting in treesitter
  use("mtdl9/vim-log-highlighting")

  -- Themes & colors
  use({
    "navarasu/onedark.nvim",
    "kyazdani42/nvim-web-devicons",
  })

  -- Buffer line
  use({
    "akinsho/bufferline.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })

  -- Status line
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })

  -- Sync packer
  if Packer_bootstrap then
    require("packer").sync()
  end
end)
