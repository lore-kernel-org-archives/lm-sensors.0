From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:04:04 +0000
Subject: [lm-sensors] [PATCH] Owner field additions to many i2c drivers,
Message-Id: <11305336613945@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11305336621501@kroah.com>
In-Reply-To: <11305336621501@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] Owner field additions to many i2c drivers, 2 of 5

This patch updates the .owner field for various struct xxxx_driver variables,
other than pci_driver.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr>
Acked-by: Mark A. Greer <mgreer@mvista.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
Acked-by: Deepak Saxena <dsaxena@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0cf3628181660be4e21fe520766dcbc3da9d71c8
tree 0537200cc49c93bb2d2f3630f589ff2b87718f91
parent ccd7aa0cc9413b79b69f6cd7c18daa1c22dfa512
author Laurent Riffard <laurent.riffard@free.fr> Mon, 17 Oct 2005 22:51:37 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:11 -0700

 drivers/i2c/busses/i2c-iop3xx.c  |    1 +
 drivers/i2c/busses/i2c-ixp2000.c |    1 +
 drivers/i2c/busses/i2c-ixp4xx.c  |    1 +
 drivers/i2c/busses/i2c-mpc.c     |    1 +
 drivers/i2c/busses/i2c-mv64xxx.c |    1 +
 drivers/i2c/busses/i2c-s3c2410.c |    2 ++
 drivers/i2c/chips/isp1301_omap.c |    1 +
 7 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 745e3a5..0f7dfd8 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -525,6 +525,7 @@ out:
 
 
 static struct device_driver iop3xx_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "IOP3xx-I2C",
 	.bus		= &platform_bus_type,
 	.probe		= iop3xx_i2c_probe,
diff --git a/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
index 9dee505..c3292dc 100644
--- a/drivers/i2c/busses/i2c-ixp2000.c
+++ b/drivers/i2c/busses/i2c-ixp2000.c
@@ -146,6 +146,7 @@ static int ixp2000_i2c_probe(struct devi
 }
 
 static struct device_driver ixp2000_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "IXP2000-I2C",
 	.bus		= &platform_bus_type,
 	.probe		= ixp2000_i2c_probe,
diff --git a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
index 013981d..3169280 100644
--- a/drivers/i2c/busses/i2c-ixp4xx.c
+++ b/drivers/i2c/busses/i2c-ixp4xx.c
@@ -155,6 +155,7 @@ static int ixp4xx_i2c_probe(struct devic
 }
 
 static struct device_driver ixp4xx_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "IXP4XX-I2C",
 	.bus		= &platform_bus_type,
 	.probe		= ixp4xx_i2c_probe,
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index f065583..b81c546 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -361,6 +361,7 @@ static int fsl_i2c_remove(struct device 
 
 /* Structure for a device driver */
 static struct device_driver fsl_i2c_driver = {
+	.owner = THIS_MODULE,
 	.name = "fsl-i2c",
 	.bus = &platform_bus_type,
 	.probe = fsl_i2c_probe,
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 99abca4..69709ee 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -570,6 +570,7 @@ mv64xxx_i2c_remove(struct device *dev)
 }
 
 static struct device_driver mv64xxx_i2c_driver = {
+	.owner	= THIS_MODULE,
 	.name	= MV64XXX_I2C_CTLR_NAME,
 	.bus	= &platform_bus_type,
 	.probe	= mv64xxx_i2c_probe,
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 69fa282..6ced28e 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -896,6 +896,7 @@ static int s3c24xx_i2c_resume(struct dev
 /* device driver for platform bus bits */
 
 static struct device_driver s3c2410_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "s3c2410-i2c",
 	.bus		= &platform_bus_type,
 	.probe		= s3c24xx_i2c_probe,
@@ -904,6 +905,7 @@ static struct device_driver s3c2410_i2c_
 };
 
 static struct device_driver s3c2440_i2c_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "s3c2440-i2c",
 	.bus		= &platform_bus_type,
 	.probe		= s3c24xx_i2c_probe,
diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index 8ee56d4..eaa4742 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -888,6 +888,7 @@ static int otg_remove(struct device *dev
 }
 
 struct device_driver omap_otg_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "omap_otg",
 	.bus		= &platform_bus_type,
 	.probe		= otg_probe,

