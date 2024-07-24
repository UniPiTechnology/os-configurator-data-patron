
.PHONY: all overlays dts

LINUX_BUILD_PATH = /lib/modules/$(shell uname -r)/build
INSTALL = install
PWD = $(shell pwd)
OVERLAY_DEST_DIR = /boot/overlays
UDEV_DEST_DIR = /opt/unipi/os-configurator/udev
LIB_DEST_DIR = /opt/unipi/os-configurator


all: overlays dts

dts: dts/unipi-zulu.dtsi dts/imx8mm-pinfunc.h dts/imx8mm.dtsi $(LINUX_BUILD_PATH)/Module.symvers $(USE_SPINOR)
	@MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C $(LINUX_BUILD_PATH) M=$(PWD)/$@

overlays: overlays/imx8mm-pinfunc.h $(LINUX_BUILD_PATH)/Module.symvers
	@MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C $(LINUX_BUILD_PATH) M=$(PWD)/$@

%.dtsi %/imx8mm-pinfunc.h:
	@S="$(LINUX_BUILD_PATH)/arch/arm64/boot/dts/freescale/$$(basename $@)"; \
	 if [ -e "$$S" ]; then ln -s "$$S" $@;\
	 else echo "Missing file $$S" >&2; false; fi

$(LINUX_BUILD_PATH)/Module.symvers:
	@touch $@


install: install-dtb install-udev install-overlays unipi_values.py
	$(INSTALL) -m 644 unipi_values.py $(DESTDIR)/$(LIB_DEST_DIR)
	cp -r files/* $(DESTDIR)

install-overlays: $(wildcard overlays/*.dtb)
	mkdir -p $(DESTDIR)/$(OVERLAY_DEST_DIR)
	$(INSTALL) -m 644 $^ $(DESTDIR)/$(OVERLAY_DEST_DIR)

install-dtb: $(wildcard dts/*.dtb)
	mkdir -p $(DESTDIR)/boot
	$(INSTALL) -m 644 $^ $(DESTDIR)/boot

install-udev: $(wildcard udev/*.rules)
	mkdir -p $(DESTDIR)/$(UDEV_DEST_DIR)
	[ -z "$^" ] || $(INSTALL) -m 644 $^ $(DESTDIR)/$(UDEV_DEST_DIR)

clean:
	@find overlays \( -name .\*.cmd -o -name .\*.tmp -o -name \*.dtb \
	      -o -name Module.symvers -o -name modules.order -o -name imx8mm-pinfunc.h \) \
	      -delete
	@find dts \( -name .\*.cmd -o -name .\*.tmp -o -name \*.dtb \
	      -o -name Module.symvers -o -name modules.order -o -name imx8mm-pinfunc.h \) \
	      -delete
