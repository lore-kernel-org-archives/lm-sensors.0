From: jmunsin@iki.fi (Jonas Munsin)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: it87 pwm patch for 2.6.6
Message-Id: <20040516205100.GA9996@nemo.sby.abo.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Attached is two incremental patches against drivers/i2c/it87.c, adding
more support to the it87 fan controller driver in 2.6.6-bk2. Attached is
also a small ruby script I use on my computer, just as an example.

it87_cleanups_jm1.patch:
a rename to reflect the datasheet name better, removal of a old comment
that doesn't apply anymore to the 2.6.x line

it87_manual_and_auto_pwm_jm1.patch:
manual and auto pwm support in one largish patch (I started to split
this one into two separate patches, but it was too much work and I got
lazy..).

The work is based on Takeru KOMORIYA' patch:
http://archives.andrew.net.au/lm-sensors/msg07002.html

The auto fan speed API is written to match these messages:
http://archives.andrew.net.au/lm-sensors/msg07517.html
http://archives.andrew.net.au/lm-sensors/msg07519.html

The following two pecularities of the it87 chip didn't exactly match
that API suggestion:

1. If the temperature of any programmed channel goes above
fanX_auto_temp_max, all fans in sg-automatic mode turn on at maximum
speed until the temperture comes down.

2. The fanX_auto_temp_channel variables are bitfields, but they can only
have one bit on (i.e., the possible values are 1, 2 and 4).

Some other observations:

1. I wrote this reading the it8705f datasheet. I got the impression the
other it87* chips work in the same way, but I haven't actually checked
this.

2. The fan controllers can be in three different states, changes in
settings effecting other states than the current one are rejected. An
alternative would be to save them and write them to the it87 after a
state change.

3. There are a lot of tunable settings files... The sysfs directory
becomes quite cluttered. And the it87.c contains a lot of adminstrative
overhead to set up all those files.

4. The fanX_auto_temp_* variables need to be mangled just like
fanX_input (i.e., if you have a compute line in your sensors.conf, you
need to do the same computation to values written to these files).


-------------- next part --------------
--- it87.c.orig	2004-05-16 22:13:32.000000000 +0300
+++ it87.c	2004-05-16 22:36:44.000000000 +0300
@@ -128,7 +128,7 @@
 
 #define IT87_REG_FAN(nr)       (0x0d + (nr))
 #define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
-#define IT87_REG_FAN_CTRL      0x13
+#define IT87_REG_FAN_MAIN_CTRL 0x13
 
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
 #define IT87_REG_TEMP(nr)      (0x29 + (nr))
@@ -159,9 +159,9 @@
 
 #define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=255?0:1350000/((val)*(div)))
 
-#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
-					((val)+5)/10),0,255))
-#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10)
+#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/(10*100)):\
+					((val)+5)/(10*100)),0,255))
+#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10*100)
 
 #define VID_FROM_REG(val) ((val)=0x1f?0:(val)>=0x10?510-(val)*10:\
 				205-(val)*5)
