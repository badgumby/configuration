#### pacman
   List installed official repo packages: `pacman -Qqettn`

   List installed AUR packages: `pacman -Qqettm`

   Create backup list of AUR packages (bash): `pacman -Qqe | grep -v "$(pacman -Qqm)" > pacman.lst`

   Create backup list of AUR packages (fish): `pacman -Qqe | grep -v "(pacman -Qqm)" > pacman.lst`

   Restore from backup `pacman.lst` created in previous command (bash): `pacman -S --needed --noconfirm $(pacman -Qqe | grep -v "$(pacman -Qqm)")`
