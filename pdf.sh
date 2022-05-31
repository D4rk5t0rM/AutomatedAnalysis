#!/bin/bash
#error when there is a space
echo "running file on the file"
file $1 2>> pdf.error
echo ""
echo "--------------------------------"
echo ""

echo "dumping everythign & looking for JS"
pdf-parser.py -d $1.txt $1 | egrep -i application > $1.js.txt
rm $1.txt
echo ""
echo "--------------------------------"
echo ""

pdfmetadata $1 2>> pdf.error
echo ""
echo "--------------------------------"
echo ""

pdfid.py -e $1 2>> pdf.error
echo "Data after EOF? try:"
echo "pdf-parser.py -x file.exe $1"
echo ""
echo "--------------------------------"
echo ""


echo "pdf-parser: Search for AcroForm"
pdf-parser.py -s AcroForm $1 2>> pdf.error
echo ""
echo "--------------------------------"
echo ""

echo "Piepdf - Not working Right now"
#piepdf $1 2>> pdf.error
echo ""
echo "--------------------------------"
echo ""

echo "pdfexplode on the file"
pdfexplode $1 2>> pdf.error
echo ""
echo "--------------------------------"
echo ""

echo "pdfextract on the file"
pdfextract $1 2>> pdf.error
echo ""
echo "--------------------------------"
echo ""

echo "looking for the strings"
strings $1 > strings_$1.txt 2>> pdf.error
echo ""
echo "--------------------------------"
echo ""

echo "pdf-parser: printing the URI list"
echo "URIs: "
pdf-parser.py -k /URI $1
echo ""
echo "--------------------------------"

echo "runnin pdfcop"
pdfcop $1
echo ""
echo "--------------------------------"


#put everything above this
echo "Searching for HTTP strings"
egrep -i http -r ./  2>> pdf.error
echo ""
echo "--------------------------------"
echo ""
