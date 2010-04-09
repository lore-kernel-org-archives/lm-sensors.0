From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Apr 2010 08:51:07 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (it87) Properly handle wrong sensor
Message-Id: <20100409105107.7b6784d4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Currently, if someone tries to set the thermal sensor type to an
unsupported value, subsequent accesses to the chip may temporarily
show the sensor in question as disabled. Use a temporary variable
and only update the cached value on success, to prevent such
confusion.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.34-rc3.orig/drivers/hwmon/it87.c	2010-04-09 10:29:27.000000000 +0200
+++ linux-2.6.34-rc3/drivers/hwmon/it87.c	2010-04-09 10:34:29.000000000 +0200
@@ -539,15 +539,14 @@ static ssize_t set_sensor(struct device
 
 	struct it87_data *data = dev_get_drvdata(dev);
 	long val;
+	u8 reg;
 
 	if (strict_strtol(buf, 10, &val) < 0)
 		return -EINVAL;
 
-	mutex_lock(&data->update_lock);
-
-	data->sensor = it87_read_value(data, IT87_REG_TEMP_ENABLE);
-	data->sensor &= ~(1 << nr);
-	data->sensor &= ~(8 << nr);
+	reg = it87_read_value(data, IT87_REG_TEMP_ENABLE);
+	reg &= ~(1 << nr);
+	reg &= ~(8 << nr);
 	if (val = 2) {	/* backwards compatibility */
 		dev_warn(dev, "Sensor type 2 is deprecated, please use 4 "
 			 "instead\n");
@@ -555,13 +554,14 @@ static ssize_t set_sensor(struct device
 	}
 	/* 3 = thermal diode; 4 = thermistor; 0 = disabled */
 	if (val = 3)
-		data->sensor |= 1 << nr;
+		reg |= 1 << nr;
 	else if (val = 4)
-		data->sensor |= 8 << nr;
-	else if (val != 0) {
-		mutex_unlock(&data->update_lock);
+		reg |= 8 << nr;
+	else if (val != 0)
 		return -EINVAL;
-	}
+
+	mutex_lock(&data->update_lock);
+	data->sensor = reg;
 	it87_write_value(data, IT87_REG_TEMP_ENABLE, data->sensor);
 	mutex_unlock(&data->update_lock);
 	return count;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
