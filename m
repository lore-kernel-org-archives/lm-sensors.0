From: ben@fluff.org.uk (Ben Dooks)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: lm75 with tmp101
Message-Id: <20050221154410.GA14014@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've done some quick tests, and the tmp101 seems to be
fine with the lm75 driver, using the following cmdline:

"lm75.force_lm75=-1,0x48"

Is there any way to pass the `kind` parameter of the
probe call via this method?

Attached is a patch to add resolution to the sysfs, which
read-only if we detect an lm75, and r/w if it is forced.

I could add a small bit of code to probe the presence of
the resolution bits if the probe is forced. 
-------------- next part --------------
diff -urN -X ../dontdiff linux-2.6.11-rc4-bk8/drivers/i2c/chips/lm75.c linux-2.6.11-rc4-bk8-tmp101-v2/drivers/i2c/chips/lm75.c
--- linux-2.6.11-rc4-bk8/drivers/i2c/chips/lm75.c	2005-01-04 10:57:49.000000000 +0000
+++ linux-2.6.11-rc4-bk8-tmp101-v2/drivers/i2c/chips/lm75.c	2005-02-21 15:40:11.000000000 +0000
@@ -43,6 +43,16 @@
 #define LM75_REG_TEMP_HYST	0x02
 #define LM75_REG_TEMP_OS	0x03
 
+/* resolution defines for extended systems */
+#define LM75_RESOLUTION_MASK	(3<<5)
+#define LM75_RESOLUTION_SHIFT	(5)
+#define LM75_RESOLUTION_BASE	(9)		/* 9..12 bits */
+#define LM75_RESOLUTION_9BIT	(0<<5)
+#define LM75_RESOLUTION_10BIT	(1<<5)
+#define LM75_RESOLUTION_11BIT	(2<<5)
+#define LM75_RESOLUTION_12BIT	(3<<5)
+
+
 /* Each client has this additional data */
 struct lm75_data {
 	struct i2c_client	client;
@@ -98,6 +108,43 @@
 set(temp_max, LM75_REG_TEMP_OS);
 set(temp_hyst, LM75_REG_TEMP_HYST);
 
+
+static ssize_t lm75_show_resolution(struct device *dev, char *buf)
+{
+ 	struct i2c_client *client = to_i2c_client(dev);
+	int value;
+
+	value = lm75_read_value(client, LM75_REG_CONF);
+	value &= LM75_RESOLUTION_MASK;
+	value >>= LM75_RESOLUTION_SHIFT;
+	value += 9;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", value);
+}
+
+static ssize_t lm75_set_resolution(struct device *dev, const char *buf,
+				   size_t count)
+{
+ 	struct i2c_client *client = to_i2c_client(dev);
+	int value = simple_strtoul(buf, NULL, 10);
+	int conf;
+
+	value -= LM75_RESOLUTION_BASE;
+
+	if (value < 0 || value > 3)
+		return -EINVAL;		/* out of range */
+
+	conf = lm75_read_value(client, LM75_REG_CONF);
+	conf &= ~LM75_RESOLUTION_MASK;
+	conf |= value << LM75_RESOLUTION_SHIFT;
+	lm75_write_value(client, LM75_REG_CONF, conf);
+
+	return count;
+}
+
+static DEVICE_ATTR(resolution, S_IWUSR | S_IRUGO,
+		   lm75_show_resolution, lm75_set_resolution);
+
 static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
 static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
@@ -189,6 +236,8 @@
 	/* Determine the chip type - only one kind supported! */
 	if (kind <= 0)
 		kind = lm75;
+	else if (kind != lm75)
+		dev_attr_resolution.attr.mode |= S_IWUSR;
 
 	if (kind = lm75) {
 		name = "lm75";
@@ -213,6 +262,8 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 
+	device_create_file(&new_client->dev, &dev_attr_resolution);
+
 	return 0;
 
 exit_free:
