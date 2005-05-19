From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: kernel 2.6.X lm85 fan control patch
Message-Id: <20040809213633.GA26019@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Here is a patch to add back in automated fan control access for the lm85
and clones in the kernel 2.6.X driver.

I have stuck with the 

Off -> Min -> Max -> Crit

model discussed on the list archive.

Most control bits are exposed.  (And yes, this generates a LOT of 
/sys/bus/i2c/device/../ files!)

I have changed a few names around in an attempt to straighten out the naming
conventions.

The accompanying lib/chips.c, lib/chips.h, and prog/sensors.h patches follow
in separate emails.

There are undoubtedly a few bugs lurking, so I'd appreciate feedback.

Thanks,

Justin Thiessen
---------------
Linux Engineer
jthiessen@penguincomputing.com
http://www.penguincomputing.com

from:
$diff -Naur


-------------------------------------

--- lm85.c	2004-08-09 12:36:03.822501296 -0700
+++ lm85.c.updated	2004-08-09 12:35:58.627291088 -0700
@@ -4,6 +4,7 @@
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
     Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
     Copyright (c) 2003        Margit Schubert-While <margitsw@t-online.de>
+    Copyright (c) 2004        Justin Thiessen <jthiessen@penguincomputing.com>
 
     Chip details at	      <http://www.national.com/ds/LM/LM85.pdf>
 
@@ -33,8 +34,6 @@
 #include <asm/io.h>
 */
 
-#undef	LM85EXTENDEDFUNC	/* Extended functionality */
-
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
@@ -158,19 +157,57 @@
 #define TEMP_FROM_REG(val)		(TEMPEXT_FROM_REG(val,0))
 #define EXTTEMP_TO_REG(val)		(SENSORS_LIMIT((val)/250,-127,127))
 
-#define PWM_TO_REG(val)			(SENSORS_LIMIT(val,0,255))
-#define PWM_FROM_REG(val)		(val)
+#define PWM_TO_REG(val)			(SENSORS_LIMIT(((val)+500)/1000,0,255))
+#define PWM_FROM_REG(val)		((val)*1000)
 
 #define EXT_FROM_REG(val,sensor)	(((val)>>(sensor * 2))&0x03)
 
-#ifdef	LM85EXTENDEDFUNC	/* Extended functionality */
-
-/* ZONEs have the following parameters:
+/*
+ * ZONEs have the following parameters:
  *    Limit (low) temp,           1. degC
  *    Hysteresis (below limit),   1. degC (0-15)
  *    Range of speed control,     .1 degC (2-80)
  *    Critical (high) temp,       1. degC
  *
+ *
+ * The current model for fan control in lm_sensors is:
+ *
+ * 
+ *   Off  Min                 Max   Critical
+ *  --+----+-------------------+-------+------------>
+ *
+ *                Temperature -->
+ *
+ * Where:
+ *
+ * Off -> temperature at which fan(s) controlled by a particular sensor
+ *        turn off
+ * Min -> minimum temperature that is require to spin up fan(s) controlled
+ *        by a particular sensor
+ * Max -> temperature at which fan(s) controlled by a particular sensor
+ *        are at 100%
+ * Critical -> temperature at which all fans are raised to 100%.
+ *
+ * So the conversion is obviously:
+ * 
+ * Off = Limit - Hysteresis
+ * Min = Limit
+ * Max = Limit + Range
+ * Critical = Critical
+ *
+ * within the limits imposed by the resolution and range of the Hysteresis and 
+ * Range registers.  Because of these limitations, the casual user may 
+ * occasionally be surprised as actual values for Off and Max vary from
+ * those requested, even though the code does its best to find the closest 
+ * possible match to the desired parameters.
+ *
+ * Is is really best to standardize the interface at the cost of obfuscating
+ * the way the chip's internals work?  Surely this will just lead to a new
+ * set of FAQs dealing with the subject...
+ * 
+ */
+ 
+/*
  * FAN PWMs have the following parameters:
  *    Reference Zone,                 1, 2, 3, etc.
  *    Spinup time,                    .05 sec
@@ -183,11 +220,12 @@
  *    Filter constant (or disabled)   .1 seconds
  */
 
-/* These are the zone temperature range encodings */
-static int lm85_range_map[] = {   /* .1 degC */
-		 20,  25,  33,  40,  50,  66,
-		 80, 100, 133, 160, 200, 266,
-		320, 400, 533, 800
+/* These are the zone temperature range encodings in .001 degree C */
+
+static int lm85_range_map[] = {   
+		2000,  2500,  3300,  4000,  5000,  6600,
+		8000, 10000, 13300, 16000, 20000, 26600,
+		32000, 40000, 53300, 80000
 	};
 static int RANGE_TO_REG( int range )
 {
@@ -195,8 +233,16 @@
 
 	if( range >= lm85_range_map[15] ) { return 15 ; }
 	for( i = 0 ; i < 15 ; ++i )
-		if( range <= lm85_range_map[i] )
-			break ;
+		if( range <= lm85_range_map[i] ) {
+			if (i = 0) {
+				break;
+			} else if ((lm85_range_map[i] - range) > 
+				(range - lm85_range_map[i-1])) {
+				i--;
+				break;
+			}
+			break;
+		}
 	return( i & 0x0f );
 }
 #define RANGE_FROM_REG(val) (lm85_range_map[(val)&0x0f])
@@ -223,6 +269,12 @@
 #define SMOOTH_FROM_REG(val) ((val)&0x08?lm85_smooth_map[(val)&0x07]:0)
 
 /* These are the fan spinup delay time encodings */
+
+/*
+ * What about the fact that the adm1027 datasheet does not list the .7
+ * second setting?
+ */
+
 static int lm85_spinup_map[] = {  /* .1 sec */
 		0, 1, 2, 4, 7, 10, 20, 40
 	};
@@ -240,7 +292,7 @@
 
 /* These are the PWM frequency encodings */
 static int lm85_freq_map[] = { /* .1 Hz */
-		100, 150, 230, 300, 380, 470, 620, 980
+		100, 150, 230, 300, 380, 470, 620, 940
 	};
 static int FREQ_TO_REG( int freq )
 {
@@ -265,14 +317,8 @@
  *     -1 -- PWM is always at 100%
  *     -2 -- PWM responds to manual control
  */
-
-#endif		/* Extended functionality */
-
 static int lm85_zone_map[] = { 1, 2, 3, -1, 0, 23, 123, -2 };
 #define ZONE_FROM_REG(val) (lm85_zone_map[((val)>>5)&0x07])
-
-#ifdef	LM85EXTENDEDFUNC	/* Extended functionality */
-
 static int ZONE_TO_REG( int zone )
 {
 	int i;
@@ -285,13 +331,15 @@
 	return( (i & 0x07)<<5 );
 }
 
-#endif		/* Extended functionality */
+/* Define Hysteresis  */
+#define HYST_TO_REG(val) (SENSORS_LIMIT(((val)+500)/1000,0,15)) 
+#define HYST_FROM_REG(val) (val * 1000)  
 
-#define HYST_TO_REG(val) (SENSORS_LIMIT((-(val)+5)/10,0,15))
-#define HYST_FROM_REG(val) (-(val)*10)
+#define ADM1027_OFFSET_TO_REG(val) (SENSORS_LIMIT((val)/1000,-127,127))
+#define ADM1027_OFFSET_FROM_REG(val) ((val)*1000)
 
-#define OFFSET_TO_REG(val) (SENSORS_LIMIT((val)/25,-127,127))
-#define OFFSET_FROM_REG(val) ((val)*25)
+#define ADT7463_OFFSET_TO_REG(val) (SENSORS_LIMIT((val)/250,-127,127))
+#define ADT7463_OFFSET_FROM_REG(val) ((val)*250)
 
 #define PPR_MASK(fan) (0x03<<(fan *2))
 #define PPR_TO_REG(val,fan) (SENSORS_LIMIT((val)-1,0,3)<<(fan *2))
@@ -332,25 +380,41 @@
    dynamically allocated, at the same time when a new lm85 client is
    allocated. */
 
+#define LM85_SPINUP_CTL_FROM_REG(val,offset) ((val & (0x01 << (offset))) \
+        >> (offset))
+#define LM85_SPINUP_CTL_TO_REG(val,offset) (val << (offset))
+
+#define ADM1027_SPINUP_CTL_FROM_REG(val) ((val >> 5) & 0x01)
+#define ADM1027_SPINUP_CTL_TO_REG(val) ((val & 0x01) << 5)
+
+#define INVERT_FROM_REG(val) (((val) & 0x10) >> 4)
+#define INVERT_TO_REG(val) (val = 1 ? val << 4 : 0)
+
+#define LM85_TACH_MODE_FROM_REG(val, tach) ( (val >> (2*tach)) & 0x03 )
+#define LM85_TACH_MODE_TO_REG(val, tach) ((val & 0x03) << (2*tach))
+
+#define ADM1027_TACH_MODE_FROM_REG(val, tach) ( (val >> (tach + 4)) & 0x01 )
+#define ADM1027_TACH_MODE_TO_REG(val, tach) (val << (tach + 4))
+
+#define DYNAMIC_TMIN_ENABLE_FROM_REG(val,nr) ((val >> (nr + 13)) & 0x01)
+#define DYNAMIC_TMIN_ENABLE_TO_REG(val,nr) ((val & 0x01) << (nr +13))
+
+#define ADT7463_THERM_LIMIT_TO_REG(val) (SENSORS_LIMIT(((val - \
+	45520)/22760),0,255))
+#define ADT7463_THERM_LIMIT_FROM_REG(val) ((val) * 22760) /* In milliseconds */
+
+#define ADT7463_THERM_TOTAL_IN_MSEC(val) ((val) * 22760) /* In milliseconds */
+
+#define ALARM_MASK_TO_REG(val,offset) ((val & 0x01) << offset)
+#define ALARM_MASK_FROM_REG(val,offset) ((val >> offset) & 0x01)
+
 /* LM85 can automatically adjust fan speeds based on temperature
  * This structure encapsulates an entire Zone config.  There are
  * three zones (one for each temperature input) on the lm85
  */
