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

### Random stuff
   Add characters to the beginning, and end, of each line of a text file

   ```
   sed -i 's|^|"|' array.txt
   sed -i 's|$|",|' array.txt
   ```
