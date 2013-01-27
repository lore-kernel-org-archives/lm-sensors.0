From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:47 +0000
Subject: [lm-sensors] [PATCH 13/13] hwmon: (pmbus) Clean up for code size reduction
Message-Id: <1359253067-11644-14-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rearranged some data structures, and merged some common functions.
Overall code and data size reduction by more than 900 bytes.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |   86 +++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 48 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index cb5e255..80eef50 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -298,29 +298,30 @@ static int pmbus_check_status_cml(struct i2c_client *client)
 	return 0;
 }
 
-bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg)
+static bool pmbus_check_register(struct i2c_client *client,
+				 int (*func)(struct i2c_client *client,
+					     int page, int reg),
+				 int page, int reg)
 {
 	int rv;
 	struct pmbus_data *data = i2c_get_clientdata(client);
 
-	rv = _pmbus_read_byte_data(client, page, reg);
+	rv = func(client, page, reg);
 	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
 		rv = pmbus_check_status_cml(client);
 	pmbus_clear_fault_page(client, -1);
 	return rv >= 0;
 }
+
+bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg)
+{
+	return pmbus_check_register(client, _pmbus_read_byte_data, page, reg);
+}
 EXPORT_SYMBOL_GPL(pmbus_check_byte_register);
 
 bool pmbus_check_word_register(struct i2c_client *client, int page, int reg)
 {
-	int rv;
-	struct pmbus_data *data = i2c_get_clientdata(client);
-
-	rv = _pmbus_read_word_data(client, page, reg);
-	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
-		rv = pmbus_check_status_cml(client);
-	pmbus_clear_fault_page(client, -1);
-	return rv >= 0;
+	return pmbus_check_register(client, _pmbus_read_word_data, page, reg);
 }
 EXPORT_SYMBOL_GPL(pmbus_check_word_register);
 
@@ -332,6 +333,19 @@ const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client *client)
 }
 EXPORT_SYMBOL_GPL(pmbus_get_driver_info);
 
+static struct _pmbus_status {
+	u32 func;
+	u16 base;
+	u16 reg;
+} pmbus_status[] = {
+	{ PMBUS_HAVE_STATUS_VOUT, PB_STATUS_VOUT_BASE, PMBUS_STATUS_VOUT },
+	{ PMBUS_HAVE_STATUS_IOUT, PB_STATUS_IOUT_BASE, PMBUS_STATUS_IOUT },
+	{ PMBUS_HAVE_STATUS_TEMP, PB_STATUS_TEMP_BASE,
+	  PMBUS_STATUS_TEMPERATURE },
+	{ PMBUS_HAVE_STATUS_FAN12, PB_STATUS_FAN_BASE, PMBUS_STATUS_FAN_12 },
+	{ PMBUS_HAVE_STATUS_FAN34, PB_STATUS_FAN34_BASE, PMBUS_STATUS_FAN_34 },
+};
+
 static struct pmbus_data *pmbus_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -341,45 +355,21 @@ static struct pmbus_data *pmbus_update_device(struct device *dev)
 
 	mutex_lock(&data->update_lock);
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		int i;
+		int i, j;
 
-		for (i = 0; i < info->pages; i++)
+		for (i = 0; i < info->pages; i++) {
 			data->status[PB_STATUS_BASE + i]
 			    = _pmbus_read_byte_data(client, i,
 						    data->status_register);
-		for (i = 0; i < info->pages; i++) {
-			if (!(info->func[i] & PMBUS_HAVE_STATUS_VOUT))
-				continue;
-			data->status[PB_STATUS_VOUT_BASE + i]
-			  = _pmbus_read_byte_data(client, i, PMBUS_STATUS_VOUT);
-		}
-		for (i = 0; i < info->pages; i++) {
-			if (!(info->func[i] & PMBUS_HAVE_STATUS_IOUT))
-				continue;
-			data->status[PB_STATUS_IOUT_BASE + i]
-			  = _pmbus_read_byte_data(client, i, PMBUS_STATUS_IOUT);
-		}
-		for (i = 0; i < info->pages; i++) {
-			if (!(info->func[i] & PMBUS_HAVE_STATUS_TEMP))
-				continue;
-			data->status[PB_STATUS_TEMP_BASE + i]
-			  = _pmbus_read_byte_data(client, i,
-						  PMBUS_STATUS_TEMPERATURE);
-		}
-		for (i = 0; i < info->pages; i++) {
-			if (!(info->func[i] & PMBUS_HAVE_STATUS_FAN12))
-				continue;
-			data->status[PB_STATUS_FAN_BASE + i]
-			  = _pmbus_read_byte_data(client, i,
-						  PMBUS_STATUS_FAN_12);
-		}
-
-		for (i = 0; i < info->pages; i++) {
-			if (!(info->func[i] & PMBUS_HAVE_STATUS_FAN34))
-				continue;
-			data->status[PB_STATUS_FAN34_BASE + i]
-			  = _pmbus_read_byte_data(client, i,
-						  PMBUS_STATUS_FAN_34);
+			for (j = 0; j < ARRAY_SIZE(pmbus_status); j++) {
+				struct _pmbus_status *s = &pmbus_status[j];
+
+				if (!(info->func[i] & s->func))
+					continue;
+				data->status[s->base + i]
+					= _pmbus_read_byte_data(client, i,
+								s->reg);
+			}
 		}
 
 		if (info->func[0] & PMBUS_HAVE_STATUS_INPUT)
@@ -913,12 +903,12 @@ static int pmbus_add_label(struct pmbus_data *data,
  */
 struct pmbus_limit_attr {
 	u16 reg;		/* Limit register */
+	u16 sbit;		/* Alarm attribute status bit */
 	bool update;		/* True if register needs updates */
 	bool low;		/* True if low limit; for limits with compare
 				   functions only */
 	const char *attr;	/* Attribute name */
 	const char *alarm;	/* Alarm attribute name */
-	u32 sbit;		/* Alarm attribute status bit */
 };
 
 /*
@@ -927,6 +917,8 @@ struct pmbus_limit_attr {
  */
 struct pmbus_sensor_attr {
 	u16 reg;			/* sensor register */
+	u8 gbit;			/* generic status bit */
+	u8 nlimit;			/* # of limit registers */
 	enum pmbus_sensor_classes class;/* sensor class */
 	const char *label;		/* sensor label */
 	bool paged;			/* true if paged sensor */
@@ -935,9 +927,7 @@ struct pmbus_sensor_attr {
 	u32 func;			/* sensor mask */
 	u32 sfunc;			/* sensor status mask */
 	int sbase;			/* status base register */
-	u32 gbit;			/* generic status bit */
 	const struct pmbus_limit_attr *limit;/* limit registers */
-	int nlimit;			/* # of limit registers */
 };
 
 /*
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
