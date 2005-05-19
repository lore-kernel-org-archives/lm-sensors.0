From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Follow-up, ticket #1375
Message-Id: <20030815115614.208bce95.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030814211421.52539.qmail@web11206.mail.yahoo.com>
In-Reply-To: <20030814211421.52539.qmail@web11206.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I may have stumbled across the root cause of my ticket #1375
> (Tyan S2727, no chips detected). The main chipset is the
> ServerWorks GC-SL with a CSB6 controlling the PCI bus. I just
> noticed the CSB6 is on the "NEW AND REQUESTED BUS DRIVERS" list.

Yes, there is no support yet. We think support could be easily added to
our i2c-piix4 driver, but we would need a datasheet to confirm that. I
just made a request to serverworks to have one, we'll see.

> 00:0f.0 ISA bridge: ServerWorks: Unknown device 0203 (rev a0)
>         Subsystem: ServerWorks: Unknown device 0201
>         Flags: bus master, medium devsel, latency 64

That should be where the I2C/SMBus bus is.

If you like playing with fire, I've attached a simple patch that make
i2c-piix4 accept the CSB6. It could work, since the CSB6 is expected to
be mostly compatible with the CSB5. However, beware that we don't have a
datasheet yet, so the CSB6 may work in a completely different manner,
loading the i2c-piix4 on it may completely screw your system. It's
unlikely, but could happen. I of course take no responsability for that.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Index: i2c-piix4.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-piix4.c,v
retrieving revision 1.57
diff -u -r1.57 i2c-piix4.c
--- i2c-piix4.c	14 Aug 2003 22:28:42 -0000	1.57
+++ i2c-piix4.c	15 Aug 2003 10:05:21 -0000
@@ -22,7 +22,7 @@
 /*
    Supports:
 	Intel PIIX4, 440MX
-	Serverworks OSB4, CSB5
+	Serverworks OSB4, CSB5, CSB6 (untested)
 	SMSC Victory66
 
    Note: we assume there can only be one device, with one SMBus interface.
@@ -465,6 +465,13 @@
 	{
 		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
 		.device =	PCI_DEVICE_ID_SERVERWORKS_CSB5,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	0,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
+		.device =	PCI_DEVICE_ID_SERVERWORKS_CSB6,
 		.subvendor =	PCI_ANY_ID,
 		.subdevice =	PCI_ANY_ID,
 		.driver_data =	0,
