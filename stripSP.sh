#1/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_DIR=$SCRIPT_DIR/spsrc322
DEBBUILD_FOLDER=$SCRIPT_DIR/debbuild
# prepare stripped sonic-pi folder in $DEBBUILD_FOLDER/opt
mkdir -p $DEBBUILD_FOLDER/opt/sonic-pi
mkdir -p $DEBBUILD_FOLDER/opt/sonic-pi/app/gui/qt/build
cp $SOURCE_DIR/sonic-pi/LICENSE.md $DEBBUILD_FOLDER/opt/sonic-pi
cp -R $SOURCE_DIR/sonic-pi/bin $DEBBUILD_FOLDER/opt/sonic-pi
echo "copying etc.."
cp -R $SOURCE_DIR/sonic-pi/etc $DEBBUILD_FOLDER/opt/sonic-pi
echo "copying server.."
cp -R $SOURCE_DIR/sonic-pi/app/server $DEBBUILD_FOLDER/opt/sonic-pi/app
cp -R $SOURCE_DIR/sonic-pi/app/gui/qt/theme $DEBBUILD_FOLDER/opt/sonic-pi/app/gui/qt
cp $SOURCE_DIR/sonic-pi/app/gui/qt/build/sonic-pi $DEBBUILD_FOLDER/opt/sonic-pi/app/gui/qt/build
echo "pruning vendor.."
cp $SOURCE_DIR/sonic-pi/app/gui/qt/prune.rb $DEBBUILD_FOLDER/opt/sonic-pi/app/gui/qt
sed -i -e 's/rehearse = true/rehearse = false/g' $DEBBUILD_FOLDER/opt/sonic-pi/app/gui/qt/prune.rb
cd $DEBBUILD_FOLDER/opt/sonic-pi
ruby app/gui/qt/prune.rb app/server/ruby/vendor
rm app/gui/qt/prune.rb
cd $SCRIPT_DIR
#substitute two patched files
cp patched/sonic-pi-server.rb $DEBBUILD_FOLDER/opt/sonic-pi/app/server/ruby/bin
cp patched/app.qss $DEBBUILD_FOLDER/opt/sonic-pi/app/gui/qt/theme
echo 'finished'