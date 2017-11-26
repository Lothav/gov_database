#!/bin/sh
git commit -am "$1" &&
git push &&
cd ~/gov_database/interface &&
npm run build &&
rm -r ~/LuizOtav.io/ibd &&
mv ~/gov_database/interface/dist ~/LuizOtav.io/ibd &&
cd ~/LuizOtav.io &&
git commit -am "$1" &&
git push