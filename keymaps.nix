{
  programs.nixvim = {
    globals = {
      mapleader = ",";
      maplocalleader = ",";
    };

    plugins.lsp.keymaps = {
      lspBuf = {
        "gD" = "declaration";
        "gd" = "definition";
        "gi" = "implementation";
        "gr" = "references";
        "K" = "hover";
        "<leader>k" = "signature_help";
        "<space>ca" = "code_action";
        # TODO: WHAAAAAAAA really
        "<space>rn" = "rename";
      };
    };

    keymaps = [
      {
        action.__raw = "vim.diagnostic.goto_prev";
        key = "[d";
        options.desc = "Previous diagnostic";
      }
      {
        action.__raw = "vim.diagnostic.goto_next";
        key = "]d";
        options.desc = "Next diagnostic";
      }
      {
        action.__raw = "!i[sort<cr>";
        key = "<F5>";
      }
      {
        action.__raw = ":w<cr>:TestSuite<cr>";
        key = "<leader>ts";
        options.desc = "Test entire suite";
      }
      {
        action.__raw = ":w<cr>:TestLast<cr>";
        key = "<leader>tr";
        options.desc = "Repeat last test run";
      }
      {
        action.__raw = ":w<cr>TestNearest<cr>";
        key = "<leader>tt";
        options.desc = "Test nearest";
      }
      {
        action.__raw = ":w<cr>TestFile<cr>";
        key = "<leader>tf";
        options.desc = "Test entire file";
      }
      # movement ...
      {
        action.__raw = "<c-w>h";
        key = "<c-h>";
      }
      {
        action.__raw = "<c-w>j";
        key = "<c-j>";
      }
      {
        action.__raw = "<c-w>k";
        key = "<c-k>";
      }
      {
        action.__raw = "<c-w>l";
        key = "<c-l>";
      }
      {
        action.__raw = ":q<cr>";
        key = "<leader>q";
        options.desc = "Quit buffer";
      }
      {
        action.__raw = ":nohlsearch<cr>";
        key = "<space>";
      }
      {
        action.__raw = "<cmd>Telescope find_files<cr>";
        key = "<leader>ff";
        options.desc = "Find files";
      }
      {
        action.__raw = "<cmd>Telescope grep_string<cr>";
        key = "<leader>a";
        options.desc = "Grep string under cursor";
      }
      {
        action.__raw = "<cmd>Telescope live_grep<cr>";
        key = "<leader>fg";
        options.desc = "Find text or pattern";
      }
      {
        action.__raw = "<cmd>Telescope buffers<cr>";
        key = "<leader>fb";
        options.desc = "Find buffers";
      }
      {
        action.__raw = "<cmd>Telescope help_tags<cr>";
        key = "<leader>fh";
        options.desc = "Find in help";
      }
      {
        action.__raw = "<cmd>Telescope oldfiles<cr>";
        key = "<leader>fo";
        options.desc = "Find recent (old) files";
      }
      {
        action.__raw = "<cmd>Telescope related_files<cr>";
        key = "<leader>fr";
        options.desc = "Find related files";
      }
      {
        action.__raw = "<cmd>Telescope commands<cr>";
        key = "<leader>fc";
        options.desc = "Find commands";
      }
    ];
  };
}
