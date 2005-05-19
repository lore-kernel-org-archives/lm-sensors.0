From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: [PATCH 2.6] i2c bus drivers (4/4)
Message-Id: <20031129213029.5207976e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for the KT600 to the i2c-viapro driver. It was
confirmed to work by Lou, lm-sensors at fixit dot nospammail dot net in
this post:
http://archives.andrew.net.au/lm-sensors/msg05299.html

This isn't a bug fix and can be delayed until after 2.6.0 if you want.

--- linux-2.6.0-test11/drivers/i2c/busses/i2c-viapro.c.orig	Sat Nov 29 15:29:04 2003
+++ linux-2.6.0-test11/drivers/i2c/busses/i2c-viapro.c	Sat Nov 29 17:02:37 2003
@@ -29,6 +29,7 @@
 	8233
 	8233A (0x3147 and 0x3177)
 	8235
+	8237
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
@@ -430,6 +431,13 @@
 	{
 		.vendor		= PCI_VENDOR_ID_VIA,
 		.device 	= PCI_DEVICE_ID_VIA_8235,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SMBBA3
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_8237,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.driver_data	= SMBBA3
--- linux-2.6.0-test11/drivers/i2c/busses/Kconfig.orig	Sat Oct 25 20:44:36 2003
+++ linux-2.6.0-test11/drivers/i2c/busses/Kconfig	Sat Nov 29 17:31:41 2003
@@ -309,6 +310,7 @@
 	  8233
 	  8233A
 	  8235
+	  8237
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-viapro.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
