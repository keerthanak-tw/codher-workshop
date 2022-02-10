ECHO -----------------------------------------------------------------------------------------------------------------
ECHO Install prod node_modules
IF EXIST build @RD /S /Q build
MD "build/nodejs"
xcopy package.json build\nodejs
cd build\nodejs
cmd /c npm install --production --ignore-scripts
ECHO -----------------------------------------------------------------------------------------------------------------
cd ../..
ECHO Babel Build lambdas
call npx babel src/*.lambda.js -d build/babel-src --minified
ECHO Package lambdas

MD "build/babel-src/createShortURL"
xcopy dev.env build\babel-src\createShortURL
>> build\babel-src\createShortURL\index.js rem/
xcopy /Q /Y /F build\babel-src\createShortURL.lambda.js build\babel-src\createShortURL\index.js

MD "build/babel-src/getLongURL"
xcopy dev.env build\babel-src\getLongURL
>> build\babel-src\getLongURL\index.js rem/
xcopy /Q /Y /F build\babel-src\getLongURL.lambda.js build\babel-src\getLongURL\index.js

ECHO SUCCESS
ECHO -----------------------------------------------------------------------------------------------------------------
