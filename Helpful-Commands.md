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

### IPtables
  Install `iptables-persistent`

  NAT port 80 to 8080

  `sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination :8080`

  Save to config

  `sudo iptables-save > /etc/iptables/rules.v4`

  List all NAT rules

  `sudo iptables -t nat -L --line-numbers`

  Delete NAT rule

  `sudo iptables -t nat -D CHAIN_NAME LINE_NUMBER`

### Random stuff
   Add characters to the beginning, and end, of each line of a text file

   ```
   sed -i 's|^|"|' array.txt
   sed -i 's|$|",|' array.txt
   ```

   Clear IcedTea cache

   `rm -rf /home/USER/.cache/icedtea-web/cache/*`
