-- Always install core Go tooling via mason, independent of whether the
-- LazyVim lang.go extra (which pulls in dap-go, gotests, etc.) is enabled.
return {
  {
    -- must match LazyVim core's own source string exactly ("mason-org/mason.nvim");
    -- LazyVim's mason.nvim spec sets opts_extend = { "ensure_installed" }, so a
    -- plain table here gets concatenated onto the core list automatically
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "gofumpt",
        "goimports",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {},
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
      },
    },
  },
}
