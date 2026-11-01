-- Always install core Go tooling via mason, independent of whether the
-- LazyVim lang.go extra (which pulls in dap-go, gotests, etc.) is enabled.
-- gopls and goimports are built by mason with `go install`, so they are only
-- enabled where a Go toolchain exists (devcontainers, not the host).
local has_go = vim.fn.executable("go") == 1

return {
  {
    -- must match LazyVim core's own source string exactly ("mason-org/mason.nvim");
    -- LazyVim's mason.nvim spec sets opts_extend = { "ensure_installed" }, so a
    -- plain table here gets concatenated onto the core list automatically
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = has_go and {
        "gopls",
        "gofumpt",
        "goimports",
      } or {
        "gofumpt",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = { enabled = has_go },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = has_go and { "goimports", "gofumpt" } or { "gofumpt" },
      },
    },
  },
}
