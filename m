From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 18 May 2009 09:37:09 +0000
Subject: Re: [lm-sensors] [PATCH RFC 0/2] tmp401: Add support for Texas
Message-Id: <20090518093709.GA4535@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090514080653.GB4486@ubuntu>
In-Reply-To: <20090514080653.GB4486@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 14, 2009 at 11:02:40AM +0200, Hans de Goede wrote:
> Hi Andre,
>
> On 05/14/2009 10:06 AM, Andre Prendel wrote:
>> Hello Jean, Hans,
>>
>> here is my first work at TI's 401/411 temperatur sensor. The patch(es)
>> aren't intented to be applied. I just want some comments and maybe
>> real testing by Hans.
>>
>> The first patch is the original one from Hans sent to me.
>>
>> The second patch contains some work of Hans' students. I've brought
>> it in shape. The driver now has multichip support in the usual way.
>>
>> TODO:
>> Update Kconfig
>> Writing documentation
>>
>
> Great, thanks for working on this!
>
>> There are a few remaining questions.
>>
>> 1. Hans' students implemented two additional sysfs entries
>> (tempX_[lowest|highest]).
>>
>> The TMP411 chip has some additional registers for minimum and maximum
>> temperatures measured since power-on and chip-reset.
>>
>> AFAIK there are no standard sysfs entries for these values. I don't
>> remove the support so far. Should it be removed? Are there other chips
>> with such features?
>>
>
> Ah, good point I forgot about that, I told my student to name the new
> tempX_[lowest|highest] based on the existing and documented
> (Documentation/hwmon/sysfs-interface) powerX_average_[lowest|highest]
> sysfs attributes, which do the same (tracking min / max over time) for
> powermeter IC's. So unless someone objects, I think these should stay
> and get documented in Documentation/hwmon/sysfs-interface.
>
>> 2. There is another command to reset the chip. Is this a useful feature?
>>
>
> An other very good point! My first response was no, but actually it is,
> as this can be used to reset the min / max temp tracking. Modelling
> after the powermeter API again, you should add a temp_reset_history, notice
> no number there as it resets the history for all temps at once
(AFAIK).

Having a closer look at the datasheet

http://focus.ti.com/docs/prod/folders/print/tmp411.html

, I've seen two ways to reset the history.

1. Writing any value to the history registers (0x30-0x37). That should
reset all these registers. I've attached a patch (delta) doing this. Hans,
could you please test this one. echo "1"> .../temp_reset_history
should reset the history for tempX_lowest (0xFFF0) and tempX_highest (0x0000).

2. SOFTWARE RESET

Writing the first e-mail I meant this command in my question. You can
find it in datasheet under SOFTWARE RESET. This command restores the
power-on values to all registers (including limits etc.).

I'd prefer 1. for reseting the history. That's what I'd expect from
temp_reset_history.

IMHO if we want to use the SOFTWARE RESET we should use another
attribute (e.g. temp_reset).

BTW, what about write-only attributes? I've seen a reset functionality
in the fscpos driver (so I did it like that). show_temp_reset always
returns 1. Using WO attributes could make more sense, but in
sysfs-interface I can only see RO and RW.

>
> Again this needs to be documented, in 2 variants: temp_reset_history and
> tempX_reset_history
>

[...]

> Regards,
>
> Hans

Andre
---

--- /drivers/hwmon/tmp401.c	2009-05-17 17:37:03.000000000 +0200
+++ drivers/hwmon/tmp401.c	2009-05-17 17:38:00.000000000 +0200
@@ -1,9 +1,9 @@
 /* tmp401.c
  *
  * Copyright (C) 2007,2008 Hans de Goede <hdegoede@redhat.com>
- * Gabriel Konat
- * Sander Leget
- * Wouter Willems
+ * Preliminary tmp411 support by:
+ * Gabriel Konat, Sander Leget, Wouter Willems
+ * Copyright (C) 2009 Andre Prendel <andre.prendel@gmx.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -285,6 +285,12 @@
 		return sprintf(buf, "0\n");
 }
 
+static ssize_t show_temp_history(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	return sprintf(buf, "1\n");
+}
+
 static ssize_t store_temp_min(struct device *dev,
 	struct device_attribute	*devattr, const char *buf, size_t count)
 {
@@ -396,6 +402,30 @@
 	return count;
 }
 
+/*
+ * Resets the historical measurements of minimum and maximum temperatures.
+ * This is done by writing any value to any of the minimum/maximum registers
+ * (0x30-0x37).
+ */
+static ssize_t reset_temp_history(struct device *dev,
+	struct device_attribute	*devattr, const char *buf, size_t count)
+{
+	long val;
+
+	if (strict_strtol(buf, 10, &val))
+		return -EINVAL;
+
+	if (val != 1) {
+		dev_err(dev, "temp_reset_history value %ld not"
+			" supported. Use 1 to reset the history!\n", val);
+		return -EINVAL;
+	}
+	i2c_smbus_write_byte_data(to_i2c_client(dev),
+		TMP411_TEMP_LOWEST_MSB[0], val);
+
+	return count;
+}
+
 static struct sensor_device_attribute tmp401_attr[] = {
 	SENSOR_ATTR(temp1_input, 0444, show_temp_value, NULL, 0),
 	SENSOR_ATTR(temp1_min, 0644, show_temp_min, store_temp_min, 0),
@@ -436,6 +466,8 @@
 	SENSOR_ATTR(temp1_lowest, 0444, show_temp_lowest, NULL, 0),
 	SENSOR_ATTR(temp2_highest, 0444, show_temp_highest, NULL, 1),
 	SENSOR_ATTR(temp2_lowest, 0444, show_temp_lowest, NULL, 1),
+	SENSOR_ATTR(temp_reset_history, 0644, show_temp_history,
+		    reset_temp_history, 0),
 };
 
 /*
@@ -606,7 +638,7 @@
 		data->temp_crit[i] = i2c_smbus_read_byte_data(client,
 			TMP401_TEMP_CRIT_LIMIT[i]);
 
-		if(data->kind = TMP411_DEVICE_ID) {
+		if (data->kind = tmp411) {
 			data->temp_lowest[i] = i2c_smbus_read_byte_data(client,
 				TMP411_TEMP_LOWEST_MSB[i]) << 8;
 			data->temp_lowest[i] |= i2c_smbus_read_byte_data(

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
