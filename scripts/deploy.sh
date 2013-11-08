#! /bin/sh

#
# This script is used to build and deploy the site on the site server.
# It is included here to demonstrate one way to manage the build and
# deployment process when using a static site builder.
#

DATE=`date +%Y%m%d-%H%M`
BUILD_DIR=${HOME}/build-${DATE}

if mkdir ${BUILD_DIR}; then
  cd ${BUILD_DIR}
  echo "*** Checking out site repository"
  if git clone https://github.com/dhdata/dhdata-site.git ; then
    cd dhdata-site
    echo "*** Checking Ruby gems"
    if bundle install ; then
      echo "*** Checking JavaScript dependencies"
      if bower install ; then
        if [ -d ./build ]; then
          echo "*** Removing previous build"
          rm -rf ./build
        fi
        echo "*** Building site"
        if middleman build ; then
          if cp -r $BUILD_DIR/dhdata-site/build/ /usr/share/nginx/dhdata-site/$DATE; then
            rm -f /usr/share/nginx/dhdata-site/current
            if [ -s /usr/share/nginx/dhdata-site/current ]; then
              echo "!!! Unable to remove previous link to site - abandoning update"
              exit 1
            fi
            if ln -s /usr/share/nginx/dhdata-site/$DATE /usr/share/nginx/dhdata-site/current; then
              rm -rf ${BUILD_DIR}
              echo "Finished with update"
              exit 0
            else
              echo "!!! SITE BROKEN - Unable to create new symbolic link"
              exit 1
            fi
          else
            echo "!!! Unable to copy built site to production location"
            exit 1
          fi
        else
          echo "!!! Unable to build site"
          exit 1
        fi
      else
        echo "!!! Unable to resolve JavaScript dependencies"
        exit 1
      fi
    else
      echo "!!! New gem dependencies are not installed"
      exit 1
    fi
  else
    echo "!!! Unable to clone git repo"
    exit 1
  fi
else
  echo "!!! Unable to create temporary build directory"
  exit 1
fi