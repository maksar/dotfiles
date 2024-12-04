{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      # custom_cursor_colors = true;
      colors = {
        cursor = { cursor = "0xAA0000"; };
        primary = {
          background = "0x282c34";
          foreground = "0xc5c8c6";
        };
        # normal = {
        #   black = "0x161821";
        #   red = "0xe27878";
        #   green = "0xb4be82";
        #   yellow = "0xe2a478";
        #   blue = "0x84a0c6";
        #   magenta = "0xa093c7";
        #   cyan = "0x89b8c2";
        #   white = "0xc6c8d1";
        # };
        # bright = {
        #   black = "0x6b7089";
        #   red = "0xe98989";
        #   green = "0xc0ca8e";
        #   yellow = "0xe9b189";
        #   blue = "0x91acd1";
      #   magenta = "0xada0d3";
        #   cyan = "0x95c4ce";
        #   white = "0xd2d4de";
        # };
      };
      cursor = {
        unfocused_hollow = false;
        style = {
          shape = "Beam";
          blinking = "Always";
        };
        thickness = 0.3;
      };
      window = {
        decorations = "none";
        opacity = 0.9;
        padding = {
          x = 5;
          y = 5;
        };
      };
      keyboard = {
        bindings = [
          {
            key = "N";
            mods = "Command";
            action = "CreateNewWindow";
          }
        ];
      };

      font = {
        size = 19;
        normal = {
          family = "Pragmasevka Nerd Font";
          # family = "PragmataProLiga Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "PragmataPro Liga";
          style = "Bold";
        };
        italic = {
          family = "PragmataPro Liga";
          style = "Italic";
        };
        bold_italic = {
          family = "PragmataPro Liga";
          style = "Bold Italic";
        };
      };
    };
  };
}
