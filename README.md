# docker_deb_packager

Simple scripts/pattern with docker to autobuild/patch .debs

### Scripts

* create_image.sh - creates image called deb-pacakger using Dockerfile
* build.sh $1 - $1 is directory that you want to build, starts deb-packager with directory mounted, executes packager.sh in directory, cleans itself up

### packager.sh

##### custom

* Adds my custom apt-repo
* Loops through directories
* Git clones source code to directory based on settings in directory/control
* Runs dh_make
* Copies debian files from directory to source/debian
* Creates source package
* Installs build deps
* Builds binary package
* Removes source

##### patch

* loops through directories
* installs source of package matching directory name
* uses quilt to install the patches in the source
* imports all custom patches in dir name *.patch
* Creates a Non-Maintainer Update in changelog
* Creates new source package
* Installs dependencies
* Creates new binary package
* Cleans up source directory