-struct lm85_zone {
-	s8 limit;	/* Low temp limit */
-	u8 hyst;	/* Low limit hysteresis. (0-15) */
-	u8 range;	/* Temp range, encoded */
-	s8 critical;	/* "All fans ON" temp limit */
-};
-
-struct lm85_autofan {
-	u8 config;	/* Register value */
-	u8 freq;	/* PWM frequency, encoded */
-	u8 min_pwm;	/* Minimum PWM value, encoded */
-	u8 min_off;	/* Min PWM or OFF below "limit", flag */
-};
 
 struct lm85_data {
+	struct i2c_client client;
 	struct semaphore lock;
 	enum chips type;
 
@@ -359,6 +423,9 @@
 	unsigned long last_reading;	/* In jiffies */
 	unsigned long last_config;	/* In jiffies */
 
+	u8 config1;		/* Register value */
+	u8 intmask1;            /* Register Value */
+	u8 intmask2;            /* Register Value */
 	u8 in[5];		/* Register value */
 	u8 in_max[5];		/* Register value */
 	u8 in_min[5];		/* Register value */
@@ -369,21 +436,88 @@
 	u16 fan[4];		/* Register value */
 	u16 fan_min[4];		/* Register value */
 	u8 pwm[3];		/* Register value */
-	u8 spinup_ctl;		/* Register encoding, combined */
+	u8 fan_auto_spinup_ctl;	/* Register encoding, combined */
 	u8 tach_mode;		/* Register encoding, combined */
 	u16 extend_adc;		/* Register value */
-	u8 fan_ppr;		/* Register value */
+	u8 adm1027_fan_ppr;	/* Register value */
 	u8 smooth[3];		/* Register encoding */
 	u8 vid;			/* Register value */
 	u8 vrm;			/* VRM version */
 	u8 syncpwm3;		/* Saved PWM3 for TACH 2,3,4 config */
-	u8 oppoint[3];		/* Register value */
+	u8 temp_auto_oppoint[3];	/* Register value */
 	u16 tmin_ctl;		/* Register value */
-	unsigned long therm_total; /* Cummulative therm count */
-	u8 therm_limit;		/* Register value */
 	u16 alarms;		/* Register encoding, combined */
-	struct lm85_autofan autofan[3];
-	struct lm85_zone zone[3];
+
+        u8 temp_auto_hyst[3];	/* Register value */
+        u8 temp_auto_range[3];	/* temp above min at which fan reaches 100% 
+				(encoded) */
+        s8 temp_auto_min[3];	/* minimum activation temp for fan_auto */
+        s8 temp_auto_critical[3];	/* "All fans ON" temp limit */
+/*
+ * Because we are shoving a square peg (the lm85 Hysteresis-temp_auto_min-range
+ * model) into a round hole (the proposed standard (temp_auto_off-
+ * temp_auto_min-temp_auto_max model), and because the lm85's allowed 
+ * Hysteresis and Range values are only a small handful of non-continuous 
+ * temperatures with varying separation between neighboring elemments,
+ * we MUST keep track of the actual values specified by the sensors.conf
+ * file or by the user via the sysfs interface.  If we were to discard the
+ * values requested and only preserve the "best-fit" numbers picked by the
+ * code, then it is entirely possible for the temp_auto_off and temp_auto_max
+ * settings to drift as new values are set for the temp_auto_min register.  
+ * This will occur even if we make sure to adjust temp_auto_off and 
+ * temp_auto_max every time temp_auto_min changes.  To observe, use the 
+ * following set of numbers:
+ *
+ * ----------------------------------
+ * temp_auto_min:		:  40
+ * Desired temp_auto_max	:  58
+ * ----------------------------------
+ *
+ * Resultant temp_auto_range	:  16
+ * Resultant temp_auto_max	:  56
+ *
+ * Now let
+ *
+ * temp_auto_min => 42
+ *
+ * If we now use 56  as the desired temp_auto_max, then we have
+ *
+ * temp_auto_max - temp_auto_min = 14
+ *
+ * The 2 bracketing elements in the allowable range table are 13.3 and 16
+ *
+ * 13.3 < 14 <= 16  --> temp_auto_range => 13.3.
+ *
+ * And so temp_auto_max => 55.3.
+ *
+ * But if we had kept track of desired temp_auto_max and used that value:
+ *
+ * temp_auto_desired_max - temp_auto_min = 16 
+ *
+ * Again using the 2 bracketing elements from the allowable range table.
+ * 
+ * 13.3 < 16 <= 16  --> temp_auto_range => 16
+ *
+ * and so temp_auto_max => 58
+ *
+ * an entirely different number.
+ * 
+ */
+        s8 temp_auto_desired_max[3];	/* temperature for pwm-controlled fan
+					to go go 100% */
+        s8 temp_auto_desired_off[3];	/* temperature for pwm-controlled fan
+					to turn off */
+        u8 fan_auto_config[3];	/* Register value */
+        u8 fan_auto_freq[3];	/* PWM frequency, encoded */
+        u8 fan_auto_min_pwm[3];	/* Minimum PWM value, encoded */
+        u8 fan_auto_min_ctl[3];	/* Min PWM or OFF below "limit", flag */
+
+	u8 adt7463_therm_limit; /* How long therm can be asserted before an
+				 * interrupt is generated.  (ADT7463-specific 
+				 * register)
+				 */
+	unsigned long adt7463_therm_total; /* Cummulative therm count in
+					    * units of 22760 ms */
 };
 
 static int lm85_attach_adapter(struct i2c_adapter *adapter);
@@ -409,7 +543,6 @@
 /* Unique ID assigned to each LM85 detected */
 static int lm85_id = 0;
 
-
 /* 4 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr)
 {
@@ -450,7 +583,8 @@
 {									\
 	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset,	\
+		NULL) 							\
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_fan_##offset##_min, set_fan_##offset##_min)
 
@@ -517,14 +651,6 @@
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t show_pwm_enable(struct device *dev, char *buf, int nr)
-{
-	struct lm85_data *data = lm85_update_device(dev);
-	int	pwm_zone;
-
-	pwm_zone = ZONE_FROM_REG(data->autofan[nr].config);
-	return sprintf(buf,"%d\n", (pwm_zone != 0 && pwm_zone != -1) );
-}
 
 #define show_pwm_reg(offset)						\
 static ssize_t show_pwm_##offset (struct device *dev, char *buf)	\
@@ -536,13 +662,8 @@
 {									\
 	return set_pwm(dev, buf, count, 0x##offset - 1);		\
 }									\
-static ssize_t show_pwm_enable##offset (struct device *dev, char *buf)	\
-{									\
-	return show_pwm_enable(dev, buf, 0x##offset - 1);			\
-}									\
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, 			\
-		show_pwm_##offset, set_pwm_##offset)			\
-static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO, show_pwm_enable##offset, NULL)
+static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, 		\
+		show_pwm_##offset, set_pwm_##offset)			
 
 show_pwm_reg(1);
 show_pwm_reg(2);
@@ -696,7 +817,8 @@
 {									\
 	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL)	\
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset,	\
+		NULL)							\
 static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_min, set_temp_##offset##_min)	\
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
@@ -706,128 +828,1353 @@
 show_temp_reg(2);
 show_temp_reg(3);
 
+/* Automatic Fan Control bits follow */
 
-int lm85_attach_adapter(struct i2c_adapter *adapter)
+static ssize_t show_fan_auto_invert(struct device *dev, char *buf, int nr)
 {
-	return i2c_detect(adapter, &addr_data, lm85_detect);
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", INVERT_FROM_REG(data->fan_auto_config[nr]));
 }
-
-int lm85_detect(struct i2c_adapter *adapter, int address,
-		int kind)
+static ssize_t set_fan_auto_invert(struct device *dev, const char *buf,
+	size_t count, int nr)
 {
-	int company, verstep ;
-	struct i2c_client *new_client = NULL;
-	struct lm85_data *data;
-	int err = 0;
-	const char *type_name = "";
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
 
-	if (i2c_is_isa_adapter(adapter)) {
-		/* This chip has no ISA interface */
-		goto ERROR0 ;
-	};
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->fan_auto_config[nr] = (data->fan_auto_config[nr] & ~(0x10))
+		| INVERT_TO_REG(val);
+	lm85_write_value(client, LM85_REG_AFAN_CONFIG(nr),
+		data->fan_auto_config[nr]);
+	up(&data->update_lock);
+	return count;
+}
 
