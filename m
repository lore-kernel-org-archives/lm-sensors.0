From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 23 Feb 2007 13:16:22 +0000
Subject: [lm-sensors] [PATCH] hwmon/smsc47m1: Add support for the LPC47M292
Message-Id: <20070223141622.432e8d54.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The new SMSC LPC47M292 Super-I/O chip is a bit different from the
previous ones, it supports a 3rd fan, but unfortunately the pin
configuration registers are different.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/smsc47m1 |   11 ++-
 drivers/hwmon/Kconfig        |    9 +-
 drivers/hwmon/smsc47m1.c     |  160 +++++++++++++++++++++++++++++++++---------
 3 files changed, 139 insertions(+), 41 deletions(-)

--- linux-2.6.21-rc1.orig/Documentation/hwmon/smsc47m1	2007-02-23 09:35:51.000000000 +0100
+++ linux-2.6.21-rc1/Documentation/hwmon/smsc47m1	2007-02-23 13:40:19.000000000 +0100
@@ -14,6 +14,10 @@ Supported chips:
         http://www.smsc.com/main/datasheets/47m14x.pdf
         http://www.smsc.com/main/tools/discontinued/47m15x.pdf
         http://www.smsc.com/main/datasheets/47m192.pdf
+  * SMSC LPC47M292
+    Addresses scanned: none, address read from Super I/O config space
+    Prefix: 'smsc47m2'
+    Datasheet: Not public
   * SMSC LPC47M997
     Addresses scanned: none, address read from Super I/O config space
     Prefix: 'smsc47m1'
@@ -32,9 +36,10 @@ Description
 The Standard Microsystems Corporation (SMSC) 47M1xx Super I/O chips
 contain monitoring and PWM control circuitry for two fans.
 
-The 47M15x and 47M192 chips contain a full 'hardware monitoring block'
-in addition to the fan monitoring and control. The hardware monitoring
-block is not supported by the driver.
+The LPC47M15x, LPC47M192 and LPC47M292 chips contain a full 'hardware
+monitoring block' in addition to the fan monitoring and control. The
+hardware monitoring block is not supported by this driver, use the
+smsc47m192 driver for that.
 
 No documentation is available for the 47M997, but it has the same device
 ID as the 47M15x and 47M192 chips and seems to be compatible.
--- linux-2.6.21-rc1.orig/drivers/hwmon/Kconfig	2007-02-23 09:49:40.000000000 +0100
+++ linux-2.6.21-rc1/drivers/hwmon/Kconfig	2007-02-23 09:49:43.000000000 +0100
@@ -422,11 +422,12 @@ config SENSORS_SMSC47M1
 	  If you say yes here you get support for the integrated fan
 	  monitoring and control capabilities of the SMSC LPC47B27x,
 	  LPC47M10x, LPC47M112, LPC47M13x, LPC47M14x, LPC47M15x,
-	  LPC47M192 and LPC47M997 chips.
+	  LPC47M192, LPC47M292 and LPC47M997 chips.
 
-	  The temperature and voltage sensor features of the LPC47M192
-	  and LPC47M997 are supported by another driver, select also
-	  "SMSC LPC47M192 and compatibles" below for those.
+	  The temperature and voltage sensor features of the LPC47M15x,
+	  LPC47M192, LPC47M292 and LPC47M997 are supported by another
+	  driver, select also "SMSC LPC47M192 and compatibles" below for
+	  those.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47m1.
--- linux-2.6.21-rc1.orig/drivers/hwmon/smsc47m1.c	2007-02-23 09:35:51.000000000 +0100
+++ linux-2.6.21-rc1/drivers/hwmon/smsc47m1.c	2007-02-23 14:04:42.000000000 +0100
@@ -3,10 +3,11 @@
                  for hardware monitoring
 
     Supports the SMSC LPC47B27x, LPC47M10x, LPC47M112, LPC47M13x,
-    LPC47M14x, LPC47M15x, LPC47M192 and LPC47M997 Super-I/O chips.
+    LPC47M14x, LPC47M15x, LPC47M192, LPC47M292 and LPC47M997
+    Super-I/O chips.
 
     Copyright (C) 2002 Mark D. Studebaker <mdsxyz123 at yahoo.com>
-    Copyright (C) 2004 Jean Delvare <khali at linux-fr.org>
+    Copyright (C) 2004-2007 Jean Delvare <khali at linux-fr.org>
     Ported to Linux 2.6 by Gabriele Gorla <gorlik at yahoo.com>
                         and Jean Delvare
 
@@ -40,6 +41,8 @@
 
 /* Address is autodetected, there is no default value */
 static unsigned short address;
+static u8 devid;
+enum chips { smsc47m1, smsc47m2 };
 
 /* Super-I/0 registers and commands */
 
