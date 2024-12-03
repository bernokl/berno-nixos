{ pkgs, lib, dsl, config, modules, ... }:
{

  imports = with modules; [
    nvchad
    essentials
    git
    lsp
    nvim-tree
    treesitter
    telescope
    which-key
    #    ai
  ];
}
