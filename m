From: hgchew@gunnet.org (Chew Hong Gunn)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <20040201074955.GA3769@evilmoon.gunnet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I have also updated gl518sm.c:
> > - I have found a bug due to me misreading the old code.  It affects
> > only fan_div*.
>
> Don't you mean fan_min*?
>
Actually, I meant fan_div* and fan_min*.

> > - I am thinking of replacing '(val >> 4) & 0x0f' with '(val & 0xf0) >> 4'
> >   as it allows easy checking with the chip specifications (the mask in
> >   particular).  I have changed a few, and if there are no objections,
> >   I will be changing the rest.
> 
> Frankly, I don't see no benefit. I don't find it more nor less readable
> one way or one other - so I wouldn't bother changing, especially since
> it is likely to introduce errors.
> 
I find it easier to check when the mask is the same as in the specs, but
you are correct to see that changing them would likely introduce errors.


> I've made the necessary change to libsensors so that it knows about your
> fan_auto1. That way, "sensors -s" shouldn't complain about it anymore.
>
Ok.  By the way, is there a label for beep_mask in libsensors?

> >  	data->fan_min[1] = FAN_TO_REG(simple_strtoul(buf, NULL, 10),
> >  		DIV_FROM_REG(data->fan_div[0]));
> 		                           ^
> Isn't it a bug?
> 
Yes, thanks for finding it.

> >  		val = gl518_read_value(client, GL518_REG_CONF);
> > -		data->beep_enable = (val >> 2) & 1;
> > +		data->beep_enable = (val & 0x04) >> 2;
> > +		data->fan_auto1  |= (val & 0x10) >> 3;
> 
> What's the point of the last line? For one thing, it seems to be bogus
> (the mask doesn't match the shift). For another, I don't really see what
> it is supposed to do.
> 
I originally intended NoFan2 to be bit 1 of fan_auto1, since they are sort
of related.  I missed it when I removed NoFan2.

The patch against rc3 is attached.
The changes in particular:

| -#define DIV_TO_REG(val)                ((val)=8?3:(val)=4?2:(val)=1?0:1)
| +#define DIV_TO_REG(val)                ((val)=8?3:(val)=4?2:(val)=1?0:3)

If an invalid div is entered, it is set to the default of 2^3=8.

| -#define VDD_TO_REG(val)                (SENSORS_LIMIT((((val)+11)/23),0,255))
| -#define VDD_FROM_REG(val)      ((val)*23)
| +#define VDD_TO_REG(val)                (SENSORS_LIMIT((((val)+12)/24),0,255))
| +#define VDD_FROM_REG(val)      ((val)*24)

Actual conversion is (val*19*5/4)=(val*23.75).  The rounding up is
negligible as it's (255*0.25mV) lower than the sensor accuracy of 75mV.

|  static inline u8 FAN_TO_REG(long rpm, int div)
|  {
| +       long rpmdiv;
|         if (rpm = 0)
| -               return 255;
| -       rpm = SENSORS_LIMIT(rpm, 1, 1000000);
| -       return SENSORS_LIMIT((960000 + rpm * div / 2) / (rpm * div), 1, 254);
| +               return 0;
| +       rpmdiv = SENSORS_LIMIT(rpm, 1, 1920000) * div;
| +       return SENSORS_LIMIT((960000 + rpmdiv / 2) / rpmdiv, 1, 255);
|  }
| -
| -#define FAN_FROM_REG(val,div)  ((val)=0 ? 0 : (val)=255 ? 0 : \
| -                               (960000/((val)*(div))))
| +#define FAN_FROM_REG(val,div)  ((val)=0 ? 0 : (960000/((val)*(div))))  


I changed rpm=0 from reg%5 to reg=0, as it breaks the fan_min=0 code
below, and as reg=255 is a valid count, while reg=0 is not.  rpm is
limited to 1920000 as that's the largest possible with rounding, and to
prevent overflow with '* div'.
-------------- next part --------------
--- gl518sm.c.rc3	2004-02-01 15:10:06.000000000 +1030
+++ gl518sm.c	2004-02-01 18:06:55.832105438 +1030
@@ -89,35 +89,37 @@
  * Fixing this is just not worth it.
  */
 
-#define RAW_FROM_REG(val)	val
-
-#define BOOL_FROM_REG(val)	((val)?0:1)
-#define BOOL_TO_REG(val)	((val)?0:1)
-
 #define TEMP_TO_REG(val)	(SENSORS_LIMIT(((((val)<0? \
 				(val)-500:(val)+500)/1000)+119),0,255))
 #define TEMP_FROM_REG(val)	(((val) - 119) * 1000)
 
+#define FAN_AUTO_FROM_REG(val)	((val)?0:1)
+#define FAN_AUTO_TO_REG(val)	((val)?0:1)
+
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
+	long rpmdiv;
 	if (rpm = 0)
-		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((960000 + rpm * div / 2) / (rpm * div), 1, 254);
+		return 0;
+	rpmdiv = SENSORS_LIMIT(rpm, 1, 1920000) * div;
+	return SENSORS_LIMIT((960000 + rpmdiv / 2) / rpmdiv, 1, 255);
 }
