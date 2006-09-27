From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:36 +0000
Subject: [lm-sensors] [PATCH 5/30] i2c: __must_check fixes, i2c-dev
Message-Id: <11593189352843-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c: __must_check fixes (i2c-dev)

Check for error on sysfs file creation.
Check for error on device creation.
Delete sysfs file on device destruction.

I couldn't test this one beyond compilation, as it applies on top of
another patch in Greg's tree [1] which breaks all my systems when I
apply it (my udev isn't recent enough.) Anyone with bleeding edge udev
is welcome to test and report.

[1] http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/i2c/i2c-dev-device.patch

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/i2c-dev.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 2ce0833..567fb05 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -406,6 +406,7 @@ static struct class *i2c_dev_class;
 static int i2cdev_attach_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev;
+	int res;
 
 	i2c_dev = get_free_i2c_dev(adap);
 	if (IS_ERR(i2c_dev))
@@ -419,14 +420,20 @@ static int i2cdev_attach_adapter(struct 
 						 MKDEV(I2C_MAJOR, adap->nr),
 						 &adap->dev, "i2c-%d",
 						 adap->nr);
-	if (!i2c_dev->class_dev)
+	if (!i2c_dev->class_dev) {
+		res = -ENODEV;
 		goto error;
-	class_device_create_file(i2c_dev->class_dev, &class_device_attr_name);
+	}
+	res = class_device_create_file(i2c_dev->class_dev, &class_device_attr_name);
+	if (res)
+		goto error_destroy;
 	return 0;
+error_destroy:
+	class_device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 error:
 	return_i2c_dev(i2c_dev);
 	kfree(i2c_dev);
-	return -ENODEV;
+	return res;
 }
 
 static int i2cdev_detach_adapter(struct i2c_adapter *adap)
@@ -437,6 +444,7 @@ static int i2cdev_detach_adapter(struct 
 	if (!i2c_dev)
 		return -ENODEV;
 
+	class_device_remove_file(i2c_dev->class_dev, &class_device_attr_name);
 	return_i2c_dev(i2c_dev);
 	class_device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 	kfree(i2c_dev);
-- 
1.4.2.1


