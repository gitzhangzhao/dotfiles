### My dotfiles, managed by GNU Stow

![gif](https://thumbs.gfycat.com/AlarmingCoordinatedEarwig-max-1mb.gif)

#### install
- [requirements(apt)](requirements.apt)
- [requirements(cargo)](requirements.cargo)
- [requirements(pip)](requirements.pip)
- [requirements(node)](requirements.node)

#### manual install
```bash
oh-my-zsh nvim i3lock-color betterlockscreen v2raya docker
```

#### fonts
- lxgw-wenkai for Chinese
- source-han-sans for Chinese
- sf mono for terminal
- sf pro for polybar

#### theme
- NordArc for GTK
- breeze-cursor-theme for cursor
- NordArc-Icons for icons

#### install scripts
- stow_all: stow all dotfiles, include home/ and /etc/.
- unstow_all: unstow all dotfiles, include home/ and /etc/.
- stow: stow one app at a time.
- unstow: unstow one app at a time.

#### v2raya
```bash
sudo docker run -d \
        --restart=always \
        --privileged \
        --network=host \
        --name v2raya \
        -v /lib/modules:/lib/modules \
        -v /etc/resolv.conf:/etc/resolv.conf \
        -v /etc/v2raya:/etc/v2raya \
        mzz2017/v2raya
```
