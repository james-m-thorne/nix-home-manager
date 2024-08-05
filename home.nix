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

  home.file = {
    ".p10k.zsh".source = ./config/zsh/.p10k.zsh;
    ".home.zsh".source = ./config/zsh/.home.zsh;
    ".ideavimrc".source = ./config/.ideavimrc;

    ".local/bin/bazel".source = "${pkgs.bazelisk}/bin/bazelisk";  # Symlink bazel to bazelisk
  };

  home.sessionPath = [ 
    "$HOME/.local/bin" 
    "$HOME/go/bin" 
  ];

  programs.go = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = {
      ll = "ls -l";
      gt = "git train";
      gta = "git train append";
      gtl = "git train last";
      gtpr = "git train pr";
      gtd = "git train delete";
      gts = "git train sync";
      gtm = "git train set-merged";
      gtsh = "git train show";
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
    initExtraFirst = ''
      # Amazon Q pre block. Keep at the top of this file.
      [ -x "$(command -v q)" ] && eval "$(q init zsh pre --rcfile zshrc)"
    '';
    initExtra = ''
      source $HOME/.p10k.zsh
      source $HOME/.home.zsh

      # Source the secrets file
      [ -f $HOME/.nixsecrets ] && source $HOME/.nixsecrets

      [[ ! $(command -v nix) && -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]] && source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"

      # Amazon Q post block. Keep at the bottom of this file.
      [ -x "$(command -v q)" ] && eval "$(q init zsh post --rcfile zshrc)"
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
    difftastic = {
      enable = true;
      background = "dark";
    };
  };

  home.packages = with pkgs;[
    (nerdfonts.override { fonts = [ "Meslo" "FiraCode" "CascadiaCode" ]; })
    awscli
    bazel-buildtools
    bazel-gazelle
    bazelisk
    dbt
    eza
    fortune
    fzf
    gh
    htop
    jetbrains.idea-ultimate
    jq
    kind
    kubectl
    kubernetes-helm
    nodejs
    python3
    poetry
    yarn
    yq
  ];

}
