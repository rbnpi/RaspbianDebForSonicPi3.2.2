#1/usr/bin/env bash
#build sonic pi deb from scratch
echo 'building sonic pi from source..'
./buildsp3.2.2.sh
echo 'copying sonic-pi to builddeb/opt..'
./stripSP.sh
echo 'prepare and build deb package..'
./preparedebbuild.sh