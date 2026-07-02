# Requirements
- chezmoi
- chezmoi_modify_manager

Currently, the dotfiles are compatibles with only arch

## New machine setup

```sh
chezmoi init --apply <repo>
```

Before the first apply, remove the live Plasma panel layout so modify_manager doesn't create duplicate containments (containment/applet IDs are auto-generated and differ per machine):

```sh
rm ~/.config/plasma-org.kde.plasma.desktop-appletsrc
chezmoi apply
```

After the first apply, subsequent applies merge correctly.
