From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 22:51:19 +0000
Subject: [lm-sensors] [PATCH 02/14] Owner field additions to many i2c
Message-Id: <20051017225137.75a0adfb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-owner-field-02-struct-device-driver.patch

This patch updates the .owner field for various struct xxxx_driver variables,
other than pci_driver.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr>
Acked-by: Mark A. Greer <mgreer@mvista.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
Acked-by: Deepak Saxena <dsaxena@mvista.com>

---
 drivers/i2c/busses/i2c-iop3xx.c  |    1 +
 drivers/i2c/busses/i2c-ixp2000.c |    1 +
 drivers/i2c/busses/i2c-ixp4xx.c  |    1 +
 drivers/i2c/busses/i2c-mpc.c     |    1 +
 drivers/i2c/busses/i2c-mv64xxx.c |    1 +
 drivers/i2c/busses/i2c-s3c2410.c |    2 ++
 drivers/i2c/chips/isp1301_omap.c |    1 +
 7 files changed, 8 insertions(+)

--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-iop3xx.c	2005-10-07 19:56:10.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-iop3xx.c	2005-10-08 16:43:17.000000000 +0200
@@ -525,6 +525,7 @@
 
 
 static struct device_driver iop3xx_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "IOP3xx-I2C",
 	.bus		= &platform_bus_type,
 	.probe		= iop3xx_i2c_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-ixp2000.c	2005-10-07 20:15:52.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-ixp2000.c	2005-10-08 16:43:17.000000000 +0200
@@ -146,6 +146,7 @@
 }
 
 static struct device_driver ixp2000_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "IXP2000-I2C",
 	.bus		= &platform_bus_type,
 	.probe		= ixp2000_i2c_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-ixp4xx.c	2005-10-07 20:15:52.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-ixp4xx.c	2005-10-08 16:43:17.000000000 +0200
@@ -155,6 +155,7 @@
 }
 
 static struct device_driver ixp4xx_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "IXP4XX-I2C",
 	.bus		= &platform_bus_type,
 	.probe		= ixp4xx_i2c_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-mpc.c	2005-10-07 19:56:10.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-mpc.c	2005-10-08 16:43:17.000000000 +0200
@@ -361,6 +361,7 @@
 
 /* Structure for a device driver */
 static struct device_driver fsl_i2c_driver = {
+	.owner = THIS_MODULE,
 	.name = "fsl-i2c",
 	.bus = &platform_bus_type,
 	.probe = fsl_i2c_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-mv64xxx.c	2005-10-07 19:56:10.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-mv64xxx.c	2005-10-08 16:43:17.000000000 +0200
@@ -570,6 +570,7 @@
 }
 
 static struct device_driver mv64xxx_i2c_driver = {
+	.owner	= THIS_MODULE,
 	.name	= MV64XXX_I2C_CTLR_NAME,
 	.bus	= &platform_bus_type,
 	.probe	= mv64xxx_i2c_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-s3c2410.c	2005-10-07 19:56:10.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-s3c2410.c	2005-10-08 16:43:18.000000000 +0200
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
--- linux-2.6.14-rc3.orig/drivers/i2c/chips/isp1301_omap.c	2005-10-07 19:56:10.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/chips/isp1301_omap.c	2005-10-08 16:43:18.000000000 +0200
@@ -888,6 +888,7 @@
 }
 
 struct device_driver omap_otg_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "omap_otg",
 	.bus		= &platform_bus_type,
 	.probe		= otg_probe,

-- 
Jean Delvare
