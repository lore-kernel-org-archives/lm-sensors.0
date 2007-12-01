From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 01 Dec 2007 10:25:33 +0000
Subject: [lm-sensors] [PATCH] hwmon: VRM is not written to registers
Message-Id: <20071201112533.7c2f991a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

What was true of reading the VRM value is also true of writing it: not
being a register value, it doesn't need hardware access, so we don't
need a reference to the i2c client. This allows for a minor code
cleanup. As gcc appears to be smart enough to simplify the generated
code by itself, this cleanup only affects the source code, the
generated binaries are unchanged.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1025.c    |    3 +--
 drivers/hwmon/asb100.c     |    6 ++----
 drivers/hwmon/lm85.c       |    8 ++------
 drivers/hwmon/lm87.c       |    3 +--
 drivers/hwmon/smsc47m192.c |    3 +--
 drivers/hwmon/w83791d.c    |    6 ++----
 drivers/hwmon/w83793.c     |    8 ++------
 7 files changed, 11 insertions(+), 26 deletions(-)

--- linux-2.6.24-rc3.orig/drivers/hwmon/adm1025.c	2007-12-01 11:11:13.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/adm1025.c	2007-12-01 11:12:21.000000000 +0100
@@ -335,8 +335,7 @@ show_vrm(struct device *dev, struct devi
 static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
 		       const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1025_data *data = i2c_get_clientdata(client);
+	struct adm1025_data *data = dev_get_drvdata(dev);
 	data->vrm = simple_strtoul(buf, NULL, 10);
 	return count;
 }
--- linux-2.6.24-rc3.orig/drivers/hwmon/asb100.c	2007-12-01 11:11:13.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/asb100.c	2007-12-01 11:12:21.000000000 +0100
@@ -520,10 +520,8 @@ static ssize_t show_vrm(struct device *d
 
 static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct asb100_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
-	data->vrm = val;
+	struct asb100_data *data = dev_get_drvdata(dev);
+	data->vrm = simple_strtoul(buf, NULL, 10);
 	return count;
 }
 
--- linux-2.6.24-rc3.orig/drivers/hwmon/lm85.c	2007-12-01 11:11:13.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/lm85.c	2007-12-01 11:12:21.000000000 +0100
@@ -444,12 +444,8 @@ static ssize_t show_vrm_reg(struct devic
 
 static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-	u32 val;
-
-	val = simple_strtoul(buf, NULL, 10);
-	data->vrm = val;
+	struct lm85_data *data = dev_get_drvdata(dev);
+	data->vrm = simple_strtoul(buf, NULL, 10);
 	return count;
 }
 
--- linux-2.6.24-rc3.orig/drivers/hwmon/lm87.c	2007-12-01 11:11:13.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/lm87.c	2007-12-01 11:12:21.000000000 +0100
@@ -511,8 +511,7 @@ static ssize_t show_vrm(struct device *d
 }
 static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm87_data *data = i2c_get_clientdata(client);
+	struct lm87_data *data = dev_get_drvdata(dev);
 	data->vrm = simple_strtoul(buf, NULL, 10);
 	return count;
 }
--- linux-2.6.24-rc3.orig/drivers/hwmon/smsc47m192.c	2007-12-01 11:11:13.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/smsc47m192.c	2007-12-01 11:12:21.000000000 +0100
@@ -341,8 +341,7 @@ static ssize_t show_vrm(struct device *d
 static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	struct smsc47m192_data *data = dev_get_drvdata(dev);
 	data->vrm = simple_strtoul(buf, NULL, 10);
 	return count;
 }
--- linux-2.6.24-rc3.orig/drivers/hwmon/w83791d.c	2007-12-01 11:11:13.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/w83791d.c	2007-12-01 11:12:21.000000000 +0100
@@ -840,14 +840,12 @@ static ssize_t store_vrm_reg(struct devi
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83791d_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	struct w83791d_data *data = dev_get_drvdata(dev);
 
 	/* No lock needed as vrm is internal to the driver
 	   (not read from a chip register) and so is not
 	   updated in w83791d_update_device() */
-	data->vrm = val;
+	data->vrm = simple_strtoul(buf, NULL, 10);
 
 	return count;
 }
--- linux-2.6.24-rc3.orig/drivers/hwmon/w83793.c	2007-12-01 11:11:13.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/w83793.c	2007-12-01 11:12:21.000000000 +0100
@@ -243,9 +243,7 @@ static struct i2c_driver w83793_driver  static ssize_t
 show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83793_data *data = i2c_get_clientdata(client);
-
+	struct w83793_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
 
@@ -264,9 +262,7 @@ static ssize_t
 store_vrm(struct device *dev, struct device_attribute *attr,
 	  const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83793_data *data = i2c_get_clientdata(client);
-
+	struct w83793_data *data = dev_get_drvdata(dev);
 	data->vrm = simple_strtoul(buf, NULL, 10);
 	return count;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
