From: greg@kroah.com (Greg KH)
Date: Wed, 18 Oct 2006 20:09:38 +0000
Subject: [lm-sensors] [PATCH 7/8] hwmon: Let w83781d and lm78 load again
Message-Id: <11612021992152-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Let the w83781d and lm78 hardware monitoring drivers load even when
no chip was detected at the ISA address. There can still be supported
chips connected to an I2C bus or SMBus.

This fixes bug #7293.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/lm78.c         |   12 ++++++------
 drivers/hwmon/w83781d.c      |   12 ++++++------
 drivers/i2c/busses/i2c-isa.c |    2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index ac1b746..73bc2ff 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -815,18 +815,18 @@ static int __init sm_lm78_init(void)
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
 
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index a4584ec..fea9206 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1685,11 +1685,10 @@ sensors_w83781d_init(void)
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
@@ -1697,7 +1696,8 @@ sensors_w83781d_init(void)
 static void __exit
 sensors_w83781d_exit(void)
 {
-	i2c_isa_del_driver(&w83781d_isa_driver);
+	if (isa_address)
+		i2c_isa_del_driver(&w83781d_isa_driver);
 	i2c_del_driver(&w83781d_driver);
 }
 
diff --git a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
index 4380653..8ed59a2 100644
--- a/drivers/i2c/busses/i2c-isa.c
+++ b/drivers/i2c/busses/i2c-isa.c
@@ -91,7 +91,7 @@ int i2c_isa_add_driver(struct i2c_driver
 	/* Now look for clients */
 	res = driver->attach_adapter(&isa_adapter);
 	if (res) {
-		dev_err(&isa_adapter.dev,
+		dev_dbg(&isa_adapter.dev,
 			"Driver %s failed to attach adapter, unregistering\n",
 			driver->driver.name);
 		driver_unregister(&driver->driver);
-- 
1.4.2.4


