{ pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # The home-manager manual is at:
  #
  #   https://rycee.gitlab.io/home-manager/release-notes.html
  #
  # Configuration options are documented at:
  #
  #   https://rycee.gitlab.io/home-manager/options.html

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  #
  # You need to change these to match your username and home directory
  # path:
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # If you use non-standard XDG locations, set these options to the
  # appropriate paths:
  #
  # xdg.cacheHome
  # xdg.configHome
  # xdg.dataHome

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  home.sessionVariables = {
    # Set GOPATH
    GOPATH = "${builtins.getEnv "HOME"}/go";

    # Update PATH to include GOPATH/bin
    PATH = "${builtins.getEnv "HOME"}/go/bin:$PATH";
  };


  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = {
      ls = "eza";
      ll = "ls -l";
    };
    zplug = {
      enable = true;
      plugins = [
        { 
          name = "romkatv/powerlevel10k"; 
          tags = [ as:theme depth:1 ]; 
        } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
    initExtra = ''
      source ~/.p10k.zsh

      # Source the secrets file
      [ -f ~/.nixsecrets ] && source ~/.nixsecrets

      gcamp() {
        git commit -am "$1" && git push
      }

      [[ ! $(command -v nix) && -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]] && source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "kubectl"
        "golang"
        "python"
        "z"
        "gh"
        "bazel"
        "aws"
        "git-prompt"
        "gitfast"
        "kind"
        "fzf"
      ];
    };
  };

  programs.git = {
    enable = true;
    userName  = "james-m-thorne";
    userEmail = "jmthorne101@gmail.com";
  };

  home.packages = with pkgs;[
    (nerdfonts.override { fonts = [ "Meslo" "FiraCode" "CascadiaCode" ]; })
    htop
    fortune
    bazel
    bazel-buildtools
    bazel-gazelle
    go
    eza
    python3
    kind
    kubernetes-helm
    yarn
    gh
    zsh
    oh-my-zsh
    kubectl
  ];

}
