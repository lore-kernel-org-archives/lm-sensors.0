From: hgchew@gunnet.org (Chew Hong Gunn)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <20040202160239.GA20149@evilmoon.gunnet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I have attached the latest patch against rc3.  I have fixed up all that
we have discussed on sunday.  In particular:
* BOOL and RAW macros
* voltage rounding
* fan speed calculation
* beep_mask for fan_min=0
* driver init code

Hopefully the code is ready now.  *phew*

Let me know what you think.

Cheers,
Hong-Gunn
-------------- next part --------------
--- gl518sm.c.rc3	2004-02-01 15:10:06.000000000 +1030
+++ gl518sm.c	2004-02-03 02:25:47.091099754 +1030
@@ -100,22 +100,21 @@
 
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
+#define FAN_FROM_REG(val,div)	((val)=0 ? 0 : (960000/((val)*(div))))
 
-#define FAN_FROM_REG(val,div)	((val)=0 ? 0 : (val)=255 ? 0 : \
-				(960000/((val)*(div))))
-
-#define IN_TO_REG(val)		(SENSORS_LIMIT((((val)+8)/19),0,255))
+#define IN_TO_REG(val)		(SENSORS_LIMIT((((val)+9)/19),0,255))
 #define IN_FROM_REG(val)	((val)*19)
 
-#define VDD_TO_REG(val)		(SENSORS_LIMIT((((val)+11)/23),0,255))
-#define VDD_FROM_REG(val)	((val)*23)
+#define VDD_TO_REG(val)		(SENSORS_LIMIT((((val)*4+47)/95),0,255))
+#define VDD_FROM_REG(val)	((val)*95/4)
 
-#define DIV_TO_REG(val)		((val)=8?3:(val)=4?2:(val)=1?0:1)
+#define DIV_TO_REG(val)		((val)=4?2:(val)=2?1:(val)=1?0:3)
 #define DIV_FROM_REG(val)	(1 << (val))
 
 #define BEEP_MASK_TO_REG(val)	((val) & 0x7f & data->alarm_mask)
@@ -273,11 +272,15 @@
 	data->fan_min[0] = FAN_TO_REG(simple_strtoul(buf, NULL, 10),
 		DIV_FROM_REG(data->fan_div[0]));
 	regvalue = (regvalue & 0x00ff) | (data->fan_min[0] << 8);
+	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
+
+	data->beep_mask = gl518_read_value(client, GL518_REG_ALARM);
 	if (data->fan_min[0] = 0)
 		data->alarm_mask &= ~0x20;
 	else
 		data->alarm_mask |= 0x20;
-	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
+	data->beep_mask &= data->alarm_mask;
+	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
 
 	return count;
 }
@@ -291,11 +294,15 @@
 	data->fan_min[1] = FAN_TO_REG(simple_strtoul(buf, NULL, 10),
 		DIV_FROM_REG(data->fan_div[1]));
 	regvalue = (regvalue & 0xff00) | data->fan_min[1];
+	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
+
+	data->beep_mask = gl518_read_value(client, GL518_REG_ALARM);
 	if (data->fan_min[1] = 0)
 		data->alarm_mask &= ~0x40;
 	else
 		data->alarm_mask |= 0x40;
-	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
+	data->beep_mask &= data->alarm_mask;
+	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
 
 	return count;
 }
@@ -350,7 +357,7 @@
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
-		    goto exit;
+		goto exit;
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
@@ -378,7 +385,7 @@
 	if (kind < 0) {
 		if ((gl518_read_value(new_client, GL518_REG_CHIP_ID) != 0x80)
 		 || (gl518_read_value(new_client, GL518_REG_CONF) & 0x80))
-                 	goto exit_free;
+			goto exit_free;
 	}
 
 	/* Determine the chip type. */
@@ -458,19 +465,18 @@
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
+	/* Comparator mode (D3=0), standby mode (D6=0) */
+	gl518_write_value(client, GL518_REG_CONF, 0xb7 & regvalue);
 
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