@@ -87,10 +90,18 @@ superio_exit(void)
 #define SMSC47M1_REG_ALARM		0x04
 #define SMSC47M1_REG_TPIN(nr)		(0x34 - (nr))
 #define SMSC47M1_REG_PPIN(nr)		(0x36 - (nr))
-#define SMSC47M1_REG_PWM(nr)		(0x56 + (nr))
 #define SMSC47M1_REG_FANDIV		0x58
-#define SMSC47M1_REG_FAN(nr)		(0x59 + (nr))
-#define SMSC47M1_REG_FAN_PRELOAD(nr)	(0x5B + (nr))
+
+static const u8 SMSC47M1_REG_FAN[3]		= { 0x59, 0x5a, 0x6b };
+static const u8 SMSC47M1_REG_FAN_PRELOAD[3]	= { 0x5b, 0x5c, 0x6c };
+static const u8 SMSC47M1_REG_PWM[3]		= { 0x56, 0x57, 0x69 };
+
+#define SMSC47M2_REG_ALARM6		0x09
+#define SMSC47M2_REG_TPIN1		0x38
+#define SMSC47M2_REG_TPIN2		0x37
+#define SMSC47M2_REG_TPIN3		0x2d
+#define SMSC47M2_REG_PPIN3		0x2c
+#define SMSC47M2_REG_FANDIV3		0x6a
 
 #define MIN_FROM_REG(reg,div)		((reg)>2 ? 0 : \
 					 983040/((192-(reg))*(div)))
@@ -103,17 +114,18 @@ superio_exit(void)
 
 struct smsc47m1_data {
 	struct i2c_client client;
+	enum chips type;
 	struct class_device *class_dev;
 	struct mutex lock;
 
 	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
 
-	u8 fan[2];		/* Register value */
-	u8 fan_preload[2];	/* Register value */
-	u8 fan_div[2];		/* Register encoding, shifted right */
+	u8 fan[3];		/* Register value */
+	u8 fan_preload[3];	/* Register value */
+	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 alarms;		/* Register encoding */
-	u8 pwm[2];		/* Register value (bit 7 is enable) */
+	u8 pwm[3];		/* Register value (bit 0 is disable) */
 };
 
 
@@ -200,7 +212,7 @@ static ssize_t set_fan_min(struct device
 	}
 
 	data->fan_preload[nr] = 192 - ((983040 + rpmdiv / 2) / rpmdiv);
-	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD(nr),
+	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD[nr],
 			     data->fan_preload[nr]);
 	mutex_unlock(&data->update_lock);
 
@@ -234,15 +246,26 @@ static ssize_t set_fan_div(struct device
 		return -EINVAL;
 	}
 
-	tmp = smsc47m1_read_value(client, SMSC47M1_REG_FANDIV) & 0x0F;
-	tmp |= (data->fan_div[0] << 4) | (data->fan_div[1] << 6);
-	smsc47m1_write_value(client, SMSC47M1_REG_FANDIV, tmp);
+	switch (nr) {
+	case 0:
+	case 1:
+		tmp = smsc47m1_read_value(client, SMSC47M1_REG_FANDIV)
+		      & ~(0x03 << (4 + 2 * nr));
+		tmp |= data->fan_div[nr] << (4 + 2 * nr);
+		smsc47m1_write_value(client, SMSC47M1_REG_FANDIV, tmp);
+		break;
+	case 2:
+		tmp = smsc47m1_read_value(client, SMSC47M2_REG_FANDIV3) & 0xCF;
+		tmp |= data->fan_div[2] << 4;
+		smsc47m1_write_value(client, SMSC47M2_REG_FANDIV3, tmp);
+		break;
+	}
 
 	/* Preserve fan min */
 	tmp = 192 - (old_div * (192 - data->fan_preload[nr])
 		     + new_div / 2) / new_div;
 	data->fan_preload[nr] = SENSORS_LIMIT(tmp, 0, 191);
-	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD(nr),
+	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD[nr],
 			     data->fan_preload[nr]);
 	mutex_unlock(&data->update_lock);
 
@@ -263,7 +286,7 @@ static ssize_t set_pwm(struct device *de
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] &= 0x81; /* Preserve additional bits */
 	data->pwm[nr] |= PWM_TO_REG(val);
