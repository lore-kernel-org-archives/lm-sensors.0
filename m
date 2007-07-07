From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Jul 2007 15:09:59 +0000
Subject: Re: [lm-sensors] add AMDSI PECI sensortype support to
Message-Id: <20070707170959.63922c3e@hyperion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_5irrlV9_rsPsVq6qT6+uMe1"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--MP_5irrlV9_rsPsVq6qT6+uMe1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 5 Jul 2007 13:23:04 +0200 (CEST), lm-sensors-notify@lm-sensors.org wrote:
>       Author: jwrdegoede
>         Date: Thu Jul  5 13:22:57 2007
> New Revision: 4552
>    Changeset: http://lm-sensors.org/changeset/4552
> 
> Modified:
>    lm-sensors/branches/lm-sensors-3.0.0/prog/sensors/chips_generic.c
> 
> Log:
> add AMDSI PECI sensortype support to generic_temp_print()

Good catch, but this does not yet cover all the values listed in
Documentation/hwmon/sysfs-interface:

temp[1-*]_type	Sensor type selection.
		Integers 1 to 6 or thermistor Beta value (typically 3435)
		RW
		1: PII/Celeron Diode
		2: 3904 transistor
		3: thermal diode
		4: thermistor (default/unknown Beta)
		5: AMD AMDSI
		6: Intel PECI
		Not all types are supported by all chips

Notice the "or thermistor Beta value". The w83627hf and w83781d drivers
actually export 3435 and not just 4 for thermistors, so the new
"sensors", in its current state, won't work for them. We could make it
default to "thermistor" for unknown or arbitrarily large values. But
OTOH, this feature (exporting the beta value) doesn't seem terribly
useful. In the two drivers which export the beta value... this value is
hard-coded in the driver, and not used anywhere, so what's the point?

Thus I think that this is also the right time to get rid of this old
convention, and start using always value 4 for thermistors. The upgrade
plan would be:

* Update Documentation/hwmon/sysfs-interface to no longer mention
beta values, and change the w83781d and w83627hf drivers to export
a thermal sensor value of 4 instead of 3435 for thermistors. We may
want to still accept when 3435 is written to the tempN_type files for
backwards compatibility for now, and drop support for it only later.
Proposed patch attached.
* Update sensors (v3) to still expect a thermal type value of 3435, and
treat it as value 4. We want it to work OK with the drivers from
previous 2.6 kernels.
* Update sensors.conf.eg to mention this change.

The good news is that the old "sensors" already defaults to
"thermistor" for unknown values for w83781d and w83627hf, so it won't
be affected by the change. Hopefully, other applications using
libsensors either do the same, or use generic code to display the
thermal types, of don't report thermal types at all.

Objection anyone?

-- 
Jean Delvare

--MP_5irrlV9_rsPsVq6qT6+uMe1
Content-Type: text/x-patch; name=hwmon-dont-export-beta.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=hwmon-dont-export-beta.patch

Deprecate the use of thermistor beta values as thermal sensor types.
No driver supports changing the beta value anyway.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
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

--MP_5irrlV9_rsPsVq6qT6+uMe1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_5irrlV9_rsPsVq6qT6+uMe1--
