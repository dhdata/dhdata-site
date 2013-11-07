#! /bin/sh

echo "*** Checking JavaScript dependencies"
bower install
if [ -d ./build ]; then
  echo "*** Removing previous build"
  rm -rf ./build
fi
echo "*** Building site"
middleman build --verbose
