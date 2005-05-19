From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <1079391393850@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913932709@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1597.1.12, 2004/03/03 10:09:09-08:00, greg@kroah.com

[PATCH] I2C: show adapter name in i2c-dev class directory to make it easier for userspace tools.


 drivers/i2c/i2c-dev.c |    8 ++++++++
 1 files changed, 8 insertions(+)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Mon Mar 15 14:35:31 2004
+++ b/drivers/i2c/i2c-dev.c	Mon Mar 15 14:35:31 2004
@@ -124,6 +124,13 @@
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
+static ssize_t show_adapter_name(struct class_device *class_dev, char *buf)
+{
+	struct i2c_dev *i2c_dev = to_i2c_dev(class_dev);
+	return sprintf(buf, "%s\n", i2c_dev->adap->name);
+}
+static CLASS_DEVICE_ATTR(name, S_IRUGO, show_adapter_name, NULL);
+
 static ssize_t i2cdev_read (struct file *file, char __user *buf, size_t count,
                             loff_t *offset)
 {
@@ -459,6 +466,7 @@
 	if (retval)
 		goto error;
 	class_device_create_file(&i2c_dev->class_dev, &class_device_attr_dev);
+	class_device_create_file(&i2c_dev->class_dev, &class_device_attr_name);
 	return 0;
 error:
 	return_i2c_dev(i2c_dev);