-	if (!i2c_check_functionality(adapter,
-					I2C_FUNC_SMBUS_BYTE_DATA)) {
-		/* We need to be able to do byte I/O */
-		goto ERROR0 ;
-	};
+static ssize_t show_fan_auto_spinup(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", SPINUP_FROM_REG(data->fan_auto_config[nr]));
+}
+static ssize_t set_fan_auto_spinup(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
 
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access lm85_{read,write}_value. */
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->fan_auto_config[nr] = (data->fan_auto_config[nr] & (~0x07))
+		| SPINUP_TO_REG(val);
+	lm85_write_value(client, LM85_REG_AFAN_CONFIG(nr),
+		data->fan_auto_config[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t show_fan_auto_zone(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ZONE_FROM_REG(data->fan_auto_config[nr]));
+}
+static ssize_t set_fan_auto_zone(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
 
-	if (!(new_client = kmalloc((sizeof(struct i2c_client)) +
-				    sizeof(struct lm85_data),
-				    GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto ERROR0;
-	}
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->fan_auto_config[nr] = (data->fan_auto_config[nr] & (~0xe0))
+		| ZONE_TO_REG(val) ;
+	lm85_write_value(client, LM85_REG_AFAN_CONFIG(nr),
+		data->fan_auto_config[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t show_fan_auto_freq(struct device *dev, char *buf, int nr)
+{
+        struct lm85_data *data = lm85_update_device(dev);
+        return sprintf(buf,"%d\n", FREQ_FROM_REG(data->fan_auto_freq[nr]));
+}
+static ssize_t set_fan_auto_freq(struct device *dev, const char *buf,
+                size_t count, int nr)
+{
+        struct i2c_client *client = to_i2c_client(dev);
+        struct lm85_data *data = i2c_get_clientdata(client);
+        int     val;
+
+        down(&data->update_lock);
+        val = simple_strtol(buf, NULL, 10);
+        data->fan_auto_freq[nr] = FREQ_TO_REG(val);
+        lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
+                (data->temp_auto_range[nr] << 4)
+                | data->fan_auto_freq[nr]
+        );
+        up(&data->update_lock);
+        return count;
+}
+static ssize_t show_fan_auto_min_pwm(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", PWM_FROM_REG(data->fan_auto_min_pwm[nr]));
+}
+static ssize_t set_fan_auto_min_pwm(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
 
-	memset(new_client, 0, sizeof(struct i2c_client) +
-			      sizeof(struct lm85_data));
-	data = (struct lm85_data *) (new_client + 1);
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &lm85_driver;
-	new_client->flags = 0;
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->fan_auto_min_pwm[nr] = PWM_TO_REG(val);
+	lm85_write_value(client, LM85_REG_AFAN_MINPWM(nr), 
+		data->fan_auto_min_pwm[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t show_fan_auto_min_ctl(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", data->fan_auto_min_ctl[nr]);
+}
+static ssize_t set_fan_auto_min_ctl(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
 
-	/* Now, we do the remaining detection. */
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->fan_auto_min_ctl[nr] = val;
+	lm85_write_value(client, LM85_REG_AFAN_SPIKE1, data->smooth[0]
+		| data->syncpwm3
+		| (data->fan_auto_min_ctl[0] ? 0x20 : 0)
+		| (data->fan_auto_min_ctl[1] ? 0x40 : 0)
+		| (data->fan_auto_min_ctl[2] ? 0x80 : 0)
+	);
+	up(&data->update_lock);
+	return count;
+}
 
-	company = lm85_read_value(new_client, LM85_REG_COMPANY);
-	verstep = lm85_read_value(new_client, LM85_REG_VERSTEP);
+#define fan_auto_reg(offset)						\
+static ssize_t show_fan##offset##_auto (struct device *dev, char *buf)	\
+{									\
+	return show_fan_auto_freq(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan##offset##_auto_invert (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_fan_auto_invert(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan##offset##_auto_spinup (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_fan_auto_spinup(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan##offset##_auto_zone (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_fan_auto_zone(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan##offset##_auto_freq (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_fan_auto_freq(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan##offset##_auto_min_pwm (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_fan_auto_min_pwm(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan##offset##_auto_min_ctl (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_fan_auto_min_ctl(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t set_fan##offset##_auto_invert (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_fan_auto_invert(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan##offset##_auto_spinup (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_fan_auto_spinup(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan##offset##_auto_zone (struct device *dev,		\
+	const char *buf, size_t count)					\
+{									\
+	return set_fan_auto_zone(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan##offset##_auto_freq (struct device *dev,		\
+	const char *buf, size_t count)					\
+{									\
+	return set_fan_auto_freq(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan##offset##_auto_min_pwm (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_fan_auto_min_pwm(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan##offset##_auto_min_ctl (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_fan_auto_min_ctl(dev, buf, count, 0x##offset - 1);	\
+}									\
+static DEVICE_ATTR(fan##offset##_auto, S_IRUGO,				\
+		show_fan##offset##_auto, NULL)				\
+static DEVICE_ATTR(fan##offset##_auto_invert, S_IRUGO | S_IWUSR,	\
+		show_fan##offset##_auto_invert,				\
+		set_fan##offset##_auto_invert)				\
+static DEVICE_ATTR(fan##offset##_auto_spinup, S_IRUGO | S_IWUSR,	\
+		show_fan##offset##_auto_spinup,				\
+		set_fan##offset##_auto_spinup)				\
+static DEVICE_ATTR(fan##offset##_auto_zone, S_IRUGO | S_IWUSR,		\
+		show_fan##offset##_auto_zone,				\
+		set_fan##offset##_auto_zone)				\
+static DEVICE_ATTR(fan##offset##_auto_freq, S_IRUGO | S_IWUSR,		\
+		show_fan##offset##_auto_freq,				\
+		set_fan##offset##_auto_freq)				\
+static DEVICE_ATTR(fan##offset##_auto_min_pwm, S_IRUGO | S_IWUSR,	\
+		show_fan##offset##_auto_min_pwm,			\
+		set_fan##offset##_auto_min_pwm)				\
+static DEVICE_ATTR(fan##offset##_auto_min_ctl, S_IRUGO | S_IWUSR,	\
+		show_fan##offset##_auto_min_ctl,			\
+		set_fan##offset##_auto_min_ctl)				\
+
+fan_auto_reg(1);
+fan_auto_reg(2);
+fan_auto_reg(3);
 
-	dev_dbg(&adapter->dev, "Detecting device at %d,0x%02x with"
-		" COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
-		i2c_adapter_id(new_client->adapter), new_client->addr,
-		company, verstep);
+/* zone/temp_auto stuff */
 
-	/* If auto-detecting, Determine the chip type. */
-	if (kind <= 0) {
-		dev_dbg(&adapter->dev, "Autodetecting device at %d,0x%02x ...\n",
-			i2c_adapter_id(adapter), address );
-		if( company = LM85_COMPANY_NATIONAL
-		    && verstep = LM85_VERSTEP_LM85C ) {
-			kind = lm85c ;
-		} else if( company = LM85_COMPANY_NATIONAL
-		    && verstep = LM85_VERSTEP_LM85B ) {
-			kind = lm85b ;
-		} else if( company = LM85_COMPANY_NATIONAL
-		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
-			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
-				" Defaulting to LM85.\n", verstep);
-			kind = any_chip ;
-		} else if( company = LM85_COMPANY_ANALOG_DEV
-		    && verstep = LM85_VERSTEP_ADM1027 ) {
-			kind = adm1027 ;
-		} else if( company = LM85_COMPANY_ANALOG_DEV
-		    && verstep = LM85_VERSTEP_ADT7463 ) {
-			kind = adt7463 ;
-		} else if( company = LM85_COMPANY_ANALOG_DEV
-		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
-			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
-				" Defaulting to ADM1027.\n", verstep);
-			kind = adm1027 ;
-		} else if( kind = 0 && (verstep & 0xf0) = 0x60) {
-			dev_err(&adapter->dev, "Generic LM85 Version 6 detected\n");
-			/* Leave kind as "any_chip" */
-		} else {
-			dev_dbg(&adapter->dev, "Autodetection failed\n");
-			/* Not an LM85 ... */
-			if( kind = 0 ) {  /* User used force=x,y */
-				dev_err(&adapter->dev, "Generic LM85 Version 6 not"
-					" found at %d,0x%02x. Try force_lm85c.\n",
-					i2c_adapter_id(adapter), address );
-			}
-			err = 0 ;
-			goto ERROR1;
-		}
-	}
+static ssize_t show_temp_auto_off(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_auto_min[nr]) -
+		HYST_FROM_REG(data->temp_auto_hyst[nr]));
+}
+static ssize_t set_temp_auto_off(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int    min, val;
 
-	/* Fill in the chip specific driver values */
-	if ( kind = any_chip ) {
-		type_name = "lm85";
-	} else if ( kind = lm85b ) {
-		type_name = "lm85b";
-	} else if ( kind = lm85c ) {
-		type_name = "lm85c";
-	} else if ( kind = adm1027 ) {
-		type_name = "adm1027";
-	} else if ( kind = adt7463 ) {
-		type_name = "adt7463";
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	min = TEMP_FROM_REG(data->temp_auto_min[nr]);
+	data->temp_auto_desired_off[nr] = TEMP_TO_REG(val);
+	data->temp_auto_hyst[nr] = HYST_TO_REG(min - val);
+	if( nr = 0 || nr = 1 ) {
+		lm85_write_value(client, LM85_REG_AFAN_HYST1,
+			(data->temp_auto_hyst[0] << 4)
+			| data->temp_auto_hyst[1]
+			);
+	} else {
+		lm85_write_value(client, LM85_REG_AFAN_HYST2,
+			(data->temp_auto_hyst[2] << 4)
+		);
 	}
-	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
-
-	/* Fill in the remaining client fields */
-	new_client->id = lm85_id++;
-	data->type = kind;
-	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	up(&data->update_lock);
+	return count;
+}
 
-	dev_dbg(&adapter->dev, "Assigning ID %d to %s at %d,0x%02x\n",
-		new_client->id, new_client->name,
-		i2c_adapter_id(new_client->adapter),
-		new_client->addr);
+static ssize_t show_temp_auto_critical(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_auto_critical[nr]));
+}
+
+static ssize_t set_temp_auto_critical(struct device *dev, const char *buf,
+                size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->temp_auto_critical[nr] = TEMP_TO_REG(val);
+	lm85_write_value(client, LM85_REG_AFAN_CRITICAL(nr),
+		data->temp_auto_critical[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t show_temp_auto_max(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_auto_min[nr]) +
+		RANGE_FROM_REG(data->temp_auto_range[nr]));
+}
+static ssize_t set_temp_auto_max(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int    min, val;
+
+	down(&data->update_lock);
+	min = TEMP_FROM_REG(data->temp_auto_min[nr]);
+	val = simple_strtol(buf, NULL, 10);
+	data->temp_auto_desired_max[nr] = TEMP_TO_REG(val);
+	data->temp_auto_range[nr] = RANGE_TO_REG(
+		val - min);
+	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
+		((data->temp_auto_range[nr] & 0x0f) << 4)
+		| (data->fan_auto_freq[nr] & 0x07));
+	up(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_temp_auto_min(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_auto_min[nr]) );
+}
+static ssize_t set_temp_auto_min(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int    val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->temp_auto_min[nr] = TEMP_TO_REG(val);
+	lm85_write_value(client, LM85_REG_AFAN_LIMIT(nr), 
+		data->temp_auto_min[nr]);
+
+/* Update temp_auto_max and temp_auto_range */
+
+	data->temp_auto_range[nr] = RANGE_TO_REG(
+		TEMP_FROM_REG(data->temp_auto_desired_max[nr]) -
+		TEMP_FROM_REG(data->temp_auto_min[nr]));
+	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
+		((data->temp_auto_range[nr] & 0x0f) << 4)
+		| (data->fan_auto_freq[nr] & 0x07));
+
+/* Update temp_auto_hyst and temp_auto_off */
+
+	data->temp_auto_hyst[nr] = HYST_TO_REG(TEMP_FROM_REG(
+		data->temp_auto_min[nr]) - TEMP_FROM_REG(
+		data->temp_auto_desired_off[nr]));
+	if( nr = 0 || nr = 1 ) {
+		lm85_write_value(client, LM85_REG_AFAN_HYST1,
+			(data->temp_auto_hyst[0] << 4)
+			| data->temp_auto_hyst[1]
+			);
+	} else {
+		lm85_write_value(client, LM85_REG_AFAN_HYST2,
+			(data->temp_auto_hyst[2] << 4)
+		);
+	}
+	up(&data->update_lock);
+	return count;
+}
+
+
+#define temp_auto(offset)						\
+static ssize_t show_temp##offset##_auto_max (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_temp_auto_max(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t set_temp##offset##_auto_max (struct device *dev,		\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_max(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t show_temp##offset##_auto_off (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_temp_auto_off(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t set_temp##offset##_auto_off (struct device *dev,		\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_off(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t show_temp##offset##_auto_critical (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_temp_auto_critical(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t set_temp##offset##_auto_critical (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_critical(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t show_temp##offset##_auto_min (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_temp_auto_min(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t set_temp##offset##_auto_min (struct device *dev,		\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_min(dev, buf, count, 0x##offset - 1);	\
+}									\
+static DEVICE_ATTR(temp##offset##_auto_max, S_IRUGO | S_IWUSR,		\
+		show_temp##offset##_auto_max,				\
+		set_temp##offset##_auto_max)				\
+static DEVICE_ATTR(temp##offset##_auto_off, S_IRUGO | S_IWUSR,		\
+		show_temp##offset##_auto_off,				\
+		set_temp##offset##_auto_off)				\
+static DEVICE_ATTR(temp##offset##_auto_critical, S_IRUGO | S_IWUSR,	\
+		show_temp##offset##_auto_critical,			\
+		set_temp##offset##_auto_critical)			\
+static DEVICE_ATTR(temp##offset##_auto_min, S_IRUGO | S_IWUSR,		\
+		show_temp##offset##_auto_min,				\
+		set_temp##offset##_auto_min)
+
+temp_auto(1);
+temp_auto(2);
+temp_auto(3);
+
+
+/*
+ * ADT7463-specific operating point dynamic Tmin control -JRT 
+ */
+
+static ssize_t show_temp_auto_oppoint(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_auto_oppoint[nr]));
+}
+
+static ssize_t set_temp_auto_oppoint(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->temp_auto_oppoint[nr] = TEMP_TO_REG(val);
+	lm85_write_value(client, ADT7463_REG_OPPOINT(nr),
+		data->temp_auto_oppoint[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+
+#define temp_auto_oppoint(offset)					\
+static ssize_t show_temp##offset##_auto_oppoint(struct device *dev, 	\
+	char *buf)							\
+{									\
+	return show_temp_auto_oppoint(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t set_temp##offset##_auto_oppoint(struct device *dev, 	\
+	const char *buf, size_t count)					\
+{									\
+	return set_temp_auto_oppoint(dev, buf, count, 0x##offset - 1);	\
+}									\
+static DEVICE_ATTR(temp##offset##_auto_oppoint, S_IRUGO | S_IWUSR,	\
+		show_temp##offset##_auto_oppoint,			\
+		set_temp##offset##_auto_oppoint)				
+
+temp_auto_oppoint(1);
+temp_auto_oppoint(2);
+temp_auto_oppoint(3);
+
+static ssize_t show_temp_auto_dynamic_tmin_ctl(struct device *dev, 
+	char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", DYNAMIC_TMIN_ENABLE_FROM_REG(
+		data->tmin_ctl, nr));
+}
+static ssize_t set_temp_auto_dynamic_tmin_ctl(struct device *dev, 
+	const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->tmin_ctl = (data->tmin_ctl & ~(0x01 << (13 + nr)))
+		| DYNAMIC_TMIN_ENABLE_TO_REG(val, nr);
+	lm85_write_value(client, ADT7463_REG_TMIN_CTL1, data->tmin_ctl);
+	up(&data->update_lock);
+	return count;
+}
+
+/*
+ * Enable/Disable ADT7463 automatic Tmin control.
+ */
+
+#define temp_auto_dynamic_tmin_ctl(offset)				\
+static ssize_t show_temp##offset##_auto_dynamic_tmin_ctl (struct 	\
+	device *dev, char *buf)						\
+{									\
+	return show_temp_auto_dynamic_tmin_ctl(dev, buf, 		\
+		0x##offset - 1);					\
+}									\
+static ssize_t set_temp##offset##_auto_dynamic_tmin_ctl (struct		\
+	device *dev, const char *buf, size_t count)			\
+{									\
+	return set_temp_auto_dynamic_tmin_ctl(dev, buf, count, 		\
+		0x##offset - 1);					\
+}									\
+static DEVICE_ATTR(temp##offset##_auto_dynamic_tmin_ctl, S_IRUGO 	\
+		| S_IWUSR, 						\
+		show_temp##offset##_auto_dynamic_tmin_ctl,		\
+		set_temp##offset##_auto_dynamic_tmin_ctl)				
+
+temp_auto_dynamic_tmin_ctl(1);
+temp_auto_dynamic_tmin_ctl(2);
+temp_auto_dynamic_tmin_ctl(3);
+
+
+/* SET ADT7463 THERM LIMIT */
+
+static ssize_t adt7463_show_therm_limit(struct device *dev, 
+	char *buf)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ADT7463_THERM_LIMIT_FROM_REG(
+		data->adt7463_therm_limit));
+}
+static ssize_t adt7463_set_therm_limit(struct device *dev, 
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->adt7463_therm_limit= ADT7463_THERM_LIMIT_TO_REG(val);
+	lm85_write_value(client, ADT7463_REG_THERM_LIMIT,
+		data->adt7463_therm_limit);
+	up(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(therm_limit, S_IRUGO | S_IWUSR,
+		adt7463_show_therm_limit, adt7463_set_therm_limit)
+
+/* SHOW ADT7463 THERM TOTAL */
+
+static ssize_t adt7463_show_therm_total(struct device *dev, 
+	char *buf)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%ld\n", ADT7463_THERM_TOTAL_IN_MSEC(
+		data->adt7463_therm_total));
+}
+
+static DEVICE_ATTR(therm_total, S_IRUGO | S_IWUSR,
+		adt7463_show_therm_total, NULL)
+
+/* SPINUP_CTL STUFF */
+
+static ssize_t lm85_show_fan_auto_spinup_ctl(struct device *dev, 
+	char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", LM85_SPINUP_CTL_FROM_REG(
+		data->fan_auto_spinup_ctl, nr));
+}
+static ssize_t lm85_set_fan_auto_spinup_ctl(struct device *dev, 
+	const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	switch (nr) {
+	case 1 :
+	data->fan_auto_spinup_ctl = (data->fan_auto_spinup_ctl &
+		0x06) | LM85_SPINUP_CTL_TO_REG(val, nr);
+		break;
+	case 2 :
+	data->fan_auto_spinup_ctl = (data->fan_auto_spinup_ctl &
+		0x05) | LM85_SPINUP_CTL_TO_REG(val, nr);
+		break;
+	case 3 :
+	data->fan_auto_spinup_ctl = (data->fan_auto_spinup_ctl &
+		0x03) | LM85_SPINUP_CTL_TO_REG(val, nr);
+		break;
+	}
+	lm85_write_value(client, LM85_REG_SPINUP_CTL,
+		data->fan_auto_spinup_ctl);
+	up(&data->update_lock);
+	return count;
+}
+
+#define lm85_fan_auto_spinup_ctl(offset)				\
+static ssize_t show_fan##offset##_auto_spinup_ctl (struct device *dev,	\
+	char *buf)							\
+{									\
+	return lm85_show_fan_auto_spinup_ctl(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan##offset##_auto_spinup_ctl (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return lm85_set_fan_auto_spinup_ctl(dev, buf, count,		\
+	0x##offset - 1);						\
+}									\
+static DEVICE_ATTR(fan##offset##_auto_spinup_ctl, S_IRUGO | S_IWUSR,	\
+		show_fan##offset##_auto_spinup_ctl,			\
+		set_fan##offset##_auto_spinup_ctl) 
+
+lm85_fan_auto_spinup_ctl(1);
+lm85_fan_auto_spinup_ctl(2);
+lm85_fan_auto_spinup_ctl(3);
+
+static ssize_t adm1027_show_fan_auto_spinup_ctl(struct device *dev, 
+	char *buf)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ADM1027_SPINUP_CTL_FROM_REG(
+		data->fan_auto_spinup_ctl));
+}
+static ssize_t adm1027_set_fan_auto_spinup_ctl(struct device *dev, 
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->fan_auto_spinup_ctl = ADM1027_SPINUP_CTL_TO_REG(val);
+
+/*
+ *  Because data->config1 is read from LM85_REG_CONFIG, and because
+ *  the start bit 0x01 is flipped _after_ the value in data->config1 is 
+ *  set, we must make sure the start bit is set properly when we write
+ *  the new configuration to the register.
+ */
+
+	data->config1 = (data->config1 & 0xdf) | data->fan_auto_spinup_ctl
+		| 0x01;
+	lm85_write_value(client, LM85_REG_CONFIG, data->config1); 
+	up(&data->update_lock); 
+	return count;
+}
+
+static DEVICE_ATTR(fan_auto_spinup_ctl, S_IRUGO | S_IWUSR,		
+		adm1027_show_fan_auto_spinup_ctl, 
+		adm1027_set_fan_auto_spinup_ctl) 			
+
+
+/* END SPINUP_CTL STUFF */
+
+/* SMOOTHING STUFF */
+
+static ssize_t show_smoothing(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", SMOOTH_FROM_REG(data->smooth[nr]) );
+}
+static ssize_t set_smoothing(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->smooth[nr] = SMOOTH_TO_REG(val);
+	switch( nr ) {
+	case 1 :
+		lm85_write_value(client, LM85_REG_AFAN_SPIKE1,
+			data->smooth[0]
+			| data->syncpwm3
+			| (data->fan_auto_min_ctl[0] ? 0x20 : 0)
+			| (data->fan_auto_min_ctl[1] ? 0x40 : 0)
+			| (data->fan_auto_min_ctl[2] ? 0x80 : 0));
+		break ;
+	case 2 :
+	case 3 :
+		lm85_write_value(client, LM85_REG_AFAN_SPIKE2,
+			data->smooth[1] << 4
+			| data->smooth[2]);
+		break ;
+	}
+	up(&data->update_lock);
+	return count;
+}
+
+#define smoothing(offset)						\
+static ssize_t show_smoothing_##offset (struct device *dev, char *buf)	\
+{									\
+	return show_smoothing(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t set_smoothing_##offset (struct device *dev,		\
+	const char *buf, size_t count)					\
+{									\
+	return set_smoothing(dev, buf, count, 0x##offset - 1);		\
+}									\
+static DEVICE_ATTR(temp##offset##_auto_smooth, S_IRUGO | S_IWUSR,		\
+		show_smoothing_##offset, set_smoothing_##offset)         
+
+smoothing(1);
+smoothing(2);
+smoothing(3);
+
+/* tach */
+
+static ssize_t lm85_show_fan_tach_mode(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", LM85_TACH_MODE_FROM_REG(data->tach_mode, nr));
+}
+static ssize_t lm85_set_fan_tach_mode(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->tach_mode = (data->tach_mode & ~(0x03 << (2*nr)))
+		| LM85_TACH_MODE_TO_REG(val,nr);
+	lm85_write_value(client, LM85_REG_TACH_MODE, data->tach_mode);
+	up(&data->update_lock);
+	return count;
+}
+
+static ssize_t adm1027_show_fan_tach_mode(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ADM1027_TACH_MODE_FROM_REG(data->tach_mode,
+		nr));
+}
+static ssize_t adm1027_set_fan_tach_mode(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->tach_mode = (data->tach_mode & ~(0x01 << (nr + 4)))
+		| ADM1027_TACH_MODE_TO_REG(val,nr);
+	lm85_write_value(client, ADM1027_REG_CONFIG3, data->tach_mode);
+	up(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_fan_tach_mode(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	switch (data->type) {
+	case adm1027  :
+	case adt7463  :
+		return adm1027_show_fan_tach_mode(dev, buf, nr);
+		break;
+	case any_chip :
+	case lm85b    :
+	case lm85c    :
+	default       :
+		return lm85_show_fan_tach_mode(dev, buf, nr);
+	}
+}
+static ssize_t set_fan_tach_mode(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	switch (data->type) {
+	case adm1027  :
+	case adt7463  :
+		return adm1027_set_fan_tach_mode(dev, buf, count, nr);
+		break;
+	case any_chip :
+	case lm85b    :
+	case lm85c    :
+	default       :
+		return lm85_set_fan_tach_mode(dev, buf, count, nr);
+	}
+}
+
+#define fan_tach_mode(offset)						\
+static ssize_t show_fan##offset##_tach_mode (struct device *dev,	\
+	char *buf)							\
+{									\
+	return show_fan_tach_mode(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t set_fan##offset##_tach_mode (struct device *dev,		\
+	const char *buf, size_t count)					\
+{									\
+	return set_fan_tach_mode(dev, buf, count, 0x##offset - 1);	\
+}									\
+static DEVICE_ATTR(fan##offset##_tach_mode, S_IRUGO | S_IWUSR,		\
+		show_fan##offset##_tach_mode, 				\
+		set_fan##offset##_tach_mode)         
+
+fan_tach_mode(1);
+fan_tach_mode(2);
+fan_tach_mode(3);
+fan_tach_mode(4);
+
+/* ADM1027 PPR control */
+
+static ssize_t adm1027_show_fan_ppr(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", PPR_FROM_REG(
+		data->adm1027_fan_ppr, nr));
+}
+
+static ssize_t adm1027_set_fan_ppr(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->adm1027_fan_ppr = ((data->adm1027_fan_ppr & 
+		~PPR_MASK(nr)) | PPR_TO_REG(val,nr));
+	lm85_write_value(client, ADM1027_REG_FAN_PPR,
+		data->adm1027_fan_ppr);
+	up(&data->update_lock);
+	return count;
+}
+
+#define adm1027_fan_ppr(offset)						\
+static ssize_t adm1027_show_fan##offset##_ppr (struct device *dev,	\
+	char *buf)							\
+{									\
+	return adm1027_show_fan_ppr(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t adm1027_set_fan##offset##_ppr (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return adm1027_set_fan_ppr(dev, buf, count,			\
+	0x##offset - 1);						\
+}									\
+static DEVICE_ATTR(fan##offset##_ppr, S_IRUGO | S_IWUSR,		\
+		adm1027_show_fan##offset##_ppr, 			\
+		adm1027_set_fan##offset##_ppr)         
+
+adm1027_fan_ppr(1);
+adm1027_fan_ppr(2);
+adm1027_fan_ppr(3);
+adm1027_fan_ppr(4);
+
+/* ADM1027 and ADT7463 temperature offset control */
+
+static ssize_t adm1027_show_temp_offset(struct device *dev, char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	if (data->type = adm1027) {
+		return sprintf(buf,"%d\n", ADM1027_OFFSET_FROM_REG(
+			data->temp_offset[nr]));
+	}else {
+		return sprintf(buf,"%d\n", ADT7463_OFFSET_FROM_REG(
+			data->temp_offset[nr]));
+	}
+}
+
+static ssize_t adm1027_set_temp_offset(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	if (data->type = adm1027) {
+		data->temp_offset[nr] = ADM1027_OFFSET_TO_REG(val);
+	} else {
+		data->temp_offset[nr] = ADT7463_OFFSET_TO_REG(val);
+	}
+	lm85_write_value(client, ADM1027_REG_TEMP_OFFSET(nr),
+		data->temp_offset[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+#define adm1027_temp_offset(offset)					\
+static ssize_t adm1027_show_temp##offset##_offset (struct device *dev,	\
+	char *buf)							\
+{									\
+	return adm1027_show_temp_offset(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t adm1027_set_temp##offset##_offset (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return adm1027_set_temp_offset(dev, buf, count,			\
+	0x##offset - 1);						\
+}									\
+static DEVICE_ATTR(temp##offset##_offset, S_IRUGO | S_IWUSR,		\
+		adm1027_show_temp##offset##_offset, 			\
+		adm1027_set_temp##offset##_offset)         
+
+adm1027_temp_offset(1);
+adm1027_temp_offset(2);
+adm1027_temp_offset(3);
+
+
+/* Here come the (many) ADM1027/ADT7463 alarm mask SET and SHOW functions */
+
+static ssize_t adm1027_show_alarm_mask_2500mv(struct device *dev, 
+	char *buf)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ALARM_MASK_FROM_REG(
+		data->intmask1, 0));
+}
+static ssize_t adm1027_set_alarm_mask_2500mv(struct device *dev, 
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->intmask1 = (data->intmask1 & ~(0x01)) 
+		| ALARM_MASK_TO_REG(val,0);
+	lm85_write_value(client, ADM1027_REG_INTMASK1, data->intmask1);
+	up(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(alarm_mask_2500mv, S_IRUGO | S_IWUSR,
+		adm1027_show_alarm_mask_2500mv, adm1027_set_alarm_mask_2500mv)
+
+static ssize_t adm1027_show_alarm_mask_vccp(struct device *dev, 
+	char *buf)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ALARM_MASK_FROM_REG(
+		data->intmask1,1));
+}
+static ssize_t adm1027_set_alarm_mask_vccp(struct device *dev, 
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->intmask1 = (data->intmask1 & ~(0x02)) 
+		| ALARM_MASK_TO_REG(val,1);
+	lm85_write_value(client, ADM1027_REG_INTMASK1, data->intmask1);
+	up(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(alarm_mask_vccp, S_IRUGO | S_IWUSR,
+		adm1027_show_alarm_mask_vccp, adm1027_set_alarm_mask_vccp)         
+
+static ssize_t adm1027_show_alarm_mask_vcc(struct device *dev, 
+	char *buf)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ALARM_MASK_FROM_REG(
+		data->intmask1,2));
+}
+static ssize_t adm1027_set_alarm_mask_vcc(struct device *dev, 
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->intmask1 = (data->intmask1 & ~(0x04)) 
+		| ALARM_MASK_TO_REG(val,2);
+	lm85_write_value(client, ADM1027_REG_INTMASK1, data->intmask1);
+	up(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(alarm_mask_vcc, S_IRUGO | S_IWUSR,
+		adm1027_show_alarm_mask_vcc, adm1027_set_alarm_mask_vcc)         
+
+static ssize_t adm1027_show_alarm_mask_5000mv(struct device *dev, 
+	char *buf)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ALARM_MASK_FROM_REG(
+		data->intmask1,3));
+}
+static ssize_t adm1027_set_alarm_mask_5000mv(struct device *dev, 
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->intmask1 = (data->intmask1 & ~(0x08)) 
+		| ALARM_MASK_TO_REG(val,3);
+	lm85_write_value(client, ADM1027_REG_INTMASK1, data->intmask1);
+	up(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(alarm_mask_5000mv, S_IRUGO | S_IWUSR,
+		adm1027_show_alarm_mask_5000mv, adm1027_set_alarm_mask_5000mv)         
+
+static ssize_t adm1027_show_alarm_mask_temp(struct device *dev, 
+	char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ALARM_MASK_FROM_REG(
+		data->intmask1,(4+nr)));
+}
+static ssize_t adm1027_set_alarm_mask_temp(struct device *dev, 
+	const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int    val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	switch (nr) {
+	case 1 :
+		data->intmask1 = (data->intmask1 & ~0x10) 
+			| ALARM_MASK_TO_REG(val,(4 + nr));
+		break;
+	case 2 :
+		data->intmask1 = (data->intmask1 & ~0x20) 
+			| ALARM_MASK_TO_REG(val,(4 + nr));
+		break;
+	case 3 :
+		data->intmask1 = (data->intmask1 & ~0x40) 
+			| ALARM_MASK_TO_REG(val,(4 + nr));
+	}
+	lm85_write_value(client, ADM1027_REG_INTMASK1, data->intmask1);
+	up(&data->update_lock);
+	return count;
+}
+
+#define adm1027_alarm_mask_temp(offset)					\
+static ssize_t adm1027_show_alarm_mask_temp##offset (			\
+	struct device *dev, char *buf)					\
+{									\
+	return adm1027_show_alarm_mask_temp(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t adm1027_set_alarm_mask_temp##offset (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return adm1027_set_alarm_mask_temp(dev, buf, count,		\
+	0x##offset - 1);						\
+}									\
+static DEVICE_ATTR(alarm_mask_temp##offset, S_IRUGO | S_IWUSR,		\
+		adm1027_show_alarm_mask_temp##offset, 			\
+		adm1027_set_alarm_mask_temp##offset)         
+
+adm1027_alarm_mask_temp(1);
+adm1027_alarm_mask_temp(2);
+adm1027_alarm_mask_temp(3);
+
+static ssize_t adm1027_show_alarm_mask_12000mv(struct device *dev, 
+	char *buf)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ALARM_MASK_FROM_REG(
+		data->intmask2,0));
+}
+
+static ssize_t adm1027_set_alarm_mask_12000mv(struct device *dev, 
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->intmask1 = data->intmask1 | 0x80;
+	data->intmask2 = (data->intmask2 & ~(0x01)) 
+		| ALARM_MASK_TO_REG(val,0);
+	lm85_write_value(client, ADM1027_REG_INTMASK1, data->intmask1);
+	lm85_write_value(client, ADM1027_REG_INTMASK2, data->intmask2);
+	up(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(alarm_mask_12000mv, S_IRUGO | S_IWUSR,
+		adm1027_show_alarm_mask_12000mv, adm1027_set_alarm_mask_12000mv)         
+
+static ssize_t adm1027_show_alarm_mask_therm(struct device *dev, 
+	char *buf)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ALARM_MASK_FROM_REG(
+		data->intmask2,1));
+}
+static ssize_t adm1027_set_alarm_mask_therm(struct device *dev, 
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int     val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	data->intmask1 = data->intmask1 | 0x80;
+	data->intmask2 = (data->intmask2 & ~(0x02)) 
+		| ALARM_MASK_TO_REG(val,1);
+	lm85_write_value(client, ADM1027_REG_INTMASK1, data->intmask1);
+	lm85_write_value(client, ADM1027_REG_INTMASK2, data->intmask2);
+	up(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(alarm_mask_therm, S_IRUGO | S_IWUSR,
+		adm1027_show_alarm_mask_therm, adm1027_set_alarm_mask_therm)         
+static ssize_t adm1027_show_alarm_mask_fan(struct device *dev, 
+	char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ALARM_MASK_FROM_REG(
+		data->intmask2,(2+nr)));
+}
+static ssize_t adm1027_set_alarm_mask_fan(struct device *dev, 
+	const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int    val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	switch (nr) {
+	case 1 :
+	data->intmask2 = (data->intmask2 & ~0x04) 
+		| ALARM_MASK_TO_REG(val,(2+nr));
+		break;
+	case 2 :
+	data->intmask2 = (data->intmask2 & ~0x08) 
+		| ALARM_MASK_TO_REG(val,(2+nr));
+		break;
+	case 3 :
+	data->intmask2 = (data->intmask2 & ~0x10) 
+		| ALARM_MASK_TO_REG(val,(2+nr));
+		break;
+	case 4 :
+	data->intmask2 = (data->intmask2 & ~0x20) 
+		| ALARM_MASK_TO_REG(val,(2+nr));
+	}
+	data->intmask1 = data->intmask1 | 0x80;
+	lm85_write_value(client, ADM1027_REG_INTMASK1, data->intmask1);
+	lm85_write_value(client, ADM1027_REG_INTMASK2, data->intmask2);
+	up(&data->update_lock);
+	return count;
+}
+
+#define adm1027_alarm_mask_fan(offset)					\
+static ssize_t adm1027_show_alarm_mask_fan##offset (struct device *dev,	\
+	char *buf)							\
+{									\
+	return adm1027_show_alarm_mask_fan(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t adm1027_set_alarm_mask_fan##offset (struct device *dev,	\
+	const char *buf, size_t count)					\
+{									\
+	return adm1027_set_alarm_mask_fan(dev, buf, count,		\
+	0x##offset - 1);						\
+}									\
+static DEVICE_ATTR(alarm_mask_fan##offset, S_IRUGO | S_IWUSR,		\
+		adm1027_show_alarm_mask_fan##offset, 			\
+		adm1027_set_alarm_mask_fan##offset)         
+
+adm1027_alarm_mask_fan(1);
+adm1027_alarm_mask_fan(2);
+adm1027_alarm_mask_fan(3);
+adm1027_alarm_mask_fan(4);
+
+
+static ssize_t adm1027_show_alarm_mask_remote_elec(struct device *dev, 
+	char *buf, int nr)
+{
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf,"%d\n", ALARM_MASK_FROM_REG(
+		data->intmask2,(6+nr)));
+}
+
+static ssize_t adm1027_set_alarm_mask_remote_elec(struct device *dev, 
+	const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	int    val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+	switch (nr) {
+	case 1 :
+		data->intmask2 = (data->intmask2 & ~0x40) 
+			| ALARM_MASK_TO_REG(val,(6+nr));
+		break;
+	case 2 :
+		data->intmask2 = (data->intmask2 & ~0x80) 
+			| ALARM_MASK_TO_REG(val,(6+nr));
+		break;
+	}
+	data->intmask1 = data->intmask1 | 0x80; 
+	lm85_write_value(client, ADM1027_REG_INTMASK1, data->intmask1);
+	lm85_write_value(client, ADM1027_REG_INTMASK2, data->intmask2);
+	up(&data->update_lock);
+	return count;
+}
+
+#define adm1027_alarm_mask_remote_elec(offset)				\
+static ssize_t adm1027_show_alarm_mask_remote##offset##_elec (		\
+	struct device *dev, char *buf)					\
+{									\
+	return adm1027_show_alarm_mask_remote_elec(dev, buf,		\
+		0x##offset - 1);					\
+}									\
+static ssize_t adm1027_set_alarm_mask_remote##offset##_elec (		\
+	struct device *dev, const char *buf, size_t count)		\
+{									\
+	return adm1027_set_alarm_mask_remote_elec(dev, buf, count,	\
+	0x##offset - 1);						\
+}									\
+static DEVICE_ATTR(alarm_mask_remote##offset##_elec, S_IRUGO | S_IWUSR,	\
+		adm1027_show_alarm_mask_remote##offset##_elec, 		\
+		adm1027_set_alarm_mask_remote##offset##_elec)         
+
+adm1027_alarm_mask_remote_elec(1);
+adm1027_alarm_mask_remote_elec(2);
+
+
+int lm85_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, lm85_detect);
+}
+
+int lm85_detect(struct i2c_adapter *adapter, int address,
+		int kind)
+{
+	int company, verstep ;
+	struct i2c_client *new_client = NULL;
+	struct lm85_data *data;
+	int err = 0;
+	const char *type_name = "";
+
+	if (i2c_is_isa_adapter(adapter)) {
+		/* This chip has no ISA interface */
+		goto ERROR0 ;
+	};
+
+	if (!i2c_check_functionality(adapter,
+					I2C_FUNC_SMBUS_BYTE_DATA)) {
+		/* We need to be able to do byte I/O */
+		goto ERROR0 ;
+	};
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access lm85_{read,write}_value. */
+
+	if (!(data = kmalloc(sizeof(struct lm85_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR0;
+	}
+	memset(data, 0, sizeof(struct lm85_data));
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &lm85_driver;
+	new_client->flags = 0;
+
+	/* Now, we do the remaining detection. */
+
+	company = lm85_read_value(new_client, LM85_REG_COMPANY);
+	verstep = lm85_read_value(new_client, LM85_REG_VERSTEP);
+
+	dev_dbg(&adapter->dev, "Detecting device at %d,0x%02x with"
+		" COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
+		i2c_adapter_id(new_client->adapter), new_client->addr,
+		company, verstep);
+
+	/* If auto-detecting, Determine the chip type. */
+	if (kind <= 0) {
+		dev_dbg(&adapter->dev, "Autodetecting device at %d,0x%02x ...\n",
+			i2c_adapter_id(adapter), address );
+		if( company = LM85_COMPANY_NATIONAL
+		    && verstep = LM85_VERSTEP_LM85C ) {
+			kind = lm85c ;
+		} else if( company = LM85_COMPANY_NATIONAL
+		    && verstep = LM85_VERSTEP_LM85B ) {
+			kind = lm85b ;
+		} else if( company = LM85_COMPANY_NATIONAL
+		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
+				" Defaulting to LM85.\n", verstep);
+			kind = any_chip ;
+		} else if( company = LM85_COMPANY_ANALOG_DEV
+		    && verstep = LM85_VERSTEP_ADM1027 ) {
+			kind = adm1027 ;
+		} else if( company = LM85_COMPANY_ANALOG_DEV
+		    && verstep = LM85_VERSTEP_ADT7463 ) {
+			kind = adt7463 ;
+		} else if( company = LM85_COMPANY_ANALOG_DEV
+		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
+				" Defaulting to ADM1027.\n", verstep);
+			kind = adm1027 ;
+		} else if( kind = 0 && (verstep & 0xf0) = 0x60) {
+			dev_err(&adapter->dev, "Generic LM85 Version 6 detected\n");
+			/* Leave kind as "any_chip" */
+		} else {
+			dev_dbg(&adapter->dev, "Autodetection failed\n");
+			/* Not an LM85 ... */
+			if( kind = 0 ) {  /* User used force=x,y */
+				dev_err(&adapter->dev, "Generic LM85 Version 6 not"
+					" found at %d,0x%02x. Try force_lm85c.\n",
+					i2c_adapter_id(adapter), address );
+			}
+			err = 0 ;
+			goto ERROR1;
+		}
+	}
+
+	/* Fill in the chip specific driver values */
+	if ( kind = any_chip ) {
+		type_name = "lm85";
+	} else if ( kind = lm85b ) {
+	} else if ( kind = lm85c ) {
+		type_name = "lm85c";
+	} else if ( kind = adm1027 ) {
+		type_name = "adm1027";
+	} else if ( kind = adt7463 ) {
+		type_name = "adt7463";
+	}
+	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
+
+	/* Fill in the remaining client fields */
+	new_client->id = lm85_id++;
+	data->type = kind;
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	dev_dbg(&adapter->dev, "Assigning ID %d to %s at %d,0x%02x\n",
+		new_client->id, new_client->name,
+		i2c_adapter_id(new_client->adapter),
+		new_client->addr);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
@@ -851,9 +2198,6 @@
 	device_create_file(&new_client->dev, &dev_attr_fan1_pwm);
 	device_create_file(&new_client->dev, &dev_attr_fan2_pwm);
 	device_create_file(&new_client->dev, &dev_attr_fan3_pwm);
-	device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable);
-	device_create_file(&new_client->dev, &dev_attr_fan2_pwm_enable);
-	device_create_file(&new_client->dev, &dev_attr_fan3_pwm_enable);
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
@@ -882,11 +2226,144 @@
 	device_create_file(&new_client->dev, &dev_attr_in0_ref);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
+/* Autofan, Zone/temp_auto, spinup, and smoothing entries */
+
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_spinup);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_spinup);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_spinup);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_zone);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_zone);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_zone);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_invert);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_invert);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_invert); 
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_freq);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_freq);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_freq);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_min_pwm);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_min_pwm);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_min_pwm);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_min_ctl);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_min_ctl);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_min_ctl);
+	device_create_file(&new_client->dev, &dev_attr_temp1_auto_min);
+	device_create_file(&new_client->dev, &dev_attr_temp2_auto_min);
+	device_create_file(&new_client->dev, &dev_attr_temp3_auto_min);
+	device_create_file(&new_client->dev, &dev_attr_temp1_auto_max);
+	device_create_file(&new_client->dev, &dev_attr_temp2_auto_max);
+	device_create_file(&new_client->dev, &dev_attr_temp3_auto_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_auto_off);
+	device_create_file(&new_client->dev, &dev_attr_temp2_auto_off);
+	device_create_file(&new_client->dev, &dev_attr_temp3_auto_off);  
+	device_create_file(&new_client->dev, &dev_attr_temp1_auto_critical);
+	device_create_file(&new_client->dev, &dev_attr_temp2_auto_critical);
+	device_create_file(&new_client->dev, &dev_attr_temp3_auto_critical);
+	device_create_file(&new_client->dev, &dev_attr_temp1_auto_smooth);
+	device_create_file(&new_client->dev, &dev_attr_temp2_auto_smooth);
+	device_create_file(&new_client->dev, &dev_attr_temp3_auto_smooth);
+	device_create_file(&new_client->dev, &dev_attr_fan1_tach_mode);
+	device_create_file(&new_client->dev, &dev_attr_fan2_tach_mode);
+	device_create_file(&new_client->dev, &dev_attr_fan3_tach_mode);
+
+/* chip variant-specific entries */
+
+	switch (data->type) {
+	case adt7463 :
+		device_create_file(&new_client->dev,
+			&dev_attr_temp1_auto_oppoint);
+		device_create_file(&new_client->dev,
+			&dev_attr_temp2_auto_oppoint);
+		device_create_file(&new_client->dev,
+			&dev_attr_temp3_auto_oppoint);
+		device_create_file(&new_client->dev,
+			&dev_attr_temp1_auto_dynamic_tmin_ctl);
+		device_create_file(&new_client->dev,
+			&dev_attr_temp2_auto_dynamic_tmin_ctl);
+		device_create_file(&new_client->dev,
+			&dev_attr_temp3_auto_dynamic_tmin_ctl);
+		device_create_file(&new_client->dev, &dev_attr_fan4_tach_mode);
+		device_create_file(&new_client->dev, 
+			&dev_attr_fan_auto_spinup_ctl); 
+		device_create_file(&new_client->dev, &dev_attr_therm_limit);
+		device_create_file(&new_client->dev, &dev_attr_therm_total);
+		device_create_file(&new_client->dev, &dev_attr_fan1_ppr);
+		device_create_file(&new_client->dev, &dev_attr_fan2_ppr);
+		device_create_file(&new_client->dev, &dev_attr_fan3_ppr);
+		device_create_file(&new_client->dev, &dev_attr_fan4_ppr);
+		device_create_file(&new_client->dev, &dev_attr_temp1_offset);
+		device_create_file(&new_client->dev, &dev_attr_temp2_offset);
+		device_create_file(&new_client->dev, &dev_attr_temp3_offset);
+		device_create_file(&new_client->dev,
+			&dev_attr_alarm_mask_2500mv);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_vccp);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_vcc);
+		device_create_file(&new_client->dev,
+			&dev_attr_alarm_mask_5000mv);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_temp1);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_temp2);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_temp3);
+		device_create_file(&new_client->dev,
+			&dev_attr_alarm_mask_12000mv);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_therm);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_fan1);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_fan2);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_fan3);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_fan4);
+		device_create_file(&new_client->dev,
+			&dev_attr_alarm_mask_remote1_elec);
+		device_create_file(&new_client->dev,
+			&dev_attr_alarm_mask_remote2_elec);
+		break;
+	case adm1027 :
+		device_create_file(&new_client->dev, &dev_attr_fan4_tach_mode);
+		device_create_file(&new_client->dev, 
+			&dev_attr_fan_auto_spinup_ctl);
+		device_create_file(&new_client->dev, &dev_attr_fan1_ppr);
+		device_create_file(&new_client->dev, &dev_attr_fan2_ppr);
+		device_create_file(&new_client->dev, &dev_attr_fan3_ppr);
+		device_create_file(&new_client->dev, &dev_attr_fan4_ppr);
+		device_create_file(&new_client->dev, &dev_attr_temp1_offset);
+		device_create_file(&new_client->dev, &dev_attr_temp2_offset);
+		device_create_file(&new_client->dev, &dev_attr_temp3_offset);
+		device_create_file(&new_client->dev,
+			&dev_attr_alarm_mask_2500mv);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_vccp);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_vcc);
+		device_create_file(&new_client->dev,
+			&dev_attr_alarm_mask_5000mv);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_temp1);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_temp2);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_temp3);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_12000mv);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_therm);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_fan1);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_fan2);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_fan3);
+		device_create_file(&new_client->dev, &dev_attr_alarm_mask_fan4);
+		device_create_file(&new_client->dev,
+			&dev_attr_alarm_mask_remote1_elec);
+		device_create_file(&new_client->dev,
+			&dev_attr_alarm_mask_remote2_elec);
+		break;
+	case lm85c :
+	case lm85b :
+	case any_chip :
+	default :
+		device_create_file(&new_client->dev, 
+			&dev_attr_fan1_auto_spinup_ctl);
+		device_create_file(&new_client->dev, 
+			&dev_attr_fan2_auto_spinup_ctl);
+		device_create_file(&new_client->dev, 
+			&dev_attr_fan3_auto_spinup_ctl);
+	}
 	return 0;
 
 	/* Error out and cleanup code */
     ERROR1:
