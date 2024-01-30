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
  home.username = "james-thorne";
  home.homeDirectory = "/home/james-thorne";

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
  home.stateVersion = "20.09";

  # Since we do not install home-manager, you need to let home-manager
  # manage your shell, otherwise it will not be able to add its hooks
  # to your profile.
  # programs.bash = {
  #   enable = true;
  # };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting = {
      enable = true;
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
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "kubectl"
        "golang"
        "python"
        "pyenv"
        "z"
        "gh"
        "docker"
        "docker-compose"
        "brew"
        "bazel"
        "aws"
        "git-prompt"
        "gitfast"
        "kind"
      ];
    };
  };

  programs.git = {
    enable = true;
    userName  = "james-m-thorne";
    userEmail = "jmthorne101@gmail.com";
  };

  home.packages = with pkgs;[
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    htop
    fortune
    bazel
    go
    python3
    kind
    kubernetes-helm
    yarn
    gh
    zsh
    oh-my-zsh
  ];

}
