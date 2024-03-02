#!/bin/bash


echo "Install adrenlinerush repo..."
cd /etc/apt/trusted.gpg.d/ && wget https://wiki.adrenlinerush.net/apt-repo/dists/stable/adrenlinerush-repo.gpg
echo "deb https://wiki.adrenlinerush.net/apt-repo stable main" >> /etc/apt/sources.list
apt-get update


echo "Starting deb-packaging..." 
cd /workspace

# Loop through directories.
for d in *; do
  if [ -d "$d" ]; then
    echo "Processing $d" 
    VERSION=$(cat $d/control | grep Version | awk '{print$2}')
    SRC=$(cat $d/control | grep Vcs-Git | awk '{print$2}')
    export DEBEMAIL=$(cat $d/control | grep Maintainer | awk '{print$4}')
    export LOGNAME=$(cat $d/control | grep Maintainer | awk '{print$2}'|| tr '[:upper:]' '[:lower:]') 
    export DEBFULLNAME=$(cat $d/control | grep Maintainer | awk '{print$2" "$3}')

    printenv


    echo "Cloning $SRC to $d-$VERSION" 
    git clone $SRC $d-$VERSION && echo "Cloning complete."

    cd $d-$VERSION

    echo "Running dh_make..." 
    dh_make -s -y -c gpl --createorig 

    echo "Copying config..." 
    cp ../$d/* debian/
    touch debian/changelog


    echo "Creating source package..."
    dpkg-source -b .

    echp "Installing build deps.."
    mk-build-deps -i -t 'apt-get -y -o Debug::pkgProblemResolver=yes --no-install-recommends'

    echo "Creating binary package..."
    dpkg-buildpackage -nc 

    echo "Cleaning up..."
    cd ../
    rm -rf $d-$VERSION
  fi
done

