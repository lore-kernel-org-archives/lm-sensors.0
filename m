From: hgchew@gunnet.org (Chew Hong Gunn)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <20040131110440.GA24292@evilmoon.gunnet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> I've updated libsensors and sensors to support the 2.6 gl518sm driver.
> Could you please checkout lm_sensors CVS and give it a try?
I have tested it out, and there are 2 issues:

* libsensors is reading from 'in0' instead of 'in_input0'
  - I have edited chips.c and attached the patch

* libsensors is reading from 'temp_input1' but gl518sm provides 'temp_input'
  - I have edited the driver to use 'temp_*' instead.
  - however, it might be confusing to read from 'temp_input1', but
    specifying it as 'temp_{max,hyst}' in the config files.  It might
    be better to append '1' for all 'temp*'

> Also, I'd like you to make sure that the 2.4 driver still works with the
> new libsensors and sensors.
I don't think I will be able to test the 2.4 drivers for a few weeks.  I
will be going overseas for 3 weeks and being a server, it takes a bit of
effort to bring it down for a kernel change.  I am happy to do it when I
get back though.  I am still able to work on the driver but using the
current kernel.

The above was tested on fedora development's kernel-2.6.1-1.57, while the
previous tests were on 2.6.3-rc2.

I have also updated gl518sm.c:
- I have found a bug due to me misreading the old code.  It affects only
  fan_div*.
- I am thinking of replacing '(val >> 4) & 0x0f' with '(val & 0xf0) >> $)'
  as it allows easy checking with the chip specifications (the mask in
  particular).  I have changed a few, and if there are no objections,
  I will be changing the rest.
- I have added fan_auto1 that switches fan1 between [true] always on and
  [false] auto on(30C)/off(25C).  This was removed from the port as it
  did not a standard item, and I didn't know what to do with it.
- I have a question regarding the init of the driver.  Is there a need
  to init the chip?  The BIOS should have initialised the chip, and we
  only need to make sure it is enabled.  Initialising the chip resets
  the config such as the min/max which the BIOS should have set, as well
  as other hardware dependent options such as 'fan2off' in the old driver.
  My understanding is that we should not be able to write 'fan2off' as it
  depends on the hardware implementation.  So I am inclined not to reset
  the chip on init of the driver.
The patch is attached and based on linux-2.6.2-rc2-i2c-gl518sm-rc2.diff.


I hope to hear your comments.

Cheers,
Hong-Gunn
-------------- next part --------------
diff -ruN lm_sensors2-CVS/lib/chips.c lm_sensors2-CVS-hg1/lib/chips.c
--- lm_sensors2-CVS/lib/chips.c	2004-01-31 07:27:38.000000000 +1030
+++ lm_sensors2-CVS-hg1/lib/chips.c	2004-01-31 18:09:30.000000000 +1030
@@ -419,7 +419,7 @@
 static sensors_chip_feature gl518_features[]    {
     { SENSORS_GL518_VDD, "vdd", NOMAP,NOMAP,
-                            R, GL518_SYSCTL_VDD, VALUE(3), 2, "in0", 3 },
+                            R, GL518_SYSCTL_VDD, VALUE(3), 2, "in_input0", 3 },
     { SENSORS_GL518_VIN1, "vin1", NOMAP,NOMAP,
                              R, GL518_SYSCTL_VIN1, VALUE(3), 
                              2 },
-------------- next part --------------
--- gl518sm.c.rc2	2004-01-30 10:48:40.000000000 +1030
+++ gl518sm.c	2004-01-31 18:26:09.000000000 +1030
@@ -1,10 +1,10 @@
 /*
  * gl518sm.c - Part of lm_sensors, Linux kernel modules for hardware
  *             monitoring
- * Copyright (C) 1998, 1999	Frodo Looijaard	<frodol@dds.nl>,
- * 				Kyosti Malkki	<kmalkki@cc.hut.fi>
+ * Copyright (C) 1998, 1999     Frodo Looijaard <frodol@dds.nl>,
+ *                              Kyosti Malkki   <kmalkki@cc.hut.fi>
  * port to 2.6 Kernel
- * Copyright (C) 2004		Hong-Gunn Chew	<hglinux@gunnet.org>
+ * Copyright (C) 2004           Hong-Gunn Chew  <hglinux@gunnet.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -22,11 +22,8 @@
  */
 
 /*
- * v2.0 (2004-01-24, Hong-Gunn Chew)
- *	- ported to 2.6 kernel
- * v2.1 (2004-01-28, Hong-Gunn Chew)
- *	- Updated sysfs output according to standard data format
- *	  (temp, in)
+ * v2.0 (2004-01-30, Hong-Gunn Chew)
+ *      - ported to 2.6 kernel
  */
 
 #include <linux/config.h>
@@ -82,6 +79,11 @@
  * Fixing this is just not worth it.
  */
 
