From: <vt8231@hiddenengine.co.uk>
Date: Mon, 11 May 2015 20:15:39 +0000
Subject: Re: [lm-sensors] Additional PWM driver support for w83792d
Message-Id: <002f01d08c27$3fefaeb0$bfcf0c10$@hiddenengine.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
In-Reply-To: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On 05/11/2015 03:45 AM, Jean Delvare wrote:
> > On Sun, 10 May 2015 09:01:25 -0700, Guenter Roeck wrote:
> >> On 05/10/2015 06:42 AM, vt8231@hiddenengine.co.uk wrote:
> >> [ ... ]
> >>>>>
> >>>>> Last note: registers 0xA3-0xA6 have extra configuration bits "Sync
> >>>>> T1/2/3". Maybe the driver should handle them but I am not sure how. It
> >>>>> could be that the extra outputs should only be exposed to user-space if
> >>>>> these bits are 0 (stand alone.) Guenter, any idea/opinion on this?
> >>>>
> >>>> How about using pwm[4567]_enable ? If I understand correctly, the possible
> >>>> modes would be manual or sync(x). In this case we could have 1 (manual),
> >>>> 2 (sync with fan1), 3 (sync with fan2), and 4 (sync with fan3), with the
> >>>> caveat that the sync settings only make sense if the matching pwmX_enable
> >>>> is set to thermal cruise mode.
> >>>>
> >>>> Does this make sense ?
> >
> > Not really. The problem is that for now I'm not sure what "sync" really
> > refers to. The datasheet mentions temperature channels, and as far as I
> > can see each temperature channel is hard-bound to a specific fan
> > output. So I suspect that what these configuration bit really mean is
> > that the pwm4 output (for example) mirrors the pwm1 output, i.e. pwm4
> > has no independent existence. In which case it's better to not expose
> > it at all.
> >
> > If the BIOS specifically configured these bits, there must be a reason
> > and that reason would be the way the fans are connected to the chipset.
> > Better not change it.
> >
> > If we really want to expose these bits then abusing pwmX_enable the way
> > you suggested is still not correct, pwmX_auto_channels_temp would be
> > better suited. But then again I don't think it adds any value if the
> > extra PWM outputs only mirror already existing PWM outputs.
> >
> Ok, fine with me.
> 
> Guenter

Thanks Jean and Guenter,

If I understand this correctly, I shouldn't be implementing pwm[4-7]_enable.

I can see the same argument for *not* implementing pwm[4-7]_mode either. 
The pwmX_mode changes the chip from a PWM to analogue output.  Again, this
would depend on the attached HW so the BIOS should have sorted this out based
on the PCB design rather than allowing Linux to change it.  The HW 
requirements indicated in sections 7.7.2.1 and 7.7.2.2 of the datasheet are
very different so I wouldn't want the user to change this and damage the chip
as a result.

If you want me to add pwm[4-7]_mode then I'll do it... but I can only see
reasons not to and if it was me, I'd either remove the existing pwm[1-3]_mode
or at least make it a read-only value.

Anyway, the patch is below.  I've tested this on my Dell FS12-NV7 running Ubuntu
15.04 and kernel 3.19.0.  It works as expected with pwm4, pwm5 and pwm6 present.
I don't see pwm7 but then again, I don't see fan7 either so that suggests 
everything is as it should be for my HW.

Best regards,

Roger



Signed-off-by:	Roger Lucas <vt8231@hiddenengine.co.uk>

diff -uprN -X a/Documentation/dontdiff a/Documentation/hwmon/w83792d b/Documentation/hwmon/w83792d
--- linux-3.19.0/Documentation/hwmon/w83792d	2015-02-09 02:54:22.000000000 +0000
+++ linux-3.19.0-new/Documentation/hwmon/w83792d	2015-05-11 21:01:48.264679792 +0100
@@ -8,7 +8,7 @@ Supported chips:
     Datasheet: http://www.winbond.com.tw
 
 Author: Shane Huang (Winbond)
-
+Updated: Roger Lucas
 
 Module Parameters
 -----------------
@@ -38,9 +38,17 @@ parameter; this will put it into a more
 The driver implements three temperature sensors, seven fan rotation speed
 sensors, nine voltage sensors, and two automatic fan regulation
 strategies called: Smart Fan I (Thermal Cruise mode) and Smart Fan II.
-Automatic fan control mode is possible only for fan1-fan3. Fan4-fan7 can run
-synchronized with selected fan (fan1-fan3). This functionality and manual PWM
-control for fan4-fan7 is not yet implemented.
+Automatic fan control mode is possible only for fan1-fan3
+
+The driver also implements up to seven fan control outputs: pwm1-7.  Pwm1, 
+pwm2 and pwm3 can be configured to PWM output or Analogue DC output via their
+associated pwmX_mode.  Outputs pwm4 through pwm7 may or may not be present
+depending on how the W83792AD/D was configured by the BIOS.  Additionally, 
+the PWM/Analogue output can not be changed for pwm4-7 and respects the 
+configuration written by the BIOS.
+
+For all pwmX outputs, a value of 0 means minimum fan speed and a value of
+255 means maximum fan speed.
 
 Temperatures are measured in degrees Celsius and measurement resolution is 1
 degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
@@ -157,16 +165,19 @@ for each fan.
 /sys files
 ----------
 
