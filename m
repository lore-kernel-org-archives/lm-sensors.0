From: Bjoern Gerhart <oss@extracloud.de>
Date: Thu, 01 Dec 2011 20:59:40 +0000
Subject: [lm-sensors] [PATCH] f75375s: added Fintek f75387 support
Message-Id: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

as seen in the lm-sensor's current "Device Support Status", the f75387
is already detected by sensors-detect but not yet supported by any
module. Because most of the f75387 behaviour seems to be the same as
of the f75375s, I modified this existing module.

So, below you find a patch inline of this mail, which enables the
Fintek f75387 support to the existing kernel source code of
drivers/hwmon/f75375s.c. The patch has been developed against kernel
2.6.39.4. The main difference concerning the datasheet compared to
f75375 seems to be the 11bit temperature read.
On the system I own (it's an Atom board whose vendor/model I'll lookup
later) the sensor reads for voltages and temperatures of the f75387
seem to be plausible. The fan inputs are not connected on that board
anyway, so they get ignore'd in my sensors3.conf (therefore unable to
test its fan inputs).

Reviews and comments welcome  ;-)

--
Bjoern Gerhart



--- linux-2.6.39.4-orig/drivers/hwmon/f75375s.c	2011-11-23
09:48:00.000000000 +0100
+++ linux-2.6.39.4/drivers/hwmon/f75375s.c	2011-12-01 14:33:33.000000000 +0100
@@ -1,6 +1,6 @@
/*
- * f75375s.c - driver for the Fintek F75375/SP and F75373
- *             hardware monitoring features
+ * f75375s.c - driver for the Fintek F75375/SP, F75373 and
+ *             F75387SG/RG hardware monitoring features
 * Copyright (C) 2006-2007  Riku Voipio
 *
 * Datasheets available at:
@@ -10,6 +10,9 @@
 *
 * f75373:
 * http://www.fintek.com.tw/files/productfiles/F75373_V025P.pdf
+ *
+ * f75387:
+ * http://www.fintek.com.tw/files/productfiles/F75387_V027P.pdf
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
@@ -40,7 +43,7 @@
/* Addresses to scan */
static const unsigned short normal_i2c[] = { 0x2d, 0x2e, I2C_CLIENT_END };

-enum chips { f75373, f75375 };
+enum chips { f75373, f75375, f75387 };

/* Fintek F75375 registers  */
#define F75375_REG_CONFIG0		0x0
@@ -59,6 +62,8 @@
#define F75375_REG_VOLT_LOW(nr)		(0x21 + (nr) * 2)

#define F75375_REG_TEMP(nr)		(0x14 + (nr))
+#define F75387_REG_TEMP11_MSB(nr)	(0x14 + (nr))
+#define F75387_REG_TEMP11_LSB(nr)	(0x14 + (nr) + 6)
#define F75375_REG_TEMP_HIGH(nr)	(0x28 + (nr) * 2)
#define F75375_REG_TEMP_HYST(nr)	(0x29 + (nr) * 2)

@@ -111,6 +116,10 @@
	s8 temp[2];
	s8 temp_high[2];
	s8 temp_max_hyst[2];
+	/* f75387: For remote temperature reading, it uses signed 11-bit
+	 * values with LSB = 0.125 degree Celsius, left-justified in 16-bit registers.
+	 */
+	s16 temp11[2];
};

static int f75375_detect(struct i2c_client *client,
@@ -122,6 +131,7 @@
static const struct i2c_device_id f75375_id[] = {
	{ "f75373", f75373 },
	{ "f75375", f75375 },
+	{ "f75387", f75387 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, f75375_id);
@@ -205,8 +215,17 @@
	if (time_after(jiffies, data->last_updated + 2 * HZ)
		|| !data->valid) {
		for (nr = 0; nr < 2; nr++) {
-			data->temp[nr] -				f75375_read8(client, F75375_REG_TEMP(nr));
+			if (!strcmp(client->name, "f75387")) {
+				/* First assign the most significant byte, therefore shift it by 8 bits */
+				data->temp11[nr] +					f75375_read8(client, F75387_REG_TEMP11_MSB(nr)) << 8;
+				/* then assign the least significant byte without changing MSB */
+				data->temp11[nr] |+					f75375_read8(client, F75387_REG_TEMP11_LSB(nr));
+			} else {
+				data->temp[nr] +					f75375_read8(client, F75375_REG_TEMP(nr));				
+			}
			data->fan[nr] 				f75375_read16(client, F75375_REG_FAN(nr));
		}
@@ -433,8 +452,10 @@
	mutex_unlock(&data->update_lock);
	return count;
}
+
#define TEMP_FROM_REG(val) ((val) * 1000)
#define TEMP_TO_REG(val) ((val) / 1000)
+#define TEMP11_FROM_REG(reg)	((reg) / 32 * 125)

static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
		char *buf)
@@ -444,6 +465,14 @@
	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
}

+static ssize_t show_temp11(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct f75375_data *data = f75375_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP11_FROM_REG(data->temp11[nr]));
+}
+
static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
		char *buf)
{
@@ -491,6 +520,7 @@
	return count;
}

+
#define show_fan(thing) \
static ssize_t show_##thing(struct device *dev, struct device_attribute *attr, \
			char *buf)\
@@ -596,6 +626,7 @@
	NULL
};

+
static const struct attribute_group f75375_group = {
	.attrs = f75375_attributes,
};
@@ -631,6 +662,12 @@
	mutex_init(&data->update_lock);
	data->kind = id->driver_data;

+	if (!strcmp(client->name, "f75387")) {
+		/* correcting the show_temp function in order to support 11bit */
+		sensor_dev_attr_temp1_input.dev_attr.show = show_temp11;
+		sensor_dev_attr_temp2_input.dev_attr.show = show_temp11;
+	}
+
	if ((err = sysfs_create_group(&client->dev.kobj, &f75375_group)))
		goto exit_free;

@@ -689,12 +726,15 @@
		name = "f75375";
	else if (chipid = 0x0204 && vendid = 0x1934)
		name = "f75373";
+	else if (chipid = 0x0410 && vendid = 0x1934)
+		name = "f75387";
	else
		return -ENODEV;

	version = f75375_read8(client, F75375_REG_VERSION);
	dev_info(&adapter->dev, "found %s version: %02X\n", name, version);
	strlcpy(info->type, name, I2C_NAME_SIZE);
+	strlcpy(client->name, name, I2C_NAME_SIZE);

	return 0;
}
@@ -711,7 +751,7 @@

MODULE_AUTHOR("Riku Voipio");
MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("F75373/F75375 hardware monitoring driver");
+MODULE_DESCRIPTION("F75373/F75375/F75387 hardware monitoring driver");

module_init(sensors_f75375_init);
module_exit(sensors_f75375_exit);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
