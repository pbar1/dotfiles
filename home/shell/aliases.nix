{ pkgs, ... }:

{
  cat = "bat";
  copy = if pkgs.stdenv.isDarwin then "pbcopy" else "wl-copy --trim-newline";
  l = "exa --header --all --long --git";
  tree = "exa --tree";
  yktog = "ykman config usb --list | grep --quiet OTP && ykman config usb --force --disable=otp || ykman config usb --force --enable=otp";
}
