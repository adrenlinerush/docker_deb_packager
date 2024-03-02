#!/bin/bash


echo "Starting deb-packaging..." 
cd /workspace

# Loop through directories.
for d in *; do
  if [ -d "$d" ]; then
    echo "Processing $d" 

    apt-cache show $d

    SOURCE=$(apt-cache show $d | grep Source | awk '{print$2}')
    VERSION=$(apt-cache show $d | grep Version | awk '{print$2}' | awk -F '-' '{print$1}')
    SOURCE_DIR="$SOURCE-$VERSION"
    echo "SOURCE_DIR=$SOURCE_DIR"

    echo "Installing source."
    apt-get source $d
    cd $SOURCE_DIR
    pwd
    ls -Alh

    echo "Applying existing patches."
    quilt push -a

    echo "Applying custom patches."
    for f in /workspace/$d/*; do
      if [[ $f == *".patch" ]]; then
        echo "Applying $f."
        quilt import $f
      fi
    done

    echo "Unapplying patches."
    quilt refresh
    quilt pop -a

    #echo "Creating source package..."
    #dpkg-source -b .

    echo "Installing build deps.."
    mk-build-deps -i -t 'apt-get -y -o Debug::pkgProblemResolver=yes --no-install-recommends'

    echo "Building Package(s)."
    DEBEMAIL="Austin Mount <austin@adrenlinerush.net>"
    debuild -us -uc -i -I -b

    echo "Cleaning up..."
    cd ../
    rm -rf $SOURCE_DIR
  fi
done

