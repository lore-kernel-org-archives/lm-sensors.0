From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: max1619
Message-Id: <20040522163232.56388d82.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405211303.18083.fishor@gmx.net>
In-Reply-To: <200405211303.18083.fishor@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Jean
> this is CVS only. I'm not redy with kernel.

OK. My comments below.

> Do you hawe some think about C++ and  about kernel?
>  I jast won to anderstend what i do.

Not sure I get what you mean. At any rate, the Linux kernel is written
in C and no C++ code is allowed. Just start from an existing driver, and
it shouldn't be too hard to adapt the code for your MAX1619 chip.

diff -ruN lm_sensors2/doc/chips/max1619 lm_sensors/doc/chips/max1619
--- lm_sensors2/doc/chips/max1619	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors/doc/chips/max1619	2004-05-22 14:19:45.000000000 +0200
@@ -0,0 +1,73 @@
+Kernel driver `lm90.o'
+===========

You forgot to edit the header line!

+Supported chips: 
+  * Maxim max1619
+    Prefix: `max1619'
+    Addresses scanned: I2C 0x4d

The MAX1619 supports 9 different addresses (same as the MAX1617).

+The different chipsets of the family are not strictly identical, although
+very similar. This driver doesn't handle any specific feature for now,
+but could if there ever was a need for it. For reference, here comes a
+non-exhaustive list of specific features:

This paragraph is irrelevant here, since your driver handles a single
chip.

+Additionally, there is a relative hysteresis value common to  critical
+value. Remote  hysteresis can be set from user-space.

The hysteresis value isn't common to anything, it's dedicated to the
remote temperature. Same goes for the critical limit.

All limits can be set (for all drivers) from user-space so mentioning it
here isn't particularly interesting.

+Chips 'max1619'
+
+LABEL                 LABEL CLASS           COMPUTE CLASS          MODE  MAGN
+l_temp                 -                     -                       R-     0
+r_temp                 -                     -                       R-     0
+r_high                r_temp                r_temp                   RW     0
+r_low                 r_temp                r-temp                   RW     0
+r_max                 r_temp                r_temp                   RW     0
+r_hyst                r_temp                r_temp                   RW     0
+alarms                 -                     -                       R-     0

No, please use standard symbol names. temp1, temp2, temp2_max,
temp2_min, temp2_hyst, temp2_crit.

diff -ruN lm_sensors2/etc/sensors.conf.eg lm_sensors/etc/sensors.conf.eg
--- lm_sensors2/etc/sensors.conf.eg	2004-05-21 16:08:17.000000000 +0200
+++ lm_sensors/etc/sensors.conf.eg	2004-05-22 14:39:46.000000000 +0200
@@ -1718,6 +1718,26 @@
 # should be higher than each of the high limits above
 #   set tcrit 85
 
+chip "max1619-*"
+
+   label l_temp "M/B Temp"
+   label r_temp "CPU Temp"
+   label r_low  "CPU Low:"
+   label r_high  "CPU High:"
+   label r_max  "CPU Max:(Fan ON)"
+   label r_hyst  "CPU Hyst:(Fan OFF)"

Labels for limits are never display, so I wouldn't bother setting them.

diff -ruN lm_sensors2/kernel/chips/max1619.c lm_sensors/kernel/chips/max1619.c
--- lm_sensors2/kernel/chips/max1619.c	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors/kernel/chips/max1619.c	2004-05-22 14:10:54.000000000 +0200
@@ -0,0 +1,561 @@
+/*
+ * max1619.c - Part of lm_sensors, Linux kernel modules for hardware
+ *          monitoring
+ * Copyright (C) 2003-2004  Aleey Fisher <fishor@mail.ru>

You should mention the fact that you started from the lm90 driver.

+#ifndef I2C_DRIVERID_MAX1619
+#define I2C_DRIVERID_MAX1619	1049
+#endif

You don't really need an ID.

+static unsigned short normal_i2c[] = { 0x4d, SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };

As said earlier, please support all address. You'll find the list in
adm1021.c.

+#define MAX1619_REG_R_MAN_ID        0xFE
+#define MAX1619_REG_R_CHIP_ID       0xFF

Please align constants using tabs, not white spaces.

+#define TEMP_FROM_REG(val)  (val & 0x80 ? val-0x100 : val)
+#define TEMP_TO_REG(val)    (val < 0 ? val+0x100 : val)

Your macros aren't safe. It's better to surround any use of the
parameters with parenthesis:

#define TEMP_FROM_REG(val)  ((val) & 0x80 ? (val)-0x100 : (val))
#define TEMP_TO_REG(val)    ((val) < 0 ? (val)+0x100 : (val))

+static struct i2c_driver max1619_driver = {
+	.owner          = THIS_MODULE,
+	.name           = "MAX1619 sensor driver",
+	.id             = I2C_DRIVERID_MAX1619,
+	.flags          = I2C_DF_NOTIFY,
+	.attach_adapter = max1619_attach_adapter,
+	.detach_client  = max1619_detach_client
+};

Don't mention .id here, it's OK.

+/*
+ * Proc entries
+ * These files are created for each detected LM90.
+ */

