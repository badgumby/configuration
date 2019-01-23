### pacman
   List installed official repo packages: `pacman -Qqettn > pacman-official`

   List installed AUR packages: `pacman -Qqettm > pacman-aur`

   List ALL packages/dependencies: `pacman -Qqe > pacman-ALL`

   Restore from backup `pacman-official` created in previous command: `pacman -S --needed --noconfirm - < pacman-official`

   Restore from backup if `yay` is installed: `yay -Ss --needed --noconfirm < pacman-ALL`
