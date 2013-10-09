From: Wei Ni <wni@nvidia.com>
Date: Wed, 09 Oct 2013 05:40:48 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (lm90) Add support for TI TMP451
Message-Id: <1381297248-13375-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327335989-10214-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327335989-10214-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

TI TMP451 is mostly compatible with ADT7461, except for
local temperature low byte and max conversion rate.
Add support to the LM90 driver.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 Documentation/hwmon/lm90 |    6 ++++++
 drivers/hwmon/lm90.c     |   45 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90
index b466974..ab81013 100644
--- a/Documentation/hwmon/lm90
+++ b/Documentation/hwmon/lm90
@@ -122,6 +122,12 @@ Supported chips:
     Prefix: 'g781'
     Addresses scanned: I2C 0x4c, 0x4d
     Datasheet: Not publicly available from GMT
+  * Texas Instruments TMP451
+    Prefix: 'tmp451'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at TI website
+               http://www.ti.com/litv/pdf/sbos686
+
 
 Author: Jean Delvare <khali@linux-fr.org>
 
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 82a1ca15..e9a5e30 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -60,6 +60,11 @@
  * This driver also supports the G781 from GMT. This device is compatible
  * with the ADM1032.
  *
+ * This driver also supports TMP451 from Texas Instruments. This device is
+ * supported in both compatibility and extended mode. It's mostly compatible
+ * with ADT7461 except for local temperature low byte register and max
+ * conversion rate.
+ *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
  * concern all supported chipsets, unless mentioned otherwise.
@@ -111,7 +116,7 @@ static const unsigned short normal_i2c[] = {
 	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
-	max6646, w83l771, max6696, sa56004, g781 };
+	max6646, w83l771, max6696, sa56004, g781, tmp451 };
 
 /*
  * The LM90 registers
@@ -168,6 +173,9 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
 #define LM90_DEF_CONVRATE_RVAL	6	/* Def conversion rate register value */
 #define LM90_MAX_CONVRATE_MS	16000	/* Maximum conversion rate in ms */
 
+/* TMP451 registers */
+#define TMP451_REG_R_LOCAL_TEMPL	0x15
+
 /*
  * Device flags
  */
@@ -206,6 +214,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "nct1008", adt7461 },
 	{ "w83l771", w83l771 },
 	{ "sa56004", sa56004 },
+	{ "tmp451", tmp451},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm90_id);
@@ -294,6 +303,13 @@ static const struct lm90_params lm90_params[] = {
 		.max_convrate = 9,
 		.reg_local_ext = SA56004_REG_R_LOCAL_TEMPL,
 	},
+	[tmp451] = {
+		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
+		  | LM90_HAVE_BROKEN_ALERT,
+		.alert_alarms = 0x7c,
+		.max_convrate = 9,
+		.reg_local_ext = TMP451_REG_R_LOCAL_TEMPL,
+	}
 };
 
 /*
@@ -718,7 +734,7 @@ static int read_temp8(struct device *dev, int index)
 	struct lm90_data *data = lm90_update_device(dev);
 	int temp;
 
-	if (data->kind = adt7461)
+	if (data->kind = adt7461 || data->kind = tmp451)
 		temp = temp_from_u8_adt7461(data, data->temp8[index]);
 	else if (data->kind = max6646)
 		temp = temp_from_u8(data->temp8[index]);
@@ -762,7 +778,7 @@ static int write_temp8(struct device *dev, int index, long val)
 		val -= 16000;
 
 	mutex_lock(&data->update_lock);
-	if (data->kind = adt7461)
+	if (data->kind = adt7461 || data->kind = tmp451)
 		data->temp8[index] = temp_to_u8_adt7461(data, val);
 	else if (data->kind = max6646)
 		data->temp8[index] = temp_to_u8(val);
@@ -803,7 +819,7 @@ static int read_temp11(struct device *dev, int index)
 	struct lm90_data *data = lm90_update_device(dev);
 	int temp;
 
-	if (data->kind = adt7461)
+	if (data->kind = adt7461 || data->kind = tmp451)
 		temp = temp_from_u16_adt7461(data, data->temp11[index]);
 	else if (data->kind = max6646)
 		temp = temp_from_u16(data->temp11[index]);
@@ -848,7 +864,7 @@ static int write_temp11(struct device *dev, int nr, int index, long val)
 		val -= 16000;
 
 	mutex_lock(&data->update_lock);
-	if (data->kind = adt7461)
+	if (data->kind = adt7461 || data->kind = tmp451)
 		data->temp11[index] = temp_to_u16_adt7461(data, val);
 	else if (data->kind = max6646)
 		data->temp11[index] = temp_to_u8(val) << 8;
@@ -912,7 +928,7 @@ static ssize_t show_temphyst(struct device *dev,
 	struct lm90_data *data = lm90_update_device(dev);
 	int temp;
 
-	if (data->kind = adt7461)
+	if (data->kind = adt7461 || data->kind = tmp451)
 		temp = temp_from_u8_adt7461(data, data->temp8[attr->index]);
 	else if (data->kind = max6646)
 		temp = temp_from_u8(data->temp8[attr->index]);
@@ -940,7 +956,7 @@ static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	if (data->kind = adt7461)
+	if (data->kind = adt7461 || data->kind = tmp451)
 		temp = temp_from_u8_adt7461(data, data->temp8[2]);
 	else if (data->kind = max6646)
 		temp = temp_from_u8(data->temp8[2]);
@@ -1368,6 +1384,19 @@ static int lm90_detect(struct i2c_client *client,
 		 && (config1 & 0x3F) = 0x00
 		 && convrate <= 0x08)
 			name = "g781";
+	} else
+	if (address = 0x4C
+	 && man_id = 0x55) { /* Texas Instruments */
+		int local_ext;
+
+		local_ext = i2c_smbus_read_byte_data(client,
+						     TMP451_REG_R_LOCAL_TEMPL);
+
+		if (chip_id = 0x00 /* TMP451 */
+		 && (config1 & 0x1B) = 0x00
+		 && convrate <= 0x09
+		 && (local_ext & 0x0F) = 0x00)
+			name = "tmp451";
 	}
 
 	if (!name) { /* identification failed */
@@ -1429,7 +1458,7 @@ static void lm90_init_client(struct i2c_client *client)
 	data->config_orig = config;
 
 	/* Check Temperature Range Select */
-	if (data->kind = adt7461) {
+	if (data->kind = adt7461 || data->kind = tmp451) {
 		if (config & 0x04)
 			data->flags |= LM90_FLAG_ADT7461_EXT;
 	}
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