Edit that comment!

+#define MAX1619_SYSCTL_LOCAL_TEMP     1200
+#define MAX1619_SYSCTL_REMOTE_TEMP    1201
+#define MAX1619_SYSCTL_REMOTE_CRYT    1205
+#define MAX1619_SYSCTL_REMOTE_TMAX    1207
+#define MAX1619_SYSCTL_REMOTE_THYST   1208
+#define MAX1619_SYSCTL_ALARMS         1210

You don't need all these. You need one SYSCTL value per file, not
symbol. You need one for temp1, one for temp2/min/max, one for
temp2_crit/hyst, and one for alarms.

+static ctl_table max1619_dir_table_template[] +{
+	{MAX1619_SYSCTL_LOCAL_TEMP, "l_temp", NULL, 0, 0644, NULL,
+	 &i2c_proc_real, &i2c_sysctl_real, NULL, &max1619_local_temp},

This one can be read-only (444), since it doesn't have any limit.

+	{MAX1619_SYSCTL_ALARMS, "alarms", NULL, 0, 0644, NULL,
+	 &i2c_proc_real, &i2c_sysctl_real, NULL, &max1619_alarms},

This one should be read-only as well.

+	if (kind < 0) 
+	{
+		u8 reg_config, reg_convrate;
+		reg_config = i2c_smbus_read_byte_data(new_client,
+			MAX1619_REG_R_CONFIG);
+		reg_convrate = i2c_smbus_read_byte_data(new_client,
+			MAX1619_REG_R_CONVRATE);
+
+		if ((reg_config & 0x03) != 0x00 )
+		{
+#ifdef DEBUG
+			printk(KERN_DEBUG "max1619.o: Detection failed at 0x%02x.\n",
+				address);
+#endif
+			goto ERROR1;
+		}
+	}

You forgot to cgecj trhe conversion rate register . It has to be <0x07. You could use the status register as well, for which reg & 0x61
should be 0.

+	if (kind <= 0) 
+	{
+		u8 man_id, chip_id;
+
+		man_id = i2c_smbus_read_byte_data(new_client,
+			MAX1619_REG_R_MAN_ID);
+		chip_id = i2c_smbus_read_byte_data(new_client,
+			MAX1619_REG_R_CHIP_ID);
+		if ((man_id & 0x4D) && (chip_id & 0x04))
+		{
+
+			kind = max1619;
+
+		}	
+	
+	}

You check is not correct. It should be (man_id = 0x4D) && (chip_id =
0x04).

+static void max1619_init_client(struct i2c_client *client)
+{
+	u8 config;
+
+	/*
+	 * Start the conversions.
+	 */
+
+	i2c_smbus_write_byte_data(client, MAX1619_REG_W_CONVRATE,
+		5); /* 2 Hz */
+	config = i2c_smbus_read_byte_data(client, MAX1619_REG_R_CONFIG);
+	if (config & 0x40)
+		i2c_smbus_write_byte_data(client, MAX1619_REG_W_CONFIG,
+			config & 0x0C); /* run */
+}

This doesn't preserve configuration bits. You should write back config &
0xBF.

+static void max1619_remote_temp(struct i2c_client *client, int operation,
+        int ctl_name, int *nrels_mag, long *results)
+{
+        struct max1619_data *data = client->data;
+
+        if (operation = SENSORS_PROC_REAL_INFO)
+                *nrels_mag = 0; /* magnitude */
+        else if (operation = SENSORS_PROC_REAL_READ)
+        {
+                max1619_update_client(client);
+                results[0] = TEMP_FROM_REG(data->remote_temp);
+                *nrels_mag = 1;
+        }
+
+}
+
+static void max1619_remote_cryt(struct i2c_client *client, int operation,
+	int ctl_name, int *nrels_mag, long *results)
+{
+	struct max1619_data *data = client->data;
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0; /* magnitude */
+	else if (operation = SENSORS_PROC_REAL_READ)
+	{
+		max1619_update_client(client);
+		results[0] = TEMP_FROM_REG(data->remote_thigh);
+		results[1] = TEMP_FROM_REG(data->remote_tlow);
+		*nrels_mag = 2;
+	}
+	else if (operation = SENSORS_PROC_REAL_WRITE)
+	{
+		if (*nrels_mag >= 1)
+		{
+			data->remote_thigh = TEMP_TO_REG(results[0]);
+			i2c_smbus_write_byte_data(client,
+				MAX1619_REG_W_REMOTE_THIGH, data->remote_thigh);
+		}
+		if (*nrels_mag >= 2)
+		{
+			data->remote_tlow = TEMP_TO_REG(results[1]);
+			i2c_smbus_write_byte_data(client, 
+				MAX1619_REG_W_REMOTE_TLOW,data->remote_tlow);
+		
+		}
+	}
+}

Merge these two into a single one. The same file will return, in order,
high limit, low limit and current reading.

+static void max1619_remote_tmax(struct i2c_client *client, int operation,
+	int ctl_name, int *nrels_mag, long *results)
+{
+	struct max1619_data *data = client->data;
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0; /* magnitude */
+	else if (operation = SENSORS_PROC_REAL_READ)
+	{
+		max1619_update_client(client);
+		results[0] = TEMP_FROM_REG(data->remote_max);
+		*nrels_mag = 1;
+	}
+	else if (operation = SENSORS_PROC_REAL_WRITE)
+	{
+		if (*nrels_mag >= 1)
+		{
+			data->remote_max = TEMP_TO_REG(results[0]);
+			i2c_smbus_write_byte_data(client,
+				MAX1619_REG_W_REMOTE_TMAX,data->remote_max);
+		}
+	}
+}
+
+static void max1619_remote_thyst(struct i2c_client *client, int operation,
+	int ctl_name, int *nrels_mag, long *results)
+{
+	struct max1619_data *data = client->data;
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0; /* magnitude */
+	else if (operation = SENSORS_PROC_REAL_READ)
+	{
+		max1619_update_client(client);
+		results[0] = TEMP_FROM_REG(data->remote_hyst);
+		*nrels_mag = 1;
+	}
+	else if (operation = SENSORS_PROC_REAL_WRITE)
+	{
+		if (*nrels_mag >= 1 )
+		{
+			data->remote_hyst = TEMP_TO_REG(results[0]);
+			i2c_smbus_write_byte_data(client,
+			       MAX1619_REG_W_REMOTE_THYST, data->remote_hyst);
+		}
+	}
+}

Merge these two ones as well. A single file should contain, in order,
the critical limit and the hysteresis value.

--- lm_sensors2/lib/chips.h	2004-05-17 21:02:31.000000000 +0200
+++ lm_sensors/lib/chips.h	2004-05-22 14:16:00.000000000 +0200
@@ -1855,6 +1855,18 @@
 #define SENSORS_XEONTEMP_REMOTE_TEMP_OVER 56 /* RW */
 #define SENSORS_XEONTEMP_ALARMS 81 /* R */
 
+/* MAX1619 chipp */

"chip", not "chipp".

diff -ruN lm_sensors2/prog/sensors/chips.c lm_sensors/prog/sensors/chips.c
--- lm_sensors2/prog/sensors/chips.c	2004-05-18 21:49:08.000000000 +0200
+++ lm_sensors/prog/sensors/chips.c	2004-05-22 14:17:42.000000000 +0200
(...)
+ if (!sensors_get_label_and_valid(*name, SENSORS_MAX1619_REMOTE_TEMP,
+      &label, &valid)
+   && !sensors_get_feature(*name, SENSORS_MAX1619_REMOTE_TEMP, &cur)
+   && !sensors_get_feature(*name, SENSORS_MAX1619_REMOTE_LOW, &low)
+   && !sensors_get_feature(*name, SENSORS_MAX1619_REMOTE_HIGH, &high))
+ {
+    if (valid) {
+      print_label(label, 10);
+      print_temp_info(cur, low, high, MINMAX, 1, 1);

Magnitude is 0 for these as well.

+      printf(" %s\n",
+        alarms&MAX1619_ALARM_REMOTE_OPEN?"DISCONNECT":
+        alarms&MAX1619_ALARM_REMOTE_OVERT?"FAN OFF":

OVERT belongs to the second set of limits (max/hyst) below.

OK, this is a really good job you did here :) Please correct everything
I mentioned and submit a new patch. I'll apply it to our CVS repository.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
