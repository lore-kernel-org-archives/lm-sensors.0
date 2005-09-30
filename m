From: laurent.riffard@free.fr (Laurent Riffard)
Date: Fri, 30 Sep 2005 16:52:36 +0000
Subject: [lm-sensors] [PATCH 2.6-mm 2/5] i2c: update .owner field for
Message-Id: <433D50D6.1080103@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch updates the .owner field for various struct xxxx_driver variables,
others than pci_driver.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
---

Index: linux-2.6-mm/drivers/i2c/busses/i2c-iop3xx.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-iop3xx.c	2005-09-10 10:13:06.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-iop3xx.c	2005-09-10 10:32:17.095643500 +0200
@@ -525,6 +525,7 @@
 
 
 static struct device_driver iop3xx_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "IOP3xx-I2C",
 	.bus		= &platform_bus_type,
 	.probe		= iop3xx_i2c_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-ixp2000.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-ixp2000.c	2005-09-10 10:13:06.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-ixp2000.c	2005-09-10 10:32:17.095643500 +0200
@@ -142,6 +142,7 @@
 }
 
 static struct device_driver ixp2000_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "IXP2000-I2C",
 	.bus		= &platform_bus_type,
 	.probe		= ixp2000_i2c_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-ixp4xx.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-ixp4xx.c	2005-09-10 10:13:06.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-ixp4xx.c	2005-09-10 10:32:17.095643500 +0200
@@ -151,6 +151,7 @@
 }
 
 static struct device_driver ixp4xx_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "IXP4XX-I2C",
 	.bus		= &platform_bus_type,
 	.probe		= ixp4xx_i2c_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-mpc.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-mpc.c	2005-09-10 10:13:06.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-mpc.c	2005-09-10 10:32:17.099643750 +0200
@@ -361,6 +361,7 @@
 
 /* Structure for a device driver */
 static struct device_driver fsl_i2c_driver = {
+	.owner = THIS_MODULE,
 	.name = "fsl-i2c",
 	.bus = &platform_bus_type,
 	.probe = fsl_i2c_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-mv64xxx.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-10 10:13:06.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-10 10:32:17.099643750 +0200
@@ -570,6 +570,7 @@
 }
 
 static struct device_driver mv64xxx_i2c_driver = {
+	.owner	= THIS_MODULE,
 	.name	= MV64XXX_I2C_CTLR_NAME,
 	.bus	= &platform_bus_type,
 	.probe	= mv64xxx_i2c_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-s3c2410.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-s3c2410.c	2005-09-10 10:13:06.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-s3c2410.c	2005-09-10 10:32:17.103644000 +0200
@@ -898,6 +898,7 @@
 /* device driver for platform bus bits */
 
 static struct device_driver s3c2410_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "s3c2410-i2c",
 	.bus		= &platform_bus_type,
 	.probe		= s3c24xx_i2c_probe,
@@ -906,6 +907,7 @@
 };
 
 static struct device_driver s3c2440_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "s3c2440-i2c",
 	.bus		= &platform_bus_type,
 	.probe		= s3c24xx_i2c_probe,
Index: linux-2.6-mm/drivers/i2c/chips/isp1301_omap.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/isp1301_omap.c	2005-09-08 16:47:36.761308750 +0200
+++ linux-2.6-mm/drivers/i2c/chips/isp1301_omap.c	2005-09-10 10:33:40.588861500 +0200
@@ -888,6 +888,7 @@
 }
 
 struct device_driver omap_otg_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "omap_otg",
 	.bus		= &platform_bus_type,
 	.probe		= otg_probe,





-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050930/69d5091e/signature-0001.bin
