{ pkgs, lib, nixvim, ... }:

let
  milli = pkgs.vimUtils.buildVimPlugin {
    name = "milli-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "amansingh-afk";
      repo = "milli.nvim";
      rev = "00274623b76a66356e31e1861360b269987a7f64";
      hash = "sha256-EtrBQH8vzBMUF/Wp7t46sb39RQSPyGZWT+HucPoRxVg";
    };
  };
  
  related-files = pkgs.vimUtils.buildVimPlugin {
    name = "vim-related-files";
    src = pkgs.fetchFromGitHub {
      owner = "synchronal";
      repo = "related-files.nvim";
      rev = "14f7123b6081fd77d40519092e18e3b81588dffd";
      hash = "sha256-ztXtSm/PQTaT2woejI6rFfMGouWP/gokIAamTe2AMy4";
    };
    dependencies = with pkgs.vimPlugins; [
      telescope-nvim
      plenary-nvim
    ];
  };
in
{
  # programs.neovim = {
  #   enable = true;
  #   
  #   plugins = with pkgs.vimPlugins; [
  #     # cmp-buffer
  #     # cmp-cmdline
  #     # cmp-nvim-lsp
  #     # cmp_luasnip
  #     # elixir-tools-nvim
  #     # fidget-nvim
  #     # gruvbox
  #     # luasnip
  #     # nvim-cmp
  #     nvim-lsp-ts-utils
  #     nvim-lspconfig
  #     # nvim-treesitter.withAllGrammars
  #     # nvim-web-devicons
  #     # plenary-nvim
  #     # telescope-nvim
  #     # vim-commentary
  #     # vim-fugitive
  #     # vim-gitgutter
  #     # vim-repeat
  #     # vim-rhubarb
  #     # vim-shellcheck
  #     # # vim-suda
  #     # vim-surround
  #     # vim-test
  #     # vim-unimpaired
  #   ];

  #   extraLuaConfig = 
  #     let
  #       luaConfigs = lib.sources.sourceFilesBySuffices ./. [ ".lua" ];
  #     in
  #     ''
  #       local lsp = require('lspconfig')
  #       local capabilities = requires('cmp_nvim_lsp').default_capabilities()

  #       package.path = '$(luaConfigs)/?.lua'
  #       require('init')
  #     '';
  # };

  # nixvim ahoy hoy

  imports = [
    # ./completion.nix
    # ./format-on-save.nix
    # ./keymaps.nix
    # ./lsp.nix
    # ./treesitter.nix
    # ./vim-test.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    opts =
      let
        spaces = 2;
      in
      {
        expandtab = true;
        number = true;
        shiftwidth = spaces;
        softtabstop = spaces;
        tabstop = spaces;
        wrap = false;
      };

    extraConfigLua = builtins.readFile ./nvim-extras.lua;

    plugins = {
      # aerial.enable = true;

      # commentary.enable = true;
      # fidget.enable = true;
      # fugitive.enable = true;
      # gitgutter.enable = true;
      # nvim-surround.enable = true; 
      # telescope.enable = true;
      # undotree.enable = true;
      # web-devicons.enable = true;
      # which-key.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      milli
      related-files

      # vim-gnupg
      # vim-repeat
      # vim-rhubarb # fugitive extensions: GBrowse opens files in github
      # vim-unimpaired

      # nvim-ufo
      # tardis-nvim
      # tokyonight-nvim
      # undotree
      # vim-tmux-navigator
      # vim-better-whitespace
      # vim-visual-multi
      # which-key-nvim
      zoxide-vim
    ];
  };
}
