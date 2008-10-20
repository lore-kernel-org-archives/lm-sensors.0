From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Oct 2008 12:49:31 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (lm90) Add support for the LM99 16
Message-Id: <20081020144931.411e49fc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The LM99 differs from the LM86, LM89 and LM90 in that it reports
remote temperatures (temp2) 16 degrees lower than they really are. So
far we have been cheating and handled this in userspace but it really
should be handled by the driver directly.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
---
 Documentation/hwmon/lm90 |    2 +-
 drivers/hwmon/lm90.c     |   37 +++++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 5 deletions(-)

--- linux-2.6.28-rc0.orig/Documentation/hwmon/lm90	2008-10-20 13:53:08.000000000 +0200
+++ linux-2.6.28-rc0/Documentation/hwmon/lm90	2008-10-20 14:18:15.000000000 +0200
@@ -8,7 +8,7 @@ Supported chips:
     Datasheet: Publicly available at the National Semiconductor website
                http://www.national.com/pf/LM/LM90.html
   * National Semiconductor LM89
-    Prefix: 'lm99'
+    Prefix: 'lm89' (no auto-detection)
     Addresses scanned: I2C 0x4c and 0x4d
     Datasheet: Publicly available at the National Semiconductor website
                http://www.national.com/mpf/LM/LM89.html
--- linux-2.6.28-rc0.orig/drivers/hwmon/lm90.c	2008-10-20 13:58:48.000000000 +0200
+++ linux-2.6.28-rc0/drivers/hwmon/lm90.c	2008-10-20 14:18:15.000000000 +0200
@@ -12,9 +12,9 @@
  * made by National Semiconductor. Both have an increased remote
  * temperature measurement accuracy (1 degree), and the LM99
  * additionally shifts remote temperatures (measured and limits) by 16
- * degrees, which allows for higher temperatures measurement. The
- * driver doesn't handle it since it can be done easily in user-space.
+ * degrees, which allows for higher temperatures measurement.
  * Note that there is no way to differentiate between both chips.
+ * When device is auto-detected, the driver will assume an LM99.
  *
  * This driver also supports the LM86, another sensor chip made by
  * National Semiconductor. It is exactly similar to the LM90 except it
@@ -169,8 +169,8 @@ static const struct i2c_device_id lm90_i
 	{ "adt7461", adt7461 },
 	{ "lm90", lm90 },
 	{ "lm86", lm86 },
-	{ "lm89", lm99 },
-	{ "lm99", lm99 },	/* Missing temperature offset */
+	{ "lm89", lm86 },
+	{ "lm99", lm99 },
 	{ "max6646", max6646 },
 	{ "max6647", max6646 },
 	{ "max6649", max6646 },
@@ -366,6 +366,10 @@ static ssize_t show_temp8(struct device
 	else
 		temp = temp_from_s8(data->temp8[attr->index]);
 
+	/* +16 degrees offset for temp2 for the LM99 */
+	if (data->kind = lm99 && attr->index = 3)
+		temp += 16000;
+
 	return sprintf(buf, "%d\n", temp);
 }
 
@@ -385,6 +389,10 @@ static ssize_t set_temp8(struct device *
 	long val = simple_strtol(buf, NULL, 10);
 	int nr = attr->index;
 
+	/* +16 degrees offset for temp2 for the LM99 */
+	if (data->kind = lm99 && attr->index = 3)
+		val -= 16000;
+
 	mutex_lock(&data->update_lock);
 	if (data->kind = adt7461)
 		data->temp8[nr] = temp_to_u8_adt7461(data, val);
@@ -411,6 +419,10 @@ static ssize_t show_temp11(struct device
 	else
 		temp = temp_from_s16(data->temp11[attr->index]);
 
+	/* +16 degrees offset for temp2 for the LM99 */
+	if (data->kind = lm99 &&  attr->index <= 2)
+		temp += 16000;
+
 	return sprintf(buf, "%d\n", temp);
 }
 
@@ -432,6 +444,10 @@ static ssize_t set_temp11(struct device
 	long val = simple_strtol(buf, NULL, 10);
 	int nr = attr->index;
 
+	/* +16 degrees offset for temp2 for the LM99 */
+	if (data->kind = lm99 && attr->index <= 2)
+		val -= 16000;
+
 	mutex_lock(&data->update_lock);
 	if (data->kind = adt7461)
 		data->temp11[nr] = temp_to_u16_adt7461(data, val);
@@ -466,6 +482,10 @@ static ssize_t show_temphyst(struct devi
 	else
 		temp = temp_from_s8(data->temp8[attr->index]);
 
+	/* +16 degrees offset for temp2 for the LM99 */
+	if (data->kind = lm99 && attr->index = 3)
+		temp += 16000;
+
 	return sprintf(buf, "%d\n", temp - temp_from_s8(data->temp_hyst));
 }
 
@@ -691,6 +711,15 @@ static int lm90_detect(struct i2c_client
 				} else
 				if ((chip_id & 0xF0) = 0x30) { /* LM89/LM99 */
 					kind = lm99;
+					dev_info(&adapter->dev,
+						 "Assuming LM99 chip at "
+						 "0x%02x\n", address);
+					dev_info(&adapter->dev,
+						 "If it is an LM89, pass "
+						 "force_lm86=%d,0x%02x when "
+						 "loading the lm90 driver\n",
+						 i2c_adapter_id(adapter),
+						 address);
 				} else
 				if (address = 0x4C
 				 && (chip_id & 0xF0) = 0x10) { /* LM86 */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
