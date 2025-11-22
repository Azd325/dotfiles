# dotfiles

## Prerequisites

### Copy your SSH keys to the new machine and correct file modes

```shell
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/known_hosts
chmod 755 ~/.ssh
```

### Clone the dotfiles

```shell
mkdir -p ~/.config
git clone git@github.com:Azd325/dotfiles.git ~/.config/nixpkgs
```

### Install Determinate Nix

```shell
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --prefer-upstream-nix
```

## First install

```shell
cd ~/.config/nixpkgs
sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- build --flake ".#aarch64"
sudo darwin-rebuild switch --flake ".#aarch64"
```

## Update

```shell
nix flake update
sudo darwin-rebuild switch --flake ".#aarch64"
```

## Validate without applying

Preview changes without switching the system:

```shell
darwin-rebuild build --flake ".#aarch64"
```

## Secrets

This repository uses [sops-nix](https://github.com/Mic92/sops-nix) for encrypted
files. Generate an age key (see `.sops.yaml`) and store it at
`~/.config/sops/age/keys.txt`, then add new secrets under `secrets/shared/` or
`secrets/hosts/<name>/` with the `sops` CLI.

## Emacs

### Install doom-emacs with my configuration

```shell
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```
