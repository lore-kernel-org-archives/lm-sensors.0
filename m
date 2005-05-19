From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: [PATCH 2.6] i2c bus drivers (3/4)
Message-Id: <20031129212400.65daa21e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for the Serverworks CSB6 to i2c-piix4 driver. It
was confirmed to work by lasirona at yahoo dot com in support ticket
#1424:
http://secure.netroedge.com/~lm78/readticket.cgi?ticket24

This isn't a bug fix and can be delayed until after 2.6.0 if you want.

--- linux-2.6.0-test11/drivers/i2c/busses/i2c-piix4.c.orig	Sat Oct 25 20:43:17 2003
+++ linux-2.6.0-test11/drivers/i2c/busses/i2c-piix4.c	Sat Nov 29 17:29:55 2003
@@ -22,7 +22,7 @@
 /*
    Supports:
 	Intel PIIX4, 440MX
-	Serverworks OSB4, CSB5
+	Serverworks OSB4, CSB5, CSB6
 	SMSC Victory66
 
    Note: we assume there can only be one device, with one SMBus interface.
@@ -418,6 +418,13 @@
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
--- linux-2.6.0-test11/drivers/i2c/busses/Kconfig.orig	Sat Oct 25 20:44:36 2003
+++ linux-2.6.0-test11/drivers/i2c/busses/Kconfig	Sat Nov 29 17:31:41 2003
@@ -161,11 +161,12 @@
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
-	  versions of the chipset is supported:
+	  versions of the chipset are supported:
 	    Intel PIIX4
 	    Intel 440MX
 	    Serverworks OSB4
 	    Serverworks CSB5
+	    Serverworks CSB6
 	    SMSC Victory66
 
 	  This driver can also be built as a module.  If so, the module


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
