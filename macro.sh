#!/bin/bash
# Ansi color code variables
red="\e[0;91m"
blue="\e[0;94m"
expand_bg="\e[K"
blue_bg="\e[0;104m${expand_bg}"
red_bg="\e[0;101m${expand_bg}"
green_bg="\e[0;102m${expand_bg}"
green="\e[0;92m"
white="\e[0;97m"
bold="\e[1m"
uline="\e[4m"
reset="\e[0m"

echo "Hashes:"
echo "=========="
echo "MD5:    "
md5sum $1
echo "SHA1:   "
sha1sum $1
echo "SHA256: "
sha256sum $1
echo 

read -p "encrypted? Y/n: " enc
echo "$enc"

if [ $enc == "y" ]; then
  echo "password?"
		read pwd
		msoffcrypto-tool $1 decrypted.vir -p $pwd
		echo "run ./macro.sh decrypted.vir"
		exit 0
fi

echo "Oleid:"
echo "=========="
echo
oleid $1

echo "++++++++++"
echo "Oleobj:"
echo "=========="
echo
oleobj $1

echo "++++++++++"
echo "OleVBA:"
echo "=========="
echo
olevba $1

echo "++++++++++"
echo "Checking for possible MSDT CVE-2022-30190 - follina:"
echo "=========="
echo
output=$(zipgrep -i '''Target="http''' $1 | sed 's/ /\n/g' | grep -i '''Target="h''')
echo -e "${red}${output}${reset}"
wget $(zipgrep -i '''Target="http''' $1 | sed 's/ /\n/g' | grep -i '''Target="h''' | awk -F '"' '{print $2}' | sed -E 's/!$//g' ) CVE-2022-30190.html.txt
echo "-"
output=$(grep -i "ms-msdt" CVE-2022-30190.html.txt)
echo -e "${red}${output}${reset}"
echo "-"

echo "++++++++++"
echo "Checking for cmd execution:"
echo "=========="
echo
output=$(zipgrep -i '''cmd''' $1| sed 's/</\n/g' | egrep -i 'cmd')
echo -e "${red}${output}${reset}"
echo "-"

echo "++++++++++"
echo "Checking for Powershell execution:"
echo "=========="
echo
output=$(zipgrep -i '''nop''' $1| sed 's/</\n/g' | egrep -i 'nop')
output=$(zipgrep -i '''ps''' $1| sed 's/</\n/g' | egrep -i 'ps')
echo -e "${red}${output}${reset}"
echo "-"

echo "++++++++++"
echo "Checking for dlls:"
echo "=========="
echo
output=$(zipgrep -i '''.dll''' $1| sed 's/</\n/g' | egrep -i '\.dll')
echo -e "${red}${output}${reset}"
echo "-"

echo "++++++++++"
echo "mraptor:"
echo "=========="
echo
mraptor $1

echo "++++++++++"
echo "vmonkey:"
echo "=========="
vmonkey $1 > vmonkey.txt
