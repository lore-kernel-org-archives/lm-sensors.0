From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: documentation update for 2.6
Message-Id: <Pine.LNX.4.58.0502051302190.7839@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello

I "ported" chips/busses documentation from 2.4.

Please read/comment so we can be sure there are no bugs left.
Also I dont know if I know status of i801 features correctly.
This is preliminary patch.

Thanks

Rudolf

diff -Naur a/Documentation/i2c/busses/i2c-ali15x3 b/Documentation/i2c/busse=
s/i2c-ali15x3
--- a/Documentation/i2c/busses/i2c-ali15x3	1970-01-01 01:00:00.000000000 +0=
100
+++ b/Documentation/i2c/busses/i2c-ali15x3	2005-02-04 22:24:27.000000000 +0=
100
@@ -0,0 +1,112 @@
+Kernel driver i2c-ali15x3
+
+Supported adapters:
+  * Acer Labs, Inc. ALI 1533 and 1543C (south bridge)
+    Datasheet: Available at the Acer Labs website (password required)
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>,
+	Mark D. Studebaker <mdsxyz123@yahoo.com>
+
+Module Parameters
+-----------------
+
+* force_addr: int
+  Initialize the base address of the i2c controller
+
+
+Notes
+-----
+
+The force_addr parameter is useful for boards that don't set the address
+in the BIOS. Does not do a PCI force; the device must still be present
+in lspci. Don't use this unless the driver complains that the
+base address is not set.
+Example: 'modprobe i2c-ali15x3 force_addr=3D0xe800'
+
+SMBus periodically hangs on ASUS P5A motherboards and can only be
+cleared by a power cycle. Cause unknown (see Issues below).
+
+
+Description
+-----------
+
+This is the driver for the SMB Host controller on
+Acer Labs Inc. (ALI) M1541 and M1543C South Bridges.
+
+The M1543C is a South bridge for desktop systems.
+The M1541 is a South bridge for portable systems.
+They are part of the following ALI chipsets:
+   "Aladdin Pro 2": Includes the M1621 Slot 1 North bridge
+   with AGP and 100MHz CPU Front Side bus
+
+   "Aladdin V": Includes the M1541 Socket 7 North bridge
+   with AGP and 100MHz CPU Front Side bus
+   Some Aladdin V motherboards:
+	Asus P5A
+	Atrend ATC-5220
+	BCM/GVC VP1541
+	Biostar M5ALA
+	Gigabyte GA-5AX (** Generally doesn't work because the BIOS doesn't
+                            enable the 7101 device! **)
+	Iwill XA100 Plus
+	Micronics C200
+	Microstar (MSI) MS-5169
+
+   "Aladdin IV": Includes the M1541 Socket 7 North bridge
+   with host bus up to 83.3 MHz.
+
+For an overview of these chips see http://www.acerlabs.com
+At this time the full data sheets on the web site are password protected,
+however if you contact the ALI office in San Jose
+they may give you the password.
+
+The M1533/M1543C devices appear as FOUR separate devices
+on the PCI bus. An output of lspci will show something similar
+to the following:
+
+  00:02.0 USB Controller: Acer Laboratories Inc. M5237 (rev 03)
+  00:03.0 Bridge: Acer Laboratories Inc. M7101      <=3D THIS IS THE ONE W=
E NEED
+  00:07.0 ISA bridge: Acer Laboratories Inc. M1533 (rev c3)
+  00:0f.0 IDE interface: Acer Laboratories Inc. M5229 (rev c1)
+
+** IMPORTANT **
+** If you have a 1533 or 1543C on the board and you get
+** "ali15x3.o: Error: Can't detect ali15x3!"
+** then run lspci.
+** If you see the 1533 and 5229 devices but NOT the 7101 device,
+** then you must enable ACPI, the PMU, SMB, or something similar
+** in the BIOS.
+** The driver won't work if it can't find the 7101 device.
+
+The SMB controller is part of the 7101 device, which is an
+ACPI-compliant Power Management Unit (PMU).
+
+The whole 7101 device has to be enabled for the SMB to work.
+You can't just enable the SMB alone.
+The SMB and the ACPI have separate I/O spaces.
+We make sure that the SMB is enabled. We leave the ACPI alone.
+
+
+Features
+--------
+This driver controls the SMB Host only.
+The SMB Slave controller on the M15X3 is not enabled.
+This driver does not use interrupts.
+
+
+Issues
+------
+This driver requests the I/O space for only the SMB
+registers. It doesn't use the ACPI region.
+
+On the ASUS P5A motherboard, there are several reports that
+the SMBus will hang and this can only be resolved by
+powering off the computer. It appears to be worse when the board
+gets hot, for example under heavy CPU load, or in the summer.
+There may be electrical problems on this board.
+On the P5A, the W83781D sensor chip is on both the ISA and
+SMBus. Therefore the SMBus hangs can generally be avoided
+by accessing the W83781D on the ISA bus only.
+
diff -Naur a/Documentation/i2c/busses/i2c-ali1535 b/Documentation/i2c/busse=
s/i2c-ali1535
--- a/Documentation/i2c/busses/i2c-ali1535	1970-01-01 01:00:00.000000000 +0=
100
+++ b/Documentation/i2c/busses/i2c-ali1535	2005-02-04 22:02:24.000000000 +0=
100
@@ -0,0 +1,50 @@
+Kernel driver i2c-ali1535
+
+Supported adapters:
+  * Acer Labs, Inc. ALI 1535 (south bridge)
+    Datasheet: Available at the Acer Labs website (password may be require=
d)
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>,
+	Mark D. Studebaker <mdsxyz123@yahoo.com>,
+	Dan Eaton <dan.eaton@rocketlogix.com>,
+	Stephen Rousset<stephen.rousset@rocketlogix.com>
+
+Module Parameters
+-----------------
+
+(none)
+
+
+Description
+-----------
+
+This is the driver for the SMB Host controller on
+Acer Labs Inc. (ALI) M1535 South Bridge.
+
+The M1535 is a South bridge for portable systems.
+It is very similar to the M15x3 South bridges also produced
+by Acer Labs Inc.  Some of the registers within the part
+have moved and some have been redefined slightly. Additionally,
+the sequencing of the SMBus transactions has been modified
+to be more consistent with the sequencing recommended by
+the manufacturer and observed through testing.  These
+changes are reflected in this driver and can be identified
+by comparing this driver to the i2c-ali15x3 driver.
+For an overview of these chips see http://www.acerlabs.com
+
+The SMB controller is part of the 7101 device, which is an
+ACPI-compliant Power Management Unit (PMU).
+
+The whole 7101 device has to be enabled for the SMB to work.
+You can't just enable the SMB alone.
+The SMB and the ACPI have separate I/O spaces.
+We make sure that the SMB is enabled. We leave the ACPI alone.
+
+
+Features
+--------
+
+This driver controls the SMB Host only.
+This driver does not use interrupts.
diff -Naur a/Documentation/i2c/busses/i2c-ali1563 b/Documentation/i2c/busse=
s/i2c-ali1563
--- a/Documentation/i2c/busses/i2c-ali1563	1970-01-01 01:00:00.000000000 +0=
100
+++ b/Documentation/i2c/busses/i2c-ali1563	2005-02-04 22:23:43.000000000 +0=
100
@@ -0,0 +1,26 @@
+Kernel driver i2c-ali1563
+
+Supported adapters:
+  * Acer Labs, Inc. ALI 1563 (south bridge)
+    Datasheet: Under NDA
+
+Author: Patrick Mochel <mochel@digitalimplant.org>
+
+Description
+-----------
+
+This is the driver for the SMB Host controller on
+Acer Labs Inc. (ALI) M1563 South Bridge.
+
+For an overview of these chips see http://www.acerlabs.com
+
+The 1563 southbridge is deceptively similar to the 1533, with a
+few notable exceptions. One of those happens to be the fact they
+upgraded the i2c core to be 2.0 compliant, and happens to be almost
+identical to the i2c controller found in the Intel 801 south bridges.
+
+Features
+--------
+
+This driver controls the SMB Host only.
+This driver does not use interrupts.
diff -Naur a/Documentation/i2c/busses/i2c-amd756 b/Documentation/i2c/busses=
/i2c-amd756
--- a/Documentation/i2c/busses/i2c-amd756	1970-01-01 01:00:00.000000000 +01=
00
+++ b/Documentation/i2c/busses/i2c-amd756	2005-02-04 22:24:54.000000000 +01=
00
@@ -0,0 +1,27 @@
+Kernel driver i2c-amd756
+
+Status: Complete and somewhat tested
+
+Supported adapters:
+  * AMD 756
+  * AMD 766
+  * AMD 768
+  * AMD 8111
+    Datasheets: Publicly available on AMD website
+
+  * nVidia nForce
+    Datasheet: Unavailable
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>
+
+Description
+-----------
+
+This driver supports the AMD 756, 766, 768 and 8111 Peripheral Bus Control=
lers, and
+the nVidia nForce.
+
+Note that for the 8111, there are two SMBus adapters. The SMBus 1.0 adapte=
r is
+supported by this driver, and the SMBus 2.0 adapter is supported
+by the i2c-amd8111 driver.
diff -Naur a/Documentation/i2c/busses/i2c-amd8111 b/Documentation/i2c/busse=
s/i2c-amd8111
--- a/Documentation/i2c/busses/i2c-amd8111	1970-01-01 01:00:00.000000000 +0=
100
+++ b/Documentation/i2c/busses/i2c-amd8111	2005-02-04 22:25:11.000000000 +0=
100
@@ -0,0 +1,40 @@
+Kernel driver i2c-adm8111
+
+Supported adapters:
+    * AMD-8111 SMBus 2.0 PCI interface
+
+Datasheets:
+	AMD datasheet not yet available, but almost everything can be found in
+        publically available ACPI 2.0 specification, which the adapter fol=
lows.
+
+Author: Vojtech Pavlik <vojtech@suse.cz>
+
+Description
+-----------
+
+If you see something like this:
+
+00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
+        Subsystem: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0
+        Flags: medium devsel, IRQ 19
+        I/O ports at d400 [size2]
+
+in your 'lspci -v', then this driver is for your chipset.
+
+Process Call Support
+--------------------
+
+Supported.
+
+SMBus 2.0 Support
+-----------------
+
+Supported. Both PEC and block process call support is implemented.
+Slave mode or host notification are not yet implemented.
+
+Notes
+-----
+
+Note that for the 8111, there are two SMBus adapters. The SMBus 2.0 adapte=
r is
+supported by this driver, and the SMBus 1.0 adapter is supported
+by the i2c-amd756 driver.
diff -Naur a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i=
2c-i801
--- a/Documentation/i2c/busses/i2c-i801	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-i801	2005-02-05 12:12:36.000000000 +0100
@@ -0,0 +1,86 @@
+Kernel driver i2c-i801
+
+Supported adapters:
+  * Intel 82801AA and 82801AB (ICH and ICH0 - part of the
+    '810' and '810E' chipsets)
+  * Intel 82801BA (ICH2 - part of the '815E' chipset)
+  * Intel 82801CA/CAM (ICH3)
+  * Intel 82801DB (ICH4) (HW PEC supported, 32 byte buffer not supported)
+  * Intel 82801EB/ER (ICH5) (HW PEC supported, 32 byte buffer not supporte=
d)
+  * Intel 6300ESB
+  * Intel 82801FB/FR/FW/FRW (ICH6)
+  * Intel ICH7
+    Datasheets: Publicly available at the Intel website
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>,
+	Mark Studebaker <mdsxyz123@yahoo.com>
+
+
+Module Parameters
+-----------------
+
+* force_addr: int
+  Forcibly enable the ICH at the given address. EXTREMELY DANGEROUS!
+
+
+Description
+-----------
+
+The ICH (properly known as the 82801AA), ICH0 (82801AB),
+ICH2 (82801BA), ICH3 (82801CA/CAM) and later devices
+are Intel chips that are a part of
+Intel's '810' chipset for Celeron-based PCs,
+'810E' chipset for Pentium-based PCs, '815E' chipset, and others.
+
+The ICH chips contain at least SEVEN separate PCI functions
+in TWO logical PCI devices.
+An output of lspci will show something similar to the following:
+
+  00:1e.0 PCI bridge: Intel Corporation: Unknown device 2418 (rev 01)
+  00:1f.0 ISA bridge: Intel Corporation: Unknown device 2410 (rev 01)
+  00:1f.1 IDE interface: Intel Corporation: Unknown device 2411 (rev 01)
+  00:1f.2 USB Controller: Intel Corporation: Unknown device 2412 (rev 01)
+  00:1f.3 Unknown class [0c05]: Intel Corporation: Unknown device 2413 (re=
v 01)
+
+The SMBus controller is function 3 in device 1f.
+Class 0c05 is SMBus Serial Controller.
+
+If you do NOT see the 24x3 device at function 3, and you can't
+figure out any way in the BIOS to enable it,
+
+The ICH chips are quite similar to Intel's PIIX4 chip,
+at least in the SMBus controller.
+
+See the file i2c-piix4 for some additional information.
+
+
+Process Call Support
+--------------------
+
+Not supported.
+
+
+I2C Block Read Support
+----------------------
+
+The ICH4 supports a special 3-byte address (command code
+plus 2 more bytes) I2C block read.
+The driver and the kernel i2c protocol stack do not
+support this.
+The ICH5 and higher support a standard 1-byte address (command code)
+I2C block read. The driver does support this.
+
+
+SMBus 2.0 Support
+-----------------
+
+The 82801DB (ICH4) and later chips support several SMBus 2.0 features.
+
+**********************
+The lm_sensors project gratefully acknowledges the support of
+Texas Instruments in the initial development of this driver.
+
+The lm_sensors project gratefully acknowledges the support of
+Intel in the development of SMBus 2.0 / ICH4 features of this driver.
diff -Naur a/Documentation/i2c/busses/i2c-i810 b/Documentation/i2c/busses/i=
2c-i810
--- a/Documentation/i2c/busses/i2c-i810	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-i810	2005-02-04 22:26:32.000000000 +0100
@@ -0,0 +1,49 @@
+Kernel driver i2c-i810
+
+Supported adapters:
+  * Intel 82810, 82810-DC100, 82810E, and 82815 (GMCH)
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>,
+        Ky?sti M?lkki <kmalkki@cc.hut.fi>,
+	Ralph Metzler <rjkm@thp.uni-koeln.de>,
+	Mark D. Studebaker <mdsxyz123@yahoo.com>
+
+Main contact: Mark Studebaker <mdsxyz123@yahoo.com>
+
+Description
+-----------
+This driver uses the i2c-algo-bit module which must be
+modprobed and/or enabled in your kernel
+(Character Devices -> I2C Support -> I2C Bit-Banging Interfaces).
+
+WARNING: If you have an '810' or '815' motherboard, your standard I2C
+temperature sensors are most likely on the 801's I2C bus.
+You want the i2c-i80 driver for those, not this driver.
+
+Now for the i2c-i810...
+
+The GMCH chip contains two I2C interfaces.
+
+The first interface is used for DDC (Data Display Channel)
+which is a serial channel through the VGA monitor connector
+to a DDC-compliant monitor. This interface is defined by the
+Video Electronics Standards Association (VESA). The standards
+are available for purchase at http://www.vesa.org .
+
+The second interface is a general-purpose I2C bus.
+It may be connected to a TV-out chip such as the BT869 or possibly
+to a digital flat-panel display.
+
+Features
+--------
+Both busses use the i2c-algo-bit driver for 'bit banging' and support
+for specific transactions is provided by i2c-algo-bit.
+
+
+Issues
+------
+If you enable bus testing in i2c-algo-bit (insmod i2c-algo-bit bit_test=3D=
1),
+the test may fail; if so, the i2c-i810 driver won't be inserted.
+However, we think this has been fixed.
diff -Naur a/Documentation/i2c/busses/i2c-nforce2 b/Documentation/i2c/busse=
s/i2c-nforce2
--- a/Documentation/i2c/busses/i2c-nforce2	1970-01-01 01:00:00.000000000 +0=
100
+++ b/Documentation/i2c/busses/i2c-nforce2	2005-02-04 22:27:10.000000000 +0=
100
@@ -0,0 +1,37 @@
+Kernel driver i2c-nforce2
+
+Supported adapters:
+    * nVidia nForce2 SMBus PCI interface (10de:0064, included in nForce2 M=
CP)
+      Datasheet: not publically available, but seems to be similar to the
+                 AMD-8111 SMBus 2.0 adapter.
+
+Authors:
+	Hans-Frieder Vogt <hfvogt@arcor.de>,
+	Thomas Leibold <thomas@plx.com>,
+        Patrick Dreker <patrick@dreker.de>
+
+Description
+-----------
+
+i2c-nforce2 is a driver for the SMBuses included in the nVidia nForce2 MCP.
+
+If your 'lspci -v' listing shows something like the following,
+
+00:01.1 SMBus: nVidia Corporation: Unknown device 0064 (rev a2)
+        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
+        Flags: 66Mhz, fast devsel, IRQ 5
+        I/O ports at c000 [size2]
+        Capabilities: <available only to root>
+
+then this driver should support the SMBuses of your motherboard.
+
+
+Notes
+-----
+
+The SMBus adapter in the nForce2 chipset seems to be very similar to the
+SMBus 2.0 adapter in the AMD-8111 southbridge. However, I could only get t=
he
+driver to work with direct I/O access, which is different to the EC interf=
ace
+of the AMD-8111.
+Tested on Asus A7N8X. The ACPI DSDT table of the Asus A7N8X lists two SMBu=
ses,
+both of which are supported by this driver.
diff -Naur a/Documentation/i2c/busses/i2c-parport b/Documentation/i2c/busse=
s/i2c-parport
--- a/Documentation/i2c/busses/i2c-parport	1970-01-01 01:00:00.000000000 +0=
100
+++ b/Documentation/i2c/busses/i2c-parport	2005-02-04 22:27:42.000000000 +0=
100
@@ -0,0 +1,154 @@
+Kernel driver i2c-parport
+
+Author: Jean Delvare <khali@linux-fr.org>
+
+This is a unified driver for several i2c-over-parallel-port adapters,
+such as the ones made by Philips, Velleman or ELV. This driver is
+meant as a replacement for the older, individual drivers:
+ * i2c-philips-par
+ * i2c-elv
+ * i2c-velleman
+ * video/i2c-parport (NOT the same as this one, dedicated to home brew
+                      teletext adapters)
+
+It currently supports the following devices:
+ * Philips adapter
+ * home brew teletext adapter
+ * Velleman K8000 adapter
+ * ELV adapter
+ * Analog Devices evaluation boards (ADM1025, ADM1030, ADM1031, ADM1032)
+
+These devices use different pinout configurations, so you have to tell
+the driver what you have, using the type module parameter. There is no
+way to autodetect the devices. Support for different pinout configurations
+can be easily added when needed.
+
+
+Building your own adapter
+-------------------------
+
+If you want to build you own i2c-over-parallel-port adapter, here is
+a sample electronics schema (credits go to Sylvain Munaut):
+
+Device                                                      PC
+Side          ___________________Vdd (+)                    Side
+               |    |         |
+              ---  ---       ---
+              | |  | |       | |
+              |R|  |R|       |R|
+              | |  | |       | |
+              ---  ---       ---
+               |    |         |
+               |    |    /|   |
+SCL  ----------x--------o |-----------x-------------------  pin 2
+                    |    \|   |       |
+                    |         |       |
+                    |   |\    |       |
+SDA  ----------x----x---| o---x---------------------------  pin 13
+               |        |/            |
+               |                      |
+               |         /|           |
+               ---------o |----------------x--------------  pin 3
+                         \|           |    |
+                                      |    |
+                                     ---  ---
+                                     | |  | |
+                                     |R|  |R|
+                                     | |  | |
+                                     ---  ---
+                                      |    |
+                                     ###  ###
+                                     GND  GND
+
+Remarks:
+ - This is the exact pinout and electronics used on the Analog Devices
+   evaluation boards.
+                   /|
+ - All inverters -o |- must be 74HC05, they must be open collector output.
+                   \|
+ - All resitors are 10k.
+ - Pins 18-25 of the parallel port connected to GND.
+ - Pins 4-9 (D2-D7) could be used as VDD is the driver drives them high.
+   The ADM1032 evaluation board uses D4-D7. Beware that the amount of
+   current you can draw from the parallel port is limited. Also note that
+   all connected lines MUST BE driven at the same state, else you'll short
+   circuit the output buffers! So plugging the I2C adapter after loading
+   the i2c-parport module might be a good safety since data line state
+   prior to init may be unknown.
+ - This is 5V!
+ - Obviously you cannot read SCL (so it's not really standard-compliant).
+   Pretty easy to add, just copy the SDA part and use another input pin.
+   That would give (ELV compatible pinout):
+
+
+Device                                                      PC
+Side          ______________________________Vdd (+)         Side
+               |    |            |    |
+              ---  ---          ---  ---
+              | |  | |          | |  | |
+              |R|  |R|          |R|  |R|
+              | |  | |          | |  | |
+              ---  ---          ---  ---
+               |    |            |    |
+               |    |      |\    |    |
+SCL  ----------x--------x--| o---x------------------------  pin 15
+                    |   |  |/         |
+                    |   |             |
+                    |   |   /|        |
+                    |   ---o |-------------x--------------  pin 2
+                    |       \|        |    |
+                    |                 |    |
+                    |                 |    |
+                    |      |\         |    |
+SDA  ---------------x---x--| o--------x-------------------  pin 10
+                        |  |/              |
+                        |                  |
+                        |   /|             |
+                        ---o |------------------x---------  pin 3
+                            \|             |    |
+                                           |    |
+                                          ---  ---
+                                          | |  | |
+                                          |R|  |R|
+                                          | |  | |
+                                          ---  ---
+                                           |    |
+                                          ###  ###
+                                          GND  GND
+
+
+If possible, you should use the same pinout configuration as existing
+adapters do, so you won't even have to change the code.
+
+
+Similar (but different) drivers
+-------------------------------
+
+This driver is NOT the same as the i2c-pport driver found in the i2c packa=
ge.
+The i2c-pport driver makes use of modern parallel port features so that
+you don't need additional electronics. It has other restrictions however, =
and
+was not ported to Linux 2.6 (yet).
+
+This driver is also NOT the same as the i2c-pcf-epp driver found in the
+lm_sensors package. The i2c-pcf-epp driver doesn't use the parallel port
+as an I2C bus directly. Instead, it uses it to control an external I2C bus
+master. That driver was not ported to Linux 2.6 (yet) either.
+
+
+Legacy documentation for Velleman adapter
+-----------------------------------------
+
+Useful links:
+Velleman                http://www.velleman.be/
+Velleman K8000 Howto    http://howto.htlw16.ac.at/k8000-howto.html
+
+The project has lead to new libs for the Velleman K8000 and K8005:
+  LIBK8000 v1.99.1 and LIBK8005 v0.21
+With these libs, you can control the K8000 interface card and the K8005
+stepper motor card with the simple commands which are in the original
+Velleman software, like SetIOchannel, ReadADchannel, SendStepCCWFull and
+many more, using /dev/velleman.
+  http://home.wanadoo.nl/hihihi/libk8000.htm
+  http://home.wanadoo.nl/hihihi/libk8005.htm
+  http://struyve.mine.nu:8080/index.php?block=3Dk8000
+  http://sourceforge.net/projects/libk8005/
diff -Naur a/Documentation/i2c/busses/i2c-parport-light b/Documentation/i2c=
/busses/i2c-parport-light
--- a/Documentation/i2c/busses/i2c-parport-light	1970-01-01 01:00:00.000000=
000 +0100
+++ b/Documentation/i2c/busses/i2c-parport-light	2005-02-04 22:28:32.000000=
000 +0100
@@ -0,0 +1,161 @@
+Kernel driver i2c-parport-light
+
+Author: Jean Delvare <khali@linux-fr.org>
+
+This driver is a light version of i2c-parport.  It doesn't depend
+on the parport driver, and uses direct I/O access instead.  This
+might be prefered on embedded systems where wasting memory for
+the clean but heavy parport handling is not an option.  The
+drawback is a reduced portability and the impossibility to
+dasiy-chain other parallel port devices.
+
+This is a unified driver for several i2c-over-parallel-port adapters,
+such as the ones made by Philips, Velleman or ELV. This driver is
+meant as a replacement for the older, individual drivers:
+ * i2c-philips-par
+ * i2c-elv
+ * i2c-velleman
+ * video/i2c-parport (NOT the same as this one, dedicated to home brew
+                      teletext adapters)
+
+It currently supports the following devices:
+ * Philips adapter
+ * home brew teletext adapter
+ * Velleman K8000 adapter
+ * ELV adapter
+ * Analog Devices evaluation boards (ADM1025, ADM1030, ADM1031, ADM1032)
+
+These devices use different pinout configurations, so you have to tell
+the driver what you have, using the type module parameter. There is no
+way to autodetect the devices. Support for different pinout configurations
+can be easily added when needed.
+
+
+Building your own adapter
+-------------------------
+
+If you want to build you own i2c-over-parallel-port adapter, here is
+a sample electronics schema (credits go to Sylvain Munaut):
+
+Device                                                      PC
+Side          ___________________Vdd (+)                    Side
+               |    |         |
+              ---  ---       ---
+              | |  | |       | |
+              |R|  |R|       |R|
+              | |  | |       | |
+              ---  ---       ---
+               |    |         |
+               |    |    /|   |
+SCL  ----------x--------o |-----------x-------------------  pin 2
+                    |    \|   |       |
+                    |         |       |
+                    |   |\    |       |
+SDA  ----------x----x---| o---x---------------------------  pin 13
+               |        |/            |
+               |                      |
+               |         /|           |
+               ---------o |----------------x--------------  pin 3
+                         \|           |    |
+                                      |    |
+                                     ---  ---
+                                     | |  | |
+                                     |R|  |R|
+                                     | |  | |
+                                     ---  ---
+                                      |    |
+                                     ###  ###
+                                     GND  GND
+
+Remarks:
+ - This is the exact pinout and electronics used on the Analog Devices
+   evaluation boards.
+                   /|
+ - All inverters -o |- must be 74HC05, they must be open collector output.
+                   \|
+ - All resitors are 10k.
+ - Pins 18-25 of the parallel port connected to GND.
+ - Pins 4-9 (D2-D7) could be used as VDD is the driver drives them high.
+   The ADM1032 evaluation board uses D4-D7. Beware that the amount of
+   current you can draw from the parallel port is limited. Also note that
+   all connected lines MUST BE driven at the same state, else you'll short
+   circuit the output buffers! So plugging the I2C adapter after loading
+   the i2c-parport module might be a good safety since data line state
+   prior to init may be unknown.
+ - This is 5V!
+ - Obviously you cannot read SCL (so it's not really standard-compliant).
+   Pretty easy to add, just copy the SDA part and use another input pin.
+   That would give (ELV compatible pinout):
+
+
+Device                                                      PC
+Side          ______________________________Vdd (+)         Side
+               |    |            |    |
+              ---  ---          ---  ---
+              | |  | |          | |  | |
+              |R|  |R|          |R|  |R|
+              | |  | |          | |  | |
+              ---  ---          ---  ---
+               |    |            |    |
+               |    |      |\    |    |
+SCL  ----------x--------x--| o---x------------------------  pin 15
+                    |   |  |/         |
+                    |   |             |
+                    |   |   /|        |
+                    |   ---o |-------------x--------------  pin 2
+                    |       \|        |    |
+                    |                 |    |
+                    |                 |    |
+                    |      |\         |    |
+SDA  ---------------x---x--| o--------x-------------------  pin 10
+                        |  |/              |
+                        |                  |
+                        |   /|             |
+                        ---o |------------------x---------  pin 3
+                            \|             |    |
+                                           |    |
+                                          ---  ---
+                                          | |  | |
+                                          |R|  |R|
+                                          | |  | |
+                                          ---  ---
+                                           |    |
+                                          ###  ###
+                                          GND  GND
+
+
+If possible, you should use the same pinout configuration as existing
+adapters do, so you won't even have to change the code.
+
+
+Similar (but different) drivers
+-------------------------------
+
+This driver is NOT the same as the i2c-pport driver found in the i2c packa=
ge.
+The i2c-pport driver makes use of modern parallel port features so that
+you don't need additional electronics. It has other restrictions however, =
and
+was not ported to Linux 2.6 (yet).
+
+This driver is also NOT the same as the i2c-pcf-epp driver found in the
+lm_sensors package. The i2c-pcf-epp driver doesn't use the parallel port
+as an I2C bus directly. Instead, it uses it to control an external I2C bus
+master. That driver was not ported to Linux 2.6 (yet) either.
+
+
+Legacy documentation for Velleman adapter
+-----------------------------------------
+
+Useful links:
+Velleman                http://www.velleman.be/
+Velleman K8000 Howto    http://howto.htlw16.ac.at/k8000-howto.html
+
+The project has lead to new libs for the Velleman K8000 and K8005:
+  LIBK8000 v1.99.1 and LIBK8005 v0.21
+With these libs, you can control the K8000 interface card and the K8005
+stepper motor card with the simple commands which are in the original
+Velleman software, like SetIOchannel, ReadADchannel, SendStepCCWFull and
+many more, using /dev/velleman.
+  http://home.wanadoo.nl/hihihi/libk8000.htm
+  http://home.wanadoo.nl/hihihi/libk8005.htm
+  http://struyve.mine.nu:8080/index.php?block=3Dk8000
+  http://sourceforge.net/projects/libk8005/
diff -Naur a/Documentation/i2c/busses/i2c-pca-isa b/Documentation/i2c/busse=
s/i2c-pca-isa
--- a/Documentation/i2c/busses/i2c-pca-isa	1970-01-01 01:00:00.000000000 +0=
100
+++ b/Documentation/i2c/busses/i2c-pca-isa	2005-02-04 22:28:44.000000000 +0=
100
@@ -0,0 +1,23 @@
+Kernel driver i2c-pca-isa
+
+Supported adapters:
+This driver supports ISA boards using the Philips PCA 9564
+Parallel bus to I2C bus controller
+
+Author: Ian Campbell <icampbell@arcom.com>, Arcom Control Systems
+
+Module Parameters
+-----------------
+
+* base int
+ I/O base address
+* irq int
+ IRQ interrupt
+* clock int
+ Clock rate as described in table 1 of PCA9564 datasheet
+
+Description
+-----------
+
+This driver supports ISA boards using the Philips PCA 9564
+Parallel bus to I2C bus controller
diff -Naur a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/=
i2c-piix4
--- a/Documentation/i2c/busses/i2c-piix4	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-piix4	2005-02-04 22:29:17.000000000 +0100
@@ -0,0 +1,73 @@
+Kernel driver i2c-piix4
+
+Supported adapters:
+  * Intel 82371AB PIIX4 and PIIX4E
+  * Intel 82443MX (440MX)
+    Datasheet: Publicly available at the Intel website
+  * ServerWorks OSB4, CSB5  and CSB6 southbridges
+    Datasheet: Only available via NDA from ServerWorks
+  * Standard Microsystems (SMSC) SLC90E66 (Victory66) southbridge
+    Datasheet: Publicly available at the SMSC website http://www.smsc.com
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>
+	Philip Edelbrock <phil@netroedge.com>
+
+
+Module Parameters
+-----------------
+
+* force: int
+  Forcibly enable the PIIX4. DANGEROUS!
+* force_addr: int
+  Forcibly enable the PIIX4 at the given address. EXTREMELY DANGEROUS!
+* fix_hstcfg: int
+  Fix config register. Needed on some boards (Force CPCI735).
+
+
+Description
+-----------
+
+The PIIX4 (properly known as the 82371AB) is an Intel chip with a lot of
+functionality. Among other things, it implements the PCI bus. One of its
+minor functions is implementing a System Management Bus. This is a true
+SMBus - you can not access it on I2C levels. The good news is that it
+natively understands SMBus commands and you do not have to worry about
+timing problems. The bad news is that non-SMBus devices connected to it
+can confuse it mightily. Yes, this is known to happen...
+
+Cat /proc/pci, and see whether it contains an entry like this:
+
+  Bus  0, device   1, function  3:
+    Bridge: Intel 82371AB PIIX4 ACPI (rev 1).
+      Medium devsel.  Fast back-to-back capable.
+
+Bus and device numbers may differ, but the function number must be identic=
al
+(like many PCI devices, the PIIX4 incorporates a number of different
+'functions', which can be considered as separate devices). If you find such
+an entry, you have a PIIX4 SMBus controller.
+
+On some computers (most notably, some Dells), the SMBus is disabled by
+default. If you use the insmod parameter 'force=3D1', the kernel module
+ will try to enable it. THIS IS VERY DANGEROUS! If the BIOS did not
+set up a correct address for this module, you could get in big trouble
+(read: crashes, data corruption, etc.). Try this only as a last resort
+(try BIOS updates first, for example), and backup first! An even more
+dangerous option is 'force_addr=3D<IOPORT>'. This will not only enable the
+PIIX4 like 'force' foes, but it will also set a new base I/O port address.
+The SMBus parts of the PIIX4 needs a range of 8 of these addresses to
+function correctly. If these addresses are already reserved by some other
+device, you will get into big trouble! DON'T USE THIS IF YOU ARE NOT VERY
+SURE ABOUT WHAT YOU ARE DOING!
+
+The PIIX4E is just an new version of the PIIX4; it is supported as well. T=
he
+PIIX/PIIX3 does not implement an SMBus or I2C bus, so you can't use this
+driver on those mainboards.
+
+The ServerWorks Southbridges, the Intel 440MX,
+and the Victory766 are identical to the PIIX4 in I2C/SMBus support.
+
+A few OSB4 southbridges are known to be misconfigured by the BIOS. In this
+case, you have you use the fix_hstcfg module parameter. Do not use it
+unless you know you have to, because in some cases it also breaks
+configuration on southbridges that don't need it.
diff -Naur a/Documentation/i2c/busses/i2c-prosavage b/Documentation/i2c/bus=
ses/i2c-prosavage
--- a/Documentation/i2c/busses/i2c-prosavage	1970-01-01 01:00:00.000000000 =
+0100
+++ b/Documentation/i2c/busses/i2c-prosavage	2005-02-04 22:29:53.000000000 =
+0100
@@ -0,0 +1,27 @@
+Kernel driver i2c-prosavage
+
+Supported adapters:
+
+	S3/VIA KM266/VT8375 aka ProSavage8
+	S3/VIA KM133/VT8365 aka Savage4
+
+Author: Henk Vergonet <henk@god.dyndns.org>
+
+Description
+-----------
+
+The Savage4 chips contain two I2C interfaces (aka a I2C 'master'
+or 'host').
+
+The first interface is used for DDC (Data Display Channel)
+which is a serial channel through the VGA monitor connector
+to a DDC-compliant monitor. This interface is defined by the
+Video Electronics Standards Association (VESA). The standards
+are available for purchase at http://www.vesa.org .
+The second interface is a general-purpose I2C bus.
+
+Usefull for gaining access to the TV Encoder chips.
+
+This driver uses the i2c-algo-bit module which must be
+modprobed and/or enabled in your kernel
+(Character Devices -> I2C Support -> I2C Bit-Banging Interfaces).
diff -Naur a/Documentation/i2c/busses/i2c-savage4 b/Documentation/i2c/busse=
s/i2c-savage4
--- a/Documentation/i2c/busses/i2c-savage4	1970-01-01 01:00:00.000000000 +0=
100
+++ b/Documentation/i2c/busses/i2c-savage4	2005-02-04 22:30:08.000000000 +0=
100
@@ -0,0 +1,30 @@
+Kernel driver i2c-savage4
+
+Supported adapters:
+  * Savage4
+  * Savage2000
+
+Authors:
+	Alexander Wold <awold@bigfoot.com>,
+	Mark D. Studebaker <mdsxyz123@yahoo.com>
+
+Description
+-----------
+
+The Savage4 chips contain two I2C interfaces (aka a I2C 'master'
+or 'host').
+
+The first interface is used for DDC (Data Display Channel)
+which is a serial channel through the VGA monitor connector
+to a DDC-compliant monitor. This interface is defined by the
+Video Electronics Standards Association (VESA). The standards
+are available for purchase at http://www.vesa.org .
+The DDC bus is not yet supported because its register is not
+directly memory-mapped.
+
+The second interface is a general-purpose I2C bus.
+This is the only interface supported by the driver at the moment.
+
+This driver uses the i2c-algo-bit module which must be
+modprobed and/or enabled in your kernel
+(Character Devices -> I2C Support -> I2C Bit-Banging Interfaces).
diff -Naur a/Documentation/i2c/busses/i2c-sis5595 b/Documentation/i2c/busse=
s/i2c-sis5595
--- a/Documentation/i2c/busses/i2c-sis5595	1970-01-01 01:00:00.000000000 +0=
100
+++ b/Documentation/i2c/busses/i2c-sis5595	2005-02-05 12:25:56.000000000 +0=
100
@@ -0,0 +1,65 @@
+Kernel driver i2c-sis5595
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+        Mark D. Studebaker <mdsxyz123@yahoo.com>,
+	Philip Edelbrock <phil@netroedge.com>
+
+Supported adapters:
+  * Silicon Integrated Systems Corp. SiS5595 Southbridge
+    Datasheet: Publicly available at the Silicon Integrated Systems Corp. =
site.
+
+Note: all have mfr. ID 0x1039.
+
+   SUPPORTED            PCI ID
+        5595            0008
+
+   Note: these chips contain a 0008 device which is incompatible with the
+         5595. We recognize these by the presence of the listed
+         "blacklist" PCI ID and refuse to load.
+
+   NOT SUPPORTED        PCI ID          BLACKLIST PCI ID
+         540            0008            0540
+         550            0008            0550
+        5513            0008            5511
+        5581            0008            5597
+        5582            0008            5597
+        5597            0008            5597
+        5598            0008            5597/5598
+         630            0008            0630
+         645            0008            0645
+         646            0008            0646
+         648            0008            0648
+         650            0008            0650
+         651            0008            0651
+         730            0008            0730
+         735            0008            0735
+         745            0008            0745
+         746            0008            0746
+
+Module Parameters
+-----------------
+
+* force_addr=3D0xaddr	Set the I/O base address. Useful for boards
+			that don't set the address in the BIOS. Does not do a
+			PCI force; the device must still be present in lspci.
+			Don't use this unless the driver complains that the
+			base address is not set.
+			Example: 'modprobe i2c-sis5595 force_addr=3D0x290'
+
+
+Description
+-----------
+
+i2c-sis5595 is a true SMBus host driver for motherboards with the
+SiS5595 southbridges.
+
+WARNING: If you are trying to access the integrated sensors on the
+SiS5595 chip, you want the sis5595.o driver for those, not this driver.
+This driver is a BUS driver, not a CHIP driver.
+A BUS driver is used by other CHIP drivers to access chips on the bus.
+
+To install this driver, simply do
+  # modprobe i2c-sis5595
+
+Please send feedback to us at sensors@stimpy.netroedge.com.
diff -Naur a/Documentation/i2c/busses/i2c-sis630 b/Documentation/i2c/busses=
/i2c-sis630
--- a/Documentation/i2c/busses/i2c-sis630	1970-01-01 01:00:00.000000000 +01=
00
+++ b/Documentation/i2c/busses/i2c-sis630	2005-02-04 22:30:38.000000000 +01=
00
@@ -0,0 +1,57 @@
+Kernel driver i2c-sis630
+
+Supported adapters:
+  * Silicon Integrated Systems Corp (SiS)
+	630 chipset (Datasheet: available at http://amalysh.bei.t-online.de/docs/=
SIS/)
+	730 chipset
+  * Possible other SiS chipsets ?
+
+Author: Alexander Malysh <amalysh@web.de>
+
+Module Parameters
+-----------------
+
+* force =3D [1|0] 	Forcibly enable the SIS630. DANGEROUS!
+			This can be interesting for chipsets not named
+			above to check if it works for you chipset, but DANGEROUS!
+* high_clock =3D [1|0]	Forcibly set Host Master Clock to 56KHz (default,wh=
at your BIOS use).
+			DANGEROUS! This should be a bit faster, but freeze some systems (i.e.
+			my Laptop).
+
+
+Description
+-----------
+
+This SMBus only driver is known to work on motherboards with the above nam=
ed
+chipsets.
+
+If you see something like this:
+
+00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
+00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
+
+or like this:
+
+00:00.0 Host bridge: Silicon Integrated Systems [SiS] 730 Host (rev 02)
+00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
+
+in your 'lspci' output , then this driver is for your chipset.
+
+Note: kernel versions later than 2.4.18 not tested.
+
+If anyone owns a board with those chips AND is willing to risk crashing &
+burning an otherwise well-behaved kernel in the name of progress... please
+contact me at <amalysh@web.de> or via the project's mailing list:
+<sensors@stimpy.netroedge.com>.  Please send bug reports and/or success
+stories as well.
+
+
+Thank Yous
+-----------
+Philip Edelbrock <phil@netroedge.com>
+- testing SiS730 support
+Mark M. Hoffman <mhoffman@lightlink.com>
+- bug fixes
+
+To anyone else which I forgot here ;), thanks!
+
diff -Naur a/Documentation/i2c/busses/i2c-sis69x b/Documentation/i2c/busses=
/i2c-sis69x
--- a/Documentation/i2c/busses/i2c-sis69x	1970-01-01 01:00:00.000000000 +01=
00
+++ b/Documentation/i2c/busses/i2c-sis69x	2005-02-05 12:26:11.000000000 +01=
00
@@ -0,0 +1,72 @@
+Kernel driver i2c-sis96x
+
+Replaces 2.4.x i2c-sis645
+
+Supported adapters:
+  * Silicon Integrated Systems Corp (SiS)
+    Any combination of these host bridges:
+	645, 645DX (aka 646), 648, 650, 651, 655, 735, 745, 746
+    and these south bridges:
+    	961, 962, 963(L)
+
+Author: Mark M. Hoffman <mhoffman@lightlink.com>
+
+Description
+-----------
+
+This SMBus only driver is known to work on motherboards with the above nam=
ed
+chipset combinations.  The driver was developed without benefit of a proper
+datasheet from SiS.  The SMBus registers are assumed compatible with those=
 of
+the SiS630, although they are located in a completely different place.  Th=
anks
+to Alexander Malysh <amalysh@web.de> for providing the SiS630 datasheet (a=
nd
+driver).
+
+The command "lspci" as root should produce something like these lines:
+
+00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0645
+00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
+00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
+
+or perhaps this...
+
+00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0645=
 (rev 02)
+00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 0961
+00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
+
+(kernel versions later than 2.4.18 may fill in the "Unknown"s)
+
+If you cant see it  please look on quirk_sis_96x_smbus (drivers/pci/quirks=
.c)
+(also if southbridge detection fails)
+
+I suspect that this driver could be made to work for the following SiS chi=
psets
+as well: 635, and 635T.
+If anyone owns a board with those chips AND is willing to risk crashing &
+burning an otherwise well-behaved kernel in the name of progress... please
+contact me at <mhoffman@lightlink.com> or via the project's mailing list:
+<sensors@stimpy.netroedge.com>.  Please send bug reports and/or success
+stories as well.
+
+
+TO DOs
+-----------
+* The driver does not support SMBus block reads/writes; I may add them if a
+scenario is found where they're needed.
+
+
+Thank Yous
+-----------
+Mark D. Studebaker <mdsxyz123@yahoo.com>
+ - design hints and bug fixes
+Alexander Maylsh <amalysh@web.de>
+ - ditto, plus an important datasheet... almost the one I really wanted
+Hans-G?nter L?tke Uphues <hg_lu@t-online.de>
+ - patch for SiS735
+Robert Zwerus <arzie@dds.nl>
+ - testing for SiS645DX
+Kianusch Sayah Karadji <kianusch@sk-tech.net>
+ - patch for SiS645DX/962
+Ken Healy
+ - patch for Sis655
+
+To anyone else who has written w/ feedback, thanks!
+
diff -Naur a/Documentation/i2c/busses/i2c-stub b/Documentation/i2c/busses/i=
2c-stub
--- a/Documentation/i2c/busses/i2c-stub	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-stub	2005-02-04 22:31:06.000000000 +0100
@@ -0,0 +1,9 @@
+Kernel driver i2c-stub
+
+Author: Mark M. Hoffman <mhoffman@lightlink.com>
+
+Description
+-----------
+
+This module may be useful to developers of SMBus client drivers,
+especially for certain kinds of sensor chips.
diff -Naur a/Documentation/i2c/busses/i2c-via b/Documentation/i2c/busses/i2=
c-via
--- a/Documentation/i2c/busses/i2c-via	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-via	2005-02-04 22:31:19.000000000 +0100
@@ -0,0 +1,41 @@
+Kernel driver i2c-via
+
+Supported adapters:
+  * VIA Technologies, InC. VT82C586B
+    Datasheet: Publicly available at the VIA website
+
+Author: Ky?sti M?lkki <kmalkki@cc.hut.fi>
+
+Description
+-----------
+
+i2c-via is an i2c bus driver for motherboards with VIA chipset.
+
+The following VIA pci chipsets are supported:
+ - MVP3, VP3, VP2/97, VPX/97
+ - others with South bridge VT82C586B
+
+Your /proc/pci or lspci listing must show this :
+
+ Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
+
+To install this driver, simply do
+  # modprobe i2c-via
+
+This driver uses the i2c-algo-bit module which must be
+modprobed and/or enabled in your kernel
+(Character Devices -> I2C Support -> I2C Bit-Banging Interfaces).
+
+    Problems?
+
+ Q: You have VT82C586B on the motherboard, but not in the listing.
+
+ A: Go to your BIOS setup, section PCI devices or similar.
+    Turn USB support on, and try again.
+
+ Q: No error messages, but still i2c doesn't seem to work.
+
+ A: This can happen. This driver uses the pins VIA recommends in their
+    datasheets, but there are several ways the motherboard manufacturer
+    can actually wire the lines.
+
diff -Naur a/Documentation/i2c/busses/i2c-viapro b/Documentation/i2c/busses=
/i2c-viapro
--- a/Documentation/i2c/busses/i2c-viapro	1970-01-01 01:00:00.000000000 +01=
00
+++ b/Documentation/i2c/busses/i2c-viapro	2005-02-04 22:31:36.000000000 +01=
00
@@ -0,0 +1,50 @@
+Kernel driver i2c-viapro
+
+Supported adapters:
+  * VIA Technologies, Inc. VT82C596A/B
+    Datasheet: Sometimes available at the VIA website
+
+  * VIA Technologies, Inc. VT82C686A/B
+    Datasheet: Sometimes available at the VIA website
+
+  * VIA Technologies, Inc. VT8231, VT8233, VT8233A, VT8235, VT8237
+    Datasheet: available on request from Via
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>,
+	Ky?sti M?lkki <kmalkki@cc.hut.fi>,
+	Mark D. Studebaker <mdsxyz123@yahoo.com>
+
+Module Parameters
+-----------------
+
+* force: int
+  Forcibly enable the SMBus controller. DANGEROUS!
+* force_addr: int
+  Forcibly enable the SMBus at the given address. EXTREMELY DANGEROUS!
+
+Description
+-----------
+
+i2c-viapro is a true SMBus host driver for motherboards with one of the
+supported VIA southbridges.
+
+Your /proc/pci or lspci -n listing must show one of these :
+
+ device 1106:3050   (VT82C596 function 3)
+ device 1106:3051   (VT82C596 function 3)
+ device 1106:3057   (VT82C686 function 4)
+ device 1106:3074   (VT8233)
+ device 1106:3147   (VT8233A)
+ device 1106:8235   (VT8231)
+ devide 1106:3177   (VT8235)
+ devide 1106:3227   (VT8237)
+
+If none of these show up, you should look in the BIOS for settings like
+enable ACPI / SMBus or even USB.
+
+To install this driver, simply do
+  # modprobe i2c-viapro
+
+
diff -Naur a/Documentation/i2c/busses/i2c-voodoo3 b/Documentation/i2c/busse=
s/i2c-voodoo3
--- a/Documentation/i2c/busses/i2c-voodoo3	1970-01-01 01:00:00.000000000 +0=
100
+++ b/Documentation/i2c/busses/i2c-voodoo3	2005-02-04 22:31:48.000000000 +0=
100
@@ -0,0 +1,76 @@
+Kernel driver i2c-voodoo3
+
+Supported adapters:
+  * 3dfx Voodoo3 based cards
+  * Voodoo Banshee based cards
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>,
+	Ralph Metzler <rjkm@thp.uni-koeln.de>,
+	Mark D. Studebaker <mdsxyz123@yahoo.com>
+
+Main contact: Philip Edelbrock <phil@netroedge.com>
+
+The code is based upon Ralph's test code (he did the hard stuff ;')
+
+Description
+-----------
+
+The 3dfx Voodoo3 chip contains two I2C interfaces (aka a I2C 'master'
+or 'host').
+
+The first interface is used for DDC (Data Display Channel)
+which is a serial channel through the VGA monitor connector
+to a DDC-compliant monitor. This interface is defined by the
+Video Electronics Standards Association (VESA). The standards
+are available for purchase at http://www.vesa.org .
+
+The second interface is a general-purpose I2C bus.
+The intent by 3dfx was to allow manufacturers to add extra
+chips to the video card such as a TV-out chip such as the BT869 or possibly
+even I2C based temperature sensors like the ADM1021 or LM75.
+
+The 'feature' set of this driver is based on the i2c-piix4 (SMBus)
+features.  I.e., SMBus byte reads and writes, as well as detected faults in
+transmission.  Quick reads/writes, block transactions, word transactions,
+are yet unwritten but are probably not too hard to add.
+
+This driver uses the i2c-algo-bit module which must be
+modprobed and/or enabled in your kernel
+(Character Devices -> I2C Support -> I2C Bit-Banging Interfaces).
+
+Stability
+---------
+Seems to be stable on the test machine, but needs more testing on other
+machines.
+
+Simultaneous accesses of the DDC and I2C busses may cause errors.
+
+
+Supported Devices
+-----------------
+Specifically, this driver was written and tested on the '3dfx Voodoo3 AGP
+3000' which has a tv-out feature (s-video or composite).  According to the
+docs and discussions, this code should work for any Voodoo3 based cards as
+well as Voodoo Banshee based cards.  The DDC interface has been tested
+on a Voodoo Banshee card.
+
+Features
+--------
+This driver controls the I2C controller of the Voodoo3 chip.  'byte read'
+transactions and 'data_byte write' transactions are supported, but all else
+is not (but is probably easy to add if the need arises).
+
+Issues
+------
+Probably many, but it seems to work OK on my system. :')
+
+
+External Device Connection
+--------------------------
+The digital video input jumpers give availability to the I2C bus.
+Specifically, pins 13 and 25 (bottom row middle, and bottom right-end) are
+the I2C clock and I2C data lines, respectively. +5V and GND are probably
+also easily available making the addition of extra I2C/SMBus devices easy
+to implement.
diff -Naur a/Documentation/i2c/busses/scx200_acb b/Documentation/i2c/busses=
/scx200_acb
--- a/Documentation/i2c/busses/scx200_acb	1970-01-01 01:00:00.000000000 +01=
00
+++ b/Documentation/i2c/busses/scx200_acb	2005-02-04 22:32:09.000000000 +01=
00
@@ -0,0 +1,14 @@
+Kernel driver scx200_acb
+
+Author: Christer Weinigel <wingel@nano-system.com>
+
+Module Parameters
+-----------------
+
+* base: int
+  Base addresses for the ACCESS.bus controllers
+
+Description
+-----------
+
+Enable the use of the ACCESS.bus controllers of a SCx200 processor.
diff -Naur a/Documentation/i2c/chips/adm1021 b/Documentation/i2c/chips/adm1=
021
--- a/Documentation/i2c/chips/adm1021	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/adm1021	2005-02-05 12:34:10.000000000 +0100
@@ -0,0 +1,114 @@
+Kernel driver adm1021
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Analog Devices ADM1021
+    Prefix `adm1021'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e (inclusiv=
e)
+    Datasheet: Publicly available at the Analog Devices website
+  * Analog Devices ADM1021A/ADM1023
+    Prefix `adm1023'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e (inclusiv=
e)
+    Datasheet: Publicly available at the Analog Devices website
+  * Genesys Logic GL523SM
+    Prefix `gl523sm'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e (inclusiv=
e)
+    Datasheet:
+  * Intel Xeon Processor
+    Prefix - any other - may require 'force_adm1021' parameter
+    Addresses scanned: none
+    Datasheet: Publicly available at Intel website
+    Status: Alpha, untested.
+  * Maxim MAX1617
+    Prefix `max1617'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e (inclusiv=
e)
+    Datasheet: Publicly available at the Maxim website
+  * Maxim MAX1617A
+    Prefix `max1617a'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e (inclusiv=
e)
+    Datasheet: Publicly available at the Maxim website
+  * National Semiconductor LM84
+    Prefix `lm84'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e (inclusiv=
e)
+    Datasheet: Publicly available at the National Semiconductor website
+  * Philips NE1617
+    Prefix `max1617' (probably detected as a max1617)
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e (inclusiv=
e)
+    Datasheet: Publicly available at the Philips website
+  * Philips NE1617A
+    Prefix `max1617' (probably detected as a max1617)
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e (inclusiv=
e)
+    Datasheet: Publicly available at the Philips website
+  * TI THMC10
+    Prefix `thmc10'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e (inclusiv=
e)
+    Datasheet: Publicly available at the TI website
+  * Onsemi MC1066
+    Prefix `mc1066'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e (inclusiv=
e)
+    Datasheet: Publicly available at the Onsemi website
+
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>
+
+Module Parameters
+-----------------
+
+* read_only: int
+  Don't set any values, read only mode
+
+
+Description
+-----------
+
+The chips supported by this driver are very similar. The Maxim MAX1617
+is the oldest; it has the problem that it is not very well detectable.
+The MAX1617A solves that.  The ADM1021 is a straight clone of the MAX1617A.
+Ditto for the THMC10.
+From here on, we will refer to all these chips as ADM1021-clones.
+
+ADM1021-clones implement two temperature sensors. One of them is internal,
+and measures the temperature of the chip itself; the other is external
+and is realised in the form of a transistor-like device. A special alarm
+indicates whether the remote sensor is connected.
+
+Each sensor has its own low and high limits. When they are crossed, the
+corresponding alarm is set and remains on as long as the temperature stays
+out of range. Temperatures are measured in degrees Celcius. Measurements
+are possible between -65 and +127 degrees, with a resolution of one degree.
+
+The ADM1021 reports a die code, which is a sort of revision code. This
+can help us pinpoint problems; it is not very useful otherwise.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared!
+
+This driver only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values. It is possible to make
+ADM1021-clones do faster measurements, but there is really no good reason
+for that.
+
+
+Xeon support
+------------
+Some Xeon processors have real max1617, adm1021, or compatible chips
+with in them, with two temperature sensors.
+
+Other Xeons have chips with only one sensor.
+
+If you have a Xeon, and the adm1021 module loads, and both
+temperatures appear valid, then things are good.
+
+If the adm1021 module doesn't load, you should try this:
+	modprobe adm1021 force_adm1021=3DBUS,ADDRESS
+	ADDRESS can only be 0x18, 0x1a, 0x29, 0x2b, 0x4c, or 0x4e.
+	See if you have one or two valid temperatures
+
+If you have dual Xeons you may have appear to have two separate
+adm1021-compatible chips, or two single-temperature sensors,
+at distinct addresses.
+
+
diff -Naur a/Documentation/i2c/chips/adm1025 b/Documentation/i2c/chips/adm1=
025
--- a/Documentation/i2c/chips/adm1025	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/adm1025	2005-02-04 23:03:30.000000000 +0100
@@ -0,0 +1,52 @@
+Kernel driver adm1025
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Analog Devices ADM1025, AMD1025A
+    Prefix `adm1025'
+    Addresses scanned: I2C 0x2c - 0x2e (inclusive)
+    Datasheet: Publicly available at the Analog Devices website
+  * Philips NE1619
+    Prefix `ne1619'
+    Addresses scanned: I2C 0x2c - 0x2d (inclusive)
+    Datasheet: Publicly available at the Philips website
+
+The NE1619 presents some differences with the original ADM1025:
+  * Only two possible addresses (0x2c - 0x2d).
+  * No temperature offset register, but we don't use it anyway.
+  * No INT mode for pin 16. We don't play with it anyway.
+
+Authors:
+	Chen-Yuan Wu <gwu@esoft.com>,
+	Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+(This is from Analog Devices.) The ADM1025 is a complete system hardware
+monitor for microprocessor-based systems, providing measurement and limit
+comparison of various system parameters. Five voltage measurement inputs
+are provided, for monitoring +2.5V, +3.3V, +5V and +12V power supplies and
+the processor core voltage. The ADM1025 can monitor a sixth power-supply
+voltage by measuring its own VCC. One input (two pins) is dedicated to a
+remote temperature-sensing diode and an on-chip temperature sensor allows
+ambient temperature to be monitored.
+
+One specificity of this chip is that the pin 11 can be hardwired in two
+different manners. It can act as the +12V power-supply voltage analog
+input, or as the a fifth digital entry for the VID reading (bit 4). It's
+kind of strange since both are useful, and the reason for designing the
+chip that way is obscure at least to me. The bit 5 of the configuration
+register can be used to define how the chip is hardwired. Please note
+that it is not a choice you have to make as the user. The choice was
+already made by your motherboard's maker. If the configuration bit isn't
+set properly, you'll have a wrong +12V reading or a wrong VID reading.
+The way the driver handles that is to preserve this bit through the
+initialization process, assuming that the BIOS set it up properly
+beforehand. If it turns out not to be true in some cases, we'll provide
+a module parameter to force modes.
+
+This driver also supports the ADM1025A, which differs from the ADM1025
+only in that it has "open-drain VID inputs while the ADM1025 has
+on-chip 100k pull-ups on the VID inputs". It doesn't make any
+difference for us.
diff -Naur a/Documentation/i2c/chips/adm1026 b/Documentation/i2c/chips/adm1=
026
--- a/Documentation/i2c/chips/adm1026	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/adm1026	2005-02-04 23:07:21.000000000 +0100
@@ -0,0 +1,103 @@
+Kernel driver adm1026
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Analog Devices ADM1026
+    Prefix `adm1026'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
+Authors:
+	Philip Pokorny <ppokorny@penguincomputing.com> for Penguin Computing
+	Justin Thiessen <jthiessen@penguincomputing.com>
+
+Module Parameters
+-----------------
+
+* gpio_input: int array (min =3D 1, max =3D 17)
+  List of GPIO pins (0-16) to program as inputs
+* gpio_output: int array (min =3D 1, max =3D 17)
+  List of GPIO pins (0-16) to program as outputs
+* gpio_inverted: int array (min =3D 1, max =3D 17)
+  List of GPIO pins (0-16) to program as inverted
+* gpio_normal: int array (min =3D 1, max =3D 17)
+  List of GPIO pins (0-16) to program as normal/non-inverted
+* gpio_fan: int array (min =3D 1, max =3D 8)
+  List of GPIO pins (0-7) to program as fan tachs
+
+
+Description
+-----------
+
+This driver implements support for the Analog Devices ADM1026.  Analog
+Devices calls it a "complete thermal system management controller."
+
+The ADM1026 implements three (3) temperature sensors, 17 voltage
+sensors, 16 general purpose digital I/O lines, eight (8) fan speed
+sensors (8-bit), an analog output and a PWM output along with limit,
+alarm and mask bits for all of the above.  There is even 8k bytes of
+EEPROM memory on chip.
+
+Temperatures are measured in degrees Celcius.  There are two external
+sensor inputs and one internal sensor.  Each sensor has a high and low
+limit.  If the limit is exceeded, an interrupt (#SMBALERT) can be
+generated.  The interrupts can be masked.  In addition, there are
+over-temp limits for each sensor.  If this limit is exceeded, the
+#THERM output will be asserted.  The current temperature and limits
+have a resolution of 1 degree.
+
+FAN rotation speeds are reported in RPM (rotations per minute) but
+measured in counts of a 22.5kHz internal clock.  Each fan has a high
+limit which corresponds to a minimum fan speed.  If the limit is
+exceeded, an interrupt can be generated.  Each fan can be programmed
+to divide the reference clock by 1, 2, 4 or 8.  Not all RPM values can
+accurately be represented, so some rounding is done. With a divider of
+8, the slowest measureable speed of a one pulse per rev fan is 1323
+RPM.  Two pulse per rev fans can be measured as slow as 661 RPM.
+
+Voltage sensors (in0 to in16) report their values in volts.  An alarm
+is triggered if the voltage has crossed a programmable minimum or
+maximum limit.  Note that minimum in this case always means 'closest
+to zero'; this is important for negative voltage measurements.
+Several inputs have integrated attenuators so they can measure higher
+voltages directly.  3.3V, 5V, 12V, -12V and battery voltage all have
+dedicated inputs.  There are several inputs scaled to 0-3V full-scale
+range for SCSI terminator power.  The remaining inputs are not scaled
+and have a 0-2.5V full-scale range.  A 2.5V or 1.82V reference voltage
+is provided for negative voltage measurements.
+
+If an alarm triggers, it will remain triggered until the hardware
+register is read at least once. This means that the cause for the
+alarm may already have disappeared!  Note that in the current
+implementation, all hardware registers are read whenever any data is
+read (unless it is less than 2.0 seconds since the last update). This
+means that you can easily miss once-only alarms.
+
+The ADM1026 measures continuously.  Analog inputs are measured about 4
+times a second.  Fan speed measurement time depends on fan speed and
+divisor.  It can take as long as 1.5 seconds to measure all fan
+speeds.
+
+The ADM1026 has the ability to automaticaly control fan speed based on
+the temperature sensor inputs.  Both the PWM output and the DAC output
+can be used to control fan speed.  Usually only one of these two
+outputs will be used.  Write the minimum PWM or DAC value to the
+appropriate control register.  Then set the low temperature limit in
+the tmin values for each temperature sensor.  The range of control is
+fixed at 20 degC, and the largest difference between current and tmin
+of the temperature sensors sets the control output.  See the datasheet
+for several example circuits for controlling fan speed with the PWM
+and DAC outputs.  The fan speed sensors do not have PWM compensation,
+so it is probably best to control the fan voltage from the power
+lead rather than on the ground lead.
+
+The datasheet shows an example application with VID signals attached
+to GPIO lines.  Unfortunately, the chip may not be connected to the
+VID lines in this way.  The driver assumes that the chips *is*
+connected this way to get a vid voltage.  If the VID value is wrong or
+not wired as shown in the example, then you will need to write the
+correct VID value to the driver either based on the GPIO values or
+setting it directly.  The value written to VID should be the *raw* VID
+value (0 to 0x3f) or -1 (to restore the default value).  When read,
+the vid interface returns the scaled voltage according to the VRM spec
+selected.
+
diff -Naur a/Documentation/i2c/chips/adm1031 b/Documentation/i2c/chips/adm1=
031
--- a/Documentation/i2c/chips/adm1031	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/adm1031	2005-02-04 23:08:37.000000000 +0100
@@ -0,0 +1,37 @@
+Kernel driver adm1031
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Analog Devices ADM1030
+    Prefix: `adm1030'
+    Addresses scanned: I2C 0x2c to 0x2e
+    Datasheet: Publicly available at the Analog Devices website
+               http://products.analog.com/products/info.asp?product=ADM1030
+
+  * Analog Devices ADM1031
+    Prefix: `adm1031'
+    Addresses scanned: I2C 0x2c to 0x2e
+    Datasheet: Publicly available at the Analog Devices website
+               http://products.analog.com/products/info.asp?product=ADM1031
+
+
+Authors:
+	Alexandre d'Alton <alex@alexdalton.org>
+	Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+ADM1030 and ADM1031 are digital temperature sensors and fan controllers.
+They sense their own temperature as well as the temperature of up to one
+(ADM1030) or two (ADM1031) external diodes.
+
+All temperature values are given in degrees Celcius. Resolution
+is 0.5 degree for the local temperature, 0.125 degree for the remote
+temperatures.
+
+Each temperature channel has its own high and low limits, plus a critical
+limit.
+
+The ADM1030 monitors a single fan speed, while the ADM1031 monitors up to
+two. Each fan channel has its own low speed limit.
diff -Naur a/Documentation/i2c/chips/asb100 b/Documentation/i2c/chips/asb100
--- a/Documentation/i2c/chips/asb100	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/asb100	2005-02-04 23:50:36.000000000 +0100
@@ -0,0 +1,72 @@
+Kernel driver asb100
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported Chips:
+  * Asus ASB100 and ASB100-A "Bach"
+    Addresses scanned: I2C 0x2d
+    Datasheet: none released
+
+Author: Mark M. Hoffman <mhoffman@lightlink.com>
+
+Description
+-----------
+
+This driver implements support for the Asus ASB100 and ASB100-A "Bach".  T=
hese
+are custom ASICs available only on Asus mainboards.  Asus refuses to suppl=
y a
+datasheet for these chips. Thanks go to many people who helped investigate
+their hardware, including:
+
+Vitaly V. Bursov
+Alexander van Kaam (author of MBM for Windows)
+Bertrik Sikken
+
+The ASB100 implements seven voltage sensors, three fan rotation speed sens=
ors,
+four temperature sensors, VID lines and alarms.  In addition to these, the
+ASB100-A also implements a single PWM controller for fans 2 and 3 (i.e. one
+setting controls both.)  If you have a plain ASB100, the pwm controller wi=
ll
+simply not work (or maybe it will for you... it doesn't for me).
+
+Temperatures are measured and reported in degrees Celcius.
+
+Fan speeds are reported in RPM (rotations per minute).  An alarm is trigge=
red
+if the rotation speed has dropped below a programmable limit.
+
+Voltage sensors (also known as IN sensors) report values in volts.
+
+The VID lines encode the core voltage value: the voltage level your proces=
sor
+should work with. This is hardcoded by the mainboard and/or processor itse=
lf.
+It is a value in volts.
+
+Alarms: (TODO question marks indicate may or may not work)
+
+0x0001 =3D> in0 (?)
+0x0002 =3D> in1 (?)
+0x0004 =3D> in2
+0x0008 =3D> in3
+0x0010 =3D> temp1 (1)
+0x0020 =3D> temp2
+0x0040 =3D> fan1
+0x0080 =3D> fan2
+0x0100 =3D> in4
+0x0200 =3D> in5 (?) (2)
+0x0400 =3D> in6 (?) (2)
+0x0800 =3D> fan3
+0x1000 =3D> chassis switch
+0x2000 =3D> temp3
+
+Alarm Notes:
+
+(1) This alarm will only trigger if the hysteresis value is 127C.
+I.e. it behaves the same as w83781d.
+
+(2) The min and max registers for these values appear to
+be read-only or otherwise stuck at 0x00.
+
+TODO:
+* Experiment with fan divisors > 8.
+* Experiment with temp. sensor types.
+* Are there really 13 voltage inputs?  Probably not...
+* Fix bogus client deregistration (like w83781d in 2.6).
+* Fix fan divisor / fan minimum interaction (like lm78).
+* Cleanups, no doubt...
+
diff -Naur a/Documentation/i2c/chips/ds1621 b/Documentation/i2c/chips/ds1621
--- a/Documentation/i2c/chips/ds1621	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/ds1621	2005-02-04 23:14:55.000000000 +0100
@@ -0,0 +1,130 @@
+Kernel driver ds1621
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Dallas Semiconductor DS1621
+    Prefix: `ds1621'
+    Addresses scanned: I2C 0x48 - 0x4f (inclusive)
+    Datasheet: Publicly available at the Dallas Semiconductor website
+               http://www.dalsemi.com/
+  * Dallas Semiconductor DS1625
+    Prefix: `ds1621'
+    Addresses scanned: I2C 0x48 - 0x4f (inclusive)
+    Datasheet: Publicly available at the Dallas Semiconductor website
+               http://www.dalsemi.com/
+
+Authors:
+	Christian W. Zuckschwerdt <zany@triq.net>
+	valueable contributions by Jan M. Sendler <sendler@sendler.de>
+	ported to 2.6 by Aurelien Jarno <aurelien@aurel32.net>
+	with the help of Jean Delvare <khali@linux-fr.org>
+
+Module Parameters
+------------------
+
+* polarity int
+  Output's polarity: 0 =3D active high, 1 =3D active low
+
+Description
+-----------
+
+The DS1621 is a (one instance) digital thermometer and thermostat. It
+has both high and low temperature limits which can be user defined
+(i. e. programmed into non-volatile on-chip registers).
+Temperature range is -55 degree Celsius to +125 in 0.5 increments. You
+may convert this into a Fahrenheit range of -67 to +257 degrees with
+0.9 steps. Unfortunally though, you will need a hash table or even a
+conversion routine for that.
+
+Temperature readings are internally converted into a 9bit value to be
+read straight via the i2c-bus, but higher resolutions may be obtained
+with little effort via 'precise_temp' access or using a simple algorithm.
+
+As for the thermostat, behavior can also be programmed using the
+polarity toggle.
+On the one hand ("heater"), the thermostat output of the chip, Tout,
+will trigger when the low limit temperature is met or underrun and
+stays high until the high limit is met or exceeded. On the other hand
+("cooler"), vice versa.
+That way "heater" equals "active low", whereas "conditioner" equals
+"active high". Please note that the DS1621 data sheet is somewhat
+misleading in this point since setting the polarity bit does not
+simply invert Tout.
+
+
+A second thing is that, during extensive testing, Tout showed a
+tolerance of up to +/- 0.5 degrees even when compared against precise
+temperature readings.
+Be sure to have a high vs. low temperature limit gap of al least 1.0
+degree Celsius to avoid Tout "bouncing", though!
+
+As for alarms, you can read the alarm status of the DS1621 via the
+'alarms' proc file interface. The result consits mainly of bit 6 and 5
+of the configuration register of the chip; bit 6 (0x40 or 64) is the
+high alarm bit and bit 5 (0x20 or 32) the low one. These bits are set
+when the high or low limits are met or exceeded and are reset by the
+module as soon as the respective temperature ranges are left.
+
+The alarm registers are in no way suitable to find out about the
+actual status of Tout. They will only tell you about its history,
+whether or not any of the limits have ever been met or exceeded since
+last power-up or reset. Be aware: When testing, it showed that the
+status of Tout can change with neither of the alarms set.
+
+Temperature conversion of the DS1621 takes up to 1000ms; internal
+access to non-volatile registers may last for 10ms or below.
+
+This driver also detects DS1625. As this chip is discontinued, you
+should use a DS1621 instead. Detected 1625s also get the
+"ds1621"-prefix, but the accuracy registers are not supported.
+The latest modification of this driver was not checked against 1625s,
+though, but should work well with them.
+
+Default values written into the DS1621 upon detection are:
+Temperature limits: High 60.0; low 0.0 degree Celsius;
+Continuous mode (not enabled), Tout active high, alarms reset.
+
+High Accuracy Temperature Reading
+---------------------------------
+
+As said before, the temperature issued via the 9bit i2c-bus data is
+somewhat arbitrary. Internally, the temperature conversion is of a
+different kind that is explained (not so...) well in the DS1621 data
+sheet. To cut the long story short: Inside the DS1621 there are two
+oscillators, both of them biassed by a temperature coefficient.
+
+Higher accuracy of the temperature reading can be achieved using the
+internal projection, which means taking account of REG_COUNT and
+REG_SLOPE (the driver manages them):
+
+Taken from Dallas Semiconductors App Note 068: 'Increasing Temperature
+Resolution on the DS1620' and App Note 105: 'High Resolution
+Temperature Measurement with Dallas Direct-to-Digital Temperature
+Sensors'
+
+- Read the 9bit temperature and strip the LSB (Truncate the .5 degs)
+- The resulting value is TEMP_READ.
+- Then, read REG_COUNT.
+- And then, REG_SLOPE.
+
+      TEMP =3D TEMP_READ - 0.25 + ((REG_SLOPE - REG_COUNT) / REG_SLOPE)
+
+Note that this is what the DONE bit in the DS1621 configuration
+register is good for: Internally, one temperature conversion takes up
+to 1000ms. Before that conversion is complete you will not be able to
+read valid things out of REG_COUNT and REG_SLOPE. The DONE bit, as you
+may have guessed by now, tells you whether the conversion is complete
+("done", in plain english) and thus, whether the values you read are
+good or not.
+
+The DS1621 has two modes of operation: "Continuous" conversion, which
+can be understood as the default stand-alone mode where the chip gets
+the temperature and controls external devices via its Tout pin or
+tells other i2c's about it if they care. The other mode is called
+"1SHOT", that means that it only figures out about the temperature
+when it is explicitly told to do so; this can be seen as power saving
+mode.
+
+Now if you want to read REG_COUNT and REG_SLOPE, you have to either
+stop the continuous conversions until the contents of these registers
+are valid, or, in 1SHOT mode, you have to have one conversion made.
diff -Naur a/Documentation/i2c/chips/eeprom b/Documentation/i2c/chips/eeprom
--- a/Documentation/i2c/chips/eeprom	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/eeprom	2005-02-05 12:24:23.000000000 +0100
@@ -0,0 +1,99 @@
+Kernel driver eeprom
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Any EEPROM chip in the designated address range
+    Prefix `eeprom'
+    Addresses scanned: I2C 0x50 - 0x57 (inclusive)
+    Datasheets: Publicly available from:
+                Atmel (www.atmel.com),
+                Catalyst (www.catsemi.com),
+                Fairchild (www.fairchildsemi.com),
+                Microchip (www.microchip.com),
+                Philips (www.semiconductor.philips.com),
+                Rohm (www.rohm.com),
+                ST (www.st.com),
+                Xicor (www.xicor.com),
+                and others.
+
+        Chip     Size (bits)    Address
+        24C01     1K            0x50 (shadows at 0x51 - 0x57)
+        24C01A    1K            0x50 - 0x57 (Typical device on DIMMs)
+        24C02     2K            0x50 - 0x57
+        24C04     4K            0x50, 0x52, 0x54, 0x56
+                                (additional data at 0x51, 0x53, 0x55, 0x57)
+        24C08     8K            0x50, 0x54 (additional data at 0x51, 0x52,
+                                0x53, 0x55, 0x56, 0x57)
+        24C16    16K            0x50 (additional data at 0x51 - 0x57)
+	Sony      2K            0x57
+
+        Atmel     34C02B  2K    0x50 - 0x57, SW write protect at 0x30-37
+        Catalyst  34FC02  2K    0x50 - 0x57, SW write protect at 0x30-37
+        Catalyst  34RC02  2K    0x50 - 0x57, SW write protect at 0x30-37
+        Fairchild 34W02   2K    0x50 - 0x57, SW write protect at 0x30-37
+        Microchip 24AA52  2K    0x50 - 0x57, SW write protect at 0x30-37
+        ST        M34C02  2K    0x50 - 0x57, SW write protect at 0x30-37
+
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>,
+        Jean Delvare <khali@linux-fr.org>,
+	Greg Kroah-Hartman <greg@kroah.com>,
+	IBM Corp.
+
+Description
+-----------
+
+This is a simple EEPROM module meant to enable reading the first 256 bytes
+of an EEPROM (on a SDRAM DIMM for example). However, it will access serial
+EEPROMs on any I2C adapter. The supported devices are generically
+called 24Cxx, and are listed above; however the numbering
+for these industry-standard devices may vary by manufacturer.
+
+This module was a programming exercise to get used to the new project
+organization laid out by Frodo, but it should be at least completely
+effective for decoding the contents of EEPROMs on DIMMs.
+
+DIMMS will typically contain a 24C01A or 24C02, or the 34C02 variants.
+The other devices will not be found on a DIMM because
+they respond to more than one address.
+
+DDC Monitors may contain any device. Often a 24C01, which responds
+to all 8 addresses, is found.
+
+Recent Sony Vaio laptops have an EEPROM at 0x57. We couldn't get the
+specification, so it is guess work and far from being complete.
+
+The Microchip 24AA52/24LCS52, ST M34C02, and others support an additional
+software write protect register at 0x30 - 0x37 (0x20 less than the
+memory location). The chip responds to "write quick" detection at this
+address but does not respond to byte reads.
+If this register is present, the lower 128 bytes of the memory
+array are not write protected. Any byte data write to this address
+will write protect the memory array permanently, and the device
+will no longer respond at the 0x30-37 address.
+The eeprom driver does not support this register.
+
+Lacking functionality:
+
+* Full support for larger devices (24C04, 24C08, 24C16). These are
+not typically found on a PC. These devices will appear as separate
+devices at multiple addresses.
+
+* Support for really large devices (24C32, 24C64, 24C128, 24C256, 24C512).
+These devices require two-byte address fields and are not supported.
+
+* Enable Writing.  Again, no technical reason why not, but making it easy
+to change the contents of the EEPROMs (on DIMMs anyway) also makes it easy
+to disable the DIMMs (potentially preventing the computer from booting)
+until the values are restored somehow.
+
+Use:
+
+After inserting the module (and any other required smbus/i2c modules), you
+should have some EEPROM directories in /sys/bus/i2c/devices of names such
+as "eeprom-i2c-0-50".  Inside each of these is a series of files which
+represent 16 bytes blocks from the EEPROM.  The data is in decimal (base
+10) delimited by spaces.
+
diff -Naur a/Documentation/i2c/chips/fscher b/Documentation/i2c/chips/fscher
--- a/Documentation/i2c/chips/fscher	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/fscher	2005-02-04 23:17:40.000000000 +0100
@@ -0,0 +1,176 @@
+Kernel driver fscher
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Fujitsu-Siemens Hermes chip
+    Prefix `fscher'
+    Addresses scanned: I2C 0x73
+
+Authors:
+	Reinhard Nissl <rnissl@gmx.de> based on work
+	from Hermann Jung <hej@odn.de>,
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>
+
+Description
+-----------
+
+This driver implements support for the Fujitsu-Siemens Hermes chip.
+It is described in the 'Register Set Specification BMC Hermes based
+Systemboard' from Fujitsu-Siemens.
+
+The Hermes chip implements a hardware-based system management,
+e.g. for controlling fan speed and core voltage.
+There is also a watchdog counter on the chip which can trigger
+an alarm and even shut the system down.
+
+The chip provides three temperature values (CPU, motherboard and auxiliary=
),
+three voltage values (+12V, +5V and battery) and three fans (power supply,
+CPU and auxiliary).
+
+Temperatures are measured in degrees Celcius. The resolution is 1 degree.
+
+Fan rotation speeds are reported in RPM (rotations per minute).
+The value can be divided by a programmable divider (1, 2 or 4) which
+is stored on the chip.
+
+Voltage sensors (also known as "in" sensors) report their values in volts.
+
+All values are reported as final values from the driver.
+There is no need for further calculations.
+
+
+Detailed description
+--------------------
+
+Below you'll find a single line description of all the bit values. With th=
is
+information, you're able to decode e. g. alarms, wdog, etc.
+To make use of the watchdog, you'll need to set the watchdog time and enab=
le
+the watchdog. After that it is necessary to restart the watchdog time with=
in
+the specified period of time, or a system reset will occur.
+
+* rev:1
+  READING & 0xff =3D 0x??: HERMES revision identification
+
+* alarms:1
+  READING & 0x80 =3D 0x80: CPU throttling active
+  READING & 0x80 =3D 0x00: CPU running at full speed
+
+  READING & 0x10 =3D 0x10: software event (see control:1)
+  READING & 0x10 =3D 0x00: no software event
+
+  READING & 0x08 =3D 0x08: watchdog event (see wdog:2)
+  READING & 0x08 =3D 0x00: no watchdog event
+
+  READING & 0x02 =3D 0x02: thermal event (see temp*:1)
+  READING & 0x02 =3D 0x00: no thermal event
+
+  READING & 0x01 =3D 0x01: fan event (see fan*:1)
+  READING & 0x01 =3D 0x00: no fan event
+
+  READING & 0x13 ! 0x00: ALERT LED is flashing
+
+* control:1
+  READING & 0x01 =3D 0x01: software event
+  READING & 0x01 =3D 0x00: no software event
+
+  WRITING & 0x01 =3D 0x01: set software event
+  WRITING & 0x01 =3D 0x00: clear software event
+
+* wdog:3
+  READING & 0x80 =3D 0x80: power off on watchdog event while thermal event
+  READING & 0x80 =3D 0x00: watchdog power off disabled (just system reset =
enabled)
+
+  READING & 0x40 =3D 0x40: watchdog timebase 60 seconds (see also wdog:1)
+  READING & 0x40 =3D 0x00: watchdog timebase  2 seconds
+
+  READING & 0x10 =3D 0x10: watchdog enabled
+  READING & 0x10 =3D 0x00: watchdog disabled
+
+  WRITING & 0x80 =3D 0x80: enable "power off on watchdog event while therm=
al event"
+  WRITING & 0x80 =3D 0x00: disable "power off on watchdog event while ther=
mal event"
+
+  WRITING & 0x40 =3D 0x40: set watchdog timebase to 60 seconds
+  WRITING & 0x40 =3D 0x00: set watchdog timebase to  2 seconds
+
+  WRITING & 0x20 =3D 0x20: disable watchdog
+
+  WRITING & 0x10 =3D 0x10: enable watchdog / restart watchdog time
+
+* wdog:2
+  READING & 0x02 =3D 0x02: watchdog system reset occurred
+  READING & 0x02 =3D 0x00: no watchdog system reset occurred
+
+  WRITING & 0x02 =3D 0x02: clear watchdog event
+
+* wdog:1
+  READING & 0xff =3D 0x??: configured watch dog time in units (see wdog:3 =
0x40)
+
+  WRITING & 0xff =3D 0x??: configure watch dog time in units
+
+* in*:1     (0: +5V, 1: +12V, 2: onboard 3V battery)
+  READING: actual voltage value
+
+* temp*:1   (1: CPU sensor, 2: onboard sensor, 3: auxiliary sensor)
+  READING & 0x02 =3D 0x02: thermal event (overtemperature)
+  READING & 0x02 =3D 0x00: no thermal event
+
+  READING & 0x01 =3D 0x01: sensor is working
+  READING & 0x01 =3D 0x00: sensor is faulty
+
+  WRITING & 0x02 =3D 0x02: clear thermal event
+
+* temp*:2   (1: CPU sensor, 2: onboard sensor, 3: auxiliary sensor)
+  READING: actual temperature value
+
+* fan*:1   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
+  READING & 0x04 =3D 0x04: fan event (fan fault)
+  READING & 0x04 =3D 0x00: no fan event
+
+  WRITING & 0x04 =3D 0x04: clear fan event
+
+* fan*:2   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
+  READING & 0x03 =3D 0x03: 8 ripples are one fan turn
+  READING & 0x03 =3D 0x02: 4 ripples are one fan turn
+  READING & 0x03 =3D 0x01: 2 ripples are one fan turn
+
+  WRITING & 0x03 =3D 0x03: set prescaler to "8 ripples are one fan turn"
+  WRITING & 0x03 =3D 0x02: set prescaler to "4 ripples are one fan turn"
+  WRITING & 0x03 =3D 0x01: set prescaler to "2 ripples are one fan turn"
+
+* fan*:3   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
+  READING & 0xff =3D 0x00: fan may be switched off
+  READING & 0xff =3D 0x01: fan must run at least at minimum speed (supply:=
 6V)
+  READING & 0xff =3D 0xff: fan must run at maximum speed (supply: 12V)
+  READING & 0xff =3D 0x??: fan must run at least at given speed (supply: 6=
V..12V)
+
+  WRITING & 0xff =3D 0x00: fan may be switched off
+  WRITING & 0xff =3D 0x01: fan must run at least at minimum speed (supply:=
 6V)
+  WRITING & 0xff =3D 0xff: fan must run at maximum speed (supply: 12V)
+  WRITING & 0xff =3D 0x??: fan must run at least at given speed (supply: 6=
V..12V)
+
+* fan*:4   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
+  READING: actual RPM value
+
+
+Limitations
+-----------
+
+* Measuring fan speed
+It seems that the chip counts "ripples" (typical fans produce 2 ripples per
+rotation while VERAX fans produce 18) in a 9-bit register. This register is
+read out every second, then the ripple prescaler (2, 4 or 8) is applied and
+the result is stored in the 8 bit output register. Due to the limitation of
+the counting register to 9 bits, it is impossible to measure a VERAX fan
+properly (even with a prescaler of 8). At its maximum speed of 3500 RPM the
+fan produces 1080 ripples per second which causes the counting register to
+overflow twice, leading to only 186 RPM.
+
+* Measuring input voltages
+in2 ("battery") reports the voltage of the onboard lithium battery and not
++3.3V from the power supply.
+
+* Undocumented features
+Fujitsu-Siemens Computers has not documented all features of the chip so f=
ar.
+Their software, System Guard, shows that there are a still some features w=
hich
+cannot be controled by this implementation.
diff -Naur a/Documentation/i2c/chips/gl518sm b/Documentation/i2c/chips/gl51=
8sm
--- a/Documentation/i2c/chips/gl518sm	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/gl518sm	2005-02-04 23:20:56.000000000 +0100
@@ -0,0 +1,79 @@
+Kernel driver gl518sm
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Genesys Logic GL518SM release 0x00
+    Prefix `gl518sm'
+    Addresses scanned: I2C 0x2c and 0x2d
+    Datasheet: http://www.genesyslogic.com/pdf
+  * Genesys Logic GL518SM release 0x80
+    Prefix `gl518sm'
+    Addresses scanned: I2C 0x2c and 0x2d
+    Datasheet: http://www.genesyslogic.com/pdf
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+        Ky?sti M?lkki <kmalkki@cc.hut.fi>
+	Hong-Gunn Chew <hglinux@gunnet.org>
+	Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+IMPORTANT: For the revision 0x00 chip, the
+           in0, in1, and in2 values (+5, +3, and +12) CANNOT be read
+           unless you use the slow 'iterate' method. Limits will still
+           work even when iterate=3D0. See below. This is a limitation
+           of the chip, not the driver.
+           Note that the 'iterate' method was trimmed while porting the
+           driver to Linux 2.6 as we considered it too ugly for the thin
+           benefit.
+
+
+This driver supports the Genesys Logic GL518SM chip. There are at least
+two revision of this chip, which we call revision 0x00 and 0x80. Revision
+0x80 chips support the reading of voltages directly, 0x00 only for VIN3.
+
+The GL518SM implements one temperature sensor, two FAN rotation speed
+sensors, and four voltage sensors. It can report alarms through the
+computer speakers.
+
+Temperatures are measured in degrees Celcius. An alarm goes off while the
+temperature is above the over temperature limit, and has not yet dropped
+below the hysteresis limit. The alarm always reflects the current situatio=
n.
+Measurements are guaranteed between -10 degrees and +110 degrees, with
+a resolution of +-3 degrees.
+
+FAN rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit.
+In case when you have selected to turn Fan1 off, no Fan1 alarm is triggere=
d.
+
+FAN readings can be divided by a programmable divider (1, 2, 4 or 8) to gi=
ve
+the readings more range or accuracy. This is important because some FANs
+report only one 'tick' each rotation, while others report two.
+Not all RPM values can accurately be represented, so some rounding is done.
+With a divider of 2, the lowest representable value is around 1900 RPM.
+
+Voltage sensors (also known as VIN sensors) report their values in volts. =
An
+alarm is triggered if the voltage has crossed a programmable minimum or
+maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. The VDD input
+measures voltages between 0.000 and 5.865 volt, with a resolution of 0.023
+volt. The other inputs measure voltages between 0.000 and 4.845 volt, with=
 a
+resolution of 0.019 volt. Note that revision 0x00 chips do not support
+reading the current voltage of any input except for VIN3; limit setting and
+alarms work fine, though. There is code to compute them by iterating.
+
+When an alarm goes off, you can be warned by a beeping signal through
+your computer speaker. It is possible to enable all beeping globally,
+or only the beeping for some alarms.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once (except for temperature alarms). This means that the
+cause for the alarm may already have disappeared!  Note that in the current
+implementation, all hardware registers are read whenever any data is read
+(unless it is less than 1.5 seconds since the last update). This means that
+you can easily miss once-only alarms.
+
+The GL518SM only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
diff -Naur a/Documentation/i2c/chips/it87 b/Documentation/i2c/chips/it87
--- a/Documentation/i2c/chips/it87	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/it87	2005-02-04 23:23:04.000000000 +0100
@@ -0,0 +1,159 @@
+Kernel driver it87
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * IT8705F
+    ISA 0x290
+    Datasheet: Publicly available at the ITE website
+               http://www.ite.com.tw
+  * IT8712F
+    Addresses scanned: I2C 0x20 - 0x2f (inclusive), ISA 0x290 (8 I/O ports)
+    Datasheet: Publicly available at the ITE website
+               http://www.ite.com.tw
+  * Sis950   [clone of IT8705F]
+    ISA 0x290
+    Datasheet: Publicly available at the SIS website
+	Appears to no longer be available on SIS website, found at
+	http://ic.doma.kiev.ua/pdf/chip/sio.htm
+
+Author: Christophe Gauthron <chrisg@0-in.com>
+
+
+Module Parameters
+-----------------
+
+* update_vbat: integer 0 if vbat should report power on value, 1 if
+  vbat should be updated after each read.  Default is 0.
+  On some boards the battery voltage is provided by either the battery or
+  the onboard power supply. Only the first reading at power on will be
+  the actual battery voltage (which the chip does automatically).  On other
+  boards the battery voltage is always fed to the chip so can be read at
+  any time.  Excessive reading may decrease battery life but no information
+  is given in the datasheet.
+
+Description
+-----------
+
+This driver implements support for the IT8705F chip.
+This chip is also known as SIS 950.
+
+This driver also supports IT8712F, which adds SmBus access, and a Vid
+input, used to report the Vcore voltage of the Pentium processor.
+
+These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
+joysticks and other miscellaneous stuff. For hardware monitoring,
+they include an 'environmnent controller' with 3 temperature sensors,
+3 fan rotation speed sensors, 8 voltage sensors, and associated alarms.
+
+Temperatures are measured in degrees Celcius. An alarm is triggered once
+when the Overtemperature Shutdown limit is crossed; it is triggered again
+as soon as it drops below the Hysteresis value.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. This is important because some Fans
+report only one 'tick' each rotation, while others report two - making
+all readings twice as high. Not all RPM values can accurately be represent=
ed,
+so some rounding is done. With a divider of 2, the lowest representable
+value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 4.08 volts, with a resolution
+of 0.016 volt.  The battery voltage in8 does not have limit registers.
+
+The VID lines (IT8712F only) encode the core voltage value: the voltage le=
vel
+your processor should work with. This is hardcoded by the mainboard and/or
+processor itself. It is a value in volts.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared!  Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The IT87xx only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
+
+The sensor type can be set at runtime as of release 2.8.2.
+To change sensor N to a thermistor, 'echo 2 > sensorN'
+where N is 1, 2, or 3.
+To change sensor N to a thermal diode, 'echo 3 > sensorN'.
+Give 0 for unused sensor. Any other value is invalid.
+To configure this at startup, put the following lines in the it87 section
+of /etc/sensors.conf.
+(2 =3D thermistor; 3 =3D thermal diode; 0 =3D unused)
+	set sensor1 3
+	set sensor2 3
+	set sensor3 3
+
+If you set a sensor to 0, you'll also want to ignore its value:
+	ignore tempN
+
+The fan speed control features can be enabled by setting the bits 0-2 of
+the fan_ctl register to 1. (Note: bits 6-4 of this register must be set to
+1 to enable the fan monitoring).
+	0x40 : enable fan speed monitoring for fan3
+	0x20 : enable fan speed monitoring for fan2
+	0x10 : enable fan speed monitoring for fan1
+	0x04 : enable fan smart guardian mode for fan3
+	0x02 : enable fan smart guardian mode for fan2
+	0x01 : enable fan smart guardian mode for fan1
+
+If a fan's smart guardian bit is not set this fan is in on-off mode.
+It can be switched on or off by setting/clearing the corresponding bit 0-2
+of the second fan control register fan_on_off. This register has no effect=
 if
+a fan is in smart guardian mode.
+	0x04 : fan3 is on
+	0x02 : fan2 is on
+	0x01 : fan1 is on
+
+Bit 7 of the pwm[1-3] registers enables/disables the chip's automatic
+temperature control mode for the specified fan. If Bit 7 is set the bits
+1 and 0 encode the number of the temperature sensor used for this feature.
+Possible register values are:
+	0x00-0x7f direct power control for the fan speed
+	0x80  automatic smart guardian mode use temperature sensor 1
+	0x81  automatic smart guardian mode use temperature sensor 2
+	0x82  automatic smart guardian mode use temperature sensor 3
+
+In automatic smart guardian mode pwm values for low, medium and high speed
+can be set in sg_pwm[1-3]. The temperature limits for fan off, low, medium,
+hi speed and over temperature are set in sg_tl[1-3]. While the sensor's
+temperature is between the low and medium speed value the fan will run in
+low speed. When the sensor's temperature is between the medium and high sp=
eed
+value the fan spins in medium speed. When the sensor's temperature is betw=
een
+the high speed and over temperature value the fan spins in high speed.
+If the sensor's temperature is higher than the over temperature limit the
+fan will spin with the highest possible speed.
+
+Example:
+The preconfigured (BIOS set) values of the Shuttle XPC SN41G2 Barebone.
+The MB uses temp2 to monitor the CPU temperature and fan3 as the fan for t=
heir
+special ICE heatpipe cooling system.
+	$ cat fan_ctl
+	116
+	$ cat tan_on_off
+	215
+	$ cat pwm3
+	129
+	$ cat sg_tl3
+	16.0 16.0 48.0 54.0 58.0
+	$ cat sg_pwm3
+	3 4 9
+
+Explanation:
+	fan_ctl -> 116 =3D 0x74 =3D 01110100 : fan monitoring on for all fans,
+		and fan3 is in smart guardian mode.
+	fan_on_off -> 215 =3D 0xd7 =11010111 : all fans are on this setting is
+		ignored for fan3 which is in smart guardian mode
+	pwm3 -> 129 =3D 0x81 =3D 10000001 : fan3 is in automatic mode and uses
+		temp2 for speed control
+	sg_tl3 -> 16.0 16.0 48.0 54.0 58.0 : off, low, med, high, and
+		over temperature limits of fan3
+	sg_pwm3 -> 3 4 9 : pwm values for low, medium and high fan speed of fan3.
+
diff -Naur a/Documentation/i2c/chips/lm63 b/Documentation/i2c/chips/lm63
--- a/Documentation/i2c/chips/lm63	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm63	2005-02-04 23:25:53.000000000 +0100
@@ -0,0 +1,57 @@
+Kernel driver lm63
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM63
+    Prefix: `lm63'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM63.html
+
+Author: Jean Delvare <khali@linux-fr.org>
+
+Thanks go to Tyan and especially Alex Buckingham for setting up a remote
+access to their S4882 test platform for this driver.
+  http://www.tyan.com/
+
+Description
+-----------
+
+The LM63 is a digital temperature sensor with integrated fan monitoring
+and control.
+
+The LM63 is basically an LM86 with fan speed monitoring and control
+capabilities added. It misses some of the LM86 features though:
+ - No low limit for local temperature.
+ - No critical limit for local temperature.
+ - Critical limit for remote temperature can be changed only once. We
+   will consider that the critical limit is read-only.
+
+The datasheet isn't very clear about what the tachometer reading is.
+
+An explanation from National Semiconductor: The two lower bits of the read
+value have to be masked out. The value is still 16 bit in width.
+
+All temperature values are given in degrees Celcius. Resolution is 1.0
+degree for the local temperature, 0.125 degree for the remote temperature.
+
+The fan speed is measured using a tachometer. Contrary to most chips which
+store the value in an 8-bit register and have a selectable clock divider
+to make sure that the result will fit in the register, the LM63 uses 16-bit
+value for measuring the speed of the fan. It can measure fan speeds down to
+83 RPM, at least in theory.
+
+Note that the pin used for fan monitoring is shared with an alert out
+function. Depending on how the board designer wanted to use the chip, fan
+speed monitoring will or will not be possible. The proper chip configurati=
on
+is left to the BIOS, and the driver will blindly trust it.
+
+A PWM output can be used to control the speed of the fan. The LM63 has two
+PWM modes: manual and automatic. Automatic mode is not fully implemented y=
et
+(you cannot define your custom pwm/temperature curve), and mode change isn=
't
+supported either.
+
+The lm63 driver will not update its values more frequently than every
+second; reading them more often will do no harm, but will return 'old'
+values.
+
diff -Naur a/Documentation/i2c/chips/lm75 b/Documentation/i2c/chips/lm75
--- a/Documentation/i2c/chips/lm75	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm75	2005-02-04 23:27:40.000000000 +0100
@@ -0,0 +1,66 @@
+Kernel driver lm75
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * National Semiconductor LM75
+    Prefix: `lm75'
+    Addresses scanned: I2C 0x48 - 0x4f (inclusive)
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com
+  * Dallas Semiconductor DS75
+    Prefix: `lm75'
+    Addresses scanned: I2C 0x48 - 0x4f (inclusive)
+    Datasheet: Publicly available at the Dallas Semiconductor website
+               http://www.dalsemi.com
+  * Dallas Semiconductor DS1775
+    Prefix: `lm75'
+    Addresses scanned: I2C 0x48 - 0x4f (inclusive)
+    Datasheet: Publicly available at the Dallas Semiconductor website
+               http://www.dalsemi.com
+  * Maxim MAX6625, MAX6626
+    Prefix: `lm75'
+    Addresses scanned: I2C 0x48 - 0x4b (inclusive)
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com
+  * Microchip (TelCom) TCN75
+    Prefix: `lm75'
+    Addresses scanned: I2C 0x48 - 0x4f (inclusive)
+    Datasheet: Publicly available at the Microchip website
+               http://www.microchip.com
+
+Author: Frodo Looijaard <frodol@dds.nl>
+
+
+Description
+-----------
+
+The LM75 implements one temperature sensor. Limits can be set through the
+Overtemperature Shutdown register and Hysteresis register. Each value can =
be
+set and read to half-degree accuracy.
+An alarm is issued (usually to a connected LM78) when the temperature
+gets higher then the Overtemperature Shutdown value; it stays on until
+the temperature falls below the Hysteresis value.
+All temperatures are in degrees Celcius, and are guaranteed within a
+range of -55 to +125 degrees.
+
+The LM75 only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
+
+The LM75 is usually used in combination with LM78-like chips, to measure
+the temperature of the processor(s).
+
+The DS75, DS1775, MAX6625, and MAX6626 are supported as well.
+They are not distinguished from an LM75. While most of these chips
+have three additional bits of accuracy (12 vs. 9 for the LM75),
+the additional bits are not supported. Not only that, but these chips will
+not be detected if not in 9-bit precision mode (use the force parameter if
+needed).
+
+The TCN75 is supported as well, and is not distinguished from an LM75.
+
+The LM75 is essentially an industry standard; there may be other
+LM75 clones not listed here, with or without various enhancements,
+that are supported.
+
+The LM77 is not supported, contrary to what we pretended for a long time.
+Both chips are simply not compatible, value encoding differs.
diff -Naur a/Documentation/i2c/chips/lm77 b/Documentation/i2c/chips/lm77
--- a/Documentation/i2c/chips/lm77	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm77	2005-02-04 23:53:06.000000000 +0100
@@ -0,0 +1,23 @@
+Kernel driver lm77
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * National Semiconductor LM77
+    Prefix: `lm75'
+    Addresses scanned: I2C 0x48 - 0x4b (inclusive)
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com
+
+Author: Andras BALI <drewie@freemail.hu>
+
+Description
+-----------
+
+The LM77 implements one temperature sensor.  The temperature
+sensor incorporates a band-gap type temperature sensor,
+10-bit ADC, and a digital comparator with user-programmable upper
+and lower limit values.
+
+Limits can be set through the Overtemperature Shutdown register and
+Hysteresis register.
+
diff -Naur a/Documentation/i2c/chips/lm78 b/Documentation/i2c/chips/lm78
--- a/Documentation/i2c/chips/lm78	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm78	2005-02-04 23:46:30.000000000 +0100
@@ -0,0 +1,81 @@
+Kernel driver lm78
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductors LM78
+    Prefix `lm78'
+    Addresses scanned: I2C 0x20 - 0x2f (inclusive), ISA 0x290 (8 I/O ports)
+    Datasheet: Publicly available at the National Semiconductors website
+  * National Semiconductors LM78-J
+    Prefix `lm78-j'
+    Addresses scanned: I2C 0x20 - 0x2f (inclusive), ISA 0x290 (8 I/O ports)
+    Datasheet: Publicly available at the National Semiconductors website
+  * National Semiconductors LM79
+    Prefix `lm79'
+    Addresses scanned: I2C 0x20 - 0x2f (inclusive), ISA 0x290 (8 I/O ports)
+    Datasheet: Publicly available at the National Semiconductors website
+
+Author: Frodo Looijaard <frodol@dds.nl>
+
+Description
+-----------
+
+This driver implements support for the National Semiconductors LM78, LM78-J
+and LM79. They are described as `Microprocessor System Hardware Monitors'.
+
+There is almost no difference between the three supported chips. Functiona=
lly,
+the LM78 and LM78-J are exactly identical. The LM79 has one more VID line,
+which is used to report the lower voltages newer Pentium processors use.
+From here on, LM7* means either of these three types.
+
+The LM7* implements one temperature sensor, three FAN rotation speed senso=
rs,
+seven voltage sensors, VID lines, alarms, and some miscellaneous stuff.
+
+Temperatures are measured in degrees Celcius. An alarm is triggered once
+when the Overtemperature Shutdown limit is crossed; it is triggered again
+as soon as it drops below the Hysteresis value.  A more useful behaviour
+can be found by setting the Hysteresis value to +127 degrees Celcius; in
+this case, alarms are issued during all the time when the actual temperatu=
re
+is above the Overtemperature Shutdown value. Measurements are guaranteed
+between -55 and +125 degrees, with a resolution of 1 degree.
+
+FAN rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. FAN
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. This is important because some FANs
+report only one 'tick' each rotation, while others report two - making
+all readings twice as high. Not all RPM values can accurately be represent=
ed,
+so some rounding is done. With a divider of 2, the lowest representable
+value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 4.08 volts, with a resolution
+of 0.016 volt.
+
+The VID lines encode the core voltage value: the voltage level your proces=
sor
+should work with. This is hardcoded by the mainboard and/or processor itse=
lf.
+It is a value in volts. When it is unconnected, you will often find the
+value 3.50 V here.
+
+In addition to the alarms described above, there are a couple of additional
+ones. There is a BTI alarm, which gets triggered when an external chip has
+crossed its limits. Usually, this is connected to all LM75 chips; if at
+least one crosses its limits, this bit gets set. The CHAS alarm triggers
+if your computer case is open. The FIFO alarms should never trigger; it
+indicates an internal error. The SMI_IN alarm indicates some other chip
+has triggered an SMI interrupt. As we do not use SMI interrupts at all,
+this condition usually indicates there is a problem with some other
+device.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared!  Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The LM7* only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
diff -Naur a/Documentation/i2c/chips/lm80 b/Documentation/i2c/chips/lm80
--- a/Documentation/i2c/chips/lm80	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm80	2005-02-04 23:54:49.000000000 +0100
@@ -0,0 +1,56 @@
+Kernel driver lm80
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductors LM80
+    Prefix `lm80'
+    Addresses scanned: I2C 0x28 - 0x2f (inclusive)
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>
+
+Description
+-----------
+
+This driver implements support for the National Semiconductors LM80.
+It is descibed as a `Serial Interface ACPI-Compatible Microprocessor
+System Hardware Monitor'.
+
+The LM80 implements one temperature sensor, two FAN rotation speed sensors,
+seven voltage sensors, alarms, and some miscellaneous stuff.
+
+Temperatures are measured in degrees Celcius. There are two sets of limits
+which operate independently. When the HOT Temperature Limit is crossed,
+this will cause an alarm that will be reasserted until the temperature
+drops below the HOT Hysteresis. The Overtemperature Shotdown (OS) limits
+should work in the same way (but this must be checked; the datasheet
+is unclear about this). Measurements are guaranteed between -55 and
++125 degrees. The current temperature measurement has a resolution of
+0.0625 degrees; the limits have a resolution of 1 degree.
+
+FAN rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. FAN
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. This is important because some FANs
+report only one 'tick' each rotation, while others report two - making
+all readings twice as high. Not all RPM values can accurately be represent=
ed,
+so some rounding is done. With a divider of 2, the lowest representable
+value is around 2600 RPM.
+
+Voltage ensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 2.55 volts, with a resolution
+of 0.01 volt.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared!  Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 2.0 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The LM80 only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
diff -Naur a/Documentation/i2c/chips/lm83 b/Documentation/i2c/chips/lm83
--- a/Documentation/i2c/chips/lm83	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm83	2005-02-05 10:12:39.000000000 +0100
@@ -0,0 +1,76 @@
+Kernel driver lm83
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * National Semiconductor LM83
+    Prefix: `lm83'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e (inclusiv=
e)
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM83.html
+
+
+Author: Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+The LM83 is a digital temperature sensor. It senses its own temperature as
+well as the temperature of up to three external diodes. It is compatible
+with many other devices such as the LM84 and all other ADM1021 clones.
+The main difference between the LM83 and the LM84 in that the later can
+only sense the temperature of one external diode.
+
+Using the adm1021 driver for a LM83 should work, but only two temperatures
+will be reported instead of four.
+
+The LM83 is only found on a handful of motherboards. Both a confirmed
+list and an unconfirmed list follow. If you can confirm or infirm the
+fact that any of these motherboards do actually have an LM83, please
+contact us. Note that the LM90 can easily be misdetected as a LM83.
+
+Confirmed motherboards:
+    SBS         P014
+
+Unconfirmed motherboards:
+    Gigabyte    GA-8IK1100
+    Iwill       MPX2
+    Soltek      SL-75DRV5
+
+The driver has been successfully tested by Magnus Forsstr?m, who I'd
+like to thank here. More testers will be of course welcome.
+
+The fact that the LM83 is only scarcely used can be easily explained.
+Most motherboards come with more than just temperature sensors for
+health monitoring. They also have voltage and fan rotation speed
+sensors. This means that temperature-only chips are usually used as
+secondary chips coupled with another chip such as an IT87 or similar
+chip, which provides more features. Since systems usually need three
+temperature sensors (motherboard, processor, power supply) and primary
+chips provide some temperature sensors, the secondary chip, if needed,
+won't have to handle more than two temperatures. Thus, ADM1021 clones
+are sufficent, and there is no need for a four temperatures sensor
+chip such as the LM83. The only case where using an LM83 would make
+sense is on SMP systems, such as the above-mentioned Iwill MPX2,
+because you want an additional temperature sensor for each additional
+CPU.
+
+On the SBS P014, this is different, since the LM83 is the only hardware
+monitoring chipset. One temperature sensor is used for the motherboard
+(actually measuring the LM83's own temperature), one is used for the
+CPU. The two other sensors must be used to measure the temperature of
+two other points of the motherboard. We suspect these points to be the
+north and south bridges, but this couldn't be confirmed.
+
+All temperature values are given in degrees Celcius. Local temperature
+is given within a range of 0 to +85 degrees. Remote temperatures are
+given within a range of 0 to +125 degrees. Resolution is 1.0 degree,
+accuracy is guaranteed to 3.0 degrees (see the datasheet for more
+details).
+
+Each sensor has its own high limit, but the critical limit is common to
+all four sensors. There is no hysteresis mechanism as found on most
+recent temperature sensors.
+
+The lm83 driver will not update its values more frequently than every
+other second; reading them more often will do no harm, but will return
+'old' values.
diff -Naur a/Documentation/i2c/chips/lm85 b/Documentation/i2c/chips/lm85
--- a/Documentation/i2c/chips/lm85	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm85	2005-02-05 10:26:27.000000000 +0100
@@ -0,0 +1,323 @@
+Kernel driver `lm85.o'
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Status: Complete and somewhat tested
+
+Supported chips:
+  * National Semiconductors LM85 (B and C versions)
+    Prefix `lm85'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+  * Analog Devices ADM1027
+    Prefix `adm1027'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+  * Analog Devices ADT7463
+    Prefix 'adt7463'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
+Authors:
+	Philip Pokorny <ppokorny@penguincomputing.com>,
+        Frodo Looijaard <frodol@dds.nl>,
+	Richard Barrington <rich_b_nz@clear.net.nz>,
+	Margit Schubert-While <margitsw@t-online.de>,
+	Justin Thiessen <jthiessen@penguincomputing.com>
+
+Description
+-----------
+
+This driver implements support for the National Semiconductors LM85
+and compatible chips including the Analog Devices ADM1027 and ADT7463.
+
+The LM85 uses the 2-wire interface compatible with the SMBUS 2.0
+specification.  Using an analog to digital converter it measures three
+(3) temperatures and five (5) voltages.  It has four (4) 16-bit
+counters for measuring fan speed.  Five (5) digital inputs are
+provided for sampling the VID signals from the processor to the VRM.
+Lastly, there are three (3) PWM outputs that can be used to control
+fan speed.
+
+The voltage inputs have internal scaling resistors so that the
+following voltage can be measured without external resistors:
+
+   2.5V, 3.3V, 5V, 12V, and CPU core voltage (2.25V)
+
+The temperatures measured are one internal diode, and two remote
+diodes.  Remote 1 is generally the CPU temperature.  These inputs are
+designed to measure a thermal diode like the one in a Pentium 4
+processor in a socket 423 or socket 478 package.  They can also
+measure temperature using a transistor like the 2N3904.
+
+A sophisticated control system for the PWM outputs is designed into
+the LM85 that allows fan speed to be adjusted automatically based on
+any of the three temperature sensors.  Each PWM output is individually
+adjustable and programmable.  Once configured, the LM85 will adjust
+the PWM outputs in response to the measured temperatures without
+further host intervention.  This feature can also be disabled for
+manual control of the PWM's.
+
+Each of the measured inputs (voltage, temperature, fan speed) has
+corresponding high/low limit values.  The LM85 will signal an ALARM if
+any measured value exceeds either limit.
+
+The LM85 samples all inputs continuously.  The lm85 driver will not
+read the lm85 more often than once a second.  Further, configuration
+data is only read once each 5 minutes.  There is twice as much config
+data as measurements, so this would seem to be a worthwhile
+optimization.
+
+Special Features
+
+The LM85 has four fan speed monitoring modes.  The ADM1027 has only
+two.  Both have special circuitry to compensate for PWM interactions
+with the TACH signal from the fans.  The ADM1027 can be configured to
+measure the speed of a two wire fan, but the input conditioning
+circuitry is different for 3-wire and 2-wire mode.  For this reason,
+the 2-wire fan modes are not exposed to user control.  The BIOS should
+initialize them to the correct mode.  If you've designed your own
+ADM1027, you'll have to modify the init_client function and add an
+insmod parameter to set this up.
+
+To smooth the response of fans to changes in temperature, the LM85 has
+an optional filter for smoothing temperatures.  The ADM1027 has the
+same config option but uses it to rate limit the changes to fan speed
+instead.  In libsensors, we associate the smoothing feature with a
+zone in the LM85 and with a PWM in the ADM1027.
+
+The ADM1027 and ADT7463 have a 10-bit ADC and can therefore measure
+temperatures with 0.25 degC resolution.  They also provide an offset to
+the temperature readings that is automatically applied during
+measurement.  This offset can be used to zero out any errors due to
+traces and placement.  The documentation says that the offset is in
+0.25 degC steps, but in initial testing of the ADM1027 it was 1.00
+degC steps.  Analog Devices has confirmed this "bug".  The ADT7463 is
+reported to work as described in the documentation.  Accordingly, the
+driver currently reports 1.00 degC steps for the ADM1027 and 0.25 degC
+steps for the ADT7463.  If you have an ADT7463, please confirm to the
+LM85 maintainer that the temperature offset works as implemented.
+
+The ADT7463 has a THERM asserted counter.  This counter has a 22.76ms
+resolution and a range of 5.8 seconds.  The driver implements a 32-bit
+accumulator of the counter value to extend the range to over a year.
+The counter will stay at it's max value until read.
+
+See the vendor datasheets for more information.  There is application
+note from National (AN-1260) with some additional information about
+the LM85.  The Analog Devices datasheet is very detailed and describes
+a procedure for determining an optimal configuration for the automatic
+PWM control.
+
+Hardware Configurations
+-----------------------
+
+The LM85 can be jumpered for 3 different SMBus addresses.  There are
+no other hardware configuration options for the LM85.
+
+The lm85 driver detects both LM85B and LM85C revisions of the chip.
+See the datasheet for a complete description of the differences.
+Other than identifying the chip, the driver behaves no differently
+with regard to these two chips.  The LM85B is recommended for new
+designs.
+
+The ADM1027 and ADT7463 chips have an optional SMBALERT output that
+can be used to signal the chipset in case a limit is exceeded or the
+temperature sensors fail.  Individual sensor interrupts can be masked
+with 'alarm_mask' so they won't trigger SMBALERT.  The SMBALERT output
+if configured replaces one of the other functions (PWM2 or IN0).  The
+driver will print a message if the BIOS has configured this option
+when the chip is detected.
+
+The ADT7463 also has an optional THERM output/input which can be
+connected to the processor PROC_HOT output.  If available, the autofan
+control dynamic Tmin feature can be enabled to keep the system
+temperature within spec (just?!) with the least possible fan noise.
+
+Configuration Notes
+-------------------
+
+* Temperatures and Zones
+
+Each temperature sensor is associated with a Zone.  There are three
+sensors and therefore three zones.  Each zone has the following
+temperature configuration points:
+
+    Limit temp    -- Temperature at which the fan will turn on
+                     [ absolute deg C from 0.0 to 127.0 ]
+    Hysteresis    -- Degrees below the limit that fan will remain
+                     on before turning off.
+                     [ relative C from 0.0 to -15.0 ]
+    Range         -- Degrees above the limit over which the fan
+                     PWM will be adjusted (from PWM_MIN to 100%)
+                     [ relative deg C from 2.0 to 80.0 ]
+    Critical temp -- Temperature above which other fans will be
+                     forced to 100% PWM
+                     [ absolute deg C from 0.0 to 127.0 ]
+
+** Temperature Range for a Zone
+
+The RANGE value for a given zone can have one of 16 different values
+in an approximately logrithmic spacing:
+Selecting a RANGE not in this list will cause the next larger range to
+be used.
+
+    Temperature ranges:    2.0, 2.5, 3.3, 4.0, 5.0, 6.6, 8.0, 10.0,
+      (in deg C)           13.3, 16.0, 20.0, 26.6, 32.0, 40.0, 53.3,
+                           80.0
+
+* Temperature Smoothing or Acoustic Enhancement
+
+The LM85 and ADM1027 use this value in different ways.  In the LM85
+it's used to filter the temperature input of a zone.  In this way, it
+affects all PWM's controlled by that zone temperature.  In the
+ADM1027, it limits the rate of change in fan speed.  Thus it is part
+of the PWM control algorithm.
+
+    Smooth filter -- Optional filter constant to smooth the system
+		     response to temperature spikes.  It either
+		     filters the measured temperatures or limits the
+		     rate of change of fan speed.  This improves
+		     the system by limiting rapid changes in fan
+		     speed.
+		     [ seconds from 0.8 to 35.0 or 0.0 for OFF ]
+
+The smoothing can be disabled, or enabled and set to one of the values
+listed below.  Selecting a filter time constant not on this list will
+cause the next smaller value to be used.  Setting the time constant to
+0 will disable the filtering.
+
+    Filter time constant:  35.0, 17.6, 11.8, 7.0, 4.4, 3.0, 1.6, 0.8
+      (in seconds)
+
+* PWM Control
+
+There are three PWM outputs.  The LM85 datasheet suggests that the
+PWM3 output control both FAN3 and FAN4.  Each PWM can be individually
+configured and assigned to a zone for it's control value.  Each PWM can be
+configured individually according to the following options.
+
+    Spinup time   -- When turning on a fan that was off, the PWM will
+                     temporarily be set to 100% for this length of
+                     time to insure the fan starts spinning.
+                     [ seconds from 0.0 to 4.0 ]
+    Minimum PWM   -- This is the PWM value at the limit temp of the
+                     referenced zone.
+                     [ PWM value from 0.0 to 255.0 ]
+    Frequency     -- This is the base frequency of the PWM output.
+                     [ Hz from 10.0 to 98.0 ]
+    Min/Off flag  -- This flag determines if the PWM will be off or
+                     "min PWM" below the limit temperature.
+                     [ 0.0 means PWM off (0%) below limit ]
+    Invert flag   -- This flag causes the PWM output to be inverted.
+                     If inverted, a PWM setting of 0 will be full on
+                     and 100 will be off.
+                     [ 0.0 means PWM is "normal" ]
+
+** Spinup Time
+
+Spinup time can be one of eight (8) values.  Selecting a spinup time
+not on this list will result in the next larger spinup time being
+selected.  Note, the value 0.2 actually results in a setting of 0.250
+seconds.
+
+    Spinup Time     0.0, 0.1, 0.2, 0.4, 0.7, 1.0, 2.0, 4.0
+      (in seconds)
+
+** PWM Frequency
+
+The base frequency of the PWM can be controlled.  The frequency can be
+set to one of the following 8 values.  Setting the frequency to a
+value not on this list, will result in the next higher frequency being
+selected.  The actual device frequency may vary slightly from this
+specification as designed by the manufacturer.  Consult the datasheet
+for more details.
+
+    PWM Frequency   10.0, 15.0, 23.0, 30.0, 38.0, 47.0, 62.0, 98.0
+      (in Hz)
+
+** Min/Off Flag
+
+Below the temperature "Limit - Hysteresis" from the controlling zone,
+the PWM can turn off (set to 0) or it can stay at the minimum PWM
+value.  Setting this flag to 1 will cause the PWM value to be the
+"Minimum PWM" value below this limit.  Setting it to 0 will set the
+PWM to 0 (off) below that limit.
+
+NOTE: It has been reported that there is a bug in the LM85 that causes
+the Min/Off flag to be associated with the zones not the PWMs.  This
+contradicts all the published documentation.  Setting pwm#_min_ctl in
+this case actually affects all PWMs controlled by zone '#'.
+
+** Invert Flag
+
+The PWM output can be inverted.  This may be useful if the fan power
+circuitry is inverted. (A low output turns on power and a high output
+turns off power to the fan).  Alternatively, if a slower fan speed is
+needed for higher temperatures, this could be set.
+
+Setting this flag to 1 will invert the PWM output.  A value of 0
+does not invert the PWM output.
+
+* PWM Controlling Zone selection
+
+PWM's can be controlled by zones according to the following
+configuration choices:
+
+   Value     Meaning
+  ------  ------------------------------------------------
+      1    Controlled by Zone 1
+      2    Controlled by Zone 2
+      3    Controlled by Zone 3
+     23    Controlled by higher temp of Zone 2 or 3
+    123    Controlled by highest temp of Zone 1, 2 or 3
+      0    PWM alwasy 0%  (off)
+     -1    PWM always 100%  (full on)
+     -2    Manual control (write to 'pwm#' to set)
+
+These are specified in sensors.conf using 'pwm#_zone'
+
+The National LM85's have two vendor specific configuration
+features.  Tach. mode and Spinup Control.  For more details on these,
+see the LM85 datasheet or Application Note AN-1260.
+
+The Analog Devices ADM1027 has several vendor specific enhancements.
+The number of pulses-per-rev of the fans can be set, Tach monitoring
+can be optimized for PWM operation, and an offset can be applied to
+the temperatures to compensate for systemic errors in the
+measurements.
+
+In addition to the ADM1027 features, the ADT7463 also has Tmin control
+and THERM asserted counts.  Automatic Tmin control acts to adjust the
+Tmin value to maintain the measured temperature sensor at a specified
+temperature.  There isn't much documentation on this feature in the
+ADT7463 data sheet.   The following values control this feature.
+(These are not available via sensors.conf)
+
+    Enable Flag   -- When set to 1, the Tmin control is enabled.  When
+                     set to 0, Tmin will remain unchanged.
+                     [ 1 means Tmin control is enabled ]
+    Control Loop  -- This value sets the cycle time of the control
+                     loop which adjusts the Tmin value.  The mapping
+                     from raw value to loop period is non-linear.
+                     [ Raw value from 0 to 7 (4sec) ]
+    Set on THERM  -- If enabled, this causes the operating point to be
+                     set from the current temperature when THERM is
+                     asserted.  If THERM is connected to a PROC_HOT
+                     signal, this can automatically set the operating
+                     point to the highest value that is within spec.
+                     allowing the lowest/quietest fan speed possible.
+                     [ 1 means set op-point on THERM asserted ]
+    Target Temp   -- This is the target temperature.  Tmin will be
+                     adjusted to keep the measured temperature at this
+                     value.
+                     [ degC -127 to 127 degC ]
+
+The THERM signal monitoring has three parameters:
+
+    THERM Limit   -- How long THERM can be asserted before an ALARM is
+                     triggered.
+                     [ 22.7 ms counts ]
+    THERM Total   -- How long THERM has been asserted since the driver
+                     was loaded.
+                     [ 22.7 ms counts ]
+    Overflows     -- How many times the THERM counter was read with a
+                     max value indicating it overflowed.
+                     [ count ]
+
diff -Naur a/Documentation/i2c/chips/lm87 b/Documentation/i2c/chips/lm87
--- a/Documentation/i2c/chips/lm87	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm87	2005-02-05 10:33:46.000000000 +0100
@@ -0,0 +1,78 @@
+Kernel driver lm87
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Status: Complete and somewhat tested
+
+Supported chips:
+  * National Semiconductors LM87
+    Prefix `lm87'
+    Addresses scanned: I2C 0x2c - 0x2f (inclusive)
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+        Philip Edelbrock <phil@netroedge.com>,
+        Mark Studebaker <mdsxyz123@yahoo.com>,
+        Stephen Rousset <stephen.rousset@rocketlogix.com>,
+	Dan Eaton <dan.eaton@rocketlogix.com>,
+	Jean Delvare <khali@linux-fr.org>,
+	Original 2.6 port Jeff Oliver
+
+Description
+-----------
+
+This driver implements support for the National Semiconductors LM87.
+
+The LM87 implements up to three temperature sensors, up to two FAN
+rotation speed sensors, up to seven voltage sensors, alarms, and some
+miscellaneous stuff.
+
+Temperatures are measured in degrees Celcius. Each input has a high
+and low alarm settings.  A high limit produces an alarm when the value
+goes above it, and an alarm is also produced when the value goes below
+the low limit.
+
+FAN rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. FAN
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. This is important because some FANs
+report only one 'tick' each rotation, while others report two - making
+all readings twice as high. Not all RPM values can accurately be represent=
ed,
+so some rounding is done. With a divider of 2, the lowest representable
+value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in
+volts. An alarm is triggered if the voltage has crossed a programmable
+minimum or maximum limit. Note that minimum in this case always means
+'closest to zero'; this is important for negative voltage
+measurements.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared!  Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 2.0 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The LM87 only updates its values each 1.0 seconds; reading it more
+often will do no harm, but will return 'old' values.
+
+
+Hardware Configurations
+-----------------------
+
+The LM87 has four pins which can serve one of two possible functions,
+depending on the hardware configuration.
+
+Some functions share pins, so not all functions are available at the same
+time. Which are depends on the hardware setup. This driver assumes that
+the BIOS configured the chip correctly. In that respect, it  differs from
+the original driver (from lm_sensors for Linux 2.4), which would force the
+LM87 to an arbitrary, compile-time chosen mode, regardless of the actual
+ chipset wiring.
+
+For reference, here is the list of exclusive functions:
+ - in0+in5 (default) or temp3
+ - fan1 (default) or in6
+ - fan2 (default) or in7
+ - VID lines (default) or IRQ lines (not handled by this driver)
+
diff -Naur a/Documentation/i2c/chips/lm90 b/Documentation/i2c/chips/lm90
--- a/Documentation/i2c/chips/lm90	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm90	2005-02-05 10:43:40.000000000 +0100
@@ -0,0 +1,105 @@
+Kernel driver lm90
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM90
+    Prefix: `lm90'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM90.html
+  * National Semiconductor LM89
+    Prefix: `lm99'
+    Addresses scanned: I2C 0x4c and 0x4d
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM89.html
+  * National Semiconductor LM99
+    Prefix: `lm99'
+    Addresses scanned: I2C 0x4c and 0x4d
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM99.html
+  * National Semiconductor LM86
+    Prefix: `lm86'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM86.html
+  * Analog Devices ADM1032
+    Prefix: `adm1032'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the Analog Devices website
+               http://products.analog.com/products/info.asp?product=ADM1032
+  * Maxim MAX6657
+    Prefix: `max6657'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+  * Maxim MAX6658
+    Prefix: `max6657'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+  * Maxim MAX6659
+    Prefix: `max6657'
+    Addresses scanned: I2C 0x4c (unsupported: 0x4d or 0x4e)
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+
+
+Author: Jean Delvare <khali@linux-fr.org>
+
+
+Description
+-----------
+
+The LM90 is a digital temperature sensor. It senses its own temperature as
+well as the temperature of up to one external diode. It is compatible
+with many other devices such as the LM86, the LM89, the LM99, the ADM1032,
+the MAX6657, MAX6658 and the MAX6659 all of which are supported by this dr=
iver.
+Note that there is no easy way to differenciate between the last three
+variants. The extra address and features of the MAX6659 are not supported =
by
+this driver.
+
+The specificity of this family of chipsets over the ADM1021/LM84
+family is that it features critical limits with hysteresis, and an
+increased resolution of the remote temperature measurement.
+
+The different chipsets of the family are not strictly identical, although
+very similar. This driver doesn't handle any specific feature for now,
+but could if there ever was a need for it. For reference, here comes a
+non-exhaustive list of specific features:
+
+LM90:
+  * Filter and alert configuration register at 0xBF.
+  * ALERT is triggered by temperatures over critical limits.
+
+LM86 and LM89:
+  * Same as LM90
+  * Better external channel accuracy
+
+LM99:
+  * Same as LM89
+  * External temperature shifted by 16 degrees down
+
+ADM1032:
+  * Consecutive alert register at 0x22.
+  * Conversion averaging.
+  * Up to 64 conversions/s.
+  * ALERT is triggered by open remote sensor.
+
+MAX6657 and MAX6658:
+  * Remote sensor type selecion
+
+All temperature values are given in degrees Celcius. Resolution
+is 1.0 degree for the local temperature, 0.125 degree for the remote
+temperature.
+
+Each sensor has its own high and low limits, plus a critical limit.
+Additionally, there is a relative hysteresis value common to both critical
+values. To make life easier to user-space applications, two absolute values
+are exported, one for each channel, but these values are of course linked.
+Only the local hysteresis can be set from user-space, and the same delta
+applies to the remote hysteresis.
+
+The lm90 driver will not update its values more frequently than every
+other second; reading them more often will do no harm, but will return
+'old' values.
+
diff -Naur a/Documentation/i2c/chips/max1619 b/Documentation/i2c/chips/max1=
619
--- a/Documentation/i2c/chips/max1619	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/max1619	2005-02-05 10:44:59.000000000 +0100
@@ -0,0 +1,29 @@
+Kernel driver max1619
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Maxim MAX1619
+    Prefix: `max1619'
+    Addresses scanned: I2C 0x18-0x1a, 0x29-0x2b, 0x4c-0x4e (inclusive)
+    Datasheet: Publicly available at the Maxim website
+               http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
+
+Authors:
+	Alexey Fisher <fishor@mail.ru>,
+	Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+The MAX1619 is a digital temperature sensor. It senses its own temperature=
 as