-	kfree(new_client);
+	kfree(data);
     ERROR0:
 	return err;
 }
@@ -894,7 +2371,7 @@
 int lm85_detach_client(struct i2c_client *client)
 {
 	i2c_detach_client(client);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -915,19 +2392,19 @@
 	case LM85_REG_FAN_MIN(3) :
 	case LM85_REG_ALARM1 :	/* Read both bytes at once */
 	case ADM1027_REG_EXTEND_ADC1 :  /* Read two bytes at once */
-		res = i2c_smbus_read_byte_data(client, reg) & 0xff ;
-		res |= i2c_smbus_read_byte_data(client, reg+1) << 8 ;
-		break ;
+		res = i2c_smbus_read_byte_data(client, reg) & 0xff;
+		res |= i2c_smbus_read_byte_data(client, reg+1) << 8;
+		break;
 	case ADT7463_REG_TMIN_CTL1 :  /* Read WORD MSB, LSB */
-		res = i2c_smbus_read_byte_data(client, reg) << 8 ;
-		res |= i2c_smbus_read_byte_data(client, reg+1) & 0xff ;
-		break ;
+		res = i2c_smbus_read_byte_data(client, reg) << 8;
+		res |= i2c_smbus_read_byte_data(client, reg+1) & 0xff;
+		break;
 	default:	/* Read BYTE data */
 		res = i2c_smbus_read_byte_data(client, reg);
-		break ;
+		break;
 	}
 
