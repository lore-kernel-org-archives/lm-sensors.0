From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: max1619
Message-Id: <20040526214054.6f2bcb35.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405211303.18083.fishor@gmx.net>
In-Reply-To: <200405211303.18083.fishor@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> here is two patches for linux kernel and for CVS

I've applied the CVS patch. I changed "temp2_hyst" to "temp2_crit_hyst"
though. In 2.6, hysteresis files have to reflect what they are an
hysteresis for.

About the linux kernel patch now:

diff -ruN linux-2.6.6-mm5/drivers/i2c/chips/Kconfig linux-2.6.6-mm5-max1619/drivers/i2c/chips/Kconfig
--- linux-2.6.6-mm5/drivers/i2c/chips/Kconfig	2004-05-25 08:51:38.000000000 +0200
+++ linux-2.6.6-mm5-max1619/drivers/i2c/chips/Kconfig	2004-05-25 09:01:53.000000000 +0200
+config SENSORS_MAX1619
+	tristate "Maxim MAX1619 sensor chip"
+	depends on I2C

depends on I2C && EXPERIMENTAL

diff -ruN linux-2.6.6-mm5/drivers/i2c/chips/max1619.c linux-2.6.6-mm5-max1619/drivers/i2c/chips/max1619.c
--- linux-2.6.6-mm5/drivers/i2c/chips/max1619.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm5-max1619/drivers/i2c/chips/max1619.c	2004-05-25 09:19:28.000000000 +0200
+ * max1619.c - Part of lm_sensors, Linux kernel modules for hardware
+ *          monitoring
+ * Copyright (C) 2003-2004 Alexey Fisher <fishor@mail.ru>
+ *                              Jean Delvare <khali@linux-fr.org>

Please align "monitoring" on "Part" and "Jean" on "Alexey", using spaces.

+ * Based on the lm90 driver. The MAX1619 is a sensor chip made by Maxim .
+ * It reports up to two temperatures (its own plus up to
+ * one external one) . Complete datasheet can be
+ * obtained from Maxim's website at:
+ *   http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf

No white spaces before dots please.

+#define show_temp(value, converter) \
+static ssize_t show_##value(struct device *dev, char *buf) \
+{ \
+	struct max1619_data *data = max1619_update_device(dev); \
+	return sprintf(buf, "%d\n", converter(data->value)); \
+}
+show_temp(temp_input1, TEMP_FROM_REG);
+show_temp(temp_input2, TEMP_FROM_REG);
+show_temp(temp_low2, TEMP_FROM_REG);
+show_temp(temp_high2, TEMP_FROM_REG);
+show_temp(temp_crit2, TEMP_FROM_REG);
+show_temp(temp_hyst2, TEMP_FROM_REG);

TEMP_FROM_REG doesn't have to be passed by parameter, since it's always
the same.

+static DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit2,
+	set_temp_crit2);
+static DEVICE_ATTR(temp2_hyst, S_IWUSR | S_IRUGO, show_temp_hyst2,
+	set_temp_hyst2);

File has to be named temp2_crit_hyst instead of temp2_hyst.


+static int max1619_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct max1619_data *data;
+	int err = 0;
+        const char *name = "";	

Broken indentation, you have 8 spaces instead of one tabulation.

+	/* The common I2C client data is placed right before the
+	   LM90-specific data. */

You forgot to update that comment.


+	if (kind <= 0) { /* identification */
+	
+		man_id = i2c_smbus_read_byte_data(new_client,
+			 MAX1619_REG_R_MAN_ID);
+		chip_id = i2c_smbus_read_byte_data(new_client,
+			  MAX1619_REG_R_CHIP_ID);
+		
+		if ((man_id = 0x4D) && (chip_id = 0x04)) 
+			{  
+				kind = max1619;
+			}
+		
+		}

Discard these extra empty lines. Move the opening { at the end of the
"if..." line.

+	if (kind = max1619) 
+	{
+		name = "max1619";
+	}

Same here, opening curly brace is misplaced.

+	device_create_file(&new_client->dev, &dev_attr_temp2_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp2_hyst);

Rename here too.

+MODULE_AUTHOR("Alexey Fisher <fishor@mail.ru>" \
+		"Jean Delvare <khali@linux-fr.org>");

No \ here. You can just split the string over lines and the compiler
will join them for you:

MODULE_AUTHOR("Alexey Fisher <fishor@mail.ru> and "
	      "Jean Delvare <khali@linux-fr.org>");

In any case, *you* are the author, I don't deserve to have my name here
;)

Rest is just fine. I told you you could do it! Very impressive :)

Once you have fixed everything, and have tested the new version with
lm_sensors CVS, you should be able to submit your new driver to Greg KH
for inclusion into the main 2.6 tree. Briefly explain what the driver is
for and how you wrote it (including the fact that I reviewed it). Don't
forget to CC: the lm_sensors mailing list. Note that you have to send
the patch *inline* (as opposed to in attachement) when sending patches
to Greg. Make sure that your e-mail client won't break it (various
e-mail clients would break long lines or replace tabs with spaces...).

Thanks, and congratulations again :)

-- 
Jean Delvare
http://khali.linux-fr.org/
