#!/bin/bash
#error when there is a space
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


echo -e "${green}running file on the file${reset}"
file $1 2>> pdf.error
echo ""
echo -e "${red}${bold}--------------------------------${reset}"
echo ""

echo -e "${green}running pdfmetadata on the file${reset}"
pdfmetadata $1 2>> pdf.error
echo ""
echo -e "${red}${bold}--------------------------------${reset}"
echo ""

echo -e "${green}running pdfid.py on the file${reset}"
pdfid.py $1 2>> pdf.error
echo ""
echo -e "${red}${bold}--------------------------------${reset}"
echo ""


echo -e "${green}pdf-parser: Search for AcroForm${reset}"
pdf-parser.py -s AcroForm $1 2>> pdf.error
echo ""
echo -e "${red}${bold}--------------------------------${reset}"
echo ""

echo -e "${green}pdf-parser: Search for JS${reset}"
pdf-parser.py -s JavaScript $1 2>> pdf.error
pdf-parser.py -s JS $1 2>> pdf.error
echo ""
echo -e "${red}${bold}--------------------------------${reset}"
echo ""


echo -e "${green}pdfinfo: Search for JS${reset}"
pdfinfo -js $1 2>> pdf.error
echo ""
echo -e "${red}${bold}--------------------------------${reset}"
echo ""


echo -e "${green}Piepdf - Not working Right now${reset}"
#piepdf $1 2>> pdf.error
echo ""
echo -e "${red}${bold}--------------------------------${reset}"
echo ""

echo -e "${green}pdfexplode on the file${reset}"
pdfexplode $1 2>> pdf.error
echo ""
echo -e "${red}${bold}--------------------------------${reset}"
echo ""

echo -e "${green}pdfextract on the file${reset}"
pdfextract $1 2>> pdf.error
echo ""
echo -e "${red}${bold}--------------------------------${reset}"
echo ""

echo -e "${green}looking for the strings${reset}"
strings $1 > strings_$1.txt 2>> pdf.error
echo ""
echo -e "${red}${bold}--------------------------------${reset}"
echo ""

echo -e "${green}pdf-parser: printing the URI list${reset}"
echo "URIs: "
pdf-parser.py -k /URI $1
echo ""
echo -e "${red}${bold}--------------------------------${reset}"

echo -e "${green}running pdfcop${reset}"
pdfcop $1
echo ""
echo -e "${red}${bold}--------------------------------${reset}"


#put everything above this
echo -e "${green}Searching for HTTP strings${reset}"
egrep http -r ./  2>> pdf.error
echo ""
echo -e "${red}${bold}--------------------------------${reset}"
echo ""