-	return res ;
+	return res;
 }
 
 int lm85_write_value(struct i2c_client *client, u8 reg, int value)
@@ -944,19 +2421,21 @@
 	case LM85_REG_FAN_MIN(2) :
 	case LM85_REG_FAN_MIN(3) :
 	/* NOTE: ALARM is read only, so not included here */
-		res = i2c_smbus_write_byte_data(client, reg, value & 0xff) ;
-		res |= i2c_smbus_write_byte_data(client, reg+1, (value>>8) & 0xff) ;
-		break ;
+		res = i2c_smbus_write_byte_data(client, reg, value & 0xff);
+		res |= i2c_smbus_write_byte_data(client, reg+1, 
+			(value>>8) & 0xff);
+		break;
 	case ADT7463_REG_TMIN_CTL1 :  /* Write WORD MSB, LSB */
-		res = i2c_smbus_write_byte_data(client, reg, (value>>8) & 0xff);
-		res |= i2c_smbus_write_byte_data(client, reg+1, value & 0xff) ;
+		res = i2c_smbus_write_byte_data(client, reg,
+			(value>>8) & 0xff);
+		res |= i2c_smbus_write_byte_data(client, reg+1, value & 0xff);
 		break ;
 	default:	/* Write BYTE data */
 		res = i2c_smbus_write_byte_data(client, reg, value);
