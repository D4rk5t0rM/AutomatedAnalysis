echo "usage: ./qr.sh mail.eml"
mkdir qr
cp $1 ./qr
cd ./qr
munpack -t $1
for i in `find . -type f`
do
zbarimg $i 2> /dev/null
done
cd ..
rm -rf qr