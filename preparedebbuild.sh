#1/usr/bin/env bash
#prepare debbuild folder structure
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEBBUILD_FOLDER=$SCRIPT_DIR/debbuild
#insert folders
cp -R DEBIAN $DEBBUILD_FOLDER
cp -R usr $DEBBUILD_FOLDER
cd $DEBBUILD_FOLDER
#create md5sums
find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums
cd $SCRIPT_DIR

sudo chown -R root:root $DEBBUILD_FOLDER
echo 'building deb package...'
sudo dpkg-deb --build $DEBBUILD_FOLDER sonic-pi_3.2.2_1_armhf.deb
echo 'finished building deb package'