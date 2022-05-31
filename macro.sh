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
echo "Checking  MSDT CVE-2022-30190 - follina:"
echo "=========="
echo
zipgrep -i '''Target="http''' doc.docx | sed 's/ /\n/g' | grep -i '''Target="h'''

echo "++++++++++"
echo "mraptor:"
echo "=========="
echo
mraptor $1

echo "++++++++++"
echo "vmonkey:"
echo "=========="
vmonkey $1 > vmonkey.txt
