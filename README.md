# dotfiles

## Prerequisites

### You need to copy your ssh-keys to the new maschine and correct the file mode.

``` shell
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/known_hosts
chmod 755 ~/.ssh
```

### Cloning the dotfiles

``` shell
cd
mkdir -p .config
cd .config
git clone git@github.com:Azd325/dotfiles.git nixpkgs
```

### Installing nix

``` shell
curl -L https://nixos.org/nix/install | sh # restart afterwards
```

## First install

``` shell
cd ~/.config/nixpkgs
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ".#aarch64"
darwin-rebuild switch --flake ".#aarch64"
```

## Update

``` shell
nix flake update
darwin-rebuild switch --flake ".#aarch64"
```

## Emacs

### Install doom-emacs with my configuration

``` shell
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```