-pwm[1-3] - this file stores PWM duty cycle or DC value (fan speed) in range:
+pwm[1-7] - this file stores PWM duty cycle or DC value (fan speed) in range:
 	0 (stop) to 255 (full)
 pwm[1-3]_enable - this file controls mode of fan/temperature control:
             * 0 Disabled
             * 1 Manual mode
             * 2 Smart Fan II
             * 3 Thermal Cruise
+	Note that pwm4-7 support manual mode only.
 pwm[1-3]_mode - Select PWM of DC mode
             * 0 DC
             * 1 PWM
+	Note that pwm4-7 respect the configuration written by the BIOS and
+	it cannot be changed by the user.
 thermal_cruise[1-3] - Selects the desired temperature for cruise (degC)
 tolerance[1-3] - Value in degrees of Celsius (degC) for +- T
 sf2_point[1-4]_fan[1-3] - four temperature points for each fan for Smart Fan II
diff -uprN -X a/Documentation/dontdiff a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
--- linux-3.19.0/drivers/hwmon/w83792d.c	2015-02-09 02:54:22.000000000 +0000
+++ linux-3.19.0-new/drivers/hwmon/w83792d.c	2015-05-11 20:38:34.996792747 +0100
@@ -219,6 +219,8 @@ static const u8 W83792D_REG_LEVELS[3][4]
 #define W83792D_REG_VBAT		0x5D
 #define W83792D_REG_I2C_ADDR		0x48
 
+#define W83792D_REG_WDOG_ENABLE		0x02
+
 /*
  * Conversions. Rounding and limit checking is only done on the TO_REG
  * variants. Note that you should be a bit careful with which arguments
@@ -289,11 +291,8 @@ struct w83792d_data {
 	u8 temp1[3];		/* current, over, thyst */
 	u8 temp_add[2][6];	/* Register value */
 	u8 fan_div[7];		/* Register encoding, shifted right */
-	u8 pwm[7];		/*
-				 * We only consider the first 3 set of pwm,
-				 * although 792 chip has 7 set of pwm.
-				 */
-	u8 pwmenable[3];
+	u8 pwm[7];		/* The 7 PWM outputs */
+	u8 pwmenable[3];	/* Only for the first 3 PWM outputs */
 	u32 alarms;		/* realtime status register encoding,combined */
 	u8 chassis;		/* Chassis status */
 	u8 thermal_cruise[3];	/* Smart FanI: Fan1,2,3 target value */
@@ -1075,6 +1074,10 @@ static DEVICE_ATTR(intrusion0_alarm, S_I
 static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0);
 static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1);
 static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2);
+static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 3);
+static SENSOR_DEVICE_ATTR(pwm5, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 4);
+static SENSOR_DEVICE_ATTR(pwm6, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 5);
+static SENSOR_DEVICE_ATTR(pwm7, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 6);
 static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
 			show_pwmenable, store_pwmenable, 1);
 static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO,
@@ -1212,6 +1215,32 @@ static const struct attribute_group w837
 	{ .attrs = w83792d_attributes_fan[3] },
 };
 
+static struct attribute *w83792d_attributes_pwm[4][2] = {
+	{
+		&sensor_dev_attr_pwm4.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_pwm5.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_pwm6.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_pwm7.dev_attr.attr,
+		NULL
+	}
+};
+
+static const struct attribute_group w83792d_group_pwm[4] = {
+	{ .attrs = w83792d_attributes_pwm[0] },
+	{ .attrs = w83792d_attributes_pwm[1] },
+	{ .attrs = w83792d_attributes_pwm[2] },
+	{ .attrs = w83792d_attributes_pwm[3] },
+};
+
 static struct attribute *w83792d_attributes[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
@@ -1406,12 +1435,20 @@ w83792d_probe(struct i2c_client *client,
 		err = sysfs_create_group(&dev->kobj, &w83792d_group_fan[0]);
 		if (err)
 			goto exit_remove_files;
+
+		err = sysfs_create_group(&dev->kobj, &w83792d_group_pwm[0]);
+		if (err)
+			goto exit_remove_files;
 	}
 
 	if (!(val1 & 0x20)) {
 		err = sysfs_create_group(&dev->kobj, &w83792d_group_fan[1]);
 		if (err)
 			goto exit_remove_files;
+
+		err = sysfs_create_group(&dev->kobj, &w83792d_group_pwm[1]);
+		if (err)
+			goto exit_remove_files;
 	}
 
 	val1 = w83792d_read_value(client, W83792D_REG_PIN);
@@ -1425,6 +1462,17 @@ w83792d_probe(struct i2c_client *client,
 		err = sysfs_create_group(&dev->kobj, &w83792d_group_fan[3]);
 		if (err)
 			goto exit_remove_files;
+
+		err = sysfs_create_group(&dev->kobj, &w83792d_group_pwm[3]);
+		if (err)
+			goto exit_remove_files;
+	}
+
+	val1 = w83792d_read_value(client, W83792D_REG_WDOG_ENABLE);
+	if (!(val1 & 0x02)) {
+		err = sysfs_create_group(&dev->kobj, &w83792d_group_pwm[2]);
+		if (err)
+			goto exit_remove_files;
 	}
 
 	data->hwmon_dev = hwmon_device_register(dev);




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
