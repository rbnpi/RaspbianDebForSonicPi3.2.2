#!/usr/bin/env bash
#script by Robin Newman to build Sonic Pi 3.2.2 release on Raspbian Buster 2020-02-05
#version 3 with correct build of erlang beam files included
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_DIR=$SCRIPT_DIR/spsrc322
echo $SCRIPT_DIR
echo $SOURCE_DIR
#check packages required for build are installed
sudo apt-get install -y \
     g++ ruby ruby-dev pkg-config git build-essential libjack-jackd2-dev \
     libsndfile1-dev libasound2-dev libavahi-client-dev libicu-dev \
     libreadline6-dev libfftw3-dev libxt-dev libudev-dev cmake \
     libqt5svg5-dev qt5-qmake qt5-default \
     qttools5-dev qttools5-dev-tools qtdeclarative5-dev libqt5webkit5-dev \
     qtpositioning5-dev libqt5sensors5-dev libqt5opengl5-dev qtmultimedia5-dev libffi-dev \
     curl python erlang-base libssl-dev libaubio5 supercollider-server sc3-plugins-server compton


mkdir -p $SOURCE_DIR
cd $SOURCE_DIR
get release source of sonic-pi-3.2.2
wget https://github.com/samaaron/sonic-pi/archive/v3.2.2.tar.gz
echo "extracting Sonic Pi source.."
tar -zxf v3.2.2.tar.gz
#rename source to sonic-pi
mv sonic-pi-3.2.2 sonic-pi
#create lib folder
 mkdir -p sonic-pi/app/server/native/lib
#link libaubio library
ln -s /usr/lib/arm-linux-gnueabihf/libaubio.so.5 sonic-pi/app/server/native/lib/libaubio-5.so
#go to qt folder which contains build scripts
cd sonic-pi/app/gui/qt/
#echo "running unix-prebuild script..."
./unix-prebuild.sh
echo "running unix_config script..."
./unix-config.sh
echo "building gui and sonic-pi app..."
cd build
cmake --build .
echo "build complete" 
cd $SCRIPT_DIR
