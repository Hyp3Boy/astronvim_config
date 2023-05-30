-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

local keymap = vim.keymap -- for conciseness
-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }
  -- set keybinds
end
-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

return {
  --configure clangd server
  lspconfig["clangd"].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    capabilities.offsetEncoding == { "utf-16" },
    cmd = {
      "/usr/bin/clangd",
      "-offset-encoding=utf-16",
    },
  },
  -- configure rust-analyzer server
  lspconfig["rust_analyzer"].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "rust" },
    root_dir = lspconfig.util.root_pattern "Cargo.toml",
  },
}
