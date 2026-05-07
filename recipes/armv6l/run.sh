#!/usr/bin/env bash

set -e
set -x

release_urlbase="$1"
disttype="$2"
customtag="$3"
datestring="$4"
commit="$5"
fullversion="$6"
source_url="$7"
source_urlbase="$8"
config_flags=

cd /home/node

tar -xf node.tar.xz

# configuring cares correctly to not use sys/random.h on this target
cd "node-${fullversion}"
pushd deps/cares/config/linux
sed -i 's/define HAVE_SYS_RANDOM_H 1/undef HAVE_SYS_RANDOM_H/g' ./ares_config.h
sed -i 's/define HAVE_GETRANDOM 1/undef HAVE_GETRANDOM/g' ./ares_config.h
popd

export CCACHE_BASEDIR="$PWD"
export CC_host="ccache clang-22"
export CXX_host="ccache clang++-22"
export CC="ccache clang-22 --target=arm-linux-gnueabihf -march=armv6zk -mfpu=vfp -mfloat-abi=hard -U__ILP32__ -Xclang -target-feature -Xclang +db"
export CXX="ccache clang++-22 --target=arm-linux-gnueabihf -march=armv6zk -mfpu=vfp -mfloat-abi=hard -U__ILP32__ -Xclang -target-feature -Xclang +db"

make -j$(getconf _NPROCESSORS_ONLN) binary V= \
  DESTCPU="arm" \
  ARCH="armv6l" \
  VARIATION="" \
  DISTTYPE="$disttype" \
  CUSTOMTAG="$customtag" \
  DATESTRING="$datestring" \
  COMMIT="$commit" \
  RELEASE_URLBASE="$release_urlbase" \
  CONFIG_FLAGS="$config_flags"

mv node-*.tar.?z /out/
