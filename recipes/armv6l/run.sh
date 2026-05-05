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
cd "node-${fullversion}"/deps/cares/config/linux
sed -i 's/define HAVE_SYS_RANDOM_H 1/undef HAVE_SYS_RANDOM_H/g' ./ares_config.h
sed -i 's/define HAVE_GETRANDOM 1/undef HAVE_GETRANDOM/g' ./ares_config.h

cd /home/node

cd "node-${fullversion}"

export CCACHE_BASEDIR="$PWD"
export CC_host="ccache clang-19 -m32"
export CXX_host="ccache clang++-19 -m32"
export CC="ccache clang-19 --target=arm-linux-gnueabihf --sysroot=/usr/arm-linux-gnueabihf --gcc-toolchain=/usr/lib/gcc-cross/arm-linux-gnueabihf \
          -march=armv6zk -mfpu=vfp -mfloat-abi=hard -U__ILP32__"
export CXX="ccache clang++-19 --target=arm-linux-gnueabihf --sysroot=/usr/arm-linux-gnueabihf --gcc-toolchain=/usr/lib/gcc-cross/arm-linux-gnueabihf \
          -march=armv6zk -mfpu=vfp -mfloat-abi=hard -U__ILP32__ -I/usr/arm-linux-gnueabihf/include -I/usr/arm-linux-gnueabihf/include/c++/14 -I/usr/arm-linux-gnueabihf/include/c++/14/arm-linux-gnueabihf"

export LDFLAGS="--sysroot=/usr/arm-linux-gnueabihf -L/usr/arm-linux-gnueabihf/lib -L/usr/lib/gcc-cross/arm-linux-gnueabihf/14 -B/usr/arm-linux-gnueabihf/lib -B/usr/lib/gcc-cross/arm-linux-gnueabihf/14"

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
