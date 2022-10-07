INSTALL = install

.PHONY: all overlays

LINUX_DIR_PATH = /lib/modules/$(shell uname -r)/build
INSTALL = install
PWD = $(shell pwd)
WORK = overlays
DTS_DEST_DIR = /opt/unipi/os-configurator/overlays
UDEV_DEST_DIR = /opt/unipi/os-configurator/udev
LIB_DEST_DIR = /opt/unipi/os-configurator
DESCRIPTION = description.yaml

#DTC_FLAGS_unipi-iris-unispi-slot12 := -@
templates =  $(wildcard *.template)

#all: $(dtsi) $(templates) $(WORK)/imx8mm-pinfunc.h

all: $(WORK)/imx8mm-pinfunc.h unipi_values.py
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C $(LINUX_DIR_PATH) M=$(PWD)/$(WORK)

$(WORK)/imx8mm-pinfunc.h:
	@mkdir -p $(WORK)
	@ln -s $(LINUX_DIR_PATH)/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h $@

udev:
	@mkdir -p udev
	@find udev -type f ! -name \*.template.rules -exec cp \{\} udev \;

$(WORK):
	@mkdir -p $(WORK)
	@cp template/*.dts $(WORK) 2>/dev/null || :

$(WORK)/Makefile: $(templates) $(DESCRIPTION) $(WORK) udev
	@python3 render-slot.py $(DESCRIPTION) -t template -o $(WORK)

unipi_values.py: template/unipi-values.template.py $(DESCRIPTION) $(WORK) udev
	@python3 render-slot.py $(DESCRIPTION) -t template -o $(WORK)

#unipi-values.o: unipi-values.c
#	gcc $^ -c -I unipi-hardware-id/include/ -fPIC

#libunipidata.so: unipi-values.o
#	gcc $^ -shared -o $@

install: install-dtb install-udev
	$(INSTALL) -m 644 unipi_values.py $(DESTDIR)/$(LIB_DEST_DIR)

install-dtb: $(wildcard $(WORK)/*.dtb)
	mkdir -p $(DESTDIR)/$(DTS_DEST_DIR)
	$(INSTALL) -m 644 $^ $(DESTDIR)/$(DTS_DEST_DIR)

install-udev: $(wildcard udev/*.rules)
	mkdir -p $(DESTDIR)/$(UDEV_DEST_DIR)
	[ -z "$^" ] || $(INSTALL) -m 644 $^ $(DESTDIR)/$(UDEV_DEST_DIR)

clean:
	@rm -rf udev $(WORK)
	@rm -f unipi_values.py
	@#touch $(WORK)/Makefile && MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C $(LINUX_DIR_PATH) M=$(PWD)/$(WORK) clean
	@#find $(WORK) -type f ! -name \*.dts -exec rm \{\} \;
