From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Aug 2007 12:30:01 +0000
Subject: [lm-sensors] [PATCH] Don't export thermistor beta
Message-Id: <20070816143001.461f92e2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Deprecate the use of thermistor beta values as thermal sensor types.
No driver supports changing the beta value anyway.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
As discussed on the lm-sensors list:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020323.html

 Documentation/hwmon/sysfs-interface |    4 ++--
 drivers/hwmon/w83627hf.c            |   19 ++++++++++---------
 drivers/hwmon/w83781d.c             |   16 +++++++++-------
 3 files changed, 21 insertions(+), 18 deletions(-)

--- linux-2.6.22-rc7.orig/Documentation/hwmon/sysfs-interface	2007-07-07 10:58:43.000000000 +0200
+++ linux-2.6.22-rc7/Documentation/hwmon/sysfs-interface	2007-07-07 16:48:41.000000000 +0200
@@ -219,12 +219,12 @@ temp[1-*]_auto_point[1-*]_temp_hyst
 ****************
 
 temp[1-*]_type	Sensor type selection.
-		Integers 1 to 6 or thermistor Beta value (typically 3435)
+		Integers 1 to 6
 		RW
 		1: PII/Celeron Diode
 		2: 3904 transistor
 		3: thermal diode
-		4: thermistor (default/unknown Beta)
+		4: thermistor
 		5: AMD AMDSI
 		6: Intel PECI
 		Not all types are supported by all chips
--- linux-2.6.22-rc7.orig/drivers/hwmon/w83627hf.c	2007-07-07 10:58:39.000000000 +0200
+++ linux-2.6.22-rc7/drivers/hwmon/w83627hf.c	2007-07-07 16:59:10.000000000 +0200
@@ -372,11 +372,8 @@ struct w83627hf_data {
 	u8 beep_enable;		/* Boolean */
 	u8 pwm[3];		/* Register value */
 	u8 pwm_freq[3];		/* Register value */
-	u16 sens[3];		/* 782D/783S only.
-				   1 = pentium diode; 2 = 3904 diode;
-				   3000-5000 = thermistor beta.
-				   Default = 3435.
-				   Other Betas unimplemented */
+	u16 sens[3];		/* 1 = pentium diode; 2 = 3904 diode;
+				   4 = thermistor */
 	u8 vrm;
 	u8 vrm_ovt;		/* Register value, 627THF/637HF/687THF only */
 };
@@ -1001,7 +998,11 @@ store_sensor_reg(struct device *dev, con
 				    tmp & ~BIT_SCFG2[nr - 1]);
 		data->sens[nr - 1] = val;
 		break;
-	case W83781D_DEFAULT_BETA:	/* thermistor */
+	case W83781D_DEFAULT_BETA:
+		dev_warn(dev, "Sensor type %d is deprecated, please use 4 "
+			 "instead\n", W83781D_DEFAULT_BETA);
+		/* fall through */
+	case 4:		/* thermistor */
 		tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
 		w83627hf_write_value(data, W83781D_REG_SCFG1,
 				    tmp & ~BIT_SCFG1[nr - 1]);
@@ -1009,8 +1010,8 @@ store_sensor_reg(struct device *dev, con
 		break;
 	default:
 		dev_err(dev,
-		       "Invalid sensor type %ld; must be 1, 2, or %d\n",
-		       (long) val, W83781D_DEFAULT_BETA);
+		       "Invalid sensor type %ld; must be 1, 2, or 4\n",
+		       (long) val);
 		break;
 	}
 
@@ -1513,7 +1514,7 @@ static void __devinit w83627hf_init_devi
 	tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
 	for (i = 1; i <= 3; i++) {
 		if (!(tmp & BIT_SCFG1[i - 1])) {
-			data->sens[i - 1] = W83781D_DEFAULT_BETA;
+			data->sens[i - 1] = 4;
 		} else {
 			if (w83627hf_read_value
 			    (data,
--- linux-2.6.22-rc7.orig/drivers/hwmon/w83781d.c	2007-05-13 10:01:15.000000000 +0200
+++ linux-2.6.22-rc7/drivers/hwmon/w83781d.c	2007-07-07 17:02:55.000000000 +0200
@@ -251,9 +251,7 @@ struct w83781d_data {
 	u8 pwm2_enable;		/* Boolean */
 	u16 sens[3];		/* 782D/783S only.
 				   1 = pentium diode; 2 = 3904 diode;
-				   3000-5000 = thermistor beta.
-				   Default = 3435. 
-				   Other Betas unimplemented */
+				   4 = thermistor */
 	u8 vrm;
 };
 
@@ -721,15 +719,19 @@ store_sensor(struct device *dev, struct 
 				    tmp & ~BIT_SCFG2[nr]);
 		data->sens[nr] = val;
 		break;
-	case W83781D_DEFAULT_BETA:	/* thermistor */
+	case W83781D_DEFAULT_BETA:
+		dev_warn(dev, "Sensor type %d is deprecated, please use 4 "
+			 "instead\n", W83781D_DEFAULT_BETA);
+		/* fall through */
+	case 4:		/* thermistor */
 		tmp = w83781d_read_value(data, W83781D_REG_SCFG1);
 		w83781d_write_value(data, W83781D_REG_SCFG1,
 				    tmp & ~BIT_SCFG1[nr]);
 		data->sens[nr] = val;
 		break;
 	default:
-		dev_err(dev, "Invalid sensor type %ld; must be 1, 2, or %d\n",
-		       (long) val, W83781D_DEFAULT_BETA);
+		dev_err(dev, "Invalid sensor type %ld; must be 1, 2, or 4\n",
+		       (long) val);
 		break;
 	}
 
@@ -1485,7 +1487,7 @@ w83781d_init_device(struct device *dev)
 		tmp = w83781d_read_value(data, W83781D_REG_SCFG1);
 		for (i = 1; i <= 3; i++) {
 			if (!(tmp & BIT_SCFG1[i - 1])) {
-				data->sens[i - 1] = W83781D_DEFAULT_BETA;
+				data->sens[i - 1] = 4;
 			} else {
 				if (w83781d_read_value
 				    (data,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
