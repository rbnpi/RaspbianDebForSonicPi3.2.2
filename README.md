In the absence of a fully fledged source debian package for Sonic Pi on Raspbian and other Linux for the latest versions this is an attempt to create a binary deb package which is build from source autoamtically.
Alternative versions ofr other distributions eg Ubuntu 20.04 are also being developed

To create a binary deb for Sonic Pi version 3.2.2
This version for Raspbian Buster

There are three scripts which can be run together or separately

buildsp3.2.2.sh  #downloads source and build sonic pi in subfolder folder spsrc322

stripSP.sh #produces a build stripped copy in subfolder debbuild/opt of sonic-pi, patched for Raspberry Pi
(the patches are to sonic-pi-server.rb  in /opt/app/server/ruby/bin (to enable starting of compton to facilitate the transparency command, and an addition to the theme file app.qss in /opt/app/gui/qt/theme to correct the background in load and save dialogs.

preparedebbuild.sh #copies in deb files including checksums and then builds final binary deb as sonic-pi-3.2.2_1_armhf.deb (owned by root)

note that final deb source folder debbuild is left with owner and group set to root:root
sudo chmod -R pi:pi debbuild  if you want to change or move it later.

The three scripts can be run without interruption using completeprocess.sh which takes about 23 minutes in total on a Pi4.
Having separate scripts meassn you can run the initial build once, and then easily rerun the strip/patch and package scripts which are much quicker.
