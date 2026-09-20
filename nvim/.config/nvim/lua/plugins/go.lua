-- Always install core Go tooling via mason, independent of whether the
-- LazyVim lang.go extra (which pulls in dap-go, gotests, etc.) is enabled.
return {
  {
    -- bare name: extends whichever mason.nvim source LazyVim core is
    -- actually pinned to, instead of forcing an owner that may not match
    -- (mason.nvim moved from williamboman/ to mason-org/ upstream; pinning
    -- a specific owner here caused a source mismatch with LazyVim core and
    -- broke ensure_installed entirely)
    "mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gopls",
        "gofumpt",
        "goimports",
      })
    end,
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
