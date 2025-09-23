#!/bin/bash

# list of file .deb
deb_files=(
  "akit-susi4-leds_1.0-1_amd64.deb"
  "libx86-1_1.1+ds1-12_amd64.deb"
  "libc-bin_2.36-9+deb12u7_amd64.deb"
)

# Info

echo "In 10 seconds, start installing the package"
for file in "${deb_files[@]}"
do
  echo "  → $file"
done

sleep 10

# Instalacja .deb
for file in "${deb_files[@]}"
do
  if [[ -f "$file" ]]; then
    echo "Instalation of: $file"
    sudo dpkg -i "$file"
  else
    echo "File dosent exist: $file"
  fi
done

# Check
echo ""
echo "Checkin instaled file:"
for file in "${deb_files[@]}"
do
  if [[ -f "$file" ]]; then
    pkg_name=$(dpkg-deb --field "$file" Package)

    echo -n "Pakiet $pkg_name: "
    if dpkg -s "$pkg_name" &>/dev/null; then
      echo "Installed correct"
    else
      echo "Not installed"
    fi
  else
    echo "File $file dosent exist."
  fi
done

#Etap 2 test network interface 
echo ""
read -p "Press Enter to continue testing network interfaces"

echo "Copying interfacesUstawienieDoTestu → /etc/network/interfaces..."
cp interfacesUstawienieDoTestu /etc/network/interfaces
systemctl restart networking.service
ip link set enpA1 up
ip link set enpA2 up
ip link set enpA3 up
ip link set enpA4 up
ip link set enpA5 up
ip link set enpB1 up
ip link set enpB2 up
ip link set enpB3 up
ip link set enpB4 up
ip link set enpB5 up
ip link set enpMGMT up
ip link set enpSERWIS up


#Etap 3 Set brige
echo "Copying interfaces → /etc/network/interfaces..."
read -p "Press Enter to end testing network interfaces"
cp interfaces /etc/network/interfaces
systemctl restart networking.service

#Show current interfaces file 
cat /etc/network/interfaces
