From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 Jul 2007 15:55:05 +0000
Subject: [lm-sensors] [PATCH] hwmon/it87: Add support for fan4 and fan5
Message-Id: <20070706175505.33f91d9f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for the IT8716F and IT8718F fan4 and fan5. The late
revisions of the IT8712F have these too but support is harder to add
and nobody asked for it yet, so I didn't include it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/it87 |    3 +-
 drivers/hwmon/it87.c     |   54 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 16 deletions(-)

--- linux-2.6.22-rc7.orig/drivers/hwmon/it87.c	2007-07-06 13:02:39.000000000 +0200
+++ linux-2.6.22-rc7/drivers/hwmon/it87.c	2007-07-06 16:38:28.000000000 +0200
@@ -141,10 +141,10 @@ static int fix_pwm_polarity;
 
 /* Monitors: 9 voltage (0 to 7, battery), 3 temp (1 to 3), 3 fan (1 to 3) */
 
-#define IT87_REG_FAN(nr)       (0x0d + (nr))
-#define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
-#define IT87_REG_FANX(nr)      (0x18 + (nr))
-#define IT87_REG_FANX_MIN(nr)  (0x1b + (nr))
+static const u8 IT87_REG_FAN[]		= { 0x0d, 0x0e, 0x0f, 0x80, 0x82 };
+static const u8 IT87_REG_FAN_MIN[]	= { 0x10, 0x11, 0x12, 0x84, 0x86 };
+static const u8 IT87_REG_FANX[]		= { 0x18, 0x19, 0x1a, 0x81, 0x83 };
+static const u8 IT87_REG_FANX_MIN[]	= { 0x1b, 0x1c, 0x1d, 0x85, 0x87 };
 #define IT87_REG_FAN_MAIN_CTRL 0x13
 #define IT87_REG_FAN_CTL       0x14
 #define IT87_REG_PWM(nr)       (0x15 + (nr))
@@ -235,8 +235,8 @@ struct it87_data {
 	u8 in_max[8];		/* Register value */
 	u8 in_min[8];		/* Register value */
 	u8 has_fan;		/* Bitfield, fans enabled */
-	u16 fan[3];		/* Register values, possibly combined */
-	u16 fan_min[3];		/* Register values, possibly combined */
+	u16 fan[5];		/* Register values, possibly combined */
+	u16 fan_min[5];		/* Register values, possibly combined */
 	u8 temp[3];		/* Register value */
 	u8 temp_high[3];	/* Register value */
 	u8 temp_low[3];		/* Register value */
@@ -555,7 +555,7 @@ static ssize_t set_fan_min(struct device
 	}
 
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	it87_write_value(data, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
+	it87_write_value(data, IT87_REG_FAN_MIN[nr], data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -596,7 +596,7 @@ static ssize_t set_fan_div(struct device
 
 	/* Restore fan min limit */
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	it87_write_value(data, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
+	it87_write_value(data, IT87_REG_FAN_MIN[nr], data->fan_min[nr]);
 
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -729,9 +729,9 @@ static ssize_t set_fan16_min(struct devi
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN16_TO_REG(val);
-	it87_write_value(data, IT87_REG_FAN_MIN(nr),
+	it87_write_value(data, IT87_REG_FAN_MIN[nr],
 			 data->fan_min[nr] & 0xff);
-	it87_write_value(data, IT87_REG_FANX_MIN(nr),
+	it87_write_value(data, IT87_REG_FANX_MIN[nr],
 			 data->fan_min[nr] >> 8);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -751,6 +751,8 @@ static struct sensor_device_attribute se
 show_fan16_offset(1);
 show_fan16_offset(2);
 show_fan16_offset(3);
+show_fan16_offset(4);
+show_fan16_offset(5);
 
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
@@ -851,6 +853,10 @@ static struct attribute *it87_attributes
 	&sensor_dev_attr_fan2_min16.dev_attr.attr,
 	&sensor_dev_attr_fan3_input16.dev_attr.attr,
 	&sensor_dev_attr_fan3_min16.dev_attr.attr,
+	&sensor_dev_attr_fan4_input16.dev_attr.attr,
+	&sensor_dev_attr_fan4_min16.dev_attr.attr,
+	&sensor_dev_attr_fan5_input16.dev_attr.attr,
+	&sensor_dev_attr_fan5_min16.dev_attr.attr,
 
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
@@ -1024,6 +1030,20 @@ static int __devinit it87_probe(struct p
 			     &sensor_dev_attr_fan3_min16.dev_attr)))
 				goto ERROR4;
 		}
+		if (data->has_fan & (1 << 3)) {
+			if ((err = device_create_file(dev,
+			     &sensor_dev_attr_fan4_input16.dev_attr))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_fan4_min16.dev_attr)))
+				goto ERROR4;
+		}
+		if (data->has_fan & (1 << 4)) {
+			if ((err = device_create_file(dev,
+			     &sensor_dev_attr_fan5_input16.dev_attr))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_fan5_min16.dev_attr)))
+				goto ERROR4;
+		}
 	} else {
 		/* 8-bit tachometers with clock divider */
 		if (data->has_fan & (1 << 0)) {
@@ -1260,6 +1280,10 @@ static void __devinit it87_init_device(s
 			it87_write_value(data, IT87_REG_FAN_16BIT,
 					 tmp | 0x07);
 		}
+		if (tmp & (1 << 4))
+			data->has_fan |= (1 << 3);	/* fan4 enabled */
+		if (tmp & (1 << 5))
+			data->has_fan |= (1 << 4);	/* fan5 enabled */
 	}
 
 	/* Set current fan mode registers and the default settings for the
@@ -1314,21 +1338,21 @@ static struct it87_data *it87_update_dev
 		data->in[8]  		    it87_read_value(data, IT87_REG_VIN(8));
 
-		for (i = 0; i < 3; i++) {
+		for (i = 0; i < 5; i++) {
 			/* Skip disabled fans */
 			if (!(data->has_fan & (1 << i)))
 				continue;
 
 			data->fan_min[i] -			    it87_read_value(data, IT87_REG_FAN_MIN(i));
+			    it87_read_value(data, IT87_REG_FAN_MIN[i]);
 			data->fan[i] = it87_read_value(data,
-				       IT87_REG_FAN(i));
+				       IT87_REG_FAN[i]);
 			/* Add high byte if in 16-bit mode */
 			if (data->type = it8716 || data->type = it8718) {
 				data->fan[i] |= it87_read_value(data,
-						IT87_REG_FANX(i)) << 8;
+						IT87_REG_FANX[i]) << 8;
 				data->fan_min[i] |= it87_read_value(data,
-						IT87_REG_FANX_MIN(i)) << 8;
+						IT87_REG_FANX_MIN[i]) << 8;
 			}
 		}
 		for (i = 0; i < 3; i++) {
--- linux-2.6.22-rc7.orig/Documentation/hwmon/it87	2007-07-04 10:50:11.000000000 +0200
+++ linux-2.6.22-rc7/Documentation/hwmon/it87	2007-07-06 14:02:26.000000000 +0200
@@ -90,7 +90,8 @@ upper VID bits share their pins with vol
 can't have both on a given board.
 
 The IT8716F, IT8718F and later IT8712F revisions have support for
-2 additional fans. They are not yet supported by the driver.
+2 additional fans. They are supported by the driver for the IT8716F and
+IT8718F but not for the IT8712F
 
 The IT8716F and IT8718F, and late IT8712F and IT8705F also have optional
 16-bit tachometer counters for fans 1 to 3. This is better (no more fan


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
