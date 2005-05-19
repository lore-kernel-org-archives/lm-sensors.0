From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: ESB2 SMBUS - validation request
Message-Id: <427FA276.7000002@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <427E318D.7050908@sh.cvut.cz>
In-Reply-To: <427E318D.7050908@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all

> Hello Rudolf,
>
> ESB2 has not been released yet.  When it is, it will have a new name.
> It is not the same as the 6300ESB.  At this time, I do not know what it
> will be called.
>
> It does support PEC.
> The PCI function is 3.
> I can not comment on what to call it at this time.
>
> Thanks for adding it to the 2.4 code.
>

I'm attaching the patch. I can't apply because I forgot my password it seems :(
Jean please apply.

Jason could you please let us now about real name when it will be released?

Thanks

regards

Rudolf

diff -Naur lm_sensors2/doc/busses/i2c-i801 lm_sensors2edit/doc/busses/i2c-i801
--- lm_sensors2/doc/busses/i2c-i801	2004-12-08 22:20:12.000000000 +0100
+++ lm_sensors2edit/doc/busses/i2c-i801	2005-05-09 19:41:00.811111400 +0200
@@ -15,6 +15,7 @@
   * Intel 6300ESB
   * Intel 82801FB/FR/FW/FRW (ICH6)
   * Intel ICH7
+  * Intel Enterprise Southbridge - ESB2 (code name)
     Datasheets: Publicly available at the Intel website

 Authors: Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock
diff -Naur lm_sensors2/kernel/busses/i2c-i801.c lm_sensors2edit/kernel/busses/i2c-i801.c
--- lm_sensors2/kernel/busses/i2c-i801.c	2005-02-09 02:05:32.000000000 +0100
+++ lm_sensors2edit/kernel/busses/i2c-i801.c	2005-05-09 16:44:18.645885504 +0200
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
+#define PCI_DEVICE_ID_INTEL_ESB2_17	0x269b
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
diff -Naur lm_sensors2/prog/detect/sensors-detect lm_sensors2edit/prog/detect/sensors-detect
--- lm_sensors2/prog/detect/sensors-detect	2005-04-14 20:03:33.000000000 +0200
+++ lm_sensors2edit/prog/detect/sensors-detect	2005-05-09 16:58:28.916624704 +0200
@@ -132,6 +132,14 @@
      } ,
      {
        vendid => 0x8086,
+       devid  => 0x269B,
+       func => 3,
+       procid => "Intel Enterprise Southbridge - ESB2",
+       driver => "i2c-i801",
+       match => sub { $_[0] =~ /^SMBus I801 adapter at [0-9a-f]{4}/ },
+     },
+     {
+       vendid => 0x8086,
        devid  => 0x266A,
        func => 3,
        procid => "Intel 82801FB ICH6",
