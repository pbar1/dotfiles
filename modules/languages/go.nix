{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.languages.go;
in
{
  options = {
    languages.go = {
      enable = mkEnableOption "Go";

      packages = mkOption {
        type = types.package;
        default = pkgs.go;
        defaultText = literalExpression "pkgs.go";
        description = "The Go package to use.";
      };

      tree-sitter = {
        enable = mkEnableOption "Tree-sitter grammar";

        package = mkOption {
          type = types.package;
          default = pkgs.tree-sitter-grammars.tree-sitter-go;
          defaultText = literalExpression "pkgs.tree-sitter-grammars.tree-sitter-go";
          description = "The Tree-sitter grammar package to use.";
        };
      };

      lsp = {
        enable = mkEnableOption "Language Server Protocol (LSP) server";

        package = mkOption {
          type = types.package;
          default = pkgs.gopls;
          defaultText = literalExpression "pkgs.gopls";
          description = "The LSP server package to use.";
        };
      };

      dap = {
        enable = mkEnableOption "Debug Adapter Protocol (DAP) server";

        package = mkOption {
          type = types.package;
          default = pkgs.delve;
          defaultText = literalExpression "pkgs.delve";
          description = "The DAP server package to use.";
        };
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = [
        cfg.package
        mkIf cfg.tree-sitter.enable cfg.tree-sitter.package
        mkIf cfg.lsp.enable cfg.lsp.package
        mkIf cfg.dap.enable cfg.dap.package
      ];
    }
  ]);
}

