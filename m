From: jmunsin@iki.fi (Jonas Munsin)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: pwm fan control with IT8705F I/O chip it87 module
Message-Id: <20041208215302.GA5665@nemo.sby.abo.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128203714.40067.qmail@web13425.mail.yahoo.com>
In-Reply-To: <20041128203714.40067.qmail@web13425.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Dec 08, 2004 at 06:44:17PM +0200, Jonas Munsin wrote:
> kernel to appear (still running 2.6.7).

Ok, I upgraded to 2.6.10-rc3.

Bellow is an updated version of my manual pwm patch, originally
submitted as http://archives.andrew.net.au/lm-sensors/msg27510.html .
I updated it to the last pwm spec. (It contains reset removal,
minor whitespace fixes and manual pwm support).

I added a comment about the initialization stuff you remarked on at
http://archives.andrew.net.au/lm-sensors/msg27570.html (i.e., it can be
removed with some additional work - I might need to look at this again
later).

This was a quick conversation to 2.6.10-rc3, hopefully I didn't make any
copy/paste mistakes.

I'll do the auto pwm part later, I need to sleep.

Note to myself:
this is it87.c_2.6.10-rc3-jm1-fixes_and_manual_pwm_20041208, combining
it87.c_2.6.10-rc3-jm-10-removed_reset_20041208
it87.c_2.6.10-rc3-jm-20-whitespace_fixes_20041208
it87.c_2.6.10-rc3-jm-30-manual_pwm_20041208


--- drivers/i2c/chips/it87.c_2.6.10-rc3	2004-12-08 22:30:51.000000000 +0200
+++ drivers/i2c/chips/it87.c	2004-12-08 23:34:27.000000000 +0200
@@ -96,9 +96,6 @@ superio_exit(void)
 /* Update battery voltage after every reading if true */
 static int update_vbat;
 
-/* Reset the registers on init if true */
-static int reset;
-
 /* Chip Type */
 
 static u16 chip_type;
@@ -128,6 +125,8 @@ static u16 chip_type;
 #define IT87_REG_FAN(nr)       (0x0d + (nr))
 #define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
 #define IT87_REG_FAN_MAIN_CTRL 0x13
+#define IT87_REG_FAN_CTL       0x14
+#define IT87_REG_PWM(nr)       (0x15 + (nr))
 
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
 #define IT87_REG_TEMP(nr)      (0x29 + (nr))
@@ -164,6 +163,9 @@ static inline u8 FAN_TO_REG(long rpm, in
 
 #define ALARMS_FROM_REG(val) (val)
 
+#define PWM_TO_REG(val)   ((val) >> 1)
+#define PWM_FROM_REG(val) (((val)&0x7f) << 1)
+
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
@@ -200,6 +202,8 @@ struct it87_data {
 	u8 vid;			/* Register encoding, combined */
 	int vrm;
 	u32 alarms;		/* Register encoding, combined */
+	u8 fan_main_ctrl;	/* Register value */
+	u8 manual_pwm_ctl[3];   /* Register encoding */
 };
 
 
@@ -440,18 +444,28 @@ static ssize_t show_fan(struct device *d
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
-				DIV_FROM_REG(data->fan_div[nr])) );
+				DIV_FROM_REG(data->fan_div[nr])));
 }
 static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n",
-		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])) );
+		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])));
 }
 static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]));
+}
+static ssize_t show_pwm_enable(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", (data->fan_main_ctrl & (1 << nr)) ? 1 : 0);
+}
+static ssize_t show_pwm(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", PWM_FROM_REG(data->manual_pwm_ctl[nr]));
 }
 static ssize_t set_fan_min(struct device *dev, const char *buf, 
 		size_t count, int nr)
@@ -499,6 +513,48 @@ static ssize_t set_fan_div(struct device
 	}
 	return count;
 }
+static ssize_t set_pwm_enable(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int tmp;
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val = 0) {
+		data->fan_main_ctrl &= ~(1 << nr);
+		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		/* make sure the fan is on */
+		tmp = it87_read_value(client, IT87_REG_FAN_CTL);
+		if ((tmp & (1 << nr)) = 0)
+			it87_write_value(client, IT87_REG_FAN_CTL, tmp | (1 << nr));
+	} else if (val = 1) {
+		/* set SmartGuardian mode */
+		data->fan_main_ctrl |= (1 << nr);
+		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		/* set saved pwm value and FAN_CTLX PWM mode bit */
+		it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr] & 0x7f);
+	} else
+		return -EINVAL;
+
+	return count;
+}
+static ssize_t set_pwm(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
+	data->manual_pwm_ctl[nr] = PWM_TO_REG(val);
+	if (data->fan_main_ctrl & (1 << nr))
+		it87_write_value(client, IT87_REG_PWM(nr), data->manual_pwm_ctl[nr]);
+
+	return count;
+}
 
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
@@ -533,6 +589,36 @@ show_fan_offset(1);
 show_fan_offset(2);
 show_fan_offset(3);
 
