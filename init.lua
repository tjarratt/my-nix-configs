local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("fidget").setup()
require("completion")
require("preferences")
require("keybindings")
require("elixirconfig").setup(capabilities)
require("nixconfig").setup(lsp, capabilities)
require("treesitter")

lsp.jqls.setup {}
lsp.eslint.setup {}

