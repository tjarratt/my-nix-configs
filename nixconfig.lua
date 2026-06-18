return {
  setup = function(lsp, capabilities)
    lsp.nil_ls.setup {
      on_attach = function(_client, _bufnr)
        vim.bo.commentstring = "# %s"
      end,
      settings = {
        ["nil"] = {
          formatting = { command = {"nixfmt"} }
        }
      },
      capabilities = capabilities
    }
  end
}