-
-#define FAN_FROM_REG(val,div)	((val)=0 ? 0 : (val)=255 ? 0 : \
-				(960000/((val)*(div))))
+#define FAN_FROM_REG(val,div)	((val)=0 ? 0 : (960000/((val)*(div))))
 
 #define IN_TO_REG(val)		(SENSORS_LIMIT((((val)+8)/19),0,255))
 #define IN_FROM_REG(val)	((val)*19)
 
-#define VDD_TO_REG(val)		(SENSORS_LIMIT((((val)+11)/23),0,255))
-#define VDD_FROM_REG(val)	((val)*23)
+#define VDD_TO_REG(val)		(SENSORS_LIMIT((((val)+12)/24),0,255))
+#define VDD_FROM_REG(val)	((val)*24)
 
-#define DIV_TO_REG(val)		((val)=8?3:(val)=4?2:(val)=1?0:1)
+#define DIV_TO_REG(val)		((val)=8?3:(val)=4?2:(val)=1?0:3)
 #define DIV_FROM_REG(val)	(1 << (val))
 
+#define ALARMS_FROM_REG(val)	val
+
+#define BEEP_ENABLE_FROM_REG(val)	((val)?0:1)
+#define BEEP_ENABLE_TO_REG(val)		((val)?0:1)
+
 #define BEEP_MASK_TO_REG(val)	((val) & 0x7f & data->alarm_mask)
 #define BEEP_MASK_FROM_REG(val)	((val) & 0x7f)
 
@@ -196,7 +198,7 @@
 show(TEMP, temp_input1, temp_in);
 show(TEMP, temp_max1, temp_max);
 show(TEMP, temp_hyst1, temp_hyst);
-show(BOOL, fan_auto1, fan_auto1);
+show(FAN_AUTO, fan_auto1, fan_auto1);
 show_fan(fan_input1, fan_in, 0);
 show_fan(fan_input2, fan_in, 1);
 show_fan(fan_min1, fan_min, 0);
@@ -215,8 +217,8 @@
 show(IN, in_max1, voltage_max[1]);
 show(IN, in_max2, voltage_max[2]);
 show(IN, in_max3, voltage_max[3]);
-show(RAW, alarms, alarms);
-show(BOOL, beep_enable, beep_enable);
+show(ALARMS, alarms, alarms);
+show(BEEP_ENABLE, beep_enable, beep_enable);
 show(BEEP_MASK, beep_mask, beep_mask);
 
 #define set(type, suffix, value, reg)					\
@@ -250,7 +252,7 @@
 
 set(TEMP, temp_max1, temp_max, GL518_REG_TEMP_MAX);
 set(TEMP, temp_hyst1, temp_hyst, GL518_REG_TEMP_HYST);
-set_bits(BOOL, fan_auto1, fan_auto1, GL518_REG_MISC, 0x08, 3);
+set_bits(FAN_AUTO, fan_auto1, fan_auto1, GL518_REG_MISC, 0x08, 3);
 set_bits(DIV, fan_div1, fan_div[0], GL518_REG_MISC, 0xc0, 6);
 set_bits(DIV, fan_div2, fan_div[1], GL518_REG_MISC, 0x30, 4);
 set_low(VDD, in_min0, voltage_min[0], GL518_REG_VDD_LIMIT);
@@ -261,7 +263,7 @@
 set_high(IN, in_max1, voltage_max[1], GL518_REG_VIN1_LIMIT);
 set_high(IN, in_max2, voltage_max[2], GL518_REG_VIN2_LIMIT);
 set_high(IN, in_max3, voltage_max[3], GL518_REG_VIN3_LIMIT);
-set_bits(BOOL, beep_enable, beep_enable, GL518_REG_CONF, 0x04, 2);
+set_bits(BEEP_ENABLE, beep_enable, beep_enable, GL518_REG_CONF, 0x04, 2);
 set(BEEP_MASK, beep_mask, beep_mask, GL518_REG_ALARM);
 
 static ssize_t set_fan_min1(struct device *dev, const char *buf, size_t count)
@@ -458,19 +460,18 @@
 /* Called when we have found a new GL518SM. */
 static void gl518_init_client(struct i2c_client *client)
 {
-	/* Power-on defaults (bit 7=1) */
-	gl518_write_value(client, GL518_REG_CONF, 0x80);
+	/* retain D4:NoFan2, D2:beep_enable */
+	u8 regvalue = gl518_read_value(client, GL518_REG_CONF) & 0x14;
 
-	/* No noisy output (bit 2=1), Comparator mode (bit 3=0), two fans (bit4=0),
-	   standby mode (bit6=0) */
-	gl518_write_value(client, GL518_REG_CONF, 0x04);
+	/* Comparator mode (D3=0), two fans (D4=0), standby mode (D6=0) */
+	gl518_write_value(client, GL518_REG_CONF, 0x00 | regvalue);
 
 	/* Never interrupts */
 	gl518_write_value(client, GL518_REG_MASK, 0x00);
 
-	/* Clear status register (bit 5=1), start (bit6=1) */
-	gl518_write_value(client, GL518_REG_CONF, 0x24);
-	gl518_write_value(client, GL518_REG_CONF, 0x44);
+	/* Clear status register (D5=1), start (D6=1) */
+	gl518_write_value(client, GL518_REG_CONF, 0x20 | regvalue);
+	gl518_write_value(client, GL518_REG_CONF, 0x40 | regvalue);
 }
 
 static int gl518_detach_client(struct i2c_client *client)
