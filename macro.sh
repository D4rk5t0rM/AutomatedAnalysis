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
wget $(zipgrep -i '''Target="http''' 4a24048f81afbe9fb62e7a6a49adbd1faf41f266b5f9feecdceb567aec096784 | sed 's/ /\n/g' | grep -i '''Target="h''' | awk -F '"' '{print $2}' | sed -E 's/!$//g' ) CVE-2022-30190.html.txt
echo "-"
output=$(grep -i "ms-msdt" CVE-2022-30190.html.txt)
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
