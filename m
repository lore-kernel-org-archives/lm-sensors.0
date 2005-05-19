From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: [PATCH 2.6] I2C chipset drivers use temp_hyst[1-3] V2
Message-Id: <20031118202556.59d8dd12.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116205914.49637571.khali@linux-fr.org>
In-Reply-To: <20031116205914.49637571.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here is an hopefully fixed version of the previous patch. Sorry for
sending a bad one in the first place.

Mark, please test that patch if you can, thanks.

Summary of the changes:
adm1021.c: No changes, that chipset uses a real min/max model.
eeeprom.c: No changes (obviously).
it87.c:    Remove buggy comments (obviously taken from via686a) about
           max and min temperature limits being over and hyst. This
           isn't the case for this driver (min/max model).
lm75.c:    Simple sysfs file name change (temp_min to temp_hyst).
lm78.c:    Simple sysfs file name change (temp_min to temp_hyst).
lm85.c:    No changes needed (min/max model).
via686a.c: Rename functions and macros from min/max to hyst/over, what
           it really is. Remove unnecessary comments. Rename sysfs
           files from temp_min[1-3] to temp_hyst[1-3].
w83781d.c: Rename variables from temp_min* to temp_hyst* (needed so
           that the macros keep working). Update macro calls
           accordingly. Fix writing temp to max and hyst being
           swapped.

Additional remarks:

The lm75 and lm78 having a single temperature channel, there is no
number appended to the file names. Shouldn't a "1" be appended in this
case? I think it would make it easier for the future library to catch
all the files.

I made sure the drivers would still compile after the changes, but did
not test them otherwise (no working 2.6.0 kernel here, and not all the
hardware anyway).

diff -ru linux-2.6.0-test9/drivers/i2c/chips.orig/it87.c linux-2.6.0-test9/drivers/i2c/chips/it87.c
--- linux-2.6.0-test9/drivers/i2c/chips.orig/it87.c	Sun Nov 16 17:06:15 2003
+++ linux-2.6.0-test9/drivers/i2c/chips/it87.c	Sun Nov 16 18:19:09 2003
@@ -343,7 +343,6 @@
 	it87_update_client(client);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr])*100 );
 }
-/* more like overshoot temperature */
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -351,7 +350,6 @@
 	it87_update_client(client);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr])*100);
 }
-/* more like hysteresis temperature */
 static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
diff -ru linux-2.6.0-test9/drivers/i2c/chips.orig/lm75.c linux-2.6.0-test9/drivers/i2c/chips/lm75.c
--- linux-2.6.0-test9/drivers/i2c/chips.orig/lm75.c	Sun Nov 16 17:06:15 2003
+++ linux-2.6.0-test9/drivers/i2c/chips/lm75.c	Sun Nov 16 18:24:37 2003
@@ -116,7 +116,7 @@
 set(temp_hyst, LM75_REG_TEMP_HYST);
 
 static DEVICE_ATTR(temp_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
-static DEVICE_ATTR(temp_min, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp_hyst, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
 static DEVICE_ATTR(temp_input, S_IRUGO, show_temp_input, NULL);
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
@@ -209,7 +209,7 @@
 	
 	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_temp_max);
-	device_create_file(&new_client->dev, &dev_attr_temp_min);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
 	device_create_file(&new_client->dev, &dev_attr_temp_input);
 
 	return 0;
diff -ru linux-2.6.0-test9/drivers/i2c/chips.orig/lm78.c linux-2.6.0-test9/drivers/i2c/chips/lm78.c
--- linux-2.6.0-test9/drivers/i2c/chips.orig/lm78.c	Sun Nov 16 17:06:15 2003
+++ linux-2.6.0-test9/drivers/i2c/chips/lm78.c	Sun Nov 16 18:30:19 2003
@@ -367,7 +367,7 @@
 static DEVICE_ATTR(temp_input, S_IRUGO, show_temp, NULL)
 static DEVICE_ATTR(temp_max, S_IRUGO | S_IWUSR,
 		show_temp_over, set_temp_over)
-static DEVICE_ATTR(temp_min, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(temp_hyst, S_IRUGO | S_IWUSR,
 		show_temp_hyst, set_temp_hyst)
 
 /* 3 Fans */
@@ -674,8 +674,8 @@
 	device_create_file(&new_client->dev, &dev_attr_in_min6);
 	device_create_file(&new_client->dev, &dev_attr_in_max6);
 	device_create_file(&new_client->dev, &dev_attr_temp_input);
-	device_create_file(&new_client->dev, &dev_attr_temp_min);
 	device_create_file(&new_client->dev, &dev_attr_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
 	device_create_file(&new_client->dev, &dev_attr_fan_input1);
 	device_create_file(&new_client->dev, &dev_attr_fan_min1);
 	device_create_file(&new_client->dev, &dev_attr_fan_div1);
diff -ru linux-2.6.0-test9/drivers/i2c/chips.orig/via686a.c linux-2.6.0-test9/drivers/i2c/chips/via686a.c
--- linux-2.6.0-test9/drivers/i2c/chips.orig/via686a.c	Sun Nov 16 17:06:15 2003
+++ linux-2.6.0-test9/drivers/i2c/chips/via686a.c	Sun Nov 16 18:54:59 2003
@@ -496,21 +496,19 @@
 	via686a_update_client(client);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr])*100 );
 }
