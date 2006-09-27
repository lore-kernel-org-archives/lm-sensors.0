From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:32 +0000
Subject: [lm-sensors] [PATCH 1/30] i2c-dev: Cleanups
Message-Id: <11593189212375-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-dev: Cleanups

* We no more need to include platform_device.h.
* Delete the to_i2c_dev macro, which is no more used (and no more valid
  either.)
* Drop i2c_dev.minor. Now that the minor number always matches the i2c
  adapter number, this field is redundant with i2c_dev.adap->nr.
* Delete i2c_dev_get_by_adapter() which is now redundant with
  i2c_dev_get_by_minor() for the same reason.
* Drop the local variable dev in i2cdev_attach_adapter(), we can
  easily do without it.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/i2c-dev.c |   33 ++++++++-------------------------
 1 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 58ccddd..6e90dec 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -34,17 +34,14 @@ #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
-#include <linux/platform_device.h>
 #include <asm/uaccess.h>
 
 static struct i2c_client i2cdev_client_template;
 
 struct i2c_dev {
-	int minor;
 	struct i2c_adapter *adap;
 	struct class_device *class_dev;
 };
-#define to_i2c_dev(d) container_of(d, struct i2c_dev, class_dev)
 
 #define I2C_MINORS	256
 static struct i2c_dev *i2c_dev_array[I2C_MINORS];
@@ -60,18 +57,6 @@ static struct i2c_dev *i2c_dev_get_by_mi
 	return i2c_dev;
 }
 
-static struct i2c_dev *i2c_dev_get_by_adapter(struct i2c_adapter *adap)
-{
-	struct i2c_dev *i2c_dev = NULL;
-
-	spin_lock(&i2c_dev_array_lock);
-	if ((i2c_dev_array[adap->nr]) &&
-	    (i2c_dev_array[adap->nr]->adap = adap))
-		i2c_dev = i2c_dev_array[adap->nr];
-	spin_unlock(&i2c_dev_array_lock);
-	return i2c_dev;
-}
-
 static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev;
@@ -86,7 +71,7 @@ static struct i2c_dev *get_free_i2c_dev(
 		dev_err(&adap->dev, "i2c-dev already has a device assigned to this adapter\n");
 		goto error;
 	}
-	i2c_dev->minor = adap->nr;
+	i2c_dev->adap = adap;
 	i2c_dev_array[adap->nr] = i2c_dev;
 	spin_unlock(&i2c_dev_array_lock);
 	return i2c_dev;
@@ -98,7 +83,7 @@ error:
 static void return_i2c_dev(struct i2c_dev *i2c_dev)
 {
 	spin_lock(&i2c_dev_array_lock);
-	i2c_dev_array[i2c_dev->minor] = NULL;
+	i2c_dev_array[i2c_dev->adap->nr] = NULL;
 	spin_unlock(&i2c_dev_array_lock);
 }
 
@@ -415,21 +400,19 @@ static struct class *i2c_dev_class;
 static int i2cdev_attach_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev;
-	struct device *dev;
 
 	i2c_dev = get_free_i2c_dev(adap);
 	if (IS_ERR(i2c_dev))
 		return PTR_ERR(i2c_dev);
 
 	pr_debug("i2c-dev: adapter [%s] registered as minor %d\n",
-		 adap->name, i2c_dev->minor);
+		 adap->name, adap->nr);
 
 	/* register this i2c device with the driver core */
-	i2c_dev->adap = adap;
-	dev = &adap->dev;
 	i2c_dev->class_dev = class_device_create(i2c_dev_class, NULL,
-						 MKDEV(I2C_MAJOR, i2c_dev->minor),
-						 dev, "i2c-%d", i2c_dev->minor);
+						 MKDEV(I2C_MAJOR, adap->nr),
+						 &adap->dev, "i2c-%d",
+						 adap->nr);
 	if (!i2c_dev->class_dev)
 		goto error;
 	class_device_create_file(i2c_dev->class_dev, &class_device_attr_name);
@@ -444,12 +427,12 @@ static int i2cdev_detach_adapter(struct 
 {
 	struct i2c_dev *i2c_dev;
 
-	i2c_dev = i2c_dev_get_by_adapter(adap);
+	i2c_dev = i2c_dev_get_by_minor(adap->nr);
 	if (!i2c_dev)
 		return -ENODEV;
 
 	return_i2c_dev(i2c_dev);
-	class_device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, i2c_dev->minor));
+	class_device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 	kfree(i2c_dev);
 
 	pr_debug("i2c-dev: adapter [%s] unregistered\n", adap->name);
-- 
1.4.2.1


