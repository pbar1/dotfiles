{ ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window.padding.x = 6;
      window.padding.y = 5;
      window.padding.dynamic_padding = true;

      font.normal.family = "Iosevka Nerd Font Mono";
      font.normal.style = "Light";
      font.bold.family = "Iosevka Nerd Font Mono";
      font.bold.style = "Regular";
      font.italic.family = "Iosevka Nerd Font Mono";
      font.italic.style = "Light Italic";
      font.bold_italic.family = "Iosevka Nerd Font Mono";
      font.bold_italic.style = "Italic";
      font.size = 16.0;
      font.glyph_offset.y = 1; # For Iosevka to look right
      font.use_thin_strokes = true; # For retina displays

      background_opacity = 0.97;

      selection.save_to_clipboard = true;

      shell.program = "/run/current-system/sw/bin/fish"; # TODO: Reference fish package bin
      shell.args = [ "--login" "-c" "tmux new-session -A -s main" ]; # Reopens existing tmux session

      key_bindings = [
        # macOS-only tmux keybindings
        { key = "N"; mods = "Command"; command = { program = "open"; args = [ "-nb" "io.alacritty" ]; }; }
        { key = "D"; mods = "Command"; chars = "\\x01\\x76"; }
        { key = "D"; mods = "Command|Shift"; chars = "\\x01\\x73"; }
        { key = "W"; mods = "Command"; chars = "\\x01\\x78"; }
        { key = "H"; mods = "Command"; chars = "\\x01\\x68"; }
        { key = "J"; mods = "Command"; chars = "\\x01\\x6a"; }
        { key = "K"; mods = "Command"; chars = "\\x01\\x6b"; }
        { key = "L"; mods = "Command"; chars = "\\x01\\x6c"; }
        { key = "T"; mods = "Command"; chars = "\\x01\\x63"; }
        { key = "Key1"; mods = "Command"; chars = "\\x01\\x31"; }
        { key = "Key2"; mods = "Command"; chars = "\\x01\\x32"; }
        { key = "Key3"; mods = "Command"; chars = "\\x01\\x33"; }
        { key = "Key4"; mods = "Command"; chars = "\\x01\\x34"; }
        { key = "Key5"; mods = "Command"; chars = "\\x01\\x35"; }
        { key = "Key6"; mods = "Command"; chars = "\\x01\\x36"; }
        { key = "Key7"; mods = "Command"; chars = "\\x01\\x37"; }
        { key = "Key8"; mods = "Command"; chars = "\\x01\\x38"; }
        { key = "Key9"; mods = "Command"; chars = "\\x01\\x39"; }
        { key = "Left"; mods = "Command"; chars = "\\x01\\x48"; }
        { key = "Down"; mods = "Command"; chars = "\\x01\\x4a"; }
        { key = "Up"; mods = "Command"; chars = "\\x01\\x4b"; }
        { key = "Right"; mods = "Command"; chars = "\\x01\\x4c"; }
      ];

      # Catppuccin theme
      colors = {
        primary.background = "0x1E1D2F";
        primary.foreground = "0xD9E0EE";

        cursor.text = "0x1E1D2F";
        cursor.cursor = "0xF5E0DC";

        normal.black = "0x6E6C7E";
        normal.red = "0xF28FAD";
        normal.green = "0xABE9B3";
        normal.yellow = "0xFAE3B0";
        normal.blue = "0x96CDFB";
        normal.magenta = "0xF5C2E7";
        normal.cyan = "0x89DCEB";
        normal.white = "0xD9E0EE";

        bright.black = "0x988BA2";
        bright.red = "0xF28FAD";
        bright.green = "0xABE9B3";
        bright.yellow = "0xFAE3B0";
        bright.blue = "0x96CDFB";
        bright.magenta = "0xF5C2E7";
        bright.cyan = "0x89DCEB";
        bright.white = "0xD9E0EE";

        indexed_colors = [
          { index = 16; color = "0xF8BD96"; }
          { index = 17; color = "0xF5E0DC"; }
        ];
      };
    };
  };
}
