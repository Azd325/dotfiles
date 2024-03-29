{ pkgs, alacritty-dracula-theme, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ "${alacritty-dracula-theme}/dracula.toml" ];
      font = {
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
        bold = {
          family = "JetBrains Mono";
          style = "Bold";
        };
        italic = {
          family = "JetBrains Mono";
          style = "Italic";
        };
        size = 16.0;
      };
      live_config_reload = true;
      selection = { save_to_clipboard = true; };
      keyboard = {
        bindings = [{
          key = 36;
          mods = "Command";
          action = "ToggleFullscreen";
        }];
      };
      window = {
        dynamic_title = true;
        startup_mode = "Maximized";
        dynamic_padding = false;
        padding = {
          x = 10;
          y = 10;
        };
      };
    };
  };
  programs.zsh = {
    autosuggestion.enable = true;
    enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      # FNM
      eval "$(fnm env --use-on-cd)"

      # Pyenv
      export PYENV_ROOT=$HOME/.pyenv
      if [[ -e $PYENV_ROOT ]]; then
        export PATH=$PYENV_ROOT/bin:$PATH
        eval "$(pyenv init --path)"
      fi
    '';
  };
  programs.starship = { enable = true; };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = cpu;
        extraConfig =
          "set -g status-right '#{cpu_bg_color} CPU: #{cpu_icon} #{cpu_percentage} | %a %h-%d %H:%M '";
      }
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
    terminal = "screen-256color";
  };

  programs.atuin = { enable = true; };
}
