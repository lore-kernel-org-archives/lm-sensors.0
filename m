From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:33 +0000
Subject: [lm-sensors] [PATCH 2/30] i2c-dev: Use a list for data storage
Message-Id: <1159318925918-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-dev: Use a list for data storage

Use a list instead of a static array for storing the i2c-dev data.
Given that most systems have less than 10 i2c busses, most of the
space was wasted, so this saves around 1 kB of memory (2 kB on 64-bit
archs.)

The drawback is that lookup was in O(1) and is now in O(N), but given
that the values of N are always small, I don't think this is a problem.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/i2c-dev.c |   45 +++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 6e90dec..206e805 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -32,6 +32,7 @@ #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/list.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 #include <asm/uaccess.h>
@@ -39,21 +40,27 @@ #include <asm/uaccess.h>
 static struct i2c_client i2cdev_client_template;
 
 struct i2c_dev {
+	struct list_head list;
 	struct i2c_adapter *adap;
 	struct class_device *class_dev;
 };
 
 #define I2C_MINORS	256
-static struct i2c_dev *i2c_dev_array[I2C_MINORS];
-static DEFINE_SPINLOCK(i2c_dev_array_lock);
+static LIST_HEAD(i2c_dev_list);
+static DEFINE_SPINLOCK(i2c_dev_list_lock);
 
 static struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
 {
 	struct i2c_dev *i2c_dev;
 
-	spin_lock(&i2c_dev_array_lock);
-	i2c_dev = i2c_dev_array[index];
-	spin_unlock(&i2c_dev_array_lock);
+	spin_lock(&i2c_dev_list_lock);
+	list_for_each_entry(i2c_dev, &i2c_dev_list, list) {
+		if (i2c_dev->adap->nr = index)
+			goto found;
+	}
+	i2c_dev = NULL;
+found:
+	spin_unlock(&i2c_dev_list_lock);
 	return i2c_dev;
 }
 
@@ -61,30 +68,28 @@ static struct i2c_dev *get_free_i2c_dev(
 {
 	struct i2c_dev *i2c_dev;
 
+	if (adap->nr >= I2C_MINORS) {
+		printk(KERN_ERR "i2c-dev: Out of device minors (%d)\n",
+		       adap->nr);
+		return ERR_PTR(-ENODEV);
+	}
+
 	i2c_dev = kzalloc(sizeof(*i2c_dev), GFP_KERNEL);
 	if (!i2c_dev)
 		return ERR_PTR(-ENOMEM);
-
-	spin_lock(&i2c_dev_array_lock);
-	if (i2c_dev_array[adap->nr]) {
-		spin_unlock(&i2c_dev_array_lock);
-		dev_err(&adap->dev, "i2c-dev already has a device assigned to this adapter\n");
-		goto error;
-	}
 	i2c_dev->adap = adap;
-	i2c_dev_array[adap->nr] = i2c_dev;
-	spin_unlock(&i2c_dev_array_lock);
+
+	spin_lock(&i2c_dev_list_lock);
+	list_add_tail(&i2c_dev->list, &i2c_dev_list);
+	spin_unlock(&i2c_dev_list_lock);
 	return i2c_dev;
-error:
-	kfree(i2c_dev);
-	return ERR_PTR(-ENODEV);
 }
 
 static void return_i2c_dev(struct i2c_dev *i2c_dev)
 {
-	spin_lock(&i2c_dev_array_lock);
-	i2c_dev_array[i2c_dev->adap->nr] = NULL;
-	spin_unlock(&i2c_dev_array_lock);
+	spin_lock(&i2c_dev_list_lock);
+	list_del(&i2c_dev->list);
+	spin_unlock(&i2c_dev_list_lock);
 }
 
 static ssize_t show_adapter_name(struct class_device *class_dev, char *buf)
-- 
1.4.2.1


