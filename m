From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Oct 2007 19:53:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627hf) Fix setting fan min right
Message-Id: <20071012215307.023857ff@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We need to read the fan clock dividers at initialization time,
otherwise the code in store_fan_min() may use uninitialized values.
That's pretty much the same bug and same fix as for the w83627ehf
driver last month.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627hf.c |   34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

--- linux-2.6.23.orig/drivers/hwmon/w83627hf.c	2007-10-12 21:09:35.000000000 +0200
+++ linux-2.6.23/drivers/hwmon/w83627hf.c	2007-10-12 21:22:15.000000000 +0200
@@ -389,6 +389,7 @@ static int __devexit w83627hf_remove(str
 
 static int w83627hf_read_value(struct w83627hf_data *data, u16 reg);
 static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value);
+static void w83627hf_update_fan_div(struct w83627hf_data *data);
 static struct w83627hf_data *w83627hf_update_device(struct device *dev);
 static void w83627hf_init_device(struct platform_device *pdev);
 
@@ -1206,6 +1207,7 @@ static int __devinit w83627hf_probe(stru
 	data->fan_min[0] = w83627hf_read_value(data, W83781D_REG_FAN_MIN(1));
 	data->fan_min[1] = w83627hf_read_value(data, W83781D_REG_FAN_MIN(2));
 	data->fan_min[2] = w83627hf_read_value(data, W83781D_REG_FAN_MIN(3));
+	w83627hf_update_fan_div(data);
 
 	/* Register common device attributes */
 	if ((err = sysfs_create_group(&dev->kobj, &w83627hf_group)))
@@ -1540,6 +1542,24 @@ static void __devinit w83627hf_init_devi
 			    | 0x01);
 }
 
+static void w83627hf_update_fan_div(struct w83627hf_data *data)
+{
+	int reg;
+
+	reg = w83627hf_read_value(data, W83781D_REG_VID_FANDIV);
+	data->fan_div[0] = (reg >> 4) & 0x03;
+	data->fan_div[1] = (reg >> 6) & 0x03;
+	if (data->type != w83697hf) {
+		data->fan_div[2] = (w83627hf_read_value(data,
+				       W83781D_REG_PIN) >> 6) & 0x03;
+	}
+	reg = w83627hf_read_value(data, W83781D_REG_VBAT);
+	data->fan_div[0] |= (reg >> 3) & 0x04;
+	data->fan_div[1] |= (reg >> 4) & 0x04;
+	if (data->type != w83697hf)
+		data->fan_div[2] |= (reg >> 5) & 0x04;
+}
+
 static struct w83627hf_data *w83627hf_update_device(struct device *dev)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
@@ -1617,18 +1637,8 @@ static struct w83627hf_data *w83627hf_up
 			  w83627hf_read_value(data, W83781D_REG_TEMP_HYST(3));
 		}
 
-		i = w83627hf_read_value(data, W83781D_REG_VID_FANDIV);
-		data->fan_div[0] = (i >> 4) & 0x03;
-		data->fan_div[1] = (i >> 6) & 0x03;
-		if (data->type != w83697hf) {
-			data->fan_div[2] = (w83627hf_read_value(data,
-					       W83781D_REG_PIN) >> 6) & 0x03;
-		}
-		i = w83627hf_read_value(data, W83781D_REG_VBAT);
-		data->fan_div[0] |= (i >> 3) & 0x04;
-		data->fan_div[1] |= (i >> 4) & 0x04;
-		if (data->type != w83697hf)
-			data->fan_div[2] |= (i >> 5) & 0x04;
+		w83627hf_update_fan_div(data);
+
 		data->alarms  		    w83627hf_read_value(data, W83781D_REG_ALARM1) |
 		    (w83627hf_read_value(data, W83781D_REG_ALARM2) << 8) |


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
