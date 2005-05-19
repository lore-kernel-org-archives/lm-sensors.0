From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] RFC PATCH 2.6 I2C: drivers: remove vrm accessor
Message-Id: <v5cj819d3pbvcm6i9jb5kj0nichg14no3t@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This patch removes vrm sysfs accessors as the function is handled 
within the drivers.  Instead an info line is printed on driver 
startup line as per previous patch for adm9240.

Affects drivers:  adm1025.c, adm1026.c, asb100.c, it87.c,
	lm85.c, lm87.c, pc87360.c, w83627hf.c, w83781d.c

Query: do we need sunset notification for this change?

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm1025.c  |   17 ++---------------
 adm1026.c  |   21 +++------------------
 asb100.c   |   24 +++---------------------
 it87.c     |   26 +++-----------------------
 lm85.c     |   27 +++------------------------
 lm87.c     |   17 ++---------------
 pc87360.c  |   17 ++---------------
 w83627hf.c |   28 +++-------------------------
 w83781d.c  |   30 +++---------------------------
 9 files changed, 24 insertions(+), 183 deletions(-)

diff -X dontdiff -Nru linux-2.6.12-rc4-mm2/drivers/i2c/chips/adm1025.c linux-2.6.12-rc4-mm2a/drivers/i2c/chips/adm1025.c
--- linux-2.6.12-rc4-mm2/drivers/i2c/chips/adm1025.c	2005-05-17 13:00:24.000000000 +1000
+++ linux-2.6.12-rc4-mm2a/drivers/i2c/chips/adm1025.c	2005-05-17 18:12:09.000000000 +1000
@@ -290,20 +290,6 @@
 static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL);
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, char *buf)
-{
-	struct adm1025_data *data = adm1025_update_device(dev);
-	return sprintf(buf, "%u\n", data->vrm);
-}
-static ssize_t set_vrm(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1025_data *data = i2c_get_clientdata(client);
-	data->vrm = simple_strtoul(buf, NULL, 10);
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-
 /*
  * Real code
  */
@@ -441,7 +427,6 @@
 	/* in1_ref is deprecated, remove after 2005-11-11 */
 	device_create_file(&new_client->dev, &dev_attr_in1_ref);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
-	device_create_file(&new_client->dev, &dev_attr_vrm);
 
 	/* Pin 11 is either in4 (+12V) or VID4 */
 	if (!(config & 0x20)) {
@@ -465,6 +450,8 @@
 	int i;
 
 	data->vrm = i2c_which_vrm();
+	dev_info(&client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
+						data->vrm % 10);
 
 	/*
 	 * Set high limits
diff -X dontdiff -Nru linux-2.6.12-rc4-mm2/drivers/i2c/chips/adm1026.c linux-2.6.12-rc4-mm2a/drivers/i2c/chips/adm1026.c
--- linux-2.6.12-rc4-mm2/drivers/i2c/chips/adm1026.c	2005-05-17 13:00:24.000000000 +1000
+++ linux-2.6.12-rc4-mm2a/drivers/i2c/chips/adm1026.c	2005-05-17 18:34:57.000000000 +1000
@@ -1270,23 +1270,6 @@
 static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL);
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
-static ssize_t show_vrm_reg(struct device *dev, char *buf)
-{
-	struct adm1026_data *data = adm1026_update_device(dev);
-	return sprintf(buf,"%d\n", data->vrm);
-}
-static ssize_t store_vrm_reg(struct device *dev, const char *buf,
-		size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
-
-	data->vrm = simple_strtol(buf, NULL, 10);
-	return count;
-}
-
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
-
 static ssize_t show_alarms_reg(struct device *dev, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
@@ -1593,6 +1576,9 @@
 	/* Set the VRM version */
 	data->vrm = i2c_which_vrm();
 
+	dev_info(&new_client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
+			data->vrm % 10);
+
 	/* Initialize the ADM1026 chip */
 	adm1026_init_client(new_client);
 
@@ -1711,7 +1697,6 @@
 	/* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */
 	device_create_file(&new_client->dev, &dev_attr_vid);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
-	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_alarm_mask);
 	device_create_file(&new_client->dev, &dev_attr_gpio);
diff -X dontdiff -Nru linux-2.6.12-rc4-mm2/drivers/i2c/chips/asb100.c linux-2.6.12-rc4-mm2a/drivers/i2c/chips/asb100.c
--- linux-2.6.12-rc4-mm2/drivers/i2c/chips/asb100.c	2005-05-12 09:47:33.000000000 +1000
+++ linux-2.6.12-rc4-mm2a/drivers/i2c/chips/asb100.c	2005-05-17 18:16:33.000000000 +1000
@@ -532,27 +532,7 @@
 #define device_create_file_vid(client) \
 device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
-/* VRM */
-static ssize_t show_vrm(struct device *dev, char *buf)
-{
-	struct asb100_data *data = asb100_update_device(dev);
-	return sprintf(buf, "%d\n", data->vrm);
-}
-
-static ssize_t set_vrm(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct asb100_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
-	data->vrm = val;
-	return count;
-}
-
 /* Alarms */
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-#define device_create_file_vrm(client) \
-device_create_file(&client->dev, &dev_attr_vrm);
-
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
@@ -840,7 +820,6 @@
 	device_create_file_temp(new_client, 4);
 
 	device_create_file_vid(new_client);
-	device_create_file_vrm(new_client);
 
 	device_create_file_alarms(new_client);
 
@@ -973,6 +952,9 @@
 	data->vrm = i2c_which_vrm();
 	vid = vid_from_reg(vid, data->vrm);
 
+	dev_info(&client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
+			data->vrm % 10);
+
 	/* Start monitoring */
 	asb100_write_value(client, ASB100_REG_CONFIG, 
 		(asb100_read_value(client, ASB100_REG_CONFIG) & 0xf7) | 0x01);
diff -X dontdiff -Nru linux-2.6.12-rc4-mm2/drivers/i2c/chips/it87.c linux-2.6.12-rc4-mm2a/drivers/i2c/chips/it87.c
--- linux-2.6.12-rc4-mm2/drivers/i2c/chips/it87.c	2005-05-17 13:00:25.000000000 +1000
+++ linux-2.6.12-rc4-mm2a/drivers/i2c/chips/it87.c	2005-05-17 18:35:39.000000000 +1000
@@ -670,28 +670,6 @@
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 static ssize_t
-show_vrm_reg(struct device *dev, char *buf)
-{
-	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
-}
-static ssize_t
-store_vrm_reg(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
-	u32 val;
-
-	val = simple_strtoul(buf, NULL, 10);
-	data->vrm = val;
-
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
-#define device_create_file_vrm(client) \
-device_create_file(&client->dev, &dev_attr_vrm)
-
-static ssize_t
 show_vid_reg(struct device *dev, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
@@ -921,8 +899,10 @@
 
 	if (data->type = it8712) {
 		data->vrm = i2c_which_vrm();
-		device_create_file_vrm(new_client);
 		device_create_file_vid(new_client);
+
+		dev_info(&new_client->dev, "Using VRM: %d.%d\n",
+				data->vrm / 10, data->vrm % 10);
 	}
 
 	return 0;
diff -X dontdiff -Nru linux-2.6.12-rc4-mm2/drivers/i2c/chips/lm85.c linux-2.6.12-rc4-mm2a/drivers/i2c/chips/lm85.c
--- linux-2.6.12-rc4-mm2/drivers/i2c/chips/lm85.c	2005-05-17 13:00:25.000000000 +1000
+++ linux-2.6.12-rc4-mm2a/drivers/i2c/chips/lm85.c	2005-05-17 18:36:16.000000000 +1000
@@ -281,9 +281,6 @@
 #define PPR_TO_REG(val,fan) (SENSORS_LIMIT((val)-1,0,3)<<(fan *2))
 #define PPR_FROM_REG(val,fan) ((((val)>>(fan * 2))&0x03)+1)
 
-/* i2c-vid.h defines vid_from_reg() */
-#define VID_FROM_REG(val,vrm) (vid_from_reg((val),(vrm)))
-
 #define ALARMS_FROM_REG(val) (val)
 
 /* Unlike some other drivers we DO NOT set initial limits.  Use
@@ -453,30 +450,11 @@
 static ssize_t show_vid_reg(struct device *dev, char *buf)
 {
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
-static ssize_t show_vrm_reg(struct device *dev, char *buf)
-{
-	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
-}
-
-static ssize_t store_vrm_reg(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-	u32 val;
-
-	val = simple_strtoul(buf, NULL, 10);
-	data->vrm = val;
-	return count;
-}
-
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
-
 static ssize_t show_alarms_reg(struct device *dev, char *buf)
 {
 	struct lm85_data *data = lm85_update_device(dev);
@@ -1163,6 +1141,8 @@
 
 	/* Set the VRM version */
 	data->vrm = i2c_which_vrm();
+	dev_info(&new_client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
+			data->vrm % 10);
 
 	/* Initialize the LM85 chip */
 	lm85_init_client(new_client);
@@ -1206,7 +1186,6 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_temp3_max);
-	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_pwm1_auto_channels);
diff -X dontdiff -Nru linux-2.6.12-rc4-mm2/drivers/i2c/chips/lm87.c linux-2.6.12-rc4-mm2a/drivers/i2c/chips/lm87.c
--- linux-2.6.12-rc4-mm2/drivers/i2c/chips/lm87.c	2005-05-17 13:00:25.000000000 +1000
+++ linux-2.6.12-rc4-mm2a/drivers/i2c/chips/lm87.c	2005-05-17 18:24:36.000000000 +1000
@@ -496,20 +496,6 @@
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, char *buf)
-{
-	struct lm87_data *data = lm87_update_device(dev);
-	return sprintf(buf, "%d\n", data->vrm);
-}
-static ssize_t set_vrm(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm87_data *data = i2c_get_clientdata(client);
-	data->vrm = simple_strtoul(buf, NULL, 10);
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-
 static ssize_t show_aout(struct device *dev, char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
@@ -665,7 +651,6 @@
 
 	if (!(data->channel & CHAN_NO_VID)) {
 		device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
-		device_create_file(&new_client->dev, &dev_attr_vrm);
 	}
 
 	device_create_file(&new_client->dev, &dev_attr_alarms);
@@ -686,6 +671,8 @@
 
 	data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
 	data->vrm = i2c_which_vrm();
+	dev_info(&client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
+			data->vrm % 10);
 
 	config = lm87_read_value(client, LM87_REG_CONFIG);
 	if (!(config & 0x01)) {
diff -X dontdiff -Nru linux-2.6.12-rc4-mm2/drivers/i2c/chips/pc87360.c linux-2.6.12-rc4-mm2a/drivers/i2c/chips/pc87360.c
--- linux-2.6.12-rc4-mm2/drivers/i2c/chips/pc87360.c	2005-05-17 13:00:25.000000000 +1000
+++ linux-2.6.12-rc4-mm2a/drivers/i2c/chips/pc87360.c	2005-05-17 18:37:16.000000000 +1000
@@ -518,20 +518,6 @@
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, char *buf)
-{
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->vrm);
-}
-static ssize_t set_vrm(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pc87360_data *data = i2c_get_clientdata(client);
-	data->vrm = simple_strtoul(buf, NULL, 10);
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-
 static ssize_t show_in_alarms(struct device *dev, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
@@ -820,6 +806,8 @@
 
 		data->vid_conf = confreg[3];
 		data->vrm = 90;
+		dev_info(&new_client->dev, "Using VRM: %d.%d\n",
+					data->vrm / 10, data->vrm % 10);
 	}
 
 	/* Fan clock dividers may be needed before any data is read */
@@ -885,7 +873,6 @@
 		device_create_file(&new_client->dev, &dev_attr_in10_status);
 
 		device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
-		device_create_file(&new_client->dev, &dev_attr_vrm);
 		device_create_file(&new_client->dev, &dev_attr_alarms_in);
 	}
 
diff -X dontdiff -Nru linux-2.6.12-rc4-mm2/drivers/i2c/chips/w83627hf.c linux-2.6.12-rc4-mm2a/drivers/i2c/chips/w83627hf.c
--- linux-2.6.12-rc4-mm2/drivers/i2c/chips/w83627hf.c	2005-05-17 13:00:25.000000000 +1000
+++ linux-2.6.12-rc4-mm2a/drivers/i2c/chips/w83627hf.c	2005-05-17 18:28:30.000000000 +1000
@@ -655,28 +655,6 @@
 device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 static ssize_t
-show_vrm_reg(struct device *dev, char *buf)
-{
-	struct w83627hf_data *data = w83627hf_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
-}
-static ssize_t
-store_vrm_reg(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
-	u32 val;
-
-	val = simple_strtoul(buf, NULL, 10);
-	data->vrm = val;
-
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
-#define device_create_file_vrm(client) \
-device_create_file(&client->dev, &dev_attr_vrm)
-
-static ssize_t
 show_alarms_reg(struct device *dev, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
@@ -1128,9 +1106,6 @@
 	if (kind != w83697hf)
 		device_create_file_vid(new_client);
 
-	if (kind != w83697hf)
-		device_create_file_vrm(new_client);
-
 	device_create_file_fan_div(new_client, 1);
 	device_create_file_fan_div(new_client, 2);
 	if (kind != w83697hf)
@@ -1330,6 +1305,9 @@
 		data->vrm = i2c_which_vrm();
 	}
 
+	dev_info(&client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
+			data->vrm % 10);
+
 	tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
 	for (i = 1; i <= 3; i++) {
 		if (!(tmp & BIT_SCFG1[i - 1])) {
diff -X dontdiff -Nru linux-2.6.12-rc4-mm2/drivers/i2c/chips/w83781d.c linux-2.6.12-rc4-mm2a/drivers/i2c/chips/w83781d.c
--- linux-2.6.12-rc4-mm2/drivers/i2c/chips/w83781d.c	2005-05-17 13:00:25.000000000 +1000
+++ linux-2.6.12-rc4-mm2a/drivers/i2c/chips/w83781d.c	2005-05-17 18:30:11.000000000 +1000
@@ -496,30 +496,6 @@
 #define device_create_file_vid(client) \
 device_create_file(&client->dev, &dev_attr_cpu0_vid);
 static ssize_t
-show_vrm_reg(struct device *dev, char *buf)
-{
-	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
-}
-
-static ssize_t
-store_vrm_reg(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 val;
-
-	val = simple_strtoul(buf, NULL, 10);
-	data->vrm = val;
-
-	return count;
-}
-
-static
-DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
-#define device_create_file_vrm(client) \
-device_create_file(&client->dev, &dev_attr_vrm);
-static ssize_t
 show_alarms_reg(struct device *dev, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
@@ -1232,9 +1208,6 @@
 	if (kind != w83697hf)
 		device_create_file_vid(new_client);
 
-	if (kind != w83697hf)
-		device_create_file_vrm(new_client);
-
 	device_create_file_fan_div(new_client, 1);
 	device_create_file_fan_div(new_client, 2);
 	if (kind != w83697hf)
@@ -1467,6 +1440,9 @@
 
 	data->vrm = i2c_which_vrm();
 
+	dev_info(&client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
+			data->vrm % 10);
+
 	if ((type != w83781d) && (type != as99127f)) {
 		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);
 		for (i = 1; i <= 3; i++) {

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
