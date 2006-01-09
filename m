From: aurelien@aurel32.net (Aurelien Jarno)
Date: Mon, 09 Jan 2006 10:20:20 +0000
Subject: [lm-sensors] w83627ehf fan controll?
Message-Id: <20060109102020.GA6279@farad.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051230143805.GA21201@Apollo>
In-Reply-To: <20051230143805.GA21201@Apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 31, 2005 at 08:12:16PM +0100, Jean Delvare wrote:
> Hi Yuan & all,
Hi!

> > I have add some entries to test the chip (in my local CVS), But I have
> > not finished the test. Did anyone do the same work on this driver?
> 
> A number of persons are supposedly working on improving this driver.
> Cadu said he would improve the driver back in July but we didn't hear
> back since. I think Rudolf has a W83627EHF chip and may be willing to
> help too. And I also seem to remember that Aurelien has such a chip and
> wanted to help with the driver some times ago.
> 
> It's rare to have that many persons working on the same driver, so it's
> quite sad that nothing has been merged into the driver yet :(
>
> If you have a patch to contribute, please do! :)
>

Yes I have started to work on it, but I have then stopped due to lack of
time. Please find attached a patch between the current version in the
kernel and my local version. It adds support for voltage inputs and it
factorizes some code.

> > Actually I'm quiet confusing about the naming rule of device file, it
> > did not cover all the PWM/SmartFan functions.
> 
> Same old story. We tried to standardize the PWM interface, but in the
> end nobody seems to be happy with that standard. I'm a bit tired of all
> this, so just implement any interface you like as long as it makes
> sense. All I am asking for is that fan stopped is PWM=0 and fan at full
> speed is PWM%5.
> 
I have also started to work on pwm, until I understood the Asus guys
have wired the fans directly to +12V. That's why I finally used a
hardware solution instead of a software one :(

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32 at debian.org         | aurelien at aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
--- /usr/src/linux-2.6.14/drivers/hwmon/w83627ehf.c	2005-10-28 02:02:08.000000000 +0200
+++ w83627ehf.c	2006-01-09 11:14:20.000000000 +0100
@@ -30,7 +30,7 @@
     Supports the following chips:
 
     Chip        #vin    #fan    #pwm    #temp   chip_id man_id
-    w83627ehf   -       5       -       3       0x88    0x5ca3
+    w83627ehf   10      5       -       3       0x88    0x5ca3
 
     This is a preliminary version of the driver, only supporting the
     fan and temperature inputs. The chip does much more than that.
@@ -114,6 +114,10 @@
 #define W83627EHF_REG_CHIP_ID		0x49
 #define W83627EHF_REG_MAN_ID		0x4F
 
+static const u16 W83627EHF_REG_IN[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x550, 0x551, 0x552 };
+static const u16 W83627EHF_REG_IN_MIN[] = { 0x2B, 0x2D, 0x2F, 0x31, 0x33, 0x35, 0x37, 0x554, 0x556, 0x558 };
+static const u16 W83627EHF_REG_IN_MAX[] = { 0x2C, 0x2E, 0x30, 0x32, 0x34, 0x36, 0x38, 0x555, 0x557, 0x559 };
+
 static const u16 W83627EHF_REG_FAN[] = { 0x28, 0x29, 0x2a, 0x3f, 0x553 };
 static const u16 W83627EHF_REG_FAN_MIN[] = { 0x3b, 0x3c, 0x3d, 0x3e, 0x55c };
 
@@ -137,6 +141,22 @@
  */
 
 static inline unsigned int
+in_from_reg(u8 reg)
+{
+	return reg * 8;
+}
+
+static inline u8
+reg_from_in(int val)
+{
+	if (val < 0)
+		return 0;
+	if (val > 2040)
+		return 255;
+	return (val + 4) / 8;
+}
+
+static inline unsigned int
 fan_from_reg(u8 reg, unsigned int div)
 {
 	if (reg = 0 || reg = 255)
@@ -182,6 +202,9 @@
 	unsigned long last_updated;	/* In jiffies */
 
 	/* Register values */
+	u8 in[10];		/* Register value */
+	u8 in_max[10];		/* Register value */
+	u8 in_min[10];		/* Register value */
 	u8 fan[5];
 	u8 fan_min[5];
 	u8 fan_div[5];
@@ -324,6 +347,16 @@
 
 	if (time_after(jiffies, data->last_updated + HZ)
 	 || !data->valid) {
+		/* Measured voltages and limits */
+		for (i = 0; i < 10; i++) {
+			data->in[i] = w83627ehf_read_value(client,
+				      W83627EHF_REG_IN[i]);
+			data->in_min[i] = w83627ehf_read_value(client,
+				          W83627EHF_REG_IN_MIN[i]);
+			data->in_max[i] = w83627ehf_read_value(client,
+				          W83627EHF_REG_IN_MAX[i]);
+		}
+
 		/* Fan clock dividers */
 		i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
 		data->fan_div[0] = (i >> 4) & 0x03;
@@ -402,6 +435,81 @@
 /*
  * Sysfs callback functions
  */
+#define show_in_reg(reg) \
+static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
+{ \
+	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
+	return sprintf(buf,"%d\n", in_from_reg(data->reg[nr])); \
+}
+show_in_reg(in)
+show_in_reg(in_min)
+show_in_reg(in_max)
+
+#define store_in_reg(REG, reg) \
+static ssize_t \
+store_in_##reg (struct device *dev, const char *buf, size_t count, int nr) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct w83627ehf_data *data = i2c_get_clientdata(client); \
+	u32 val; \
+	 \
+	val = simple_strtoul(buf, NULL, 10); \
+	 \
+	down(&data->update_lock); \
+	data->in_##reg[nr] = reg_from_in(val); \
+	w83627ehf_write_value(client, W83627EHF_REG_IN_##REG[nr], \
+			    data->in_##reg[nr]); \
+	 \
+	up(&data->update_lock); \
+	return count; \
+}
+store_in_reg(MIN, min)
+store_in_reg(MAX, max)
+	
+#define sysfs_in_offset(offset) \
+static ssize_t \
+show_regs_in_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	return show_in(dev, buf, offset); \
+} \
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
+
+#define sysfs_in_reg_offset(reg, offset) \
+static ssize_t show_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	return show_in_##reg (dev, buf, offset); \
+} \
+static ssize_t \
+store_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, \
+			    const char *buf, size_t count) \
+{ \
+	return store_in_##reg (dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(in##offset##_##reg, S_IRUGO | S_IWUSR, \
+		  show_regs_in_##reg##offset, store_regs_in_##reg##offset);
+
+#define sysfs_in_offsets(offset) \
+sysfs_in_offset(offset) \
+sysfs_in_reg_offset(min, offset) \
+sysfs_in_reg_offset(max, offset)
+	
+sysfs_in_offsets(0);
+sysfs_in_offsets(1);
+sysfs_in_offsets(2);
+sysfs_in_offsets(3);
+sysfs_in_offsets(4);
+sysfs_in_offsets(5);
+sysfs_in_offsets(6);
+sysfs_in_offsets(7);
+sysfs_in_offsets(8);
+sysfs_in_offsets(9);
+
+#define device_create_file_in(client, offset) \
+do { \
+	device_create_file(&client->dev, &dev_attr_in##offset##_input); \
+	device_create_file(&client->dev, &dev_attr_in##offset##_max); \
+	device_create_file(&client->dev, &dev_attr_in##offset##_min); \
+} while (0)
 
 #define show_fan_reg(reg) \
 static ssize_t \
@@ -522,21 +630,23 @@
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO, \
 		   show_reg_fan##offset##_div, NULL);
 
-sysfs_fan_offset(1);
-sysfs_fan_min_offset(1);
-sysfs_fan_div_offset(1);
-sysfs_fan_offset(2);
-sysfs_fan_min_offset(2);
-sysfs_fan_div_offset(2);
-sysfs_fan_offset(3);
-sysfs_fan_min_offset(3);
-sysfs_fan_div_offset(3);
-sysfs_fan_offset(4);
-sysfs_fan_min_offset(4);
-sysfs_fan_div_offset(4);
-sysfs_fan_offset(5);
-sysfs_fan_min_offset(5);
-sysfs_fan_div_offset(5);
+#define sysfs_fan_offsets(offset) \
+sysfs_fan_offset(offset) \
+sysfs_fan_min_offset(offset) \
+sysfs_fan_div_offset(offset)
+
+sysfs_fan_offsets(1);
+sysfs_fan_offsets(2);
+sysfs_fan_offsets(3);
+sysfs_fan_offsets(4);
+sysfs_fan_offsets(5);
+
+#define device_create_file_fan(client, offset) \
+do { \
+	device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
+	device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
+	device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
+} while (0)
 
 #define show_temp1_reg(reg) \
 static ssize_t \
@@ -639,6 +749,13 @@
 sysfs_temp_reg_offset(max, 3);
 sysfs_temp_reg_offset(max_hyst, 3);
 
+#define device_create_file_temp(client, offset) \
+do { \
+	device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
+	device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
+	device_create_file(&client->dev, &dev_attr_temp##offset##_max_hyst); \
+} while (0)
+
 /*
  * Driver and client management
  */
@@ -665,6 +782,13 @@
 					      W83627EHF_REG_TEMP_CONFIG[i],
 					      tmp & 0xfe);
 	}
+	w83627ehf_write_value(client, 0x00, 0x04);
+	w83627ehf_write_value(client, 0x02, 0x04);
+	w83627ehf_write_value(client, 0x04, 0x00);
+	w83627ehf_write_value(client, 0x10, 0x04);
+	w83627ehf_write_value(client, 0x12, 0x00);
+	w83627ehf_write_value(client, 0x60, 0x04);
+	w83627ehf_write_value(client, 0x62, 0x00);
 }
 
 static int w83627ehf_detect(struct i2c_adapter *adapter)
@@ -724,36 +848,31 @@
 		goto exit_detach;
 	}
 
-	device_create_file(&client->dev, &dev_attr_fan1_input);
-	device_create_file(&client->dev, &dev_attr_fan1_min);
-	device_create_file(&client->dev, &dev_attr_fan1_div);
-	device_create_file(&client->dev, &dev_attr_fan2_input);
-	device_create_file(&client->dev, &dev_attr_fan2_min);
-	device_create_file(&client->dev, &dev_attr_fan2_div);
-	device_create_file(&client->dev, &dev_attr_fan3_input);
-	device_create_file(&client->dev, &dev_attr_fan3_min);
-	device_create_file(&client->dev, &dev_attr_fan3_div);
+	device_create_file_in(client, 0);
+	device_create_file_in(client, 1);
+	device_create_file_in(client, 2);
+	device_create_file_in(client, 3);
+	device_create_file_in(client, 4);
+	device_create_file_in(client, 5);
+	device_create_file_in(client, 6);
+	device_create_file_in(client, 7);
+	device_create_file_in(client, 8);
+	device_create_file_in(client, 9);
+
+	device_create_file_fan(client, 1);
+	device_create_file_fan(client, 2);
+	device_create_file_fan(client, 3);
 
 	if (data->has_fan & (1 << 3)) {
-		device_create_file(&client->dev, &dev_attr_fan4_input);
-		device_create_file(&client->dev, &dev_attr_fan4_min);
-		device_create_file(&client->dev, &dev_attr_fan4_div);
+		device_create_file_fan(client, 4);
 	}
 	if (data->has_fan & (1 << 4)) {
-		device_create_file(&client->dev, &dev_attr_fan5_input);
-		device_create_file(&client->dev, &dev_attr_fan5_min);
-		device_create_file(&client->dev, &dev_attr_fan5_div);
+		device_create_file_fan(client, 5);
 	}
-
-	device_create_file(&client->dev, &dev_attr_temp1_input);
-	device_create_file(&client->dev, &dev_attr_temp1_max);
-	device_create_file(&client->dev, &dev_attr_temp1_max_hyst);
-	device_create_file(&client->dev, &dev_attr_temp2_input);
-	device_create_file(&client->dev, &dev_attr_temp2_max);
-	device_create_file(&client->dev, &dev_attr_temp2_max_hyst);
-	device_create_file(&client->dev, &dev_attr_temp3_input);
-	device_create_file(&client->dev, &dev_attr_temp3_max);
-	device_create_file(&client->dev, &dev_attr_temp3_max_hyst);
+	
+	device_create_file_temp(client, 1);
+	device_create_file_temp(client, 2);
+	device_create_file_temp(client, 3);
 
 	return 0;
 
