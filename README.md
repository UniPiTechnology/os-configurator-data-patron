# Unipi-os-configurator-data-patron

Unipi Patron specific data for unipi-os-configurator.

Contains device tree overlays an udev rules for various Unipi Patron models.

Package name is unipi-os-configurator-data (without the "-patron"!)

### Building on native (arm64) architecture
Install unipi-kernel-headers package.
```
make all
make install
```


### Building on non-arm64 architecture

- prepare Zulu kernel building environment in directory ./zulu-kernel
```
git clone https://github.com/UniPiTechnology/zulu-kernel.git
cd zulu-kernel
./prepare.sh build
CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make unipi-zulu_defconfig
CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make prepare
cp dts/unipi-zulu.dtsi ../dts
cd ..
```
- build device tree and overlays
```
CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make LINUX_BUILD_PATH=$(pwd)/zulu-kernel/linux-imx all
```

- install files to directory ./install
```
CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make DESTDIR=$(pwd)/install install
```

