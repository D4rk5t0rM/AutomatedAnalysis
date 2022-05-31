#!/bin/bash
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
zipgrep -i '''Target="http''' $1 | sed 's/ /\n/g' | grep -i '''Target="h'''
wget $(zipgrep -i '''Target="http''' 4a24048f81afbe9fb62e7a6a49adbd1faf41f266b5f9feecdceb567aec096784 | sed 's/ /\n/g' | grep -i '''Target="h''' | awk -F '"' '{print $2}' | sed -E 's/!$//g' ) CVE-2022-30190.html.txt
grep -i "ms-msdt" CVE-2022-30190.html.txt

echo "++++++++++"
echo "mraptor:"
echo "=========="
echo
mraptor $1

echo "++++++++++"
echo "vmonkey:"
echo "=========="
vmonkey $1 > vmonkey.txt