@@ -325,24 +325,24 @@
 static ssize_t show_temp(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr])*100 );
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
 }
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr])*100);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr]));
 }
 static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr])*100);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr]));
 }
 static ssize_t set_temp_max(struct device *dev, const char *buf, 
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/100;
+	int val = simple_strtol(buf, NULL, 10);
 	data->temp_high[nr] = TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
 	return count;
@@ -352,7 +352,7 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/100;
+	int val = simple_strtol(buf, NULL, 10);
 	data->temp_low[nr] = TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
 	return count;
@@ -773,9 +773,7 @@
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the IT87 access and should not be necessary. 
-   There are some ugly typecasts here, but the good new is - they should
-   nowhere else be necessary! */
+   would slow down the IT87 access and should not be necessary. */
 static int it87_read_value(struct i2c_client *client, u8 reg)
 {
 	struct it87_data *data = i2c_get_clientdata(client);
@@ -795,9 +793,7 @@
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the IT87 access and should not be necessary. 
-   There are some ugly typecasts here, but the good new is - they should
-   nowhere else be necessary! */
+   would slow down the IT87 access and should not be necessary. */
 static int it87_write_value(struct i2c_client *client, u8 reg, u8 value)
 {
 	struct it87_data *data = i2c_get_clientdata(client);
@@ -840,11 +836,11 @@
 	}
 
 	/* Check if tachometers are reset manually or by some reason */
-	tmp = it87_read_value(client, IT87_REG_FAN_CTRL);
+	tmp = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
 	if ((tmp & 0x70) = 0) {
 		/* Enable all fan tachometers */
 		tmp = (tmp & 0x8f) | 0x70;
-		it87_write_value(client, IT87_REG_FAN_CTRL, tmp);
+		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, tmp);
 	}
 
 	/* Start monitoring */
-------------- next part --------------
--- it87.c.orig	2004-05-16 23:10:31.000000000 +0300
+++ it87.c	2004-05-16 23:14:44.000000000 +0300
@@ -129,6 +129,8 @@
 #define IT87_REG_FAN(nr)       (0x0d + (nr))
 #define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
 #define IT87_REG_FAN_MAIN_CTRL 0x13
+#define IT87_REG_FAN_CTL       0x14
+#define IT87_REG_PWM(nr)       (0x15 + (nr))
 
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
 #define IT87_REG_TEMP(nr)      (0x29 + (nr))
@@ -145,6 +147,17 @@
 
 #define IT87_REG_CHIPID        0x58
 
+#define IT87_REG_OFF_TEMP(nr)  ((nr=2)?0x70:((nr=1)?0x68:0x60))
+#define IT87_REG_LOW_TEMP(nr)  ((nr=2)?0x71:((nr=1)?0x69:0x61))
+#define IT87_REG_MED_TEMP(nr)  ((nr=2)?0x72:((nr=1)?0x6a:0x62))
+#define IT87_REG_HI_TEMP(nr)   ((nr=2)?0x73:((nr=1)?0x6b:0x63))
+#define IT87_REG_FULL_TEMP(nr) ((nr=2)?0x74:((nr=1)?0x6c:0x64))
+
+#define IT87_REG_LOW_PWM(nr)   ((nr=2)?0x75:((nr=1)?0x6d:0x65))
+#define IT87_REG_MED_PWM(nr)   ((nr=2)?0x76:((nr=1)?0x6e:0x66))
+#define IT87_REG_HI_PWM(nr)    ((nr=2)?0x77:((nr=1)?0x6f:0x67))
+								 
+
 #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
 #define IN_FROM_REG(val) (((val) *  16) / 10)
 
@@ -159,6 +172,10 @@
 
 #define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=255?0:1350000/((val)*(div)))
 
+#define PWM_TO_REG(val) ((val) >> 1)
+
+#define PWM_FROM_REG(val) (((val)&0x7f) << 1)
+
 #define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/(10*100)):\
 					((val)+5)/(10*100)),0,255))
 #define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10*100)
@@ -195,6 +212,11 @@
 	u8 in_min[9];		/* Register value */
 	u8 fan[3];		/* Register value */
 	u8 fan_min[3];		/* Register value */
+	u8 pwm_mode[3];		/* PWM bit 7 (0 = software, 1 = automatic) */
+	u8 pwm_tmpin[3];	/* PWM bits 1-0 when bit 7 = 1*/
+	u8 pwm_value[3];	/* PWM bits 6-0 when bit 7 = 0 */
+	u8 fan_main_ctrl;	/* Register value */
+	u8 fan_ctl;		/* Register value */
 	u8 temp[3];		/* Register value */
 	u8 temp_high[3];	/* Register value */
 	u8 temp_low[3];		/* Register value */
@@ -204,6 +226,24 @@
 	u32 alarms;		/* Register encoding, combined */
 };
 
