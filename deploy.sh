#!/bin/sh
git commit -am "$1" &&
git push &&
cd interface &&
npm run build &&
cd ../ &&
sed -i -e 's/\/static/\/ibd\/static/g' ./interface/dist/index.html
cd ./interface/dist/js &&
for i in *; do
    sed -i -e 's/\/static/\/ibd\/static/g' $i
done &&
rm -r ~/LuizOtav.io/ibd &&
mv ./interface/dist ~/LuizOtav.io/ibd &&
cd ~/LuizOtav.io &&
git commit -am "$1" &&
git push