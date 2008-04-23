From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 23 Apr 2008 05:24:36 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon (dme1737): cleanups
Message-Id: <480EC814.3090107@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070105000801080905000504"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070105000801080905000504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix names of attribute structs to make them more consistent with the 
rest of the code. Minor comment changes.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>


--------------070105000801080905000504
Content-Type: text/x-patch;
 name="dme1737-cleanups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dme1737-cleanups.patch"

Fix names of attribute structs to make them more consistent with the rest
of the code. Minor comment changes.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Index: linux/drivers/hwmon/dme1737.c
===================================================================
--- linux.orig/drivers/hwmon/dme1737.c	2008-04-17 22:21:54.000000000 -0700
+++ linux/drivers/hwmon/dme1737.c	2008-04-22 22:02:45.000000000 -0700
@@ -1166,7 +1166,7 @@
 	return sprintf(buf, "%d\n", res);
 }
 
-static struct attribute *dme1737_attr_pwm[];
+static struct attribute *dme1737_pwm_chmod_attr[];
 static void dme1737_chmod_file(struct device*, struct attribute*, mode_t);
 
 static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
@@ -1230,7 +1230,7 @@
 		switch (val) {
 		case 0:
 			/* Change permissions of pwm[ix] to read-only */
-			dme1737_chmod_file(dev, dme1737_attr_pwm[ix],
+			dme1737_chmod_file(dev, dme1737_pwm_chmod_attr[ix],
 					   S_IRUGO);
 			/* Turn fan fully on */
 			data->pwm_config[ix] = PWM_EN_TO_REG(0,
@@ -1245,12 +1245,12 @@
 			dme1737_write(client, DME1737_REG_PWM_CONFIG(ix),
 				      data->pwm_config[ix]);
 			/* Change permissions of pwm[ix] to read-writeable */
-			dme1737_chmod_file(dev, dme1737_attr_pwm[ix],
+			dme1737_chmod_file(dev, dme1737_pwm_chmod_attr[ix],
 					   S_IRUGO | S_IWUSR);
 			break;
 		case 2:
 			/* Change permissions of pwm[ix] to read-only */
-			dme1737_chmod_file(dev, dme1737_attr_pwm[ix],
+			dme1737_chmod_file(dev, dme1737_pwm_chmod_attr[ix],
 					   S_IRUGO);
 			/* Turn on auto mode using the saved zone channel
 			 * assignment */
@@ -1612,7 +1612,7 @@
 /* The following structs hold the PWM attributes, some of which are optional.
  * Their creation depends on the chip configuration which is determined during
  * module load. */
-static struct attribute *dme1737_attr_pwm1[] = {
+static struct attribute *dme1737_pwm1_attr[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
@@ -1623,7 +1623,7 @@
 	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_pwm2[] = {
+static struct attribute *dme1737_pwm2_attr[] = {
 	&sensor_dev_attr_pwm2.dev_attr.attr,
 	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
@@ -1634,7 +1634,7 @@
 	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_pwm3[] = {
+static struct attribute *dme1737_pwm3_attr[] = {
 	&sensor_dev_attr_pwm3.dev_attr.attr,
 	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
@@ -1645,13 +1645,13 @@
 	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_pwm5[] = {
+static struct attribute *dme1737_pwm5_attr[] = {
 	&sensor_dev_attr_pwm5.dev_attr.attr,
 	&sensor_dev_attr_pwm5_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm5_enable.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_pwm6[] = {
+static struct attribute *dme1737_pwm6_attr[] = {
 	&sensor_dev_attr_pwm6.dev_attr.attr,
 	&sensor_dev_attr_pwm6_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm6_enable.dev_attr.attr,
@@ -1659,53 +1659,53 @@
 };
 
 static const struct attribute_group dme1737_pwm_group[] = {
-	{ .attrs = dme1737_attr_pwm1 },
-	{ .attrs = dme1737_attr_pwm2 },
-	{ .attrs = dme1737_attr_pwm3 },
+	{ .attrs = dme1737_pwm1_attr },
+	{ .attrs = dme1737_pwm2_attr },
+	{ .attrs = dme1737_pwm3_attr },
 	{ .attrs = NULL },
-	{ .attrs = dme1737_attr_pwm5 },
-	{ .attrs = dme1737_attr_pwm6 },
+	{ .attrs = dme1737_pwm5_attr },
+	{ .attrs = dme1737_pwm6_attr },
 };
 
 /* The following structs hold the fan attributes, some of which are optional.
  * Their creation depends on the chip configuration which is determined during
  * module load. */
-static struct attribute *dme1737_attr_fan1[] = {
+static struct attribute *dme1737_fan1_attr[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan1_type.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_fan2[] = {
+static struct attribute *dme1737_fan2_attr[] = {
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
 	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan2_type.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_fan3[] = {
+static struct attribute *dme1737_fan3_attr[] = {
 	&sensor_dev_attr_fan3_input.dev_attr.attr,
 	&sensor_dev_attr_fan3_min.dev_attr.attr,
 	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan3_type.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_fan4[] = {
+static struct attribute *dme1737_fan4_attr[] = {
 	&sensor_dev_attr_fan4_input.dev_attr.attr,
 	&sensor_dev_attr_fan4_min.dev_attr.attr,
 	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan4_type.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_fan5[] = {
+static struct attribute *dme1737_fan5_attr[] = {
 	&sensor_dev_attr_fan5_input.dev_attr.attr,
 	&sensor_dev_attr_fan5_min.dev_attr.attr,
 	&sensor_dev_attr_fan5_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan5_max.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_fan6[] = {
+static struct attribute *dme1737_fan6_attr[] = {
 	&sensor_dev_attr_fan6_input.dev_attr.attr,
 	&sensor_dev_attr_fan6_min.dev_attr.attr,
 	&sensor_dev_attr_fan6_alarm.dev_attr.attr,
@@ -1714,17 +1714,17 @@
 };
 
 static const struct attribute_group dme1737_fan_group[] = {
-	{ .attrs = dme1737_attr_fan1 },
-	{ .attrs = dme1737_attr_fan2 },
-	{ .attrs = dme1737_attr_fan3 },
-	{ .attrs = dme1737_attr_fan4 },
-	{ .attrs = dme1737_attr_fan5 },
-	{ .attrs = dme1737_attr_fan6 },
+	{ .attrs = dme1737_fan1_attr },
+	{ .attrs = dme1737_fan2_attr },
+	{ .attrs = dme1737_fan3_attr },
+	{ .attrs = dme1737_fan4_attr },
+	{ .attrs = dme1737_fan5_attr },
+	{ .attrs = dme1737_fan6_attr },
 };
 
 /* The permissions of all of the following attributes are changed to read-
  * writeable if the chip is *not* locked. Otherwise they stay read-only. */
-static struct attribute *dme1737_attr_lock[] = {
+static struct attribute *dme1737_misc_chmod_attr[] = {
 	/* Temperatures */
 	&sensor_dev_attr_temp1_offset.dev_attr.attr,
 	&sensor_dev_attr_temp2_offset.dev_attr.attr,
@@ -1745,14 +1745,14 @@
 	NULL
 };
 
-static const struct attribute_group dme1737_lock_group = {
-	.attrs = dme1737_attr_lock,
+static const struct attribute_group dme1737_misc_chmod_group = {
+	.attrs = dme1737_misc_chmod_attr,
 };
 
 /* The permissions of the following PWM attributes are changed to read-
  * writeable if the chip is *not* locked and the respective PWM is available.
  * Otherwise they stay read-only. */
-static struct attribute *dme1737_attr_pwm1_lock[] = {
+static struct attribute *dme1737_pwm1_chmod_attr[] = {
 	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm1_ramp_rate.dev_attr.attr,
@@ -1761,7 +1761,7 @@
 	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_pwm2_lock[] = {
+static struct attribute *dme1737_pwm2_chmod_attr[] = {
 	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm2_ramp_rate.dev_attr.attr,
@@ -1770,7 +1770,7 @@
 	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_pwm3_lock[] = {
+static struct attribute *dme1737_pwm3_chmod_attr[] = {
 	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm3_ramp_rate.dev_attr.attr,
@@ -1779,29 +1779,29 @@
 	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_pwm5_lock[] = {
+static struct attribute *dme1737_pwm5_chmod_attr[] = {
 	&sensor_dev_attr_pwm5.dev_attr.attr,
 	&sensor_dev_attr_pwm5_freq.dev_attr.attr,
 	NULL
 };
-static struct attribute *dme1737_attr_pwm6_lock[] = {
+static struct attribute *dme1737_pwm6_chmod_attr[] = {
 	&sensor_dev_attr_pwm6.dev_attr.attr,
 	&sensor_dev_attr_pwm6_freq.dev_attr.attr,
 	NULL
 };
 
-static const struct attribute_group dme1737_pwm_lock_group[] = {
-	{ .attrs = dme1737_attr_pwm1_lock },
-	{ .attrs = dme1737_attr_pwm2_lock },
-	{ .attrs = dme1737_attr_pwm3_lock },
+static const struct attribute_group dme1737_pwm_chmod_group[] = {
+	{ .attrs = dme1737_pwm1_chmod_attr },
+	{ .attrs = dme1737_pwm2_chmod_attr },
+	{ .attrs = dme1737_pwm3_chmod_attr },
 	{ .attrs = NULL },
-	{ .attrs = dme1737_attr_pwm5_lock },
-	{ .attrs = dme1737_attr_pwm6_lock },
+	{ .attrs = dme1737_pwm5_chmod_attr },
+	{ .attrs = dme1737_pwm6_chmod_attr },
 };
 
 /* Pwm[1-3] are read-writeable if the associated pwm is in manual mode and the
  * chip is not locked. Otherwise they are read-only. */
-static struct attribute *dme1737_attr_pwm[] = {
+static struct attribute *dme1737_pwm_chmod_attr[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm2.dev_attr.attr,
 	&sensor_dev_attr_pwm3.dev_attr.attr,
@@ -1927,15 +1927,15 @@
 		dev_info(dev, "Device is locked. Some attributes "
 			 "will be read-only.\n");
 	} else {
-		/* Change permissions of standard attributes */
-		dme1737_chmod_group(dev, &dme1737_lock_group,
+		/* Change permissions of standard sysfs attributes */
+		dme1737_chmod_group(dev, &dme1737_misc_chmod_group,
 				    S_IRUGO | S_IWUSR);
 
-		/* Change permissions of PWM attributes */
-		for (ix = 0; ix < ARRAY_SIZE(dme1737_pwm_lock_group); ix++) {
+		/* Change permissions of PWM sysfs attributes */
+		for (ix = 0; ix < ARRAY_SIZE(dme1737_pwm_chmod_group); ix++) {
 			if (data->has_pwm & (1 << ix)) {
 				dme1737_chmod_group(dev,
-						&dme1737_pwm_lock_group[ix],
+						&dme1737_pwm_chmod_group[ix],
 						S_IRUGO | S_IWUSR);
 			}
 		}
@@ -1945,7 +1945,7 @@
 			if ((data->has_pwm & (1 << ix)) &&
 			    (PWM_EN_FROM_REG(data->pwm_config[ix]) == 1)) {
 				dme1737_chmod_file(dev,
-						dme1737_attr_pwm[ix],
+						dme1737_pwm_chmod_attr[ix],
 						S_IRUGO | S_IWUSR);
 			}
 		}

--------------070105000801080905000504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070105000801080905000504--
