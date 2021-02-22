### pacman

List installed official repo packages:

```
pacman -Qqettn > pacman-official
```

List installed AUR packages:

```
pacman -Qqettm > pacman-aur
```

List ALL packages/dependencies:

```
pacman -Qqe > pacman-ALL
```

Restore `pacman-official` packages from backup file:

```
pacman -S --needed --noconfirm - < pacman-official
```

Restore ALL from backup if `yay` is installed:

```
for app in `cat pacman-ALL`; do yay -S --needed "$app"; done
```

##### Downgrade all packages back to a specific date

Move `/etc/pacman.conf` and `/etc/pacman.d/mirrorlist` to backups

```
sudo mv /etc/pacman.conf /etc/pacman.conf.bak
sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
```

Create a new `/etc/pacman.conf` file with the following information

```
[options]
Architecture = auto

[core]
SigLevel = PackageRequired
Server=https://archive.archlinux.org/repos/2019/10/07/$repo/os/$arch

[extra]
SigLevel = PackageRequired
Server=https://archive.archlinux.org/repos/2019/10/07/$repo/os/$arch

[community]
SigLevel = PackageRequired
Server=https://archive.archlinux.org/repos/2019/10/07/$repo/os/$arch
```

> Modify the date to match your preferred rollback date

Create a new `/etc/pacman.d/mirrorlist` file with the following information

```
> Modify the date to match your preferred rollback date
```

> Modify the date to match your preferred rollback date

Now you can issue the command to refresh the pacman package list, and then update

```
sudo pacman -Syyuu
```

### IPtables
  Install `iptables-persistent`

  NAT port 80 to 8080

  `sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination :8080`

  `sudo iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 80 -j REDIRECT --to-port 8080`

  Save to config

  `sudo iptables-save > /etc/iptables/rules.v4`

  List all NAT rules

  `sudo iptables -t nat -L --line-numbers`

  Delete NAT rule

  `sudo iptables -t nat -D CHAIN_NAME LINE_NUMBER`

### VIM Tips

Search and replace a string within line range

> Example searches from line 1 to line 20

```
:1,20 s/search_string/replace_string/gc
```

Search and replace a string within entire document

```
:%s/search_string/replace_string/gc
```

> Remove the `c` from the end of line to remove confirmation before changing each string found

### Random stuff

Connect to serial console on Linux/MacOS via `screen`

```sh
screen /dev/{usb/cu device} {baudrate}
```

Add characters to the beginning, and end, of each line of a text file

```
sed -i 's|^|"|' array.txt
sed -i 's|$|",|' array.txt
```

Clear IcedTea cache
`rm -rf /home/USER/.cache/icedtea-web/cache/*`

Update default applications on Linux
```
~/.config/mimeapps.list
```

Flash Player on Linux
> Download flash player tar.gz from Adobe website
```
sudo cp libflashplayer.so /usr/lib/mozilla/plugins/libflashplayer.so
```

### Useful Linux applications

##### lsdesktopf

Searches computer for all desktop files that can be used for mimeapps

```
lsdesktopf --list | grep -i firefox
```

### Passwordless `su` to a specific user based on user or group

> /etc/pam.d/su

```sh
auth		[success=ignore default=1]	pam_succeed_if.so	user = oracle
#auth		sufficient	pam_succeed_if.so	use_uid user = it
auth		sufficient	pam_succeed_if.so	use_uid user ingroup suoracle
```

### Passwordless `sudo su` to a specific user

> /etc/sudoers.d/custom_config

```sh
it ALL = (root) NOPASSWD: /bin/su - 
```