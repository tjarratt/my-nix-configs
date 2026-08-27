{ pkgs, ... }:

{
  programs.nixvim = {
    lsp.servers = {
      bashls.enable = true;
      cssls.enable = true;
      elixirls = {
        enable = true;
        config = {
          cmd = [ "${pkgs.elixir-ls}/scripts/language_server.sh" ];
        };
      };
      jsonls.enable = true;
      lua_ls.enable = true;
      tailwindcss.enable = true;
      nixd = {
        enable = true;
        config.formatting.command = [ "nixfmt" ];
      };
      rust_analyzer.enable = true;
    };

    plugins.lsp.enable = true;
  };
}
