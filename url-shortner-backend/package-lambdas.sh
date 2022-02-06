#!/bin/sh
set -x
echo "-----------------------------------------------------------------------------------------------------------------"
printf "Install prod node_modules\n"
rm -rf build
mkdir -p build/nodejs
cp package.json build/nodejs
cd build/nodejs
npm install --production --ignore-scripts
echo "-----------------------------------------------------------------------------------------------------------------"
cd ..
zip -r -q lambdalayer.zip nodejs
cd ..
printf "Babel Build lambdas\n"
npx babel src/*.lambda.js -d build/babel-src --minified
printf "Package lambdas\n"
for lambdaName in createShortURL getLongURL
do
  mkdir -p build/babel-src/$lambdaName
  cp dev.env build/babel-src/$lambdaName/.env
  fileSuffix=".lambda.js"
  fileSuffixForArchive=".js"
  cp build/babel-src/$lambdaName$fileSuffix build/babel-src/$lambdaName/index.js
  archiveSuffix=".zip"
  archiveFileName=$lambdaName$fileSuffixForArchive$archiveSuffix
  echo "Zipping $archiveFileName"
  cd build/babel-src/$lambdaName
  zip -r -q $archiveFileName index.js .env
  mv $archiveFileName ../
  cd ../../..
done
echo "SUCCESS"
echo "-----------------------------------------------------------------------------------------------------------------"