+#define RAW_FROM_REG(val)	val
+
+#define BOOL_FROM_REG(val)	((val)?0:1)
+#define BOOL_TO_REG(val)	((val)?0:1)
+
 #define TEMP_TO_REG(val)	(SENSORS_LIMIT(((((val)<0? \
 				(val)-500:(val)+500)/1000)+119),0,255))
 #define TEMP_FROM_REG(val)	(((val) - 119) * 1000)
@@ -106,13 +108,8 @@
 #define DIV_TO_REG(val)		((val)=8?3:(val)=4?2:(val)=1?0:1)
 #define DIV_FROM_REG(val)	(1 << (val))
 
-#define ALARMS_FROM_REG(val)	val
-
-#define BEEP_ENABLE_TO_REG(val)		((val)?0:1)
-#define BEEP_ENABLE_FROM_REG(val)	((val)?0:1)
-
-#define BEEP_MASK_TO_REG(val)		((val) & 0x7f & data->alarm_mask)
-#define BEEP_MASK_FROM_REG(val)		((val) & 0x7f)
+#define BEEP_MASK_TO_REG(val)	((val) & 0x7f & data->alarm_mask)
+#define BEEP_MASK_FROM_REG(val)	((val) & 0x7f)
 
 /* Each client has this additional data */
 struct gl518_data {
@@ -129,6 +126,7 @@
 	u8 fan_in[2];
 	u8 fan_min[2];
 	u8 fan_div[2];		/* Register encoding, shifted right */
+	u8 fan_auto1;		/* Boolean */
 	u8 temp_in;		/* Register values */
 	u8 temp_max;		/* Register values */
 	u8 temp_hyst;		/* Register values */
@@ -185,9 +183,10 @@
 		DIV_FROM_REG(data->fan_div[index])));			\
 }
 
-show(TEMP, temp_input, temp_in);
-show(TEMP, temp_max, temp_max);
-show(TEMP, temp_hyst, temp_hyst);
+show(TEMP, temp_input1, temp_in);
+show(TEMP, temp_max1, temp_max);
+show(TEMP, temp_hyst1, temp_hyst);
+show(BOOL, fan_auto1, fan_auto1);
 show_fan(fan_input1, fan_in, 0);
 show_fan(fan_input2, fan_in, 1);
 show_fan(fan_min1, fan_min, 0);
@@ -206,8 +205,8 @@
 show(IN, in_max1, voltage_max[1]);
 show(IN, in_max2, voltage_max[2]);
 show(IN, in_max3, voltage_max[3]);
-show(ALARMS, alarms, alarms);
-show(BEEP_ENABLE, beep_enable, beep_enable);
+show(RAW, alarms, alarms);
+show(BOOL, beep_enable, beep_enable);
 show(BEEP_MASK, beep_mask, beep_mask);
 
 #define set(type, suffix, value, reg)					\
@@ -229,20 +228,21 @@
 	struct gl518_data *data = i2c_get_clientdata(client);		\
 	int regvalue = gl518_read_value(client, reg);			\
 	data->value = type##_TO_REG(simple_strtoul(buf, NULL, 10));	\
-	regvalue = (regvalue & mask) | (data->value << shift);		\
+	regvalue = (regvalue & ~mask) | (data->value << shift);		\
 	gl518_write_value(client, reg, regvalue);			\
 	return count;							\
 }
 
 #define set_low(type, suffix, value, reg)				\
-	set_bits(type, suffix, value, reg, 0xff00, 0)
+	set_bits(type, suffix, value, reg, 0x00ff, 0)
 #define set_high(type, suffix, value, reg)				\
-	set_bits(type, suffix, value, reg, 0x00ff, 8)
+	set_bits(type, suffix, value, reg, 0xff00, 8)
 
-set(TEMP, temp_max, temp_max, GL518_REG_TEMP_MAX);
-set(TEMP, temp_hyst, temp_hyst, GL518_REG_TEMP_HYST);
-set_bits(DIV, fan_div1, fan_div[0], GL518_REG_MISC, 0x3f, 4);
-set_bits(DIV, fan_div2, fan_div[1], GL518_REG_MISC, 0xcf, 6);
+set(TEMP, temp_max1, temp_max, GL518_REG_TEMP_MAX);
+set(TEMP, temp_hyst1, temp_hyst, GL518_REG_TEMP_HYST);
+set_bits(BOOL, fan_auto1, fan_auto1, GL518_REG_MISC, 0x08, 3);
+set_bits(DIV, fan_div1, fan_div[0], GL518_REG_MISC, 0xc0, 6);
+set_bits(DIV, fan_div2, fan_div[1], GL518_REG_MISC, 0x30, 4);
 set_low(VDD, in_min0, voltage_min[0], GL518_REG_VDD_LIMIT);
 set_low(IN, in_min1, voltage_min[1], GL518_REG_VIN1_LIMIT);
 set_low(IN, in_min2, voltage_min[2], GL518_REG_VIN2_LIMIT);
@@ -251,7 +251,7 @@
 set_high(IN, in_max1, voltage_max[1], GL518_REG_VIN1_LIMIT);
 set_high(IN, in_max2, voltage_max[2], GL518_REG_VIN2_LIMIT);
 set_high(IN, in_max3, voltage_max[3], GL518_REG_VIN3_LIMIT);
