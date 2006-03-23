From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Mar 2006 15:50:25 +0000
Subject: [lm-sensors] [PATCH 10/10] i2c-parport: Make type parameter
Message-Id: <20060323165025.ddb0f7c7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: "Mark M. Hoffman" <mhoffman at lightlink.com>
Content-Disposition: inline; filename=i2c-parport-require-type-parameter.patch

This patch forces the user to specify what type of adapter is present when
loading i2c-parport or i2c-parport-light.  If none is specified, the driver
init simply fails - instead of assuming adapter type 0.

This alleviates the sometimes lengthy boot time delays which can be caused
by accidentally building one of these into a kernel along with several i2c
slave drivers that have lengthy probe routines (e.g. hwmon drivers).

Kconfig and documentation updated accordingly.

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/i2c/busses/i2c-parport   |   16 ++++++++++------
 drivers/i2c/busses/Kconfig             |    5 ++++-
 drivers/i2c/busses/i2c-parport-light.c |    9 +++++++--
 drivers/i2c/busses/i2c-parport.c       |    9 +++++++--
 drivers/i2c/busses/i2c-parport.h       |    2 +-
 5 files changed, 29 insertions(+), 12 deletions(-)

--- linux-2.6.16.orig/drivers/i2c/busses/i2c-parport-light.c	2006-03-20 22:42:50.000000000 +0100
+++ linux-2.6.16/drivers/i2c/busses/i2c-parport-light.c	2006-03-22 13:22:36.000000000 +0100
@@ -121,9 +121,14 @@
 
 static int __init i2c_parport_init(void)
 {
-	if (type < 0 || type >= ARRAY_SIZE(adapter_parm)) {
+	if (type < 0) {
+		printk(KERN_WARNING "i2c-parport: adapter type unspecified\n");
+		return -ENODEV;
+	}
+
+	if (type >= ARRAY_SIZE(adapter_parm)) {
 		printk(KERN_WARNING "i2c-parport: invalid type (%d)\n", type);
-		type = 0;
+		return -ENODEV;
 	}
 
 	if (base = 0) {
--- linux-2.6.16.orig/drivers/i2c/busses/i2c-parport.h	2006-03-20 22:42:50.000000000 +0100
+++ linux-2.6.16/drivers/i2c/busses/i2c-parport.h	2006-03-22 13:22:36.000000000 +0100
@@ -90,7 +90,7 @@
 	},
 };
 
-static int type;
+static int type = -1;
 module_param(type, int, 0);
 MODULE_PARM_DESC(type,
 	"Type of adapter:\n"
--- linux-2.6.16.orig/drivers/i2c/busses/i2c-parport.c	2006-03-20 22:42:50.000000000 +0100
+++ linux-2.6.16/drivers/i2c/busses/i2c-parport.c	2006-03-22 13:22:36.000000000 +0100
@@ -241,9 +241,14 @@
 
 static int __init i2c_parport_init(void)
 {
-	if (type < 0 || type >= ARRAY_SIZE(adapter_parm)) {
+	if (type < 0) {
+		printk(KERN_WARNING "i2c-parport: adapter type unspecified\n");
+		return -ENODEV;
+	}
+
+	if (type >= ARRAY_SIZE(adapter_parm)) {
 		printk(KERN_WARNING "i2c-parport: invalid type (%d)\n", type);
-		type = 0;
+		return -ENODEV;
 	}
 
 	return parport_register_driver(&i2c_parport_driver);
--- linux-2.6.16.orig/drivers/i2c/busses/Kconfig	2006-03-22 12:49:12.000000000 +0100
+++ linux-2.6.16/drivers/i2c/busses/Kconfig	2006-03-22 13:22:36.000000000 +0100
@@ -289,7 +289,10 @@
 	  This driver is a replacement for (and was inspired by) an older
 	  driver named i2c-philips-par.  The new driver supports more devices,
 	  and makes it easier to add support for new devices.
-	  
+
+	  An adapter type parameter is now mandatory.  Please read the file
+	  Documentation/i2c/busses/i2c-parport for details.
+
 	  Another driver exists, named i2c-parport-light, which doesn't depend
 	  on the parport driver.  This is meant for embedded systems. Don't say
 	  Y here if you intend to say Y or M there.
--- linux-2.6.16.orig/Documentation/i2c/busses/i2c-parport	2006-03-20 22:42:33.000000000 +0100
+++ linux-2.6.16/Documentation/i2c/busses/i2c-parport	2006-03-22 13:25:29.000000000 +0100
@@ -12,18 +12,22 @@
                       teletext adapters)
 
 It currently supports the following devices:
- * Philips adapter
- * home brew teletext adapter
- * Velleman K8000 adapter
- * ELV adapter
- * Analog Devices evaluation boards (ADM1025, ADM1030, ADM1031, ADM1032)
- * Barco LPT->DVI (K5800236) adapter
+ * (type=0) Philips adapter
+ * (type=1) home brew teletext adapter
+ * (type=2) Velleman K8000 adapter
+ * (type=3) ELV adapter
+ * (type=4) Analog Devices ADM1032 evaluation board
+ * (type=5) Analog Devices evaluation boards: ADM1025, ADM1030, ADM1031
+ * (type=6) Barco LPT->DVI (K5800236) adapter
 
 These devices use different pinout configurations, so you have to tell
 the driver what you have, using the type module parameter. There is no
 way to autodetect the devices. Support for different pinout configurations
 can be easily added when needed.
 
+Earlier kernels defaulted to type=0 (Philips).  But now, if the type
+parameter is missing, the driver will simply fail to initialize.
+
 
 Building your own adapter
 -------------------------

-- 
Jean Delvare