+well as the temperature of up to one external diode.
+
+All temperature values are given in degrees Celcius. Resolution
+is 1.0 degree for the local temperature and for the remote temperature.
+
+Only the external sensor has high and low limits.
+
+The max1619 driver will not update its values more frequently than every
+other second; reading them more often will do no harm, but will return
+'old' values.
+
diff -Naur a/Documentation/i2c/chips/pcf8574 b/Documentation/i2c/chips/pcf8=
574
--- a/Documentation/i2c/chips/pcf8574	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/pcf8574	2005-02-05 11:55:59.000000000 +0100
@@ -0,0 +1,75 @@
+Kernel driver pcf8574
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Philips PCF8574
+    Prefix: `pcf8574'
+    Addresses scanned: I2C 0x20 - 0x27 (inclusive)
+    Datasheet: Publicly available at the Philips Semiconductors website
+               http://semiconductors.philips.com/
+
+ * Philips PCF8574A
+    Prefix: `pcf8574a'
+    Addresses scanned: I2C 0x38 - 0x3f (inclusive)
+    Datasheet: Publicly available at the Philips Semiconductors website
+               http://semiconductors.philips.com/
+
+Authors: Frodo Looijaard <frodol@dds.nl>,
+         Philip Edelbrock <phil@netroedge.com>,
+         Dan Eaton <dan.eaton@rocketlogix.com>,
+	 Aurelien Jarno <aurel32@debian.org>,
+	 Jean Delvare <khali@linux-fr.org>,
+
+Module Parameters
+-----------------
+
+* force: short array (min =3D 1, max =3D 48)
+  List of adapter,address pairs to boldly assume to be present
+
+
+Description
+-----------
+The PCF8574(A) is an 8-bit I/O expander for the I2C bus produced by Philips
+Semiconductors. It is designed to provide a byte I2C interface to up to 16
+separate devices (8 x PCF8574 and 8 x PCF8574A).
+
+This device consists of a quasi-bidirectionnal port. Each of the eight I/Os
+can be independently used as an input or output. To setup an I/O as an
+input, you have to write a 1 to the corresponding output.
+
+For more informations see the datasheet.
+
+
+Accessing PCF8574(A) via /sys interface
+-------------------------------------
+
+! Be careful !
+The PCF8574(A) is plainly impossible to detect ! Stupid chip.
+So every chip with adress in the interval [20..27] and (38..3f) are
+detected as PCF8574(A). If you have other chips in this address
+range, the workaround is to load this module after the one
+for your others chips.
+
+On detection (i.e. insmod, modprobe et al.), directories are being
+created for each detected PCF8574(A):
+
+/sys/bus/i2c/devices/<0>-<1>/
+where <0> is the bus the chip was detected on (e. g. i2c-0)
+and <1> the chip address ([20..27] or [38..3f]):
+
+(example: /sys/bus/i2c/devices/1-0020/)
+
+Inside these directories, there are two files each:
+read and write. (and one file with chip name)
+
+The read file is read-only. Reading gives you the current I/O input
+if the corresponding output is set as 1, otherwise the current output
+value, that is to say 0.
+
+The write file is read/write. Writing a value outputs it on the I/O
+port. Reading return the last written value.
+
+On module initialization the chip is configured as eight I/Os input (all
+outputs to 1), so you can connect any circuit to the PCF8574(A) without
+to be afraid of short-circuit.
+
diff -Naur a/Documentation/i2c/chips/pcf8591 b/Documentation/i2c/chips/pcf8=
591
--- a/Documentation/i2c/chips/pcf8591	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/pcf8591	2005-02-05 12:01:45.000000000 +0100
@@ -0,0 +1,94 @@
+Kernel driver pcf8591
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Philips PCF8591
+    Prefix: `pcf8591'
+    Addresses scanned: I2C 0x48 - 0x4f (inclusive)
+    Datasheet: Publicly available at the Philips Semiconductor website
+               http://semiconductors.philips.com/
+
+Authors:
+	Aurelien Jarno <aurelien@aurel32.net>
+	valuable contributions by Jan M. Sendler <sendler@sendler.de>,
+	Jean Delvare <khali@linux-fr.org>
+
+
+Description
+-----------
+The PCF8591 is an 8-bit A/D and D/A converter (4 analog input and one
+analog ouput) for the I2C bus produced by Philips Semiconductors. It
+is designed to provide a byte I2C interface to up to 4 separate devices.
+
+The PCF8591 has 4 analog inputs programmable as single-ended or
+differential inputs :
+- mode 0 : four single ended inputs
+        Pins AIN0 to AIN3 are single ended inputs for channels 0 to 3
+
+- mode 1 : three differential inputs
+        Pins AIN3 is the common negative differential input
+        Pins AIN0 to AIN2 are positive differential inputs for channels 0 =
to 2
+
+- mode 2 : single ended and differential mixed
+        Pins AIN0 and AIN1 are single ended inputs for channels 0 and 1
+        Pins AIN2 is the positive differential input for channel 3
+        Pins AIN3 is the negative differential input for channel 3
+
+- mode 3 : four differential inputs
+        Pins AIN0 is the positive differential input for channel 0
+        Pins AIN1 is the negative differential input for channel 0
+        Pins AIN2 is the positive differential input for channel 1
+        Pins AIN3 is the negative differential input for channel 1
+
+For more informations see the datasheet.
+
+Module parameters
+-----------------
+
+* force: short array (min =3D 1, max =3D 48)
+  List of adapter,address pairs to boldly assume to be present
+
+* input_mode int
+
+    Analog input mode:
+         0 =3D four single ended inputs
+         1 =3D three differential inputs
+         2 =3D single ended and differential mixed
+         3 =3D two differential inputs
+
+
+Accessing PCF8591 via /sys interface
+-------------------------------------
+
+! Be careful !
+The PCF8591 is plainly impossible to detect ! Stupid chip.
+So every chip with adress in the interval [48..4f] are
+detected as PCF8591. If you have other chips in this address
+range, the workaround is to load this module after the one
+for your others chips.
+
+On detection (i.e. insmod, modprobe et al.), directories are being
+created for each detected PCF8591:
+
+/sys/bus/devices/<0>-<1>/
+where <0> is the bus the chip was detected on (e. g. i2c-0)
+and <1> the chip address ([48..4f])
+
+Inside these directories, there are such files:
+in0, in1, in2, in3, out0_enable, out0_output, name
+
+Name contains chip name.
+
+The in0, in1, in2 and in3 files are ro. Reading gives the value
+of the corresponding channel. Depending on the current analog inputs
+configuration, channel in2 and/or in3 may are not used by the chip
+and so read as 0. Values range are from 0 to 255 for single
+ended inputs and -128 to +127 for differential inputs (8-bit ADC).
+
+The out0_enable is rw. Reading gives "0" for analog output enabled and
+"1" for analog output disabled. Writing accepts "0" and "1" accordingly.
+
+The out0_output is rw. Writing a number between 0 and 255 (8-bit DAC), send
+the value to the digital-to-analog converter. Note that a voltage will
+only appears on AOUT pin if aout_enable equals 1. Reading return the last
+value written.
diff -Naur a/Documentation/i2c/chips/pc87360 b/Documentation/i2c/chips/pc87=
360
--- a/Documentation/i2c/chips/pc87360	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/pc87360	2005-02-05 10:49:01.000000000 +0100
@@ -0,0 +1,191 @@
+Kernel driver pc87360
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * National Semiconductor PC87360, PC87363, PC87364, PC87365 and PC87366
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheets:
+	http://www.national.com/pf/PC/PC87360.html
+	http://www.national.com/pf/PC/PC87363.html
+	http://www.national.com/pf/PC/PC87364.html
+	http://www.national.com/pf/PC/PC87365.html
+	http://www.national.com/pf/PC/PC87366.html
+
+Authors: Jean Delvare <khali@linux-fr.org>
+
+Thanks to Sandeep Mehta, Tonko de Rooy and Daniel Ceregatti for testing.
+Thanks to Rudolf Marek for helping me investigate conversion issues.
+
+
+Module Parameters
+-----------------
+
+* init int
+  Chip initialization level:
+   0: None
+  *1: Forcibly enable internal voltage and temperature channels, except in9
+   2: Forcibly enable all voltage and temperature channels, except in9
+   3: Forcibly enable all voltage and temperature channels, including in9
+
+Note that this parameter has no effect for the PC87360, PC87363 and PC87364
+chips.
+
+Also note that for the PC87366, initialization levels 2 and 3 don't enable
+all temperature channels, because some of them share pins with each other,
+so they can't be used at the same time.
+
+
+Description
+-----------
+
+The National Semiconductor PC87360 Super I/O chip contains monitoring and
+PWM control circuitry for two fans. The PC87363 chip is similar, and the
+PC87364 chip has monitoring and PWM control for a third fan.
+
+The National Semiconductor PC87365 and PC87366 Super I/O chips are complete
+hardware monitoring chipsets, not only controling and monitoring three fan=
s,
+but also monitoring eleven voltage inputs and two (PC87365) or six
+(PC87366) remote temperatures.
+
+  Chip        #vin    #fan    #pwm    #temp   devid
+
+  PC87360     -       2       2       -       0xE1
+  PC87363     -       2       2       -       0xE8
+  PC87364     -       3       3       -       0xE4
+  PC87365     11      3       3       2       0xE5
+  PC87366     11      3       3       3-4     0xE9
+
+The driver assumes that no more than one chip is present, and the standard
+Super I/O address is used (0x2E/0x2F).
+
+
+Fan Monitoring
+--------------
+
+Fan rotation speeds are reported in RPM (revolutions per minute). An alarm
+is triggered if the rotation speed has dropped below a programmable limit.
+A different alarm is triggered if the fan speed is too low to be measured.
+It is suggested to increase the fan divider (which is really a clock
+divider) in this case.
+
+Fan readings are affected by a programmable clock divider, giving the
+readings more range or accuracy. Usually, users have to learn how it works,
+but this driver implements dynamic clock divider selection, so you don't
+have to care no more.
+
+For reference, here are a few values about clock dividers:
+
+                slowest         accuracy        highest
+                measurable      around 3000     accurate
+    divider     speed (RPM)     RPM (RPM)       speed (RPM)
+         1        1882              18           6928
+         2         941              37           4898
+         4         470              74           3464
+         8         235             150           2449
+
+For the curious, here is how the values above were computed:
+ * slowest measurable speed: clock/(255*divider)
+ * accuracy around 3000 RPM: 3000^2/clock
+ * highest accurate speed: sqrt(clock*100)
+The clock speed for the PC87360 family is 480 kHz. I arbitrarily chose 100
+RPM as the lowest acceptable accuracy.
+
+As mentioned above, you don't have to care about this no more.
+
+Note that not all RPM values can be represented, even when the best clock
+divider is selected. This is not only true for the measured speeds, but
+also for the programmable low limits, so don't be surprised if you try to
+set, say, fan1_min to 2900 and it finaly reads 2909.
+
+
+Fan Control
+-----------
+
+PWM (pulse width modulation) values range from 0 to 255, with 0 meaning
+that the fan is stopped, and 255 meaning that the fan goes at full speed.
+
+Be extremely careful when changing PWM values. Low PWM values, even
+non-zero, can stop the fan, which may cause irreversible damage to your
+hardware if temperature increases too much. When changing PWM values, go
+step by step and keep an eye on temperatures.
+
+One user reported problems with PWM. Changing PWM values would break fan
+speed readings. No explanation nor fix could be found.
+
+
+Temperature Monitoring
+----------------------
+
+Temperatures are reported in degrees Celcius. Each temperature measured has
+associated low, high and overtemperature limits, each of which triggers an
+alarm when crossed.
+
+The first two temperature channels are external. The third one (PC87366
+only) is internal.
+
+The PC87366 has three additional temperature channels, based on
+thermistors (as opposed to thermal diodes for the first three temperature
+channels). For technical reasons, these channels are held by the VLM
+(voltage level monitor) logical device, not the TMS (temperature
+measurement) one. As a consequence, these temperatures are exported as
+voltages, and converted into temperatures in user-space.
+
+Note that these three additional channels share their pins with the
+external thermal diode channels, so you (physically) can't use them all at
+the same time. Although it should be possible to mix the two sensor types,
+the documents from National Semiconductor suggest that motherboard
+manufacturers should choose one type and stick to it. So you will more
+likely have either channels 1 to 3 (thermal diodes) or 3 to 6 (internal
+thermal diode, and thermistors).
+
+
+Voltage Monitoring
+------------------
+
+Voltages are reported relatively to a reference voltage, either internal or
+external. Some of them (in7:Vsb, in8:Vdd and in10:AVdd) are divided by two
+internally, you will have to compensate in sensors.conf. Others (in0 to in=
6)
+are likely to be divided externally. The meaning of each of these inputs as
+well as the values of the resistors used for division is left to the
+motherboard manufacturers, so you will have to document yourself and edit
+sensors.conf accordingly. National Semiconductor has a document with
+recommended resistor values for some voltages, but this still leaves much
+room for per motherboard specificities, unfortunately. Even worse,
+motherboard manufacturers don't seem to care about National Semiconductor's
+recommendations.
+
+Each voltage measured has associated low and high limit, each of which
+triggers an alarm when crossed.
+
+When available, VID inputs are used to provide the nominal CPU Core voltag=
e.
+The driver will default to VRM 9.0, but this can be changed from user-spac=
e.
+The chipsets can handle two sets of VID inputs (on dual-CPU systems), but
+the driver will only export one for now. This may change later if there is
+a need.
+
+
+General Remarks
+---------------
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may already
+have disappeared! Note that all hardware registers are read whenever any
+data is read (unless it is less than 2 seconds since the last update, in
+which case cached values are returned instead). As a consequence, when
+a once-only alarm triggers, it may take 2 seconds for it to show, and 2
+more seconds for it to disappear.
+
+Monitoring of in9 isn't enabled at lower init levels (<3) because that
+channel measures the battery voltage (Vbat). It is a known fact that
+repeatedly sampling the battery voltage reduces its lifetime. National
+Semiconductor smartly designed their chipset so that in9 is sampled only
+once every 1024 sampling cycles (that is every 34 minutes at the default
+sampling rate), so the effect is attenuated, but still present.
+
+
+Limitations
+-----------
+
+The datasheets suggests that some values (fan mins, fan dividers)
+shouldn't be changed once the monitoring has started, but we ignore that
+recommendation. We'll reconsider if it actually causes trouble.
diff -Naur a/Documentation/i2c/chips/smsc47m1 b/Documentation/i2c/chips/sms=
c47m1
--- a/Documentation/i2c/chips/smsc47m1	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/smsc47m1	2005-02-05 12:23:58.000000000 +0100
@@ -0,0 +1,53 @@
+Kernel driver smsc47m1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Status: Beta.
+
+Supported chips:
+  * SMSC 47B27x and 47M1xx Super I/O Controllers
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheets:
+	http://www.smsc.com/main/datasheets/47b27x.pdf
+	http://www.smsc.com/main/datasheets/47m10x.pdf
+	http://www.smsc.com/main/datasheets/47m13x.pdf
+	http://www.smsc.com/main/datasheets/47m14x.pdf
+
+Authors:
+	Mark D. Studebaker <mdsxyz123@yahoo.com>,
+	With assistance from Bruce Allen <ballen@uwm.edu>, and his
+	fan.c program: http://www.lsc-group.phys.uwm.edu/%7Eballen/driver/
+	Gabriele Gorla <gorlik@yahoo.com>,
+	Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+The Standard Microsystems Corporation (SMSC) 47M1xx Super I/O chips
+contain monitoring and PWM control circuitry for two fans.
+
+The 47M15x and 47M192 chips contain a full 'hardware monitoring block'
+in addition to the fan monitoring and control. The hardware monitoring
+block is not yet supported by the driver.
+
+FAN rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. FAN
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. This is important because some FANs
+report only one 'tick' each rotation, while others report two - making
+all readings twice as high. Not all RPM values can accurately be represent=
ed,
+so some rounding is done. With a divider of 2, the lowest representable
+value is around 2600 RPM.
+
+PWM values are from 0 to 255.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared!  Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+
+**********************
+The lm_sensors project gratefully acknowledges the support of
+Intel in the development of this driver.
diff -Naur a/Documentation/i2c/chips/via686a b/Documentation/i2c/chips/via6=
86a
--- a/Documentation/i2c/chips/via686a	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/via686a	2005-02-05 10:54:16.000000000 +0100
@@ -0,0 +1,72 @@
+Kernel driver via686a
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Via VT82C686A, VT82C686B  Southbridge Integrated Hardware Monitor
+    Prefix: via686a
+    Addresses scanned: ISA in PCI-space encoded address
+    Datasheet: Sometimes available at the Via site http://www.via.com.tw.
+
+Authors: Ky?sti M?lkki <kmalkki@cc.hut.fi>,
+         Mark D. Studebaker <mdsxyz123@yahoo.com>
+	 Bob Dougherty <bobd@stanford.edu>
+    	 (Some conversion-factor data were contributed by
+	 Jonathan Teh Soon Yew <j.teh@iname.com> and Alex van Kaam <darkside@chel=
lo.nl>.)
+
+Module Parameters
+-----------------
+
+force_addr=3D0xaddr	Set the I/O base address. Useful for Asus A7V boards
+			that don't set the address in the BIOS. Does not do a
+			PCI force; the via686a must still be present in lspci.
+			Don't use this unless the driver complains that the
+			base address is not set.
+			Example: 'modprobe via686a force_addr=3D0x6000'
+
+Description
+-----------
+
+The driver does not distinguish between the chips and reports
+all as a 686A.
+
+The Via 686a southbridge has integrated hardware monitor functionality.
+It also has an I2C bus, but this driver only supports the hardware monitor.
+For the I2C bus driver, see ../busses/i2c-viapro.
+
+The Via 686a implements three temperature sensors, two FAN rotation speed
+sensors, five voltage sensors and alarms.
+
+Temperatures are measured in degrees Celcius. An alarm is triggered once
+when the Overtemperature Shutdown limit is crossed; it is triggered again
+as soon as it drops below the hysteresis value.  A more useful behaviour
+can be found by setting the hysteresis value to +127 degrees Celcius; in
+this case, alarms are issued during all the time when the actual temperatu=
re
+is above the Overtemperature Shutdown value. Measurements are guaranteed
+between -55 and +125 degrees, with a resolution of 1 degree.
+
+FAN rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. FAN
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. This is important because some FANs
+report only one 'tick' each rotation, while others report two - making
+all readings twice as high. Not all RPM values can accurately be represent=
ed,
+so some rounding is done. With a divider of 2, the lowest representable
+value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 4.08 volts, with a resolution
+of 0.016 volt.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared!  Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The driver only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
+
diff -Naur a/Documentation/i2c/chips/w83l785ts b/Documentation/i2c/chips/w8=
3l785ts
--- a/Documentation/i2c/chips/w83l785ts	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/w83l785ts	2005-02-05 11:03:41.000000000 +0100
@@ -0,0 +1,42 @@
+Kernel driver w83l785ts
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Winbond W83L785TS-S
+    Prefix: `w83l785ts'
+    Addresses scanned: I2C 0x2e
+    Datasheet: Publicly available at the Winbond USA website
+               http://www.winbond-usa.com/products/winbond_products/pdfs/P=
CIC/W83L785TS-S.pdf
+
+
+Authors:
+	Jean Delvare <khali@linux-fr.org>,
+	Wolfgang Ziegler <nuppla@gmx.at>
+
+Description
+-----------
+
+The W83L785TS-S is a digital temperature sensor. It senses the
+temperature of a single external diode. The high limit is
+theoretically defined as 85 or 100 degrees C through a combination
+of external resistors, so the user cannot change it. Values seen so
+far suggest that the two possible limits are actually 95 and 110
+degrees C. The datasheet is rather poor and obviously inaccurate
+on several points including this one.
+
+All temperature values are given in degrees Celcius. Resolution
+is 1.0 degree. See the datasheet for details.
+
+The w83l785ts driver will not update its values more frequently than
+every other second; reading them more often will do no harm, but will
+return 'old' values.
+
+Known Issues
+------------
+
+On some systems (Asus), the BIOS is known to interfere with the driver
+and cause read errors. The driver will retry a given number of times
+(5 by default) and then give up, returning the old value (or 0 if
+there is no old value). It seems to work well enough so that you should
+not notice anything. Thanks to James Bolt for helping test this feature.
+
diff -Naur a/Documentation/i2c/chips/w83627hf b/Documentation/i2c/chips/w83=
627hf
--- a/Documentation/i2c/chips/w83627hf	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/w83627hf	2005-02-05 11:07:23.000000000 +0100
@@ -0,0 +1,72 @@
+Kernel driver w83627hf
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Winbond W83627HF (ISA accesses ONLY)
+    Prefix 'w83627hf'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: Publicly available at the Winbond website
+  * Winbond W83627THF (ISA accesses ONLY)
+    Prefix 'w83627thf'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: Publicly available at the Winbond website
+  * Winbond W83697HF (ISA accesses ONLY)
+    Prefix 'w83697hf'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: Publicly available at the Winbond website
+  * Winbond W83637HF (ISA accesses ONLY)
+    Prefix 'w83637hf'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: Publicly available at the Winbond website
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>,
+        Mark Studebaker <mdsxyz123@yahoo.com>,
+	Bernhard C. Schrenk <clemy@clemy.org>
+
+Module Parameters
+-----------------
+
+* force_addr: int
+  Program the Super I/O register for the sensors ISA base address
+* force_i2c: int
+  Program the Super I/O register for the i2c address of the sensors
+* init=3D[0,1] (default 1)
+  Use 'init=3D0' to bypass initializing the chip.
+  Try this if your computer crashes when you load the module.
+
+Description
+-----------
+
+This driver implements support for ISA accesses *only* for
+the Winbond W83627HF, W83627THF, W83697HF and W83637HF Super I/O chips.
+We will refer to them collectively as Winbond chips.
+
+This driver supports ISA accesses, which should be more reliable
+than i2c accesses. Also, for Tyan boards which contain both a
+Super I/O chip and a second i2c-only Winbond chip (often a W83782D),
+using this driver will avoid i2c address conflicts and complex
+initialization that were required in the w83781d driver
+(lm_sensors releases 2.7.0 and earlier).
+
+If you really want i2c accesses for these Super I/O chips,
+use the w83781d driver. However this is not the preferred method
+now that this ISA driver has been developed.
+
+Technically, the w83627thf does not support a VID reading.  However, it's
+possible or even likely that your mainboard maker has routed these signals
+to a specific set of general purpose IO pins (the Asus P4C800-E is one such
+board).  The w83627thf driver now interprets these as VID.  If the VID on
+your board doesn't work, first see doc/vid in the lm_sensors package.  If
+that still doesn't help, email us at sensors@stimpy.netroedge.com.
+
+For further information on this driver, /proc values, etc.
+see the w83781d driver documentation.
+
+
+Author/Maintainer
+-----------------
+Mark D. Studebaker (mdsxyz123@yahoo.com).
+Derived from the w83781d driver.
+Send requests to the sensors@stimpy.netroedge.com mailing list.
diff -Naur a/Documentation/i2c/chips/w83781d b/Documentation/i2c/chips/w837=
81d
--- a/Documentation/i2c/chips/w83781d	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/w83781d	2005-02-05 11:01:54.000000000 +0100
@@ -0,0 +1,433 @@
+Kernel driver w83781d
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Winbond W83781D
+    Prefix 'w83781d'
+    Addresses scanned: I2C 0x20 - 0x2f (inclusive), ISA 0x290 (8 I/O ports)
+    Datasheet: Publicly available at the Winbond website (www.winbond.com.=
tw)
+  * Winbond W83782D
+    Prefix 'w83782d'
+    Addresses scanned: I2C 0x20 - 0x2f (inclusive), ISA 0x290 (8 I/O ports)
+    Datasheet: Publicly available at the Winbond website
+  * Winbond W83783S
+    Prefix 'w83783s'
+    Addresses scanned: I2C 0x2d
+    Datasheet: Publicly available at the Winbond website
+  * Winbond W83791D
+    Prefix 'w83791d'
+    Addresses scanned: I2C 0x2c - 0x2f (inclusive)
+    Datasheet: Publicly available at the Winbond website
+  * Winbond W83627HF
+    Prefix 'w83627hf'
+    Addresses scanned: I2C 0x20 - 0x2f (inclusive), ISA 0x290 (8 I/O ports)
+    Datasheet: Publicly available at the Winbond website
+  * Winbond W83697HF
+    Prefix 'w83697hf'
+    Addresses scanned: ISA 0x290 (8 I/O ports)
+    Datasheet: Publicly available at the Winbond website
+  * Asus AS99127F
+    Prefix 'as99127f'
+    Addresses scanned: I2C 0x28 - 0x2f (inclusive)
+    Datasheet: Unavailable from Asus
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>,
+        Mark Studebaker <mdsxyz123@yahoo.com>
+
+Module parameters
+-----------------
+
+* init=3D[0,1] (default 1)
+  Use 'init=3D0' to bypass initializing the chip.
+  Try this if your computer crashes when you load the module.
+
+Description
+-----------
+
+This driver implements support for the Winbond W83781D, W83782D,
+W8783S, and W83627HF chips, and the Asus AS99127F chips.
+We will refer to them collectively as W8378* chips.
+
+There is quite some difference between these chips, but they are similar
+enough that it was sensible to put them together in one driver.
+The W83627HF chip is assumed to be identical to the ISA W83782D.
+The Asus chips are similar to an I2C-only W83782D.
+
+Chip        #vin    #fanin  #pwm    #temp   wchipid vendid  i2c     ISA
+as99127f    7       3       0       3       0x31    0x12c3  yes     no
+as99127f rev.2 (type_name =3D as99127f)       0x31    0x5ca3  yes     no
+w83781d     7       3       0       3       0x10-1  0x5ca3  yes     yes
+w83627hf    9       3       2       3       0x21    0x5ca3  yes     yes(LP=
C)
+w83627thf   9       3       2       3       0x90    0x5ca3  no      yes(LP=
C)
+w83782d     9       3       2-4     3       0x30    0x5ca3  yes     yes
+w83783s     5-6     3       2       1-2     0x40    0x5ca3  yes     no
+w83697hf    8       2       2       2       0x60    0x5ca3  no      yes(LP=
C)
+
+Detection of these chips can sometimes be foiled because they can be in
+an internal state that allows no clean access. If you know the address
+of the chip, use a 'force' parameter; this will put them into a more
+well-behaved state first.
+
+The W8378* implements temperature sensors (three on the W83781D and W83782=
D,
+two on the W83783S), three FAN rotation speed sensors, voltage sensors
+(seven on the W83781D, nine on the W83782D and six on the W83783S), VID
+lines, alarms with beep warnings, and some miscellaneous stuff.
+
+Temperatures are measured in degrees Celcius. There is always one main
+temperature sensor, and one (W83783S) or two (W83781D and W83782D) other
+sensors.  An alarm is triggered for the main sensor once when the
+Overtemperature Shutdown limit is crossed; it is triggered again as soon as
+it drops below the Hysteresis value. A more useful behaviour
+can be found by setting the Hysteresis value to +127 degrees Celcius; in
+this case, alarms are issued during all the time when the actual temperatu=
re
+is above the Overtemperature Shutdown value. The driver sets the
+hysteresis value for temp1 to 127 at initialization.
+
+For the other temperature sensor(s), an
+alarm is triggered when the temperature gets higher then the Overtemperatu=
re
+Shutdown value; it stays on until the temperature falls below the Hysteres=
is
+value. But on the W83781D, there is only one alarm that functions for both
+other sensors!  Temperatures are guaranteed within a range of -55 to +125
+degrees. The main temperature sensors has a resolution of 1 degree; the ot=
her
+sensor(s) of 0.5 degree.
+
+FAN rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. FAN
+readings can be divided by a programmable divider (1, 2, 4 or 8 for the
+W83781D; 1, 2, 4, 8, 16, 32, 64 or 128 for the others) to give
+the readings more range or accuracy. This is important because some FANs
+report only one 'tick' each rotation, while others report two - making
+all readings twice as high. Not all RPM values can accurately be represent=
ed,
+so some rounding is done. With a divider of 2, the lowest representable
+value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 4.08 volts, with a resolution
+of 0.016 volt.
+
+The VID lines encode the core voltage value: the voltage level your proces=
sor
+should work with. This is hardcoded by the mainboard and/or processor itse=
lf.
+It is a value in volts. When it is unconnected, you will often find the
+value 3.50 V here.
+
+The W83782D and W83783S temperature conversion machine understands about
+several kinds of temperature probes. You can program the so-called
+beta value in the sensor files. '1' is the PII/Celeron diode, '2' is the
+TN3904 transistor, and 3435 the default thermistor value. Other values
+are (not yet) supported. You can program your own values through the
+rt interface, but this is not very useful, because these tables are
+under NDA.
+
+In addition to the alarms described above, there is a CHAS alarm on the
+chips which triggers if your computer case is open.
+
+When an alarm goes off, you can be warned by a beeping signal through
+your computer speaker. It is possible to enable all beeping globally,
+or only the beeping for some alarms.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared!  Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The chips only update values each 1.5 seconds; reading them more often
+will do no harm, but will return 'old' values.
+
+
+W8378* PROBLEMS
+-----------------
+Known problems:
+	- Some chips are misidentified.
+	  This is caused by the chip having the wrong WCHIPID register
+	  value, so there is no fix. The workaround is to use the
+          force_CHIP parameter.
+	  (modprobe w83781d force_CHIP=3DBUS,0x2d where CHIP is the chip name
+	   and BUS is your i2c bus number see /sys/bus/i2c dir)
+
+
+AS99127F PROBLEMS
+-----------------
+The as99127f support was developed without the benefit of a datasheet.
+In most cases it is treated as a w83781d (although revision 2 of the
+AS9917F looks more like a w83782d).
+This support will be BETA until a datasheet is released.
+One user has reported problems with fans stopping
+occasionally.
+
+Note that the individual beep bits are inverted from the other chips.
+The driver now takes care of this so that user-space applications
+don't have to know about it.
+
+Known problems:
+	- Problems with diode/thermistor settings (supported?)
+	- One user reports fans stopping under high server load.
+	- Revision 2 seems to have 2 PWM registers but we don't know
+	  how to handle them. More details below.
+
+These will not be fixed unless we get a datasheet.
+If you have problems, please lobby Asus to release a datasheet.
+Unfortunately several others have without success.
+Please do not send mail to us asking for better as99127f support.
+We have done the best we can without a datasheet.
+Please do not send mail to the author or the sensors group asking for
+a datasheet or ideas on how to convince Asus. We can't help.
+
+
+NOTES:
+-----
+  783s has no in1 so that in[2-6] are compatible with the 781d/782d.
+
+  783s pin is programmable for -5V or temp1; defaults to -5V,
+       no control in driver so temp1 doesn't work.
+
+  782d and 783s datasheets differ on which is pwm1 and which is pwm2.
+       We chose to follow 782d.
+
+  782d and 783s pin is programmable for fan3 input or pwm2 output;
+       defaults to fan3 input.
+       If pwm2 is enabled (with echo 255 1 > pwm2), then
+       fan3 will report 0.
+
+  782d has pwm1-2 for isa, pwm1-4 for i2c. (pwm3-4 share pins with
+       the isa pins)
+
+  781d allowable values for fan_div are 1,2,4,8.
+  782d/783s allowable values for fan_div are 1,2,4,8,16,32,64,128.
+
+
+
+Data sheet updates:
+------------------
+	- PWM clock registers:
+
+		000: master /  512
+		001: master / 1024
+		010: master / 2048
+		011: master / 4096
+		100: master / 8192
+
+
+Answers from Winbond tech support
+---------------------------------
+>
+> 1) In the W83781D data sheet section 7.2 last paragraph, it talks about
+>    reprogramming the R-T table if the Beta of the thermistor is not
+>    3435K. The R-T table is described briefly in section 8.20.
+>    What formulas do I use to program a new R-T table for a given Beta?
+>
+	We are sorry that the calculation for R-T table value is
+confidential. If you have another Beta value of thermistor, we can help
+to calculate the R-T table for you. But you should give us real R-T
+Table which can be gotten by thermistor vendor. Therefore we will calculate
+them and obtain 32-byte data, and you can fill the 32-byte data to the
+register in Bank0.CR51 of W83781D.
+
+
+> 2) In the W83782D data sheet, it mentions that pins 38, 39, and 40 are
+>    programmable to be either thermistor or Pentium II diode inputs.
+>    How do I program them for diode inputs? I can't find any register
+>    to program these to be diode inputs.
+ --> You may program Bank0 CR[5Dh] and CR[59h] registers.
+
+ 	CR[5Dh]    		bit 1(VTIN1)    bit 2(VTIN2)   bit 3(VTIN3)
+
+      	thermistor                0		 0		0
+ 	diode 		          1		 1		1
+
+
+(error) CR[59h] 		bit 4(VTIN1)	bit 2(VTIN2)   bit 3(VTIN3)
+(right) CR[59h] 		bit 4(VTIN1)	bit 5(VTIN2)   bit 6(VTIN3)
+
+ 	PII thermal diode         1		 1		1
+ 	2N3904	diode	          0		 0		0
+
+
+Author/Maintainer
+-----------------
+Original 781D support: Frodo and Phil (sensors@stimpy.netroedge.com)
+782D/783S support added by: Mark D. Studebaker (mdsxyz123@yahoo.com)
+Send requests to the sensors@stimpy.netroedge.com mailing list.
+
+
+Asus Clones
+-----------
+
+We have no datasheets for the Asus clones (AS99127F and ASB100 Bach).
+Here are some very useful information that were given to us by Alex Van
+Kaam about how to detect these chips, and how to read their values. He
+also gives advice for another Asus chipset, the Mozart-2 (which we
+don't support yet). Thanks Alex!
+I reworded some parts and added personal comments.
+
+# Detection:
+
+AS99127F rev.1, AS99127F rev.2 and ASB100:
+- I2C address range: 0x29 - 0x2F
+- If register 0x58 holds 0x31 then we have an Asus (either ASB100 or
+  AS99127F)
+- Which one depends on register 0x4F (manufacturer ID):
+  0x06 or 0x94: ASB100
+  0x12 or 0xC3: AS99127F rev.1
+  0x5C or 0xA3: AS99127F rev.2
+  Note that 0x5CA3 is Winbond's ID (WEC), which let us think Asus get their
+  AS99127F rev.2 direct from Winbond. The other codes mean ATT and DVC,
+  respectively. ATT could stand for Asustek something (although it would be
+  very badly chosen IMHO), I don't know what DVC could stand for. Maybe
+  these codes simply aren't meant to be decoded that way.
+
+Mozart-2:
+- I2C address: 0x77
+- If register 0x58 holds 0x56 or 0x10 then we have a Mozart-2
+- Of the mozart there are 3 types:
+  0x58=3D0x56, 0x4E=3D0x94, 0x4F=3D0x36: Asus ASM58 Mozart-2
+  0x58=3D0x56, 0x4E=3D0x94, 0x4F=3D0x06: Asus AS2K129R Mozart-2
+  0x58=3D0x10, 0x4E=3D0x5C, 0x4F=3D0xA3: Asus ??? Mozart-2
+  You can handle all 3 the exact same way :)
+
+# Temperature sensors:
+
+ASB100:
+- sensor 1: register 0x27
+- sensor 2 & 3 are the 2 LM75's on the SMBus
+- sensor 4: register 0x17
+Remark: I noticed that on Intel boards sensor 2 is used for the CPU
+  and 4 is ignored/stuck, on AMD boards sensor 4 is the CPU and sensor 2 is
+  either ignored or a socket temperature.
+
+AS99127F (rev.1 and 2 alike):
+- sensor 1: register 0x27
+- sensor 2 & 3 are the 2 LM75's on the SMBus
+Remark: Register 0x5b is suspected to be temperature type selector. Bit 1
+  would control temp1, bit 3 temp2 and bit 5 temp3.
+
+Mozart-2:
+- sensor 1: register 0x27
+- sensor 2: register 0x13
+
+# Fan sensors:
+
+ASB100, AS99127F (rev.1 and 2 alike):
+- 3 fans, identical to the W83781D
+
+Mozart-2:
+- 2 fans only, 1350000/rpm/div
+- fan 1: register 0x28,  divisor on register 0xA1 (bits 4-5)
+- fan 2: register 0x29,  divisor on register 0xA1 (bits 6-7)
+
+# Voltages:
+
+This is where there is a diffrence between AS99127F rev.1 and 2.
+Remark: The difference is similar to the difference between
+  W83781D and W83782D.
+
+ASB100:
+in0=3Dr(0x20)*0.016
+in1=3Dr(0x21)*0.016
+in2=3Dr(0x22)*0.016
+in3=3Dr(0x23)*0.016*1.68
+in4=3Dr(0x24)*0.016*3.8
+in5=3Dr(0x25)*(-0.016)*3.97
+in6=3Dr(0x26)*(-0.016)*1.666
+
+AS99127F rev.1:
+in0=3Dr(0x20)*0.016
+in1=3Dr(0x21)*0.016
+in2=3Dr(0x22)*0.016
+in3=3Dr(0x23)*0.016*1.68
+in4=3Dr(0x24)*0.016*3.8
+in5=3Dr(0x25)*(-0.016)*3.97
+in6=3Dr(0x26)*(-0.016)*1.503
+
+AS99127F rev.2:
+in0=3Dr(0x20)*0.016
+in1=3Dr(0x21)*0.016
+in2=3Dr(0x22)*0.016
+in3=3Dr(0x23)*0.016*1.68
+in4=3Dr(0x24)*0.016*3.8
+in5=3D(r(0x25)*0.016-3.6)*5.14+3.6
+in6=3D(r(0x26)*0.016-3.6)*3.14+3.6
+
+Mozart-2:
+in0=3Dr(0x20)*0.016
+in1%5
+in2=3Dr(0x22)*0.016
+in3=3Dr(0x23)*0.016*1.68
+in4=3Dr(0x24)*0.016*4
+in5%5
+in6%5
+
+
+# PWM
+
+Additional info about PWM on the AS99127F (may apply to other Asus
+chips as well) by Jean Delvare as of 2004-04-09:
+
+AS99127F revision 2 seems to have two PWM registers at 0x59 and 0x5A,
+and a temperature sensor type selector at 0x5B (which basically means
+that they swapped registers 0x59 and 0x5B when you compare with Winbond
+chips).
+Revision 1 of the chip also has the temperature sensor type selector at
+0x5B, but PWM registers have no effect.
+
+We don't know exactly how the temperature sensor type selection works.
+Looks like bits 1-0 are for temp1, bits 3-2 for temp2 and bits 5-4 for
+temp3, although it is possible that only the most significant bit matters
+each time. So far, values other than 0 always broke the readings.
+
+PWM registers seem to be split in two parts: bit 7 is a mode selector,
+while the other bits seem to define a value or threshold.
+
+When bit 7 is clear, bits 6-0 seem to hold a threshold value. If the value
+is below a given limit, the fan runs at low speed. If the value is above
+the limit, the fan runs at full speed. We have no clue as to what the limit
+represents. Note that there seem to be some inertia in this mode, speed
+changes may need some time to trigger. Also, an hysteresis mechanism is
+suspected since walking through all the values increasingly and then
+decreasingly led to slighlty different limits.
+
+When bit 7 is set, bits 3-0 seem to hold a threshold value, while bits 6-4
+would not be significant. If the value is below a given limit, the fan runs
+at full speed, while if it is above the limit it runs at low speed (so this
+is the contrary of the other mode, in a way). Here again, we don't know
+what the limit is supposed to represent.
+
+One remarkable thing is that the fans would only have two or three
+different speeds (transitional states left apart), not a whole range as
+you usually get with PWM.
+
+As a conclusion, you can write 0x00 or 0x8F to the PWM registers to make
+fans run at low speed, and 0x7F or 0x80 to make them run at full speed.
+
+Please contact us if you can figure out how it is supposed to work. As
+long as we don't know more, the w83781d driver doesn't handle PWM on
+AS99127F chips at all.
+
+Additional info about PWM on the AS99127F rev.1 by Hector Martin:
+
+I've been fiddling around with the (in)famous 0x59 register and
+found out the following values do work as a form of coarse pwm:
+
+0x80 - seems to turn fans off after some time(1-2 minutes)... might be
+some form of auto-fan-control based on temp? hmm (Qfan? this mobo is an
+old ASUS, it isn't marketed as Qfan. Maybe some beta pre-attemp at Qfan
+that was dropped at the BIOS)
+0x81 - off
+0x82 - slightly "on-ner" than off, but my fans do not get to move. I can
+hear the high-pitched PWM sound that motors give off at too-low-pwm.
+0x83 - now they do move. Estimate about 70% speed or so.
+0x84-0x8f - full on
+
+Changing the high nibble doesn't seem to do much except the high bit
+(0x80) must be set for PWM to work, else the current pwm doesn't seem to
+change.
+
+My mobo is an ASUS A7V266-E. This behaviour is similar to what I got
+with speedfan under Windows, where 0-15% would be off, 15-2x% (can't
+remember the exact value) would be 70% and higher would be full on.
diff -Naur a/Documentation/i2c/i2c-parport b/Documentation/i2c/i2c-parport
--- a/Documentation/i2c/i2c-parport	2005-02-03 02:55:52.000000000 +0100
+++ b/Documentation/i2c/i2c-parport	1970-01-01 01:00:00.000000000 +0100
@@ -1,156 +0,0 @@
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-i2c-parport driver
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-2004-07-06, Jean Delvare
-
-This is a unified driver for several i2c-over-parallel-port adapters,
-such as the ones made by Philips, Velleman or ELV. This driver is
-meant as a replacement for the older, individual drivers:
- * i2c-philips-par
- * i2c-elv
- * i2c-velleman
- * video/i2c-parport (NOT the same as this one, dedicated to home brew
-                      teletext adapters)
-
-It currently supports the following devices:
- * Philips adapter
- * home brew teletext adapter
- * Velleman K8000 adapter
- * ELV adapter
- * Analog Devices evaluation boards (ADM1025, ADM1030, ADM1031, ADM1032)
-
-These devices use different pinout configurations, so you have to tell
-the driver what you have, using the type module parameter. There is no
-way to autodetect the devices. Support for different pinout configurations
-can be easily added when needed.
-
-
-Building your own adapter
--------------------------
-
-If you want to build you own i2c-over-parallel-port adapter, here is
-a sample electronics schema (credits go to Sylvain Munaut):
-
-Device                                                      PC
-Side          ___________________Vdd (+)                    Side
-               |    |         |
-              ---  ---       ---
-              | |  | |       | |
-              |R|  |R|       |R|
-              | |  | |       | |
-              ---  ---       ---
-               |    |         |
-               |    |    /|   |
-SCL  ----------x--------o |-----------x-------------------  pin 2
-                    |    \|   |       |
-                    |         |       |
-                    |   |\    |       |
-SDA  ----------x----x---| o---x---------------------------  pin 13
-               |        |/            |
-               |                      |
-               |         /|           |
-               ---------o |----------------x--------------  pin 3
-                         \|           |    |
-                                      |    |
-                                     ---  ---
-                                     | |  | |
-                                     |R|  |R|
-                                     | |  | |
-                                     ---  ---
-                                      |    |
-                                     ###  ###
-                                     GND  GND
-
-Remarks:
- - This is the exact pinout and electronics used on the Analog Devices
-   evaluation boards.
-                   /|
- - All inverters -o |- must be 74HC05, they must be open collector output.
-                   \|
- - All resitors are 10k.
- - Pins 18-25 of the parallel port connected to GND.
- - Pins 4-9 (D2-D7) could be used as VDD is the driver drives them high.
-   The ADM1032 evaluation board uses D4-D7. Beware that the amount of
-   current you can draw from the parallel port is limited. Also note that
-   all connected lines MUST BE driven at the same state, else you'll short
-   circuit the output buffers! So plugging the I2C adapter after loading
-   the i2c-parport module might be a good safety since data line state
-   prior to init may be unknown.
- - This is 5V!
- - Obviously you cannot read SCL (so it's not really standard-compliant).
-   Pretty easy to add, just copy the SDA part and use another input pin.
-   That would give (ELV compatible pinout):
-
-
-Device                                                      PC
-Side          ______________________________Vdd (+)         Side
-               |    |            |    |
-              ---  ---          ---  ---
-              | |  | |          | |  | |
-              |R|  |R|          |R|  |R|
-              | |  | |          | |  | |
-              ---  ---          ---  ---
-               |    |            |    |
-               |    |      |\    |    |
-SCL  ----------x--------x--| o---x------------------------  pin 15
-                    |   |  |/         |
-                    |   |             |
-                    |   |   /|        |
-                    |   ---o |-------------x--------------  pin 2
-                    |       \|        |    |
-                    |                 |    |
-                    |                 |    |
-                    |      |\         |    |
-SDA  ---------------x---x--| o--------x-------------------  pin 10
-                        |  |/              |
-                        |                  |
-                        |   /|             |
-                        ---o |------------------x---------  pin 3
-                            \|             |    |
-                                           |    |
-                                          ---  ---
-                                          | |  | |
-                                          |R|  |R|
-                                          | |  | |
-                                          ---  ---
-                                           |    |
-                                          ###  ###
-                                          GND  GND
-
-
-If possible, you should use the same pinout configuration as existing
-adapters do, so you won't even have to change the code.
-
-
-Similar (but different) drivers
--------------------------------
-
-This driver is NOT the same as the i2c-pport driver found in the i2c packa=
ge.
-The i2c-pport driver makes use of modern parallel port features so that
-you don't need additional electronics. It has other restrictions however, =
and
-was not ported to Linux 2.6 (yet).
-
-This driver is also NOT the same as the i2c-pcf-epp driver found in the
-lm_sensors package. The i2c-pcf-epp driver doesn't use the parallel port
-as an I2C bus directly. Instead, it uses it to control an external I2C bus
-master. That driver was not ported to Linux 2.6 (yet) either.
-
-
-Legacy documentation for Velleman adapter
------------------------------------------
-
-Useful links:
-Velleman                http://www.velleman.be/
-Velleman K8000 Howto    http://howto.htlw16.ac.at/k8000-howto.html
-
-The project has lead to new libs for the Velleman K8000 and K8005:
-  LIBK8000 v1.99.1 and LIBK8005 v0.21
-With these libs, you can control the K8000 interface card and the K8005
-stepper motor card with the simple commands which are in the original
-Velleman software, like SetIOchannel, ReadADchannel, SendStepCCWFull and
-many more, using /dev/velleman.
-  http://home.wanadoo.nl/hihihi/libk8000.htm
-  http://home.wanadoo.nl/hihihi/libk8005.htm
-  http://struyve.mine.nu:8080/index.php?block=3Dk8000
-  http://sourceforge.net/projects/libk8005/
