# Basic setup for my MacOS layout

## Packages to install

#### [Brew](https://brew.sh)

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

---

#### [iTerm](https://iterm2.com/)

Download from site

---

#### [Fish Shell](https://fishshell.com/)

```
brew install fish
```

##### Set fish to default shell

Edit the `/etc/shells` file and add fish shell

```
/usr/local/bin/fish
```

Change shell for user account

```
chsh
```

##### [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish) (Fish Shell manager)

```
curl -L https://get.oh-my.fish | fish
```

##### Agnoster Theme for OMF

```
omf install agnoster
```

##### [Powerline Fonts](https://github.com/powerline/fonts)

Preferred font: [DejaVuSansMono](https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf)

---

## Switch between integrated and discrete graphics

```
# Always use the integrated graphics card
sudo pmset -a gpuswitch 0

# Always use the discrete graphics card
sudo pmset -a gpuswitch 1

# Automatically switch between discrete and integrated graphics card (this is your laptop's default setting)
sudo pmset -a gpuswitch 2
```

#### Flags for setting graphics to specific modes:
- While charging: -c
- While on battery: -b
- Change for all modes: -a

## Networking

### Static Routes

```sh
sudo route add -host {host ip} {gateway ip}
```