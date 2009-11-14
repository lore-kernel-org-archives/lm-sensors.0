From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Nov 2009 15:31:48 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (adt7475) Add support for the
Message-Id: <20091114163148.4f23cf9f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for the ADT7473 to the adt7475 driver, and mark the
adt7473 driver for removal. The ADT7473 and ADT7475 chips are almost
the same chip and essentially compatible, so there's no point in
having separate drivers for them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
Darrick, please test this patch and the next 2, and confirm your
ADT7473 still works fine.

 Documentation/feature-removal-schedule.txt |    7 +++++++
 Documentation/hwmon/adt7473                |    2 ++
 drivers/hwmon/Kconfig                      |   10 +++++++---
 drivers/hwmon/adt7473.c                    |    3 ++-
 drivers/hwmon/adt7475.c                    |   25 +++++++++++++++++--------
 5 files changed, 35 insertions(+), 12 deletions(-)

--- linux-2.6.32-rc7.orig/drivers/hwmon/Kconfig	2009-11-14 13:04:32.000000000 +0100
+++ linux-2.6.32-rc7/drivers/hwmon/Kconfig	2009-11-14 13:05:53.000000000 +0100
@@ -191,21 +191,25 @@ config SENSORS_ADT7470
 	  will be called adt7470.
 
 config SENSORS_ADT7473
-	tristate "Analog Devices ADT7473"
+	tristate "Analog Devices ADT7473 (DEPRECATED)"
 	depends on I2C && EXPERIMENTAL
+	select SENSORS_ADT7475
 	help
 	  If you say yes here you get support for the Analog Devices
 	  ADT7473 temperature monitoring chips.
 
+	  This driver is deprecated, you should use the adt7475 driver
+	  instead.
+
 	  This driver can also be built as a module. If so, the module
 	  will be called adt7473.
 
 config SENSORS_ADT7475
-	tristate "Analog Devices ADT7475"
+	tristate "Analog Devices ADT7473 and ADT7475"
 	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the Analog Devices
-	  ADT7475 hardware monitoring chips.
+	  ADT7473 and ADT7475 hardware monitoring chips.
 
 	  This driver can also be build as a module.  If so, the module
 	  will be called adt7475.
--- linux-2.6.32-rc7.orig/drivers/hwmon/adt7473.c	2009-11-14 13:04:32.000000000 +0100
+++ linux-2.6.32-rc7/drivers/hwmon/adt7473.c	2009-11-14 13:05:53.000000000 +0100
@@ -174,7 +174,6 @@ static const struct i2c_device_id adt747
 	{ "adt7473", adt7473 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, adt7473_id);
 
 static struct i2c_driver adt7473_driver = {
 	.class		= I2C_CLASS_HWMON,
@@ -1166,6 +1165,8 @@ static int adt7473_remove(struct i2c_cli
 
 static int __init adt7473_init(void)
 {
+	pr_notice("The adt7473 driver is deprecated, please use the adt7475 "
+		  "driver instead\n");
 	return i2c_add_driver(&adt7473_driver);
 }
 
--- linux-2.6.32-rc7.orig/drivers/hwmon/adt7475.c	2009-11-14 13:04:32.000000000 +0100
+++ linux-2.6.32-rc7/drivers/hwmon/adt7475.c	2009-11-14 13:05:53.000000000 +0100
@@ -113,11 +113,12 @@
 #define TEMP_OFFSET_REG(idx) (REG_TEMP_OFFSET_BASE + (idx))
 #define TEMP_TRANGE_REG(idx) (REG_TEMP_TRANGE_BASE + (idx))
 
-static unsigned short normal_i2c[] = { 0x2e, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
-I2C_CLIENT_INSMOD_1(adt7475);
+I2C_CLIENT_INSMOD_2(adt7473, adt7475);
 
 static const struct i2c_device_id adt7475_id[] = {
+	{ "adt7473", adt7473 },
 	{ "adt7475", adt7475 },
 	{ }
 };
@@ -970,19 +971,27 @@ static int adt7475_detect(struct i2c_cli
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	int vendid, devid;
+	const char *name;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	if (adt7475_read(REG_VENDID) != 0x41 ||
-	    adt7475_read(REG_DEVID) != 0x75) {
-		dev_err(&adapter->dev,
-			"Couldn't detect a adt7475 part at 0x%02x\n",
-			(unsigned int)client->addr);
+	vendid = adt7475_read(REG_VENDID);
+	devid = adt7475_read(REG_DEVID);
+
+	if (vendid = 0x41 && devid = 0x73)
+		name = "adt7473";
+	else if (vendid = 0x41 && devid = 0x75 && client->addr = 0x2e)
+		name = "adt7475";
+	else {
+		dev_dbg(&adapter->dev,
+			"Couldn't detect an ADT7473 or ADT7475 part at "
+			"0x%02x\n", (unsigned int)client->addr);
 		return -ENODEV;
 	}
 
-	strlcpy(info->type, adt7475_id[0].name, I2C_NAME_SIZE);
+	strlcpy(info->type, name, I2C_NAME_SIZE);
 
 	return 0;
 }
--- linux-2.6.32-rc7.orig/Documentation/hwmon/adt7473	2009-11-14 13:04:32.000000000 +0100
+++ linux-2.6.32-rc7/Documentation/hwmon/adt7473	2009-11-14 13:10:56.000000000 +0100
@@ -9,6 +9,8 @@ Supported chips:
 
 Author: Darrick J. Wong
 
+This driver is depreacted, please use the adt7475 driver instead.
+
 Description
 -----------
 
--- linux-2.6.32-rc7.orig/Documentation/feature-removal-schedule.txt	2009-11-14 13:04:32.000000000 +0100
+++ linux-2.6.32-rc7/Documentation/feature-removal-schedule.txt	2009-11-14 13:05:53.000000000 +0100
@@ -480,3 +480,10 @@ Why:	With the recent innovations in CPU
 Who:	Alok N Kataria <akataria@vmware.com>
 
 ----------------------------
+
+What:	adt7473 hardware monitoring driver
+When:	February 2010
+Why:	Obsoleted by the adt7475 driver.
+Who:	Jean Delvare <khali@linux-fr.org>
+
+---------------------------


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
