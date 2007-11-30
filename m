From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Nov 2007 22:52:44 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83781d) Misc cleanups
Message-Id: <20071130235244.0435cf19@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Drop unused defines
* Drop unused driver ID
* Remove trailing whitespace

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83781d.c |   13 ++++---------
 include/linux/i2c-id.h  |    1 -
 2 files changed, 4 insertions(+), 10 deletions(-)

--- linux-2.6.24-rc3.orig/drivers/hwmon/w83781d.c	2007-11-30 22:32:41.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/w83781d.c	2007-11-30 22:49:08.000000000 +0100
@@ -151,10 +151,6 @@ static const u8 BIT_SCFG2[] = { 0x10, 0x
 
 #define W83781D_DEFAULT_BETA		3435
 
-/* RT Table registers */
-#define W83781D_REG_RT_IDX		0x50
-#define W83781D_REG_RT_VAL		0x51
-
 /* Conversions */
 #define IN_TO_REG(val)			SENSORS_LIMIT(((val) + 8) / 16, 0, 255)
 #define IN_FROM_REG(val)		((val) * 16)
@@ -269,7 +265,6 @@ static struct i2c_driver w83781d_driver 
 	.driver = {
 		.name = "w83781d",
 	},
-	.id = I2C_DRIVERID_W83781D,
 	.attach_adapter = w83781d_attach_adapter,
 	.detach_client = w83781d_detach_client,
 };
@@ -694,7 +689,7 @@ store_fan_div(struct device *dev, struct
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	
+
 	/* Save fan_min */
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
@@ -1000,7 +995,7 @@ ERROR_SC_0:
 #define IN_UNIT_ATTRS(X)					\
 	&sensor_dev_attr_in##X##_input.dev_attr.attr,		\
 	&sensor_dev_attr_in##X##_min.dev_attr.attr,		\
-	&sensor_dev_attr_in##X##_max.dev_attr.attr, 		\
+	&sensor_dev_attr_in##X##_max.dev_attr.attr,		\
 	&sensor_dev_attr_in##X##_alarm.dev_attr.attr,		\
 	&sensor_dev_attr_in##X##_beep.dev_attr.attr
 
@@ -1441,9 +1436,9 @@ w83781d_isa_remove(struct platform_devic
 }
 
 /* The SMBus locks itself, usually, but nothing may access the Winbond between
-   bank switches. ISA access must always be locked explicitly! 
+   bank switches. ISA access must always be locked explicitly!
    We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the W83781D access and should not be necessary. 
+   would slow down the W83781D access and should not be necessary.
    There are some ugly typecasts here, but the good news is - they should
    nowhere else be necessary! */
 static int
--- linux-2.6.24-rc3.orig/include/linux/i2c-id.h	2007-11-30 14:19:47.000000000 +0100
+++ linux-2.6.24-rc3/include/linux/i2c-id.h	2007-11-30 22:48:52.000000000 +0100
@@ -131,7 +131,6 @@
 #define I2C_DRIVERID_LM78 1002
 #define I2C_DRIVERID_LM75 1003
 #define I2C_DRIVERID_EEPROM 1005
-#define I2C_DRIVERID_W83781D 1006
 #define I2C_DRIVERID_LM80 1007
 #define I2C_DRIVERID_ADM1021 1008
 #define I2C_DRIVERID_ADM9240 1009


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
