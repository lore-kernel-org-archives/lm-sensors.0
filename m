From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Sat, 05 Jan 2013 17:58:22 +0000
Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
Message-Id: <201301051758.r05HwMmM024179@mx3.lsn.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_00E2_01CDEB3B.F6619300"
List-Id: <lm-sensors.vger.kernel.org>
References: <201301050318.r053Ioa1022953@mx3.lsn.net>
In-Reply-To: <201301050318.r053Ioa1022953@mx3.lsn.net>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00E2_01CDEB3B.F6619300
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

	Well, I'm making some progress, but I'm not there, yet.  I removed
the old version of lm-sensors and downloaded and compiled the newest build.
The sensors-detect script now recognizes several sensors, and reports that
k10temp and it87 need to be installed.  Modprobe inserts k10temp just fine,
but it croaks on it87.  I tried running the kernel with
acpi_enforce_resources=lax, but that didn't help, so I downloaded the source
code for it87 from http://khali.linux-fr.org/devel/misc/it87.  When I
attempt to run `make`, however, it complains: "*** No rule to make target
`modules'.  Stop."  I don't see anything wrong with the Makefile, but then I
am far from being an expert on Makefiles.  Does anyone have a suggestion?

Makefile:

# For building for the current running version of Linux
TARGET		:= $(shell uname -r)
# Or specific version
#TARGET		:= 3.4.16
#TARGET		:= 3.0.39
#TARGET		:= 2.6.32.57

KERNEL_MODULES	:= /lib/modules/$(TARGET)
KERNEL_BUILD	:= $(KERNEL_MODULES)/build
SYSTEM_MAP	:= $(shell if test -r /boot/System.map-$(TARGET) ; then echo
/boot/System.map-$(TARGET) ; else echo $(KERNEL_BUILD)/System.map ; fi)

DRIVER := it87

# Directory below /lib/modules/$(TARGET)/kernel into which to install
# the module:
MOD_SUBDIR = drivers/hwmon

obj-m	:= $(DRIVER).o

.PHONY: all install modules modules_install clean

all: modules

# Targets for running make directly in the external module directory:
modules clean:
	@$(MAKE) -C $(KERNEL_BUILD) M=$(CURDIR) $@

install: modules_install

modules_install:
	test -d $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR) || mkdir
$(KERNEL_MODULES)/kernel/$(MOD_SUBDIR)
	cp $(DRIVER).ko $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR)
	depmod -a -F $(SYSTEM_MAP) $(TARGET)

_____________________________________________
From: Leslie Rhorer [mailto:lrhorer@mygrande.net] 
Sent: Friday, January 04, 2013 9:19 PM
To: 'lm-sensors@lm-sensors.org'
Subject: ASUS M5A99X EVO R2.0

	I just pruchased an ASUS M5A99X EVO R2.0 motherboard with UEFI BIOS.
Sensors-detect finds no sensors on the motherboard, yet there are 5 fan
sensors plus temperature sensors for the CPU and the motherboard.  I'm
running kernel 2.6.32-5-amd64 with an 8 core AMD FX-8350 Vishera CPU.  How
can I get lm-sensors to detect these sensors?

------=_NextPart_000_00E2_01CDEB3B.F6619300
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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

------=_NextPart_000_00E2_01CDEB3B.F6619300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_00E2_01CDEB3B.F6619300--