+#define show_pwm_offset(offset)						\
+static ssize_t show_pwm##offset##_enable (struct device *dev,		\
+	char *buf)							\
+{									\
+	return show_pwm_enable(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_pwm##offset (struct device *dev, char *buf)		\
+{									\
+	return show_pwm(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t set_pwm##offset##_enable (struct device *dev,		\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm_enable(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_pwm##offset (struct device *dev,			\
+		const char *buf, size_t count)				\
+{									\
+	return set_pwm(dev, buf, count, 0x##offset - 1);		\
+}									\
+static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,		\
+		show_pwm##offset##_enable,				\
+		set_pwm##offset##_enable);				\
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
+		show_pwm##offset , set_pwm##offset );
+
+show_pwm_offset(1);
+show_pwm_offset(2);
+show_pwm_offset(3);
+
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
@@ -774,6 +860,12 @@ int it87_detect(struct i2c_adapter *adap
 	device_create_file(&new_client->dev, &dev_attr_fan2_div);
 	device_create_file(&new_client->dev, &dev_attr_fan3_div);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
+	device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm1);
+	device_create_file(&new_client->dev, &dev_attr_pwm2);
+	device_create_file(&new_client->dev, &dev_attr_pwm3);
 
 	if (data->type = it8712) {
 		device_create_file_vrm(new_client);
@@ -851,12 +943,17 @@ static int it87_write_value(struct i2c_c
 /* Called when we have found a new IT87. */
 static void it87_init_client(struct i2c_client *client, struct it87_data *data)
 {
-	int tmp;
+	int tmp, i;
 
-	if (reset) {
-		/* Reset all except Watchdog values and last conversion values
-		   This sets fan-divs to 2, among others */
-		it87_write_value(client, IT87_REG_CONFIG, 0x80);
+	/* initialize to sane defaults:
+	 * - if the chip is in manual pwm mode, this will be overwritten with
+	 *   the actual settings on the chip (so in this case, initialization
+	 *   is not needed)
+	 * - if in automatic or on/off mode, we could switch to manual mode,
+	 *   read the registers and set manual_pwm_ctl accordingly, but currently
+	 *   this is not implemented, so we initialize to something sane */
+	for (i = 0; i < 3; i++) {
+		data->manual_pwm_ctl[i] = 0x7f;
 	}
 
 	/* Check if temperature channnels are reset manually or by some reason */
@@ -876,13 +973,37 @@ static void it87_init_client(struct i2c_
 	}
 
 	/* Check if tachometers are reset manually or by some reason */
-	tmp = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
-	if ((tmp & 0x70) = 0) {
+	data->fan_main_ctrl = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
+	if ((data->fan_main_ctrl & 0x70) = 0) {
 		/* Enable all fan tachometers */
-		tmp = (tmp & 0x8f) | 0x70;
-		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, tmp);
+		data->fan_main_ctrl |= 0x70;
+		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 	}
 
+	/* Set current fan mode registers and the default settings for the
+	 * other mode registers */
+	for (i = 0; i < 3; i++) {
+		if (data->fan_main_ctrl & (1 << i)) {
+			/* pwm mode */
+			tmp = it87_read_value(client, IT87_REG_PWM(i));
+			if (tmp & 0x80) {
+				/* automatic pwm - not yet implemented, but
+				 * leave the settings made by the BIOS alone
+				 * until a change is requested via the sysfs
+				 * interface */
+			} else {
+				/* manual pwm */
+				data->manual_pwm_ctl[i] = tmp & 0x7f;
+			}
+		} else {
+			/* on/off mode, make sure the fan is on */
+			tmp = it87_read_value(client, IT87_REG_FAN_CTL);
+			if ((tmp & (1 << i)) = 0)
+				it87_write_value(client,
+						IT87_REG_FAN_CTL, tmp | (1 << i));
+		}
+ 	}
+
 	/* Start monitoring */
 	it87_write_value(client, IT87_REG_CONFIG,
 			 (it87_read_value(client, IT87_REG_CONFIG) & 0x36)
@@ -984,8 +1105,6 @@ MODULE_AUTHOR("Chris Gauthron <chrisg@0-
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
-module_param(reset, bool, 0);
-MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);
