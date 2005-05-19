From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: i2c-dev namespace cleanup
Message-Id: <1109968594850@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685943850@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: mhoffman@lightlink.com

ChangeSet 1.2090, 2005/03/02 12:04:12-08:00, mhoffman@lightlink.com

[PATCH] I2C: i2c-dev namespace cleanup

This patch is namespace cleanup for the i2c-dev module.  Please apply.

Signed-off-by Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-dev.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	2005-03-04 12:25:37 -08:00
+++ b/drivers/i2c/i2c-dev.c	2005-03-04 12:25:37 -08:00
@@ -55,7 +55,7 @@
 static struct i2c_dev *i2c_dev_array[I2C_MINORS];
 static DEFINE_SPINLOCK(i2c_dev_array_lock);
 
-struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
+static struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
 {
 	struct i2c_dev *i2c_dev;
 
@@ -65,7 +65,7 @@
 	return i2c_dev;
 }
 
-struct i2c_dev *i2c_dev_get_by_adapter(struct i2c_adapter *adap)
+static struct i2c_dev *i2c_dev_get_by_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev = NULL;
 
@@ -173,8 +173,8 @@
 	return ret;
 }
 
-int i2cdev_ioctl (struct inode *inode, struct file *file, unsigned int cmd, 
-                  unsigned long arg)
+static int i2cdev_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
 {
 	struct i2c_client *client = (struct i2c_client *)file->private_data;
 	struct i2c_rdwr_ioctl_data rdwr_arg;

