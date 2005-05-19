From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: ESB2 SMBUS - validation request
Message-Id: <427E318D.7050908@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I noticed that you added ESB2 support to i2c-i801.c Thats OK for 2.6 kernels
however for 2.4.x series it is needed too. (lm_sensors lives outside 2.4 tree
and its homepage is at http://www.lm-sensors.nu)

I created neccessary patch that adds support to 2.4.x i2c-i801.c and to our
sensors-detect script, but I need to confirm that:

1) the SMBUS host supports PEC
2) the PCI "function" is 3
3) it is OK to call it "Intel Enterprise Southbridge - ESB2"

I failed to find datasheet for it so any point to it for future reference would
be perfect. (Or just state it is same as in 6300ESB)

What is left is documentattion update in doc/ directory.
I will also update 2.6.12-rc4/Documentation/i2c/busses/i2c-i801 file.

Regards

Rudolf

FIY: here is what files were modified and how.

--- lm_sensors2/kernel/busses/i2c-i801.c	
+++ lm_sensors2_zmena/kernel/busses/i2c-i801.c
@@ -31,6 +31,7 @@
     6300ESB		25A4   ("")
     ICH6		266A   ("")
     ICH7		27DA   ("")
+    ESB2 		269B   ("")
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
     of Intel's '810' and other chipsets.
@@ -75,6 +76,11 @@
 #define PCI_DEVICE_ID_INTEL_ESB_4	0x25a4
 #endif

+/* ESB2 - Enterprise Southbridge is undefined */
+#ifndef PCI_DEVICE_ID_INTEL_ESB2_17
+#define PCI_DEVICE_ID_INTEL_ESB2_17 	0x269b
+#endif
+
 /* ICH6 is undefined */
 #ifndef PCI_DEVICE_ID_INTEL_ICH6_16
 #define PCI_DEVICE_ID_INTEL_ICH6_16	0x266a
@@ -160,6 +166,7 @@
 	if (dev->device = PCI_DEVICE_ID_INTEL_82801DB_3 ||
 	    dev->device = PCI_DEVICE_ID_INTEL_82801EB_3 ||
 	    dev->device = PCI_DEVICE_ID_INTEL_ESB_4 ||
+	    dev->device = PCI_DEVICE_ID_INTEL_ESB2_17 ||	
 	    dev->device = PCI_DEVICE_ID_INTEL_ICH6_16 ||
 	    dev->device = PCI_DEVICE_ID_INTEL_ICH7_17)
 		isich4 = 1;
@@ -658,6 +665,12 @@
 	},
 	{
 		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_ESB2_17,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice = 	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
 		.device =	PCI_DEVICE_ID_INTEL_ICH6_16,
 		.subvendor =	PCI_ANY_ID,
 		.subdevice =	PCI_ANY_ID,
--- lm_sensors2/prog/detect/sensors-detect
+++ lm_sensors2_zmena/prog/detect/sensors-detect
@@ -132,6 +132,14 @@
      } ,
      {
        vendid => 0x8086,
+       devid  => 0x269B,
+       func => 3,
+       procid => "Intel Enterprise Southbridge - ESB2",
+       driver => "i2c-i801",
+       match => sub { $_[0] =~ /^SMBus I801 adapter at [0-9a-f]{4}/ },
+     } ,
+     {
+       vendid => 0x8086,
        devid  => 0x266A,
        func => 3,
        procid => "Intel 82801FB ICH6",
