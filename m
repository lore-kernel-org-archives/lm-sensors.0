From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: max1619
Message-Id: <20040523221440.7a2f9a96.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405211303.18083.fishor@gmx.net>
In-Reply-To: <200405211303.18083.fishor@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Jean
> new diff is ready

I'll review it.

> some more quastions:
>  " || " mean "and"

No. || means "or". && means "and".

diff -ruN lm_sensors2/doc/chips/max1619 lm_sensors/doc/chips/max1619
--- lm_sensors2/doc/chips/max1619	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors/doc/chips/max1619	2004-05-23 13:03:21.000000000 +0200
+Module Parameters
+-----------------

Please insert the module parameters there. Just do "modinfo max1619" and
copy the parameter information here.

+LABEL                 FEATURE SYMBOL                              SYSCTL FILE:N
+temp1                 SENSORS_MAX1619_LOCAL_TEMP               temp1:3

N is 1 for this one.

+temp2                 SENSORS_MAX1619_REMOTE_TEMP              temp2:3
+temp2_max             SENSORS_MAX1619_REMOTE_HIGH              temp2_max_min:2
+temp2_min             SENSORS_MAX1619_REMOTE_LOW               temp2_max_min:1

temp2_max and temp2_min are in file temp2.

+temp2_crit            SENSORS_MAX1619_REMOTE_HYST              temp2_hyst_crit:1
+temp2_hyst            SENSORS_MAX1619_REMOTE_MAX               temp2_hyst_crit:1

N is 2 for temp2_hyst.

Please rename file temp2_hyst_crit to temp2_crit.

diff -ruN lm_sensors2/kernel/chips/max1619.c lm_sensors/kernel/chips/max1619.c
--- lm_sensors2/kernel/chips/max1619.c	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors/kernel/chips/max1619.c	2004-05-23 20:22:47.000000000 +0200
@@ -0,0 +1,525 @@
+/*
+ * max1619.c - Part of lm_sensors, Linux kernel modules for hardware
+ *          monitoring
+ * Copyright (C) 2003-2004 Jean Delvare <khali@linux-fr.org> 
+ *                         Alexey Fisher <fishor@mail.ru>

Hey, put your name first! You are the main author.

+/*
+ * Addresses to scan
+ */
+
+static unsigned short normal_i2c[] = { 0x18, 0x1a, 0x29, 0x2b,
+        0x4c, 0x4e,0x4d, SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };

This is not correct. The addresses are ranges for this driver, i.e not
only "0x18 and 0x1a" but "from 0x18 to 0x1a", which also includes 0x19.
Just use normal_i2c_range instead of normal_i2c, just as the adm1021
driver does.

+#define MAX1619_SYSCTL_REMOTE_CRIT_HYST	1202

Rename to MAX1619_SYSCTL_REMOTE_CRIT.

+static void max1619_remote_temp(struct i2c_client *client, int operation,
+	int ctl_name, int *nrels_mag, long *results)
+{
+	struct max1619_data *data = client->data;
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0; /* magnitude */
+	else if (operation = SENSORS_PROC_REAL_READ)
+	{
+		max1619_update_client(client);
+		results[0] = TEMP_FROM_REG(data->remote_temp);
+		results[1] = TEMP_FROM_REG(data->remote_low);
+		results[2] = TEMP_FROM_REG(data->remote_high);
+		*nrels_mag = 3;
+	}

Order is not correct. Must be high, low and current temperature, in that
order.

+	else if (operation = SENSORS_PROC_REAL_WRITE)
+	{
+		if (*nrels_mag >= 1)
+		{
+			data->remote_low = TEMP_TO_REG(results[1]);
+			i2c_smbus_write_byte_data(client,
+				MAX1619_REG_W_REMOTE_TLOW, data->remote_low);
+		}
+		if (*nrels_mag >= 2)
+		{
+			data->remote_high = TEMP_TO_REG(results[2]);
+			i2c_smbus_write_byte_data(client, 
+				MAX1619_REG_W_REMOTE_THIGH,data->remote_high);
+		
+		}
+	}

So same here: high first, low then.

And this is results[0] and results[1], not [1] and [2].

+MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org> 
+		 Alexey Fisher <fishor@mail.ru>");

Same as above, put your name first.

+MODULE_DESCRIPTION("MAX1619 sensor driver");
+MODULE_LICENSE("GPL");

--- lm_sensors2/lib/chips.c	2004-05-17 20:36:31.000000000 +0200
+++ lm_sensors/lib/chips.c	2004-05-23 19:56:17.000000000 +0200
+    { SENSORS_MAX1619_REMOTE_TEMP, "temp2",
+     NOMAP, NOMAP,
+      R, MAX1619_SYSCTL_REMOTE_TEMP, VALUE(1), 0 },
+    { SENSORS_MAX1619_REMOTE_HIGH, "temp2_min",
+      NOMAP,NOMAP,
+      RW, MAX1619_SYSCTL_REMOTE_TEMP, VALUE(2), 0 },
+    { SENSORS_MAX1619_REMOTE_LOW, "temp2_max",
+      NOMAP, NOMAP,
+      RW, MAX1619_SYSCTL_REMOTE_TEMP, VALUE(3), 0 },

VALUE(N) are not correct, same change as in the driver is needed: max
first, min second, current reading last.

Everything else is just fine :) Congratulations.

I guess that your next patch should be OK and I'll be able to apply it.

Thanks!

-- 
Jean Delvare
http://khali.linux-fr.org/
