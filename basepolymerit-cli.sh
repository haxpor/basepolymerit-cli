#!/bin/bash

# usage basepolymerit-cli.sh myProjectName MyComponentClassName

if [ "$#" -ne 2 ]
then
	echo "usage: basepolymerit-cli.sh myProjectName MyComponentClassName"
	exit 1
fi

# check if running on macOS or Linux
# as for macOS, its sed is older version and we need to use gsed via `brew install gnu-sed` to do stuff interchangeably with sed
# on Linux, it's normal
SYS=`uname -s`
if [ $SYS == "Darwin" ]; then
    RET=`which gsed`
    if [ -z "$RET" ]; then
        echo "Error: No gsed install. Use 'brew install gnu-sed'"
        exit 1
    fi
fi

BASEJIT_GITHUB_URL=https://github.com/haxpor/basepolymerit/archive/master.zip
BASEJIT_BASE=basepolymerit
PROJ_NAME=$1
CLASS_NAME=$2
# get lower case, and hyphen separated text
ELEM_NAME=`gsed -e 's/\([A-Z]\)/-\L\1/g' -e 's/^-//' <<< $CLASS_NAME`
FILE_NAME=$ELEM_NAME-component

OLD_ELEM_NAME="stock-ticker"
OLD_FILE_NAME="test-component"
OLD_CLASS_NAME="StockTicker"

# download latest source files only of basejit from github
curl -L -o $BASEJIT_BASE.zip $BASEJIT_GITHUB_URL

# unzip
unzip $BASEJIT_BASE.zip

# clean up
mv $BASEJIT_BASE-master/** ./
mv $BASEJIT_BASE-master/.[!.]* ./
rm $BASEJIT_BASE.zip

# remove un-zipped folder
rmdir $BASEJIT_BASE-master

# change basejit text in all source file to the specified from command line
find ./src -type f -name "*.html" -exec sed -i '' "s/$OLD_ELEM_NAME/$ELEM_NAME/g" {} +
find ./src -type f -name "*.html" -exec sed -i '' "s/$OLD_FILE_NAME/$FILE_NAME/g" {} +
find ./src -type f -name "*.js" -exec sed -i '' "s/$OLD_CLASS_NAME/$CLASS_NAME/g" {} +
find ./test -type f -name "*.js" -exec sed -i '' "s/$OLD_ELEM_NAME/$ELEM_NAME/g" {} +
find ./package.json -exec sed -i '' "s/$BASEJIT_BASE/$PROJ_NAME/g" {} +
find ./index.html -exec sed -i '' "s/$OLD_ELEM_NAME/$ELEM_NAME/g" {} +
find ./index.html -exec sed -i '' "s/$OLD_FILE_NAME/$FILE_NAME/g" {} +
find ./scripts/build.sh -exec sed -i '' "s/$OLD_FILE_NAME/$FILE_NAME/g" {} +

# replace content of README.md file
echo "# $PROJ_NAME 
<project description here>

# Misc
This project is based on [https://github.com/haxpor/basepolymerit](https://github.com/haxpor/basepolymerit)" > README.md

# rename files
mv ./src/$OLD_FILE_NAME.js ./src/$FILE_NAME.js
mv ./src/$OLD_FILE_NAME.html ./src/$FILE_NAME.html
mv ./test/test.component.test.js ./test/$FILE_NAME.test.js

# prepare all packages
npm install
bower install