+/* Modes that the it87's fan controllers can be in. */
+enum it87_pwm_modes {
+	PWM_OFF,	/* pwm settings disabled, only on/off available */
+	PWM_SOFTWARE,	/* manual pwm enabled for userspace software to adjust */
+	PWM_AUTOMATIC	/* automatic pwm, it87 adjusts speed according to settings */
+};
+
+static inline enum it87_pwm_modes it87_pwm_mode(struct it87_data *data, int nr) {
+	if (data->fan_main_ctrl & (1 << nr)) {
+		if (data->pwm_mode[nr] = 0)
+			return PWM_SOFTWARE;
+		else
+			return PWM_AUTOMATIC;
+	} else {
+		return PWM_OFF;
+	}
+}
+
 
 static int it87_attach_adapter(struct i2c_adapter *adapter);
 static int it87_find(int *address);
@@ -455,6 +495,83 @@
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
 }
+static ssize_t show_fan_pwm(struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf,"%d\n", PWM_FROM_REG(data->pwm_value[nr]));
+}
+static ssize_t show_fan_pwm_enable (struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf, "%d\n", (data->fan_main_ctrl & (1 << nr)) != 0);
+}
+static ssize_t show_fan_enable (struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf, "%d\n", (data->fan_ctl & (1 << nr)) != 0);
+}
+static ssize_t show_fan_auto_enable (struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf, "%d\n", data->pwm_mode[nr]);
+}
+static ssize_t show_fan_auto_temp_channel (struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf, "%d\n", data->pwm_tmpin[nr] ? (data->pwm_tmpin[nr] << 1) : 1 );
+}
+static ssize_t show_fan_auto_temp_off (struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 temp = it87_read_value(client, IT87_REG_OFF_TEMP(nr));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(temp));
+}
+static ssize_t show_fan_auto_temp_min (struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 temp = it87_read_value(client, IT87_REG_LOW_TEMP(nr));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(temp));
+}
+static ssize_t show_fan_auto_temp_low (struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 temp = it87_read_value(client, IT87_REG_MED_TEMP(nr));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(temp));
+}
+static ssize_t show_fan_auto_temp_medium (struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 temp = it87_read_value(client, IT87_REG_HI_TEMP(nr));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(temp));
+}
+static ssize_t show_fan_auto_temp_max (struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 temp = it87_read_value(client, IT87_REG_FULL_TEMP(nr));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(temp));
+}
+static ssize_t show_fan_auto_pwm_min (struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 temp = it87_read_value(client, IT87_REG_LOW_PWM(nr));
+	return sprintf(buf, "%d\n", temp);
+}
+static ssize_t show_fan_auto_pwm_low (struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 temp = it87_read_value(client, IT87_REG_MED_PWM(nr));
+	return sprintf(buf, "%d\n", temp);
+}
+static ssize_t show_fan_auto_pwm_medium (struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 temp = it87_read_value(client, IT87_REG_HI_PWM(nr));
+	return sprintf(buf, "%d\n", temp);
+}
+static ssize_t show_fan_auto_pwm_max (struct device *dev, char *buf, int nr)
+{
+	return sprintf(buf, "%d\n", 255);
+}
 static ssize_t set_fan_min(struct device *dev, const char *buf, 
 		size_t count, int nr)
 {
@@ -501,6 +618,175 @@
 	}
 	return count;
 }