-/* more like overshoot temperature */
-static ssize_t show_temp_max(struct device *dev, char *buf, int nr) {
+static ssize_t show_temp_over(struct device *dev, char *buf, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr])*100);
 }
-/* more like hysteresis temperature */
-static ssize_t show_temp_min(struct device *dev, char *buf, int nr) {
+static ssize_t show_temp_hyst(struct device *dev, char *buf, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr])*100);
 }
-static ssize_t set_temp_max(struct device *dev, const char *buf, 
+static ssize_t set_temp_over(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
@@ -519,7 +517,7 @@
 	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
 	return count;
 }
-static ssize_t set_temp_min(struct device *dev, const char *buf, 
+static ssize_t set_temp_hyst(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
@@ -534,30 +532,30 @@
 	return show_temp(dev, buf, 0x##offset - 1);			\
 }									\
 static ssize_t								\
-show_temp_##offset##_max (struct device *dev, char *buf)		\
+show_temp_##offset##_over (struct device *dev, char *buf)		\
 {									\
-	return show_temp_max(dev, buf, 0x##offset - 1);			\
+	return show_temp_over(dev, buf, 0x##offset - 1);			\
 }									\
 static ssize_t								\
-show_temp_##offset##_min (struct device *dev, char *buf)		\
+show_temp_##offset##_hyst (struct device *dev, char *buf)		\
 {									\
-	return show_temp_min(dev, buf, 0x##offset - 1);			\
+	return show_temp_hyst(dev, buf, 0x##offset - 1);			\
 }									\
-static ssize_t set_temp_##offset##_max (struct device *dev, 		\
+static ssize_t set_temp_##offset##_over (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_over(dev, buf, count, 0x##offset - 1);		\
 }									\
-static ssize_t set_temp_##offset##_min (struct device *dev, 		\
+static ssize_t set_temp_##offset##_hyst (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_hyst(dev, buf, count, 0x##offset - 1);		\
 }									\
 static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_temp_##offset, NULL) \
 static DEVICE_ATTR(temp_max##offset, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_max, set_temp_##offset##_max) 	\
-static DEVICE_ATTR(temp_min##offset, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_min, set_temp_##offset##_min)	
+		show_temp_##offset##_over, set_temp_##offset##_over) 	\
+static DEVICE_ATTR(temp_hyst##offset, S_IRUGO | S_IWUSR, 		\
+		show_temp_##offset##_hyst, set_temp_##offset##_hyst)	
 
 show_temp_offset(1);
 show_temp_offset(2);
@@ -760,9 +758,9 @@
 	device_create_file(&new_client->dev, &dev_attr_temp_max1);
 	device_create_file(&new_client->dev, &dev_attr_temp_max2);
 	device_create_file(&new_client->dev, &dev_attr_temp_max3);
-	device_create_file(&new_client->dev, &dev_attr_temp_min1);
-	device_create_file(&new_client->dev, &dev_attr_temp_min2);
-	device_create_file(&new_client->dev, &dev_attr_temp_min3);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst2);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst3);
 	device_create_file(&new_client->dev, &dev_attr_fan_input1);
 	device_create_file(&new_client->dev, &dev_attr_fan_input2);
 	device_create_file(&new_client->dev, &dev_attr_fan_min1);
diff -ru linux-2.6.0-test9/drivers/i2c/chips.orig/w83781d.c linux-2.6.0-test9/drivers/i2c/chips/w83781d.c
--- linux-2.6.0-test9/drivers/i2c/chips.orig/w83781d.c	Sun Nov 16 17:06:15 2003
+++ linux-2.6.0-test9/drivers/i2c/chips/w83781d.c	Tue Nov 18 19:39:18 2003
@@ -309,11 +309,11 @@
 	u8 fan[3];		/* Register value */
 	u8 fan_min[3];		/* Register value */
 	u8 temp;
-	u8 temp_min;		/* Register value */
 	u8 temp_max;		/* Register value */
+	u8 temp_hyst;		/* Register value */
 	u16 temp_add[2];	/* Register value */
 	u16 temp_max_add[2];	/* Register value */
-	u16 temp_min_add[2];	/* Register value */
+	u16 temp_hyst_add[2];	/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
@@ -510,8 +510,8 @@
 	} \
 }
 show_temp_reg(temp);
-show_temp_reg(temp_min);
 show_temp_reg(temp_max);
+show_temp_reg(temp_hyst);
 
 #define store_temp_reg(REG, reg) \
 static ssize_t store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
@@ -538,8 +538,8 @@
 	 \
 	return count; \
 }
-store_temp_reg(OVER, min);
-store_temp_reg(HYST, max);
+store_temp_reg(OVER, max);
+store_temp_reg(HYST, hyst);
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
@@ -562,8 +562,8 @@
 
 #define sysfs_temp_offsets(offset) \
 sysfs_temp_offset(offset); \
-sysfs_temp_reg_offset(min, offset); \
-sysfs_temp_reg_offset(max, offset);
+sysfs_temp_reg_offset(max, offset); \
+sysfs_temp_reg_offset(hyst, offset);
 
 sysfs_temp_offsets(1);
 sysfs_temp_offsets(2);
@@ -573,7 +573,7 @@
 do { \
 device_create_file(&client->dev, &dev_attr_temp_input##offset); \
 device_create_file(&client->dev, &dev_attr_temp_max##offset); \
-device_create_file(&client->dev, &dev_attr_temp_min##offset); \
+device_create_file(&client->dev, &dev_attr_temp_hyst##offset); \
 } while (0)
 
 static ssize_t
@@ -1865,15 +1865,15 @@
 		}
 
 		data->temp = w83781d_read_value(client, W83781D_REG_TEMP(1));
-		data->temp_min -		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(1));
 		data->temp_max +		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(1));
+		data->temp_hyst  		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(1));
 		data->temp_add[0]  		    w83781d_read_value(client, W83781D_REG_TEMP(2));
 		data->temp_max_add[0]  		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(2));
-		data->temp_min_add[0] +		data->temp_hyst_add[0]  		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(2));
 		if (data->type != w83783s && data->type != w83697hf) {
 			data->temp_add[1] @@ -1881,7 +1881,7 @@
 			data->temp_max_add[1]  			    w83781d_read_value(client,
 					       W83781D_REG_TEMP_OVER(3));
-			data->temp_min_add[1] +			data->temp_hyst_add[1]  			    w83781d_read_value(client,
 					       W83781D_REG_TEMP_HYST(3));
 		}


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
