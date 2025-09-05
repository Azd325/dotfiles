# dotfiles

## Prerequisites

### Copy your SSH keys to the new machine and correct file modes

``` shell
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/known_hosts
chmod 755 ~/.ssh
```

### Clone the dotfiles

``` shell
cd
mkdir -p .config
cd .config
git clone git@github.com:Azd325/dotfiles.git nixpkgs
```

### Install Determinate Nix

``` shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

## First install

``` shell
cd ~/.config/nixpkgs
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ".#aarch64"
sudo darwin-rebuild switch --show-trace --flake ".#aarch64"
```

## Update

``` shell
nix flake update
sudo darwin-rebuild switch --show-trace --flake ".#aarch64"

## Validate without applying

Preview changes without switching the system:

``` shell
darwin-rebuild build --flake ".#aarch64"
```
```

## Emacs

### Install doom-emacs with my configuration

``` shell
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```