-	smsc47m1_write_value(client, SMSC47M1_REG_PWM(nr),
+	smsc47m1_write_value(client, SMSC47M1_REG_PWM[nr],
 			     data->pwm[nr]);
 	mutex_unlock(&data->update_lock);
 
@@ -284,7 +307,7 @@ static ssize_t set_pwm_en(struct device 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] &= 0xFE; /* preserve the other bits */
 	data->pwm[nr] |= !val;
-	smsc47m1_write_value(client, SMSC47M1_REG_PWM(nr),
+	smsc47m1_write_value(client, SMSC47M1_REG_PWM[nr],
 			     data->pwm[nr]);
 	mutex_unlock(&data->update_lock);
 
@@ -345,6 +368,7 @@ static DEVICE_ATTR(pwm##offset##_enable,
 
 fan_present(1);
 fan_present(2);
+fan_present(3);
 
 static DEVICE_ATTR(alarms, S_IRUGO, get_alarms, NULL);
 
@@ -358,11 +382,16 @@ static struct attribute *smsc47m1_attrib
 	&dev_attr_fan2_input.attr,
 	&dev_attr_fan2_min.attr,
 	&dev_attr_fan2_div.attr,
+	&dev_attr_fan3_input.attr,
+	&dev_attr_fan3_min.attr,
+	&dev_attr_fan3_div.attr,
 
 	&dev_attr_pwm1.attr,
 	&dev_attr_pwm1_enable.attr,
 	&dev_attr_pwm2.attr,
 	&dev_attr_pwm2_enable.attr,
+	&dev_attr_pwm3.attr,
+	&dev_attr_pwm3_enable.attr,
 
 	&dev_attr_alarms.attr,
 	NULL
@@ -377,7 +406,7 @@ static int __init smsc47m1_find(unsigned
 	u8 val;
 
 	superio_enter();
-	val = superio_inb(SUPERIO_REG_DEVID);
+	devid = superio_inb(SUPERIO_REG_DEVID);
 
 	/*
 	 * SMSC LPC47M10x/LPC47M112/LPC47M13x (device id 0x59), LPC47M14x
@@ -386,18 +415,29 @@ static int __init smsc47m1_find(unsigned
 	 * can do much more besides (device id 0x60).
 	 * The LPC47M997 is undocumented, but seems to be compatible with
 	 * the LPC47M192, and has the same device id.
+	 * The LPC47M292 (device id 0x6B) is somewhat compatible, but it
+	 * supports a 3rd fan, and the pin configuration registers are
+	 * unfortunately different.
 	 */
-	if (val = 0x51)
+	switch (devid) {
+	case 0x51:
 		printk(KERN_INFO "smsc47m1: Found SMSC LPC47B27x\n");
-	else if (val = 0x59)
+		break;
+	case 0x59:
 		printk(KERN_INFO "smsc47m1: Found SMSC "
 		       "LPC47M10x/LPC47M112/LPC47M13x\n");
-	else if (val = 0x5F)
+		break;
+	case 0x5F:
 		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M14x\n");
-	else if (val = 0x60)
+		break;
+	case 0x60:
 		printk(KERN_INFO "smsc47m1: Found SMSC "
 		       "LPC47M15x/LPC47M192/LPC47M997\n");
-	else {
+		break;
+	case 0x6B:
+		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M292\n");
+		break;
+	default:
 		superio_exit();
 		return -ENODEV;
 	}
@@ -421,7 +461,7 @@ static int smsc47m1_detect(struct i2c_ad
 	struct i2c_client *new_client;
 	struct smsc47m1_data *data;
 	int err = 0;
-	int fan1, fan2, pwm1, pwm2;
+	int fan1, fan2, fan3, pwm1, pwm2, pwm3;
 
 	if (!request_region(address, SMSC_EXTENT, smsc47m1_driver.driver.name)) {
 		dev_err(&adapter->dev, "Region 0x%x already in use!\n", address);
@@ -433,6 +473,7 @@ static int smsc47m1_detect(struct i2c_ad
 		goto error_release;
 	}
 
+	data->type = devid = 0x6B ? smsc47m2 : smsc47m1;
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
@@ -441,20 +482,35 @@ static int smsc47m1_detect(struct i2c_ad
 	new_client->driver = &smsc47m1_driver;
 	new_client->flags = 0;
 
-	strlcpy(new_client->name, "smsc47m1", I2C_NAME_SIZE);
+	strlcpy(new_client->name,
+		data->type = smsc47m2 ? "smsc47m2" : "smsc47m1",
+		I2C_NAME_SIZE);
 	mutex_init(&data->update_lock);
 
 	/* If no function is properly configured, there's no point in
 	   actually registering the chip. */
-	fan1 = (smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(0)) & 0x05)
-	       = 0x05;
-	fan2 = (smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(1)) & 0x05)
-	       = 0x05;
 	pwm1 = (smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(0)) & 0x05)
 	       = 0x04;
 	pwm2 = (smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(1)) & 0x05)
 	       = 0x04;
-	if (!(fan1 || fan2 || pwm1 || pwm2)) {
+	if (data->type = smsc47m2) {
+		fan1 = (smsc47m1_read_value(new_client, SMSC47M2_REG_TPIN1)
+			& 0x0d) = 0x09;
+		fan2 = (smsc47m1_read_value(new_client, SMSC47M2_REG_TPIN2)
+			& 0x0d) = 0x09;
+		fan3 = (smsc47m1_read_value(new_client, SMSC47M2_REG_TPIN3)
+			& 0x0d) = 0x0d;
+		pwm3 = (smsc47m1_read_value(new_client, SMSC47M2_REG_PPIN3)
+			& 0x0d) = 0x08;
+	} else {
+		fan1 = (smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(0))
+			& 0x05) = 0x05;
+		fan2 = (smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(1))
+			& 0x05) = 0x05;
+		fan3 = 0;
+		pwm3 = 0;
+	}
+	if (!(fan1 || fan2 || fan3 || pwm1 || pwm2 || pwm3)) {
 		dev_warn(&adapter->dev, "Device at 0x%x is not configured, "
 			 "will not use\n", new_client->addr);
 		err = -ENODEV;
@@ -497,6 +553,18 @@ static int smsc47m1_detect(struct i2c_ad
 		dev_dbg(&new_client->dev, "Fan 2 not enabled by hardware, "
 			"skipping\n");
 
+	if (fan3) {
+		if ((err = device_create_file(&new_client->dev,
+					      &dev_attr_fan3_input))
+		 || (err = device_create_file(&new_client->dev,
+					      &dev_attr_fan3_min))
+		 || (err = device_create_file(&new_client->dev,
+					      &dev_attr_fan3_div)))
+			goto error_remove_files;
+	} else
+		dev_dbg(&new_client->dev, "Fan 3 not enabled by hardware, "
+			"skipping\n");
+
 	if (pwm1) {
 		if ((err = device_create_file(&new_client->dev,
 					      &dev_attr_pwm1))
@@ -506,6 +574,7 @@ static int smsc47m1_detect(struct i2c_ad
 	} else
 		dev_dbg(&new_client->dev, "PWM 1 not enabled by hardware, "
 			"skipping\n");
+
 	if (pwm2) {
 		if ((err = device_create_file(&new_client->dev,
 					      &dev_attr_pwm2))
@@ -516,6 +585,16 @@ static int smsc47m1_detect(struct i2c_ad
 		dev_dbg(&new_client->dev, "PWM 2 not enabled by hardware, "
 			"skipping\n");
 
+	if (pwm3) {
+		if ((err = device_create_file(&new_client->dev,
+					      &dev_attr_pwm3))
+		 || (err = device_create_file(&new_client->dev,
+					      &dev_attr_pwm3_enable)))
+			goto error_remove_files;
+	} else
+		dev_dbg(&new_client->dev, "PWM 3 not enabled by hardware, "
+			"skipping\n");
+
 	if ((err = device_create_file(&new_client->dev, &dev_attr_alarms)))
 		goto error_remove_files;
 
@@ -580,15 +659,16 @@ static struct smsc47m1_data *smsc47m1_up
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2) || init) {
-		int i;
+		int i, fan_nr;
+		fan_nr = data->type = smsc47m2 ? 3 : 2;
 
-		for (i = 0; i < 2; i++) {
+		for (i = 0; i < fan_nr; i++) {
 			data->fan[i] = smsc47m1_read_value(client,
-				       SMSC47M1_REG_FAN(i));
+				       SMSC47M1_REG_FAN[i]);
 			data->fan_preload[i] = smsc47m1_read_value(client,
-					       SMSC47M1_REG_FAN_PRELOAD(i));
+					       SMSC47M1_REG_FAN_PRELOAD[i]);
 			data->pwm[i] = smsc47m1_read_value(client,
-				       SMSC47M1_REG_PWM(i));
+				       SMSC47M1_REG_PWM[i]);
 		}
 
 		i = smsc47m1_read_value(client, SMSC47M1_REG_FANDIV);
@@ -601,6 +681,18 @@ static struct smsc47m1_data *smsc47m1_up
 		if (data->alarms)
 			smsc47m1_write_value(client, SMSC47M1_REG_ALARM, 0xC0);
 
+		if (fan_nr >= 3) {
+			data->fan_div[2] = (smsc47m1_read_value(client,
+					    SMSC47M2_REG_FANDIV3) >> 4) & 0x03;
+			data->alarms |= (smsc47m1_read_value(client,
+					 SMSC47M2_REG_ALARM6) & 0x40) >> 4;
+			/* Clear alarm if needed */
+			if (data->alarms & 0x04)
+				smsc47m1_write_value(client,
+						     SMSC47M2_REG_ALARM6,
+						     0x40);
+		}
+
 		data->last_updated = jiffies;
 	}
 


-- 
Jean Delvare

