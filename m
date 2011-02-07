From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Feb 2011 07:40:00 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110207084000.48fe8679@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 6 Feb 2011 20:50:05 -0800, Guenter Roeck wrote:
> On Sun, Feb 06, 2011 at 10:50:02PM -0500, Andy Lutomirski wrote:
> > 2. PWM control doesn't seem to have any effect.  (The BIOS PWM control
> > settings definitely work.)
>
> Ok, I'll look into it.

I had already noticed that the W83667HG was more complex than the
previous chips in this respect, and had even started writing a patch to
address the problem (which was never tested and is maybe not even
finished, I can't remember.) I don't know if the W83677HG-I is similar
in this respect, or even worse. Here is what I had back then (June
2009!) if it is of any interest to you:

---
 drivers/hwmon/w83627ehf.c |   87 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 13 deletions(-)

--- linux-2.6.31-rc1.orig/drivers/hwmon/w83627ehf.c	2009-06-25 09:32:17.000000000 +0200
+++ linux-2.6.31-rc1/drivers/hwmon/w83627ehf.c	2009-06-25 15:22:18.000000000 +0200
@@ -198,6 +198,10 @@ static const u8 W83627EHF_REG_TOLERANCE[
 static const u8 W83627EHF_REG_FAN_MIN_OUTPUT[] = { 0x08, 0x09, 0x15, 0x64 };
 static const u8 W83627EHF_REG_FAN_STOP_TIME[] = { 0x0C, 0x0D, 0x17, 0x66 };
 
+/* W83667HG-specific fan controller routing */
+#define W83667HG_REG_FANCTRL2_SEL	0x62
+#define W83667HG_REG_FANCTRL4_SEL	0x7C
+
 /*
  * Conversions
  */
@@ -296,7 +300,7 @@ struct w83627ehf_data {
 	u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable duty cycle */
 	u8 pwm_enable[4]; /* 1->manual
 			     2->thermal cruise (also called SmartFan I) */
-	u8 pwm_num;		/* number of pwm */
+	u8 has_pwm;		/* some fan contollers can be unused */
 	u8 pwm[4];
 	u8 target_temp[4];
 	u8 tolerance[4];
@@ -514,13 +518,14 @@ static struct w83627ehf_data *w83627ehf_
 		}
 
 		for (i = 0; i < 4; i++) {
-			/* pwmcfg, tolerance mapped for i=0, i=1 to same reg */
-			if (i != 1) {
-				pwmcfg = w83627ehf_read_value(data,
+			if (!(data->has_pwm & BIT(i)))
+				continue;
+
+			pwmcfg = w83627ehf_read_value(data,
 						W83627EHF_REG_PWM_ENABLE[i]);
-				tolerance = w83627ehf_read_value(data,
+			tolerance = w83627ehf_read_value(data,
 						W83627EHF_REG_TOLERANCE[i]);
-			}
+
 			data->pwm_mode[i]  				((pwmcfg >> W83627EHF_PWM_MODE_SHIFT[i]) & 1)
 				? 0 : 1;
@@ -1217,7 +1222,7 @@ static void w83627ehf_device_remove_file
 		device_remove_file(dev, &sda_fan_div[i].dev_attr);
 		device_remove_file(dev, &sda_fan_min[i].dev_attr);
 	}
-	for (i = 0; i < data->pwm_num; i++) {
+	for (i = 0; i < 4; i++) {
 		device_remove_file(dev, &sda_pwm[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
@@ -1308,8 +1313,60 @@ static int __devinit w83627ehf_probe(str
 
 	/* 627EHG and 627EHF have 10 voltage inputs; 627DHG and 667HG have 9 */
 	data->in_num = (sio_data->kind = w83627ehf) ? 10 : 9;
-	/* 667HG has 3 pwms */
-	data->pwm_num = (sio_data->kind = w83667hg) ? 3 : 4;
+
+	/*
+	 * The W83667HG has 4 fan speed controllers for 3 fan control output
+	 * pins. Controllers can be routed to pins in many different ways.
+	 * Depending on the configuration, a given controller can control
+	 * more than one fan, or no fan at all (in which case we don't
+	 * expose it.)
+	 *
+	 * To make things even more complex, the first 3 fan controllers are
+	 * compatible with the ones in older chips, but the 4th one is not.
+	 * We do not support the 4th controller on the 667HG yet.
+	 */
+	if (sio_data->kind = w83667hg) {
+		u8 fc2_sel, fc4_sel;
+		fc2_sel = w83627ehf_read_value(data, W83667HG_REG_FANCTRL2_SEL);
+		fc4_sel = w83627ehf_read_value(data, W83667HG_REG_FANCTRL4_SEL);
+
+		if (fc4_sel & BIT(4)) {
+			dev_info(dev, "%s is controlled by pwm%d "
+				 "(unsupported)\n", "SYSFANOUT", 4);
+		} else if (fc2_sel & BIT(4)) {
+			data->has_pwm |= BIT(1);
+			dev_info(dev, "%s is controlled by pwm%d\n",
+				 "SYSFANOUT", 2);
+		} else {
+			data->has_pwm |= BIT(0);
+			dev_info(dev, "%s is controlled by pwm%d\n",
+				 "SYSFANOUT", 1);
+		}
+
+		if (fc4_sel & BIT(5)) {
+			dev_info(dev, "%s is controlled by pwm%d "
+				 "(unsupported)\n", "CPUFANOUT", 4);
+		} else {
+			data->has_pwm |= BIT(1);
+			dev_info(dev, "%s is controlled by pwm%d\n",
+				 "CPUFANOUT", 2);
+		}
+
+		if (fc4_sel & BIT(6)) {
+			dev_info(dev, "%s is controlled by pwm%d "
+				 "(unsupported)\n", "AUXFANOUT", 4);
+		} else if (fc2_sel & BIT(5)) {
+			data->has_pwm |= BIT(1);
+			dev_info(dev, "%s is controlled by pwm%d\n",
+				 "AUXFANOUT", 2);
+		} else {
+			data->has_pwm |= BIT(2);
+			dev_info(dev, "%s is controlled by pwm%d\n",
+				 "AUXFANOUT", 3);
+		}
+	} else {
+		data->has_pwm = 0x0f;	/* pwm1 to pwm4 */
+	}
 
 	/* Check temp3 configuration bit for 667HG */
 	if (sio_data->kind = w83667hg) {
@@ -1407,7 +1464,7 @@ static int __devinit w83627ehf_probe(str
 			goto exit_remove;
 
 	/* if fan4 is enabled create the sf3 files for it */
-	if ((data->has_fan & (1 << 3)) && data->pwm_num >= 4)
+	if ((data->has_fan & BIT(3)) && (data->has_pwm & BIT(3)))
 		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
 			if ((err = device_create_file(dev,
 				&sda_sf3_arrays_fan4[i].dev_attr)))
@@ -1438,8 +1495,12 @@ static int __devinit w83627ehf_probe(str
 				|| (err = device_create_file(dev,
 					&sda_fan_min[i].dev_attr)))
 				goto exit_remove;
-			if (i < data->pwm_num &&
-				((err = device_create_file(dev,
+		}
+	}
+
+	for (i = 0; i < 4; i++) {
+		if (data->has_pwm & BIT(i)) {
+			if ((err = device_create_file(dev,
 					&sda_pwm[i].dev_attr))
 				|| (err = device_create_file(dev,
 					&sda_pwm_mode[i].dev_attr))
@@ -1448,7 +1509,7 @@ static int __devinit w83627ehf_probe(str
 				|| (err = device_create_file(dev,
 					&sda_target_temp[i].dev_attr))
 				|| (err = device_create_file(dev,
-					&sda_tolerance[i].dev_attr))))
+					&sda_tolerance[i].dev_attr)))
 				goto exit_remove;
 		}
 	}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
