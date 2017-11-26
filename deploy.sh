#!/bin/sh
git commit -am "$1" &&
git push &&
cd ~/gov_database/interface &&
npm run build &&
sed -i -e 's/\/static/\/ibd\/static/g' ~/gov_database/interface/dist/index.html
cd ~/gov_database/interface/dist/js &&
for i in *; do
    sed -i -e 's/\/static/\/ibd\/static/g' $i
done &&
rm -r ~/LuizOtav.io/ibd &&
mv ~/gov_database/interface/dist ~/LuizOtav.io/ibd &&
cd ~/LuizOtav.io &&
git commit -am "$1" &&
git push