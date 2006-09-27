From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:49 +0000
Subject: [lm-sensors] [PATCH 18/30] i2c-dev: attach/detach_adapter cleanups
Message-Id: <11593189833591-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-dev: attach/detach_adapter cleanups

* Only print that an adapter was attached when it succeeds.
* i2c_dev = NULL on detach simply means that the attach failed
  before, this isn't an error per se.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/i2c-dev.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 567fb05..3f86903 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -412,9 +412,6 @@ static int i2cdev_attach_adapter(struct 
 	if (IS_ERR(i2c_dev))
 		return PTR_ERR(i2c_dev);
 
-	pr_debug("i2c-dev: adapter [%s] registered as minor %d\n",
-		 adap->name, adap->nr);
-
 	/* register this i2c device with the driver core */
 	i2c_dev->class_dev = class_device_create(i2c_dev_class, NULL,
 						 MKDEV(I2C_MAJOR, adap->nr),
@@ -427,6 +424,9 @@ static int i2cdev_attach_adapter(struct 
 	res = class_device_create_file(i2c_dev->class_dev, &class_device_attr_name);
 	if (res)
 		goto error_destroy;
+
+	pr_debug("i2c-dev: adapter [%s] registered as minor %d\n",
+		 adap->name, adap->nr);
 	return 0;
 error_destroy:
 	class_device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
@@ -441,8 +441,8 @@ static int i2cdev_detach_adapter(struct 
 	struct i2c_dev *i2c_dev;
 
 	i2c_dev = i2c_dev_get_by_minor(adap->nr);
-	if (!i2c_dev)
-		return -ENODEV;
+	if (!i2c_dev) /* attach_adapter must have failed */
+		return 0;
 
 	class_device_remove_file(i2c_dev->class_dev, &class_device_attr_name);
 	return_i2c_dev(i2c_dev);
-- 
1.4.2.1


