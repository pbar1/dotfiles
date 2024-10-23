{ pkgs, ... }:

let
  pinentryPackage = if pkgs.stdenv.isDarwin then pkgs.pinentry_mac else null;
in
{
  programs.gpg.enable = true;

  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryPackage = pinentryPackage;
}