+static ssize_t set_fan_pwm(struct device *dev, const char *buf,
+		 size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (it87_pwm_mode(data, nr) != PWM_SOFTWARE)
+		return -1;
+	if (val < 0 || val > 255)
+		return -1;
+	data->pwm_value[nr] = PWM_TO_REG(val);
+	it87_write_value(client, IT87_REG_PWM(nr), data->pwm_value[nr]);
+	return count;
+}
+static ssize_t set_fan_pwm_enable (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val = 1)
+		data->fan_main_ctrl |= 1 << nr;
+	else if (val = 0)
+		data->fan_main_ctrl &= ~(1 << nr);
+	else
+		return -1;
+	data->fan_main_ctrl |= 0x70;
+	it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+	return count;
+}
+static ssize_t set_fan_enable (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (it87_pwm_mode(data, nr) != PWM_OFF)
+		return -1;
+	if (val = 1)
+		data->fan_ctl |= 1 << nr;
+	else if (val = 0)
+		data->fan_ctl &= ~(1 << nr);
+	else
+		return -1;
+	it87_write_value(client, IT87_REG_FAN_CTL, (1 << 7) | data->fan_ctl);
+	return count;
+}
+static ssize_t set_fan_auto_enable (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	u8 lowbits;
+
+	if (it87_pwm_mode(data, nr) = PWM_OFF)
+		return -1;
+
+	if (val = 1) {
+		data->pwm_mode[nr] = 1;
+		lowbits = data->pwm_tmpin[nr];
+	} else if (val = 0) {
+		data->pwm_mode[nr] = 0;
+		lowbits = data->pwm_value[nr];
+	} else
+		return -1;
+	it87_write_value(client, IT87_REG_PWM(nr),
+			data->pwm_mode[nr] << 7 | lowbits);
+	return count;
+}
+static ssize_t set_fan_auto_temp_channel (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (it87_pwm_mode(data, nr) != PWM_AUTOMATIC)
+		return -1;
+	if (!(val = 1 || val = 2 || val = 4))
+		return -1;
+	data->pwm_tmpin[nr] = val >> 1;
+	it87_write_value(client, IT87_REG_PWM(nr), 1 << 7 | data->pwm_tmpin[nr]);
+	return count;
+}
+static ssize_t set_fan_auto_temp_off (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val = simple_strtol(buf, NULL, 10);
+
+	it87_write_value(client, IT87_REG_OFF_TEMP(nr), TEMP_TO_REG(val));
+	return count;
+}
+static ssize_t set_fan_auto_temp_min (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val = simple_strtol(buf, NULL, 10);
+
+	it87_write_value(client, IT87_REG_LOW_TEMP(nr), TEMP_TO_REG(val));
+	return count;
+}
+static ssize_t set_fan_auto_temp_low (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val = simple_strtol(buf, NULL, 10);
+
+	it87_write_value(client, IT87_REG_MED_TEMP(nr), TEMP_TO_REG(val));
+	return count;
+}
+static ssize_t set_fan_auto_temp_medium (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val = simple_strtol(buf, NULL, 10);
+
+	it87_write_value(client, IT87_REG_HI_TEMP(nr), TEMP_TO_REG(val));
+	return count;
+}
+static ssize_t set_fan_auto_temp_max (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val = simple_strtol(buf, NULL, 10);
+
+	it87_write_value(client, IT87_REG_FULL_TEMP(nr), TEMP_TO_REG(val));
+	return count;
+}
+static ssize_t set_fan_auto_pwm_min (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val = simple_strtol(buf, NULL, 10);
+
+	it87_write_value(client, IT87_REG_LOW_PWM(nr), val);
+	return count;
+}
+static ssize_t set_fan_auto_pwm_low (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val = simple_strtol(buf, NULL, 10);
+
+	it87_write_value(client, IT87_REG_MED_PWM(nr), val);
+	return count;
+}
+static ssize_t set_fan_auto_pwm_medium (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val = simple_strtol(buf, NULL, 10);
+
+	it87_write_value(client, IT87_REG_HI_PWM(nr), val);
+	return count;
+}
+static ssize_t set_fan_auto_pwm_max (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val != 255)
+		return -1;
+	return count;
+}
 
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
@@ -515,6 +801,75 @@
 {									\
 	return show_fan_div(dev, buf, 0x##offset - 1);			\
 }									\
+static ssize_t show_fan_##offset##_pwm (struct device *dev, char *buf)	\
+{									\
+	return show_fan_pwm(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t show_fan_##offset##_pwm_enable (struct device *dev,	\
+		char *buf) 						\
+{									\
+	return show_fan_pwm_enable(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan_##offset##_enable (struct device *dev,		\
+		char *buf) 						\
+{									\
+	return show_fan_enable(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan_##offset##_auto_enable (struct device *dev,	\
+		char *buf) 						\
+{									\
+	return show_fan_auto_enable(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan_##offset##_auto_temp_channel (			\
+		struct device *dev, char *buf) 				\
+{									\
+	return show_fan_auto_temp_channel(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t show_fan_##offset##_auto_temp_off (			\
+		struct device *dev, char *buf) 				\
+{									\
+	return show_fan_auto_temp_off(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t show_fan_##offset##_auto_temp_min (			\
+		struct device *dev, char *buf) 				\
+{									\
+	return show_fan_auto_temp_min(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t show_fan_##offset##_auto_temp_low (			\
+		struct device *dev, char *buf) 				\
+{									\
+	return show_fan_auto_temp_low(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t show_fan_##offset##_auto_temp_medium (			\
+		struct device *dev, char *buf) 				\
+{									\
+	return show_fan_auto_temp_medium(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t show_fan_##offset##_auto_temp_max (			\
+		struct device *dev, char *buf) 				\
+{									\
+	return show_fan_auto_temp_max(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t show_fan_##offset##_auto_pwm_min (			\
+		struct device *dev, char *buf) 				\
+{									\
+	return show_fan_auto_pwm_min(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan_##offset##_auto_pwm_low (			\
+		struct device *dev, char *buf) 				\
+{									\
+	return show_fan_auto_pwm_low(dev, buf, 0x##offset - 1);		\
+}									\
+static ssize_t show_fan_##offset##_auto_pwm_medium (			\
+		struct device *dev, char *buf) 				\
+{									\
+	return show_fan_auto_pwm_medium(dev, buf, 0x##offset - 1);	\
+}									\
+static ssize_t show_fan_##offset##_auto_pwm_max (			\
+		struct device *dev, char *buf) 				\
+{									\
+	return show_fan_auto_pwm_max(dev, buf, 0x##offset - 1);		\
+}									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
@@ -525,11 +880,122 @@
 {									\
 	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
 }									\
+static ssize_t set_fan_##offset##_pwm (struct device *dev,		\
+		const char *buf, size_t count)				\
+{									\
+	return set_fan_pwm(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_fan_##offset##_pwm_enable (struct device *dev,	\
+		const char *buf, size_t count)				\
+{									\
+	return set_fan_pwm_enable(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan_##offset##_enable (struct device *dev,		\
+		const char *buf, size_t count)				\
+{									\
+	return set_fan_enable(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_fan_##offset##_auto_enable (struct device *dev,	\
+		const char *buf, size_t count)				\
+{									\
+	return set_fan_auto_enable(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan_##offset##_auto_temp_channel (			\
+		struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_fan_auto_temp_channel(dev, buf, count,		\
+			0x##offset - 1);				\
+}									\
+static ssize_t set_fan_##offset##_auto_temp_off (			\
+		struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_fan_auto_temp_off(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan_##offset##_auto_temp_min (			\
+		struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_fan_auto_temp_min(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan_##offset##_auto_temp_low (			\
+		struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_fan_auto_temp_low(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan_##offset##_auto_temp_medium (			\
+		struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_fan_auto_temp_medium(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan_##offset##_auto_temp_max (			\
+		struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_fan_auto_temp_max(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan_##offset##_auto_pwm_min (			\
+		struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_fan_auto_pwm_min(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan_##offset##_auto_pwm_low (			\
+		struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_fan_auto_pwm_low(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan_##offset##_auto_pwm_medium (			\
+		struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_fan_auto_pwm_medium(dev, buf, count, 0x##offset - 1);	\
+}									\
+static ssize_t set_fan_##offset##_auto_pwm_max (			\
+		struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_fan_auto_pwm_max(dev, buf, count, 0x##offset - 1);	\
+}									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_fan_##offset##_min, set_fan_##offset##_min) 	\
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_div, set_fan_##offset##_div)
+		show_fan_##offset##_div, set_fan_##offset##_div)	\
+static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR,		\
+		show_fan_##offset##_pwm, set_fan_##offset##_pwm)	\
+static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_pwm_enable,				\
+		set_fan_##offset##_pwm_enable)				\
+static DEVICE_ATTR(fan##offset##_enable, S_IRUGO | S_IWUSR,		\
+		show_fan_##offset##_enable, set_fan_##offset##_enable)	\
+static DEVICE_ATTR(fan##offset##_auto_enable, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_auto_enable,			\
+		set_fan_##offset##_auto_enable) 			\
+static DEVICE_ATTR(fan##offset##_auto_temp_channel, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_auto_temp_channel,			\
+		set_fan_##offset##_auto_temp_channel)			\
+static DEVICE_ATTR(fan##offset##_auto_temp_off, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_auto_temp_off,			\
+		set_fan_##offset##_auto_temp_off)			\
+static DEVICE_ATTR(fan##offset##_auto_temp_min, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_auto_temp_min,			\
+		set_fan_##offset##_auto_temp_min)			\
+static DEVICE_ATTR(fan##offset##_auto_temp_low, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_auto_temp_low,			\
+		set_fan_##offset##_auto_temp_low)			\
+static DEVICE_ATTR(fan##offset##_auto_temp_medium, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_auto_temp_medium,			\
+		set_fan_##offset##_auto_temp_medium)			\
+static DEVICE_ATTR(fan##offset##_auto_temp_max, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_auto_temp_max,			\
+		set_fan_##offset##_auto_temp_max)			\
+static DEVICE_ATTR(fan##offset##_auto_pwm_min, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_auto_pwm_min,			\
+		set_fan_##offset##_auto_pwm_min)			\
+static DEVICE_ATTR(fan##offset##_auto_pwm_low, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_auto_pwm_low,			\
+		set_fan_##offset##_auto_pwm_low)			\
+static DEVICE_ATTR(fan##offset##_auto_pwm_medium, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_auto_pwm_medium,			\
+		set_fan_##offset##_auto_pwm_medium)			\
+static DEVICE_ATTR(fan##offset##_auto_pwm_max, S_IRUGO | S_IWUSR,	\
+		show_fan_##offset##_auto_pwm_max,			\
+		set_fan_##offset##_auto_pwm_max)
 
 show_fan_offset(1);
 show_fan_offset(2);
@@ -739,6 +1205,48 @@
 	device_create_file(&new_client->dev, &dev_attr_fan1_div);
 	device_create_file(&new_client->dev, &dev_attr_fan2_div);
 	device_create_file(&new_client->dev, &dev_attr_fan3_div);
+	device_create_file(&new_client->dev, &dev_attr_fan1_pwm);
+	device_create_file(&new_client->dev, &dev_attr_fan2_pwm);
+	device_create_file(&new_client->dev, &dev_attr_fan3_pwm);
+	device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan2_pwm_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan3_pwm_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan1_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan2_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan3_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_enable);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_temp_channel);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_temp_channel);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_temp_channel);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_temp_off);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_temp_off);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_temp_off);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_temp_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_temp_min);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_temp_min);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_temp_low);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_temp_low);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_temp_low);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_temp_medium);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_temp_medium);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_temp_medium);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_pwm_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_pwm_min);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_pwm_min);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_pwm_low);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_pwm_low);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_pwm_low);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_pwm_medium);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_pwm_medium);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_pwm_medium);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto_pwm_max);
+	device_create_file(&new_client->dev, &dev_attr_fan2_auto_pwm_max);
+	device_create_file(&new_client->dev, &dev_attr_fan3_auto_pwm_max);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
@@ -843,6 +1351,14 @@
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, tmp);
 	}
 
+	/* Check poloarity of FAN_CTL3-1 registers (which are low active after a reset) */
+	tmp = it87_read_value(client, IT87_REG_FAN_CTL);
+	if ((tmp & (1 << 7)) = 0) {
+		/* Set polarity of FAN_CTL3-1 to active high */
+		tmp |= (1 << 7) | 0x7;
+		it87_write_value(client, IT87_REG_FAN_CTL, tmp);
+	}
+
 	/* Start monitoring */
 	it87_write_value(client, IT87_REG_CONFIG,
 			 (it87_read_value(client, IT87_REG_CONFIG) & 0x36)
@@ -904,6 +1420,18 @@
 		data->fan_div[1] = (i >> 3) & 0x07;
 		data->fan_div[2] = (i & 0x40) ? 3 : 1;
 
+		for (i = 0; i < 3; i++) {
+			u8 pwm;
+			pwm = it87_read_value(client, IT87_REG_PWM(i));
+			data->pwm_mode[i] = (pwm >> 7);
+			if (it87_pwm_mode(data, i) = PWM_AUTOMATIC)
+				data->pwm_tmpin[i] = pwm & 0x03;
+			else if (it87_pwm_mode(data, i) = PWM_SOFTWARE)
+				data->pwm_value[i] = pwm & 0x7f;
+		}
+		data->fan_main_ctrl = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
+		data->fan_ctl = it87_read_value(client, IT87_REG_FAN_CTL);
+
 		data->alarms  			it87_read_value(client, IT87_REG_ALARM1) |
 			(it87_read_value(client, IT87_REG_ALARM2) << 8) |
-------------- next part --------------
#!/usr/bin/ruby

def set_value(file, val)
	Kernel.system("echo #{val} > #{file}")
end

def convert_cpu_temp(temp)
	((3*temp-128)*1000).to_i
end
def convert_mb_temp(temp)
	((temp)*1000).to_i
end

devdir="/sys/bus/i2c/devices/0-0290"

begin
	f = File.new(devdir, "r")
	f.close
rescue Errno::ENOENT
	print "no driver module loaded?\n"
	exit
end

Dir.chdir(devdir)


set_value("fan1_pwm_enable", 1)
set_value("fan1_auto_enable", 1)
set_value("fan1_auto_temp_channel", 1)

set_value("fan1_auto_temp_off", convert_cpu_temp(53))
set_value("fan1_auto_temp_min", convert_cpu_temp(55))
set_value("fan1_auto_pwm_min", 205)
set_value("fan1_auto_temp_low", convert_cpu_temp(58))
set_value("fan1_auto_pwm_low", 220)
set_value("fan1_auto_temp_medium", convert_cpu_temp(60))
set_value("fan1_auto_pwm_medium", 245)
set_value("fan1_auto_temp_max", convert_cpu_temp(62))



set_value("fan2_pwm_enable", 1)
set_value("fan2_auto_enable", 1)
set_value("fan2_auto_temp_channel", 2)

offtemp = 37 # reach => off
ontemp = 42 # cross => on
panictemp = 45
set_value("fan2_auto_temp_off", convert_mb_temp(offtemp))
set_value("fan2_auto_temp_min", convert_mb_temp(ontemp))
set_value("fan2_auto_pwm_min", 255)
set_value("fan2_auto_temp_low", convert_mb_temp(ontemp))
set_value("fan2_auto_pwm_low", 255)
set_value("fan2_auto_temp_medium", convert_mb_temp(ontemp))
set_value("fan2_auto_pwm_medium", 255)
set_value("fan2_auto_temp_max", convert_mb_temp(panictemp))