-		break ;
+		break;
 	}
 
-	return res ;
+	return res;
 }
 
 void lm85_init_client(struct i2c_client *client)
@@ -971,18 +2450,18 @@
 	dev_dbg(&client->dev, "LM85_REG_CONFIG is: 0x%02x\n", value);
 	if( value & 0x02 ) {
 		dev_err(&client->dev, "Client (%d,0x%02x) config is locked.\n",
-			    i2c_adapter_id(client->adapter), client->addr );
+			i2c_adapter_id(client->adapter), client->addr );
 	};
-	if( ! (value & 0x04) ) {
+	if ( ! (value & 0x04) ) {
 		dev_err(&client->dev, "Client (%d,0x%02x) is not ready.\n",
-			    i2c_adapter_id(client->adapter), client->addr );
+			i2c_adapter_id(client->adapter), client->addr );
 	};
-	if( value & 0x10
-	    && ( data->type = adm1027
+	if ( value & 0x10 && ( data->type = adm1027 
 		|| data->type = adt7463 ) ) {
-		dev_err(&client->dev, "Client (%d,0x%02x) VxI mode is set.  "
+			dev_err(&client->dev, 
+			"Client (%d,0x%02x) VxI mode is set.  "
 			"Please report this to the lm85 maintainer.\n",
-			    i2c_adapter_id(client->adapter), client->addr );
+			i2c_adapter_id(client->adapter), client->addr );
 	};
 
 	/* WE INTENTIONALLY make no changes to the limits,
@@ -1018,8 +2497,8 @@
 		 * more significant bits that are read later.
 		 */
 		if ( (data->type = adm1027) || (data->type = adt7463) ) {
-			data->extend_adc -			    lm85_read_value(client, ADM1027_REG_EXTEND_ADC1);
+			data->extend_adc = lm85_read_value(client, 
+				ADM1027_REG_EXTEND_ADC1);
 		}
 
 		for (i = 0; i <= 4; ++i) {
@@ -1043,9 +2522,10 @@
 		}
 
 		if ( data->type = adt7463 ) {
-			if( data->therm_total < ULONG_MAX - 256 ) {
-			    data->therm_total +-				lm85_read_value(client, ADT7463_REG_THERM );
+			if ( data->adt7463_therm_total < ULONG_MAX - 256 ) {
+				data->adt7463_therm_total += 
+					lm85_read_value(client, 
+					ADT7463_REG_THERM);
 			}
 		}
 
@@ -1061,71 +2541,77 @@
 
 		for (i = 0; i <= 4; ++i) {
 			data->in_min[i] -			    lm85_read_value(client, LM85_REG_IN_MIN(i));
+				lm85_read_value(client, LM85_REG_IN_MIN(i));
 			data->in_max[i] -			    lm85_read_value(client, LM85_REG_IN_MAX(i));
+				lm85_read_value(client, LM85_REG_IN_MAX(i));
 		}
 
 		for (i = 0; i <= 3; ++i) {
 			data->fan_min[i] -			    lm85_read_value(client, LM85_REG_FAN_MIN(i));
+				lm85_read_value(client, LM85_REG_FAN_MIN(i));
 		}
 
 		for (i = 0; i <= 2; ++i) {
 			data->temp_min[i] -			    lm85_read_value(client, LM85_REG_TEMP_MIN(i));
+				lm85_read_value(client, LM85_REG_TEMP_MIN(i));
 			data->temp_max[i] -			    lm85_read_value(client, LM85_REG_TEMP_MAX(i));
+				lm85_read_value(client, LM85_REG_TEMP_MAX(i));
 		}
 
 		data->vid = lm85_read_value(client, LM85_REG_VID);
 
 		for (i = 0; i <= 2; ++i) {
 			int val ;
-			data->autofan[i].config -			    lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
+			data->fan_auto_config[i] = lm85_read_value(client,
+				LM85_REG_AFAN_CONFIG(i));
 			val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
-			data->autofan[i].freq = val & 0x07 ;
-			data->zone[i].range = (val >> 4) & 0x0f ;
-			data->autofan[i].min_pwm -			    lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));
-			data->zone[i].limit -			    lm85_read_value(client, LM85_REG_AFAN_LIMIT(i));
-			data->zone[i].critical -			    lm85_read_value(client, LM85_REG_AFAN_CRITICAL(i));
+			data->fan_auto_freq[i] = val & 0x07 ;
+                        data->temp_auto_range[i] = (val >> 4) & 0x0f;
+                        data->temp_auto_min[i] = lm85_read_value(client, 
+				LM85_REG_AFAN_LIMIT(i)); 
+			data->temp_auto_critical[i] = lm85_read_value(client, 
+				LM85_REG_AFAN_CRITICAL(i));
+                        data->fan_auto_min_pwm[i] = lm85_read_value(client, 
+				LM85_REG_AFAN_MINPWM(i));
 		}
 
 		i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
 		data->smooth[0] = i & 0x0f ;
 		data->syncpwm3 = i & 0x10 ;  /* Save PWM3 config */
-		data->autofan[0].min_off = (i & 0x20) != 0 ;
-		data->autofan[1].min_off = (i & 0x40) != 0 ;
-		data->autofan[2].min_off = (i & 0x80) != 0 ;
+		data->fan_auto_min_ctl[0] = (i & 0x20) != 0 ;
+		data->fan_auto_min_ctl[1] = (i & 0x40) != 0 ;
+		data->fan_auto_min_ctl[2] = (i & 0x80) != 0 ;
 		i = lm85_read_value(client, LM85_REG_AFAN_SPIKE2);
 		data->smooth[1] = (i>>4) & 0x0f ;
 		data->smooth[2] = i & 0x0f ;
 
-		i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
-		data->zone[0].hyst = (i>>4) & 0x0f ;
-		data->zone[1].hyst = i & 0x0f ;
-
+		i = lm85_read_value(client, LM85_REG_AFAN_HYST1) ;
+		data->temp_auto_hyst[0] = (i>>4)  & 0x0f ;
+		data->temp_auto_hyst[1] = i & 0x0f ;
 		i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
-		data->zone[2].hyst = (i>>4) & 0x0f ;
-
+		data->temp_auto_hyst[2] = (i>>4)  & 0x0f ;
+		data->config1 = lm85_read_value(client, LM85_REG_CONFIG);
 		if ( (data->type = lm85b) || (data->type = lm85c) ) {
 			data->tach_mode = lm85_read_value(client,
 				LM85_REG_TACH_MODE );
-			data->spinup_ctl = lm85_read_value(client,
+			data->fan_auto_spinup_ctl = lm85_read_value(client,
 				LM85_REG_SPINUP_CTL );
 		} else if ( (data->type = adt7463) || (data->type = adm1027) ) {
+			data->intmask1 = lm85_read_value(client, 
+				ADM1027_REG_INTMASK1);
+			data->intmask2 = lm85_read_value(client, 
+				ADM1027_REG_INTMASK2);
+			data->fan_auto_spinup_ctl = data->config1 & 0x20;
 			if ( data->type = adt7463 ) {
 				for (i = 0; i <= 2; ++i) {
-				    data->oppoint[i] = lm85_read_value(client,
+				    data->temp_auto_oppoint[i] = 
+					lm85_read_value(client,
 					ADT7463_REG_OPPOINT(i) );
 				}
 				data->tmin_ctl = lm85_read_value(client,
 					ADT7463_REG_TMIN_CTL1 );
-				data->therm_limit = lm85_read_value(client,
+				data->adt7463_therm_limit = 
+					lm85_read_value(client,
 					ADT7463_REG_THERM_LIMIT );
 			}
 			for (i = 0; i <= 2; ++i) {
@@ -1134,7 +2620,7 @@
 			}
 			data->tach_mode = lm85_read_value(client,
 				ADM1027_REG_CONFIG3 );
-			data->fan_ppr = lm85_read_value(client,
+			data->adm1027_fan_ppr = lm85_read_value(client,
 				ADM1027_REG_FAN_PPR );
 		}
 	
@@ -1164,7 +2650,7 @@
  *     post 2.7.0 CVS changes.
  */
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>");
+MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>, Justin Thiessen <jthiessen@penguincomputing.com>");
 MODULE_DESCRIPTION("LM85-B, LM85-C driver");
 
 module_init(sm_lm85_init);

