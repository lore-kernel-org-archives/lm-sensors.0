From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 28 Mar 2012 16:38:28 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (pmbus_core) Fix compiler warning
Message-Id: <1332952708-4110-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some configurations produce the following compiler warning:

drivers/hwmon/pmbus/pmbus_core.c: In function 'pmbus_show_boolean':
drivers/hwmon/pmbus/pmbus_core.c:752: warning: 'val' may be used uninitialized in this function

While this is a false positive, it can easily be fixed by overloading the return
value from pmbus_get_boolean with both val and error return code (val is a
boolean and thus never negative).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index be51037..29b319d 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -710,13 +710,13 @@ static u16 pmbus_data2reg(struct pmbus_data *data,
  * If a negative value is stored in any of the referenced registers, this value
  * reflects an error code which will be returned.
  */
-static int pmbus_get_boolean(struct pmbus_data *data, int index, int *val)
+static int pmbus_get_boolean(struct pmbus_data *data, int index)
 {
 	u8 s1 = (index >> 24) & 0xff;
 	u8 s2 = (index >> 16) & 0xff;
 	u8 reg = (index >> 8) & 0xff;
 	u8 mask = index & 0xff;
-	int status;
+	int ret, status;
 	u8 regval;
 
 	status = data->status[reg];
@@ -725,7 +725,7 @@ static int pmbus_get_boolean(struct pmbus_data *data, int index, int *val)
 
 	regval = status & mask;
 	if (!s1 && !s2)
-		*val = !!regval;
+		ret = !!regval;
 	else {
 		long v1, v2;
 		struct pmbus_sensor *sensor1, *sensor2;
@@ -739,9 +739,9 @@ static int pmbus_get_boolean(struct pmbus_data *data, int index, int *val)
 
 		v1 = pmbus_reg2data(data, sensor1);
 		v2 = pmbus_reg2data(data, sensor2);
-		*val = !!(regval && v1 >= v2);
+		ret = !!(regval && v1 >= v2);
 	}
-	return 0;
+	return ret;
 }
 
 static ssize_t pmbus_show_boolean(struct device *dev,
@@ -750,11 +750,10 @@ static ssize_t pmbus_show_boolean(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct pmbus_data *data = pmbus_update_device(dev);
 	int val;
-	int err;
 
-	err = pmbus_get_boolean(data, attr->index, &val);
-	if (err)
-		return err;
+	val = pmbus_get_boolean(data, attr->index);
+	if (val < 0)
+		return val;
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
