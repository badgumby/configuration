#!/bin/bash

# NIC name passed to script
NIC=$1

# Signal Strength colors
# Greater than -69
GREAT="42f462"
# -70 to -79
OKAY="f4a941"
# Less than -80
NOTGOOD="f45241"
# Other
OTHER="41a0f4"

# Check if NIC exists
if [[ $(nmcli d show | grep "$NIC") = *GENERAL.DEVICE* ]]; then
  # Return IP address to $IPADDRESS variable
  IPADDRESS=$(nmcli d show "$NIC" | grep 'IP4.ADDRESS' | awk '{ print $2 }' | cut -f1 -d"/")
  # Also, if NIC is wifi adapter
  if [[ $(nmcli d show "$NIC" | grep 'GENERAL.TYPE' | awk '{ print $2 }') = *wifi* ]]; then
    # Return signal strength (in dBm's) to $WIFI variable
    GetWIFI=$(iwconfig "$NIC" | grep "Signal" | awk '{ print $4 }' | sed 's/level=//')
    #GetWIFI="-68"
    # Change color based on strength
    if [[ $GetWIFI -ge "-69" ]]; then
      WIFI="%{F#$GREAT}$GetWIFI dBm%{F-}"
    elif [[ $GetWIFI -ge "-70" && $GetWIFI -le "-79" ]]; then
      WIFI="%{F#$OKAY}$GetWIFI dBm%{F-}"
    elif [[ $GetWIFI -le "-80" ]]; then
      WIFI="%{F#$NOTGOOD}$GetWIFI dBm%{F-}"
    else
      # Something is weird, default to blue
      WIFI="%{F#$OTHER}$GetWIFI dBm%{F-}"
    fi
  fi
fi

# Return results (as long as one variable exists)
if [[ -n $IPADDRESS ]] || [[ -n $WIFI ]]; then
  echo "$IPADDRESS $WIFI";
fi
