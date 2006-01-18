From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Jan 2006 22:20:53 +0000
Subject: [lm-sensors] [PATCH 16/17] hwmon: f71805f semaphore to mutex
Message-Id: <20060118232053.036f5a7c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-f71805f-convert-semaphore-to-mutex.patch

Convert the new f71805f hardware monitoring driver to use mutexes
instead of semaphores.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/f71805f.c |   57 ++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

--- linux-2.6.15-git.orig/drivers/hwmon/f71805f.c	2006-01-13 18:38:11.000000000 +0100
+++ linux-2.6.15-git/drivers/hwmon/f71805f.c	2006-01-13 20:28:09.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
 
 static struct platform_device *pdev;
@@ -131,10 +132,10 @@
 struct f71805f_data {
 	unsigned short addr;
 	const char *name;
-	struct semaphore lock;
+	struct mutex lock;
 	struct class_device *class_dev;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 	unsigned long last_limits;	/* In jiffies */
@@ -224,20 +225,20 @@
 {
 	u8 val;
 
-	down(&data->lock);
+	mutex_lock(&data->lock);
 	outb(reg, data->addr + ADDR_REG_OFFSET);
 	val = inb(data->addr + DATA_REG_OFFSET);
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 
 	return val;
 }
 
 static void f71805f_write8(struct f71805f_data *data, u8 reg, u8 val)
 {
-	down(&data->lock);
+	mutex_lock(&data->lock);
 	outb(reg, data->addr + ADDR_REG_OFFSET);
 	outb(val, data->addr + DATA_REG_OFFSET);
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 }
 
 /* It is important to read the MSB first, because doing so latches the
@@ -246,24 +247,24 @@
 {
 	u16 val;
 
-	down(&data->lock);
+	mutex_lock(&data->lock);
 	outb(reg, data->addr + ADDR_REG_OFFSET);
 	val = inb(data->addr + DATA_REG_OFFSET) << 8;
 	outb(++reg, data->addr + ADDR_REG_OFFSET);
 	val |= inb(data->addr + DATA_REG_OFFSET);
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 
 	return val;
 }
 
 static void f71805f_write16(struct f71805f_data *data, u8 reg, u16 val)
 {
-	down(&data->lock);
+	mutex_lock(&data->lock);
 	outb(reg, data->addr + ADDR_REG_OFFSET);
 	outb(val >> 8, data->addr + DATA_REG_OFFSET);
 	outb(++reg, data->addr + ADDR_REG_OFFSET);
 	outb(val & 0xff, data->addr + DATA_REG_OFFSET);
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 }
 
 static struct f71805f_data *f71805f_update_device(struct device *dev)
@@ -271,7 +272,7 @@
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	int nr;
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 
 	/* Limit registers cache is refreshed after 60 seconds */
 	if (time_after(jiffies, data->last_updated + 60 * HZ)
@@ -323,7 +324,7 @@
 		data->valid = 1;
 	}
 
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 
 	return data;
 }
@@ -362,10 +363,10 @@
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	long val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_high[0] = in0_to_reg(val);
 	f71805f_write8(data, F71805F_REG_IN_HIGH(0), data->in_high[0]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 
 	return count;
 }
@@ -376,10 +377,10 @@
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	long val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_low[0] = in0_to_reg(val);
 	f71805f_write8(data, F71805F_REG_IN_LOW(0), data->in_low[0]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 
 	return count;
 }
@@ -422,10 +423,10 @@
 	int nr = attr->index;
 	long val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_high[nr] = in_to_reg(val);
 	f71805f_write8(data, F71805F_REG_IN_HIGH(nr), data->in_high[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 
 	return count;
 }
@@ -438,10 +439,10 @@
 	int nr = attr->index;
 	long val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_low[nr] = in_to_reg(val);
 	f71805f_write8(data, F71805F_REG_IN_LOW(nr), data->in_low[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 
 	return count;
 }
@@ -474,10 +475,10 @@
 	int nr = attr->index;
 	long val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_low[nr] = fan_to_reg(val);
 	f71805f_write16(data, F71805F_REG_FAN_LOW(nr), data->fan_low[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 
 	return count;
 }
@@ -531,10 +532,10 @@
 	int nr = attr->index;
 	long val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_high[nr] = temp_to_reg(val);
 	f71805f_write8(data, F71805F_REG_TEMP_HIGH(nr), data->temp_high[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 
 	return count;
 }
@@ -547,10 +548,10 @@
 	int nr = attr->index;
 	long val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_hyst[nr] = temp_to_reg(val);
 	f71805f_write8(data, F71805F_REG_TEMP_HYST(nr), data->temp_hyst[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 
 	return count;
 }
@@ -711,9 +712,9 @@
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	data->addr = res->start;
-	init_MUTEX(&data->lock);
+	mutex_init(&data->lock);
 	data->name = "f71805f";
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
 
 	platform_set_drvdata(pdev, data);
 

-- 
Jean Delvare

