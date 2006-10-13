From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 13 Oct 2006 14:56:28 +0000
Subject: [lm-sensors] [PATCH] hwmon: Let w83781d and lm78 load again
Message-Id: <20061013165628.b258f035.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Let the w83781d and lm78 hardware monitoring drivers load even when
no chip was detected at the ISA address. There can still be supported
chips connected to an I2C bus or SMBus.

This fixes bug #7293.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/lm78.c         |   12 ++++++------
 drivers/hwmon/w83781d.c      |   12 ++++++------
 drivers/i2c/busses/i2c-isa.c |    2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

This patch is for 2.6.19.

--- linux-2.6.19-rc1.orig/drivers/hwmon/w83781d.c	2006-10-05 11:04:36.000000000 +0200
+++ linux-2.6.19-rc1/drivers/hwmon/w83781d.c	2006-10-09 23:54:30.000000000 +0200
@@ -1685,11 +1685,10 @@
 	if (res)
 		return res;
 
-	res = i2c_isa_add_driver(&w83781d_isa_driver);
-	if (res) {
-		i2c_del_driver(&w83781d_driver);
-		return res;
-	}
+	/* Don't exit if this one fails, we still want the I2C variants
+	   to work! */
+	if (i2c_isa_add_driver(&w83781d_isa_driver))
+		isa_address = 0;
 
 	return 0;
 }
@@ -1697,7 +1696,8 @@
 static void __exit
 sensors_w83781d_exit(void)
 {
-	i2c_isa_del_driver(&w83781d_isa_driver);
+	if (isa_address)
+		i2c_isa_del_driver(&w83781d_isa_driver);
 	i2c_del_driver(&w83781d_driver);
 }
 
--- linux-2.6.19-rc1.orig/drivers/hwmon/lm78.c	2006-10-05 11:04:36.000000000 +0200
+++ linux-2.6.19-rc1/drivers/hwmon/lm78.c	2006-10-10 07:39:35.000000000 +0200
@@ -815,18 +815,18 @@
 	if (res)
 		return res;
 
-	res = i2c_isa_add_driver(&lm78_isa_driver);
-	if (res) {
-		i2c_del_driver(&lm78_driver);
-		return res;
-	}
+	/* Don't exit if this one fails, we still want the I2C variants
+	   to work! */
+	if (i2c_isa_add_driver(&lm78_isa_driver))
+		isa_address = 0;
 
 	return 0;
 }
 
 static void __exit sm_lm78_exit(void)
 {
-	i2c_isa_del_driver(&lm78_isa_driver);
+	if (isa_address)
+		i2c_isa_del_driver(&lm78_isa_driver);
 	i2c_del_driver(&lm78_driver);
 }
 
--- linux-2.6.19-rc1.orig/drivers/i2c/busses/i2c-isa.c	2006-10-05 11:04:38.000000000 +0200
+++ linux-2.6.19-rc1/drivers/i2c/busses/i2c-isa.c	2006-10-10 07:38:07.000000000 +0200
@@ -91,7 +91,7 @@
 	/* Now look for clients */
 	res = driver->attach_adapter(&isa_adapter);
 	if (res) {
-		dev_err(&isa_adapter.dev,
+		dev_dbg(&isa_adapter.dev,
 			"Driver %s failed to attach adapter, unregistering\n",
 			driver->driver.name);
 		driver_unregister(&driver->driver);


-- 
Jean Delvare

