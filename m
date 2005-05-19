From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [PATCH 2.6] I2C: i2c-dev namespace cleanup
Message-Id: <20050122180704.GA4141@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg:

This patch is namespace cleanup for the i2c-dev module.  Please apply.

Signed-off-by Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.11-rc2/drivers/i2c/i2c-dev.c
=================================--- linux-2.6.11-rc2.orig/drivers/i2c/i2c-dev.c	2005-01-22 13:00:43.000000000 -0500
+++ linux-2.6.11-rc2/drivers/i2c/i2c-dev.c	2005-01-22 13:00:52.000000000 -0500
@@ -55,7 +55,7 @@ struct i2c_dev {
 static struct i2c_dev *i2c_dev_array[I2C_MINORS];
 static DEFINE_SPINLOCK(i2c_dev_array_lock);
 
-struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
+static struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
 {
 	struct i2c_dev *i2c_dev;
 
@@ -65,7 +65,7 @@ struct i2c_dev *i2c_dev_get_by_minor(uns
 	return i2c_dev;
 }
 
-struct i2c_dev *i2c_dev_get_by_adapter(struct i2c_adapter *adap)
+static struct i2c_dev *i2c_dev_get_by_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev = NULL;
 
@@ -173,8 +173,8 @@ static ssize_t i2cdev_write (struct file
 	return ret;
 }
 
-int i2cdev_ioctl (struct inode *inode, struct file *file, unsigned int cmd, 
-                  unsigned long arg)
+static int i2cdev_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
 {
 	struct i2c_client *client = (struct i2c_client *)file->private_data;
 	struct i2c_rdwr_ioctl_data rdwr_arg;

-- 
Mark M. Hoffman
mhoffman@lightlink.com