-set_bits(BEEP_ENABLE, beep_enable, beep_enable, GL518_REG_CONF, 0xfb, 2);
+set_bits(BOOL, beep_enable, beep_enable, GL518_REG_CONF, 0x04, 2);
 set(BEEP_MASK, beep_mask, beep_mask, GL518_REG_ALARM);
 
 static ssize_t set_fan_min1(struct device *dev, const char *buf, size_t count)
@@ -262,11 +262,11 @@
 
 	data->fan_min[0] = FAN_TO_REG(simple_strtoul(buf, NULL, 10),
 		DIV_FROM_REG(data->fan_div[0]));
-	regvalue = (regvalue & 0xff00) | data->fan_min[0];
+	regvalue = (regvalue & 0x00ff) | (data->fan_min[0] << 8);
 	if (data->fan_min[0] = 0)
-		data->alarm_mask &= ~0x0020;
+		data->alarm_mask &= ~0x20;
 	else
-		data->alarm_mask |= 0x0020;
+		data->alarm_mask |= 0x20;
 	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
 
 	return count;
@@ -280,19 +280,21 @@
 
 	data->fan_min[1] = FAN_TO_REG(simple_strtoul(buf, NULL, 10),
 		DIV_FROM_REG(data->fan_div[0]));
-	regvalue = (regvalue & 0x00ff) | (data->fan_min[1] << 8);
+	regvalue = (regvalue & 0xff00) | data->fan_min[1];
 	if (data->fan_min[1] = 0)
-		data->alarm_mask &= ~0x0040;
+		data->alarm_mask &= ~0x40;
 	else
-		data->alarm_mask |= 0x0040;
+		data->alarm_mask |= 0x40;
 	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
 
 	return count;
 }
 
-static DEVICE_ATTR(temp_input, S_IRUGO, show_temp_input, NULL);
-static DEVICE_ATTR(temp_max, S_IWUSR|S_IRUGO, show_temp_max, set_temp_max);
-static DEVICE_ATTR(temp_hyst, S_IWUSR|S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input1, NULL);
+static DEVICE_ATTR(temp_max1, S_IWUSR|S_IRUGO, show_temp_max1, set_temp_max1);
+static DEVICE_ATTR(temp_hyst1, S_IWUSR|S_IRUGO,
+	show_temp_hyst1, set_temp_hyst1);
+static DEVICE_ATTR(fan_auto1, S_IWUSR|S_IRUGO, show_fan_auto1, set_fan_auto1);
 static DEVICE_ATTR(fan_input1, S_IRUGO, show_fan_input1, NULL);
 static DEVICE_ATTR(fan_input2, S_IRUGO, show_fan_input2, NULL);
 static DEVICE_ATTR(fan_min1, S_IWUSR|S_IRUGO, show_fan_min1, set_fan_min1);
@@ -417,15 +419,16 @@
 	device_create_file(&new_client->dev, &dev_attr_in_max1);
 	device_create_file(&new_client->dev, &dev_attr_in_max2);
 	device_create_file(&new_client->dev, &dev_attr_in_max3);
+	device_create_file(&new_client->dev, &dev_attr_fan_auto1);
 	device_create_file(&new_client->dev, &dev_attr_fan_input1);
 	device_create_file(&new_client->dev, &dev_attr_fan_input2);
 	device_create_file(&new_client->dev, &dev_attr_fan_min1);
 	device_create_file(&new_client->dev, &dev_attr_fan_min2);
 	device_create_file(&new_client->dev, &dev_attr_fan_div1);
 	device_create_file(&new_client->dev, &dev_attr_fan_div2);
-	device_create_file(&new_client->dev, &dev_attr_temp_input);
-	device_create_file(&new_client->dev, &dev_attr_temp_max);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_beep_enable);
 	device_create_file(&new_client->dev, &dev_attr_beep_mask);
@@ -545,19 +548,17 @@
 		    gl518_read_value(client, GL518_REG_TEMP_HYST);
 
 		val = gl518_read_value(client, GL518_REG_MISC);
-		data->fan_div[0] = (val >> 6) & 0x03;
-		data->fan_div[1] = (val >> 4) & 0x03;
+		data->fan_div[0] = (val & 0xc0) >> 6;
+		data->fan_div[1] = (val & 0x30) >> 4;
+		data->fan_auto1  = (val & 0x08) >> 3;
 
 		data->alarms &= data->alarm_mask;
 
 		val = gl518_read_value(client, GL518_REG_CONF);
-		data->beep_enable = (val >> 2) & 1;
+		data->beep_enable = (val & 0x04) >> 2;
+		data->fan_auto1  |= (val & 0x10) >> 3;
 
-		if (data->type = gl518sm_r00) {
-			data->voltage_in[0] = 0;
-			data->voltage_in[1] = 0;
-			data->voltage_in[2] = 0;
-		} else {
+		if (data->type != gl518sm_r00) {
 			data->voltage_in[0]  			    gl518_read_value(client, GL518_REG_VDD);
 			data->voltage_in[1] 
