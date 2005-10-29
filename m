From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:12:48 +0000
Subject: [lm-sensors] [PATCH] I2C: remove devfs support from i2c-dev driver
Message-Id: <1130533664130@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: remove devfs support from i2c-dev driver

as devfs is gone, this isn't needed anymore.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0dc9a32d9a975ccd25b9f531451165c93e1c7313
tree df2c1fd2bd0f98d305a9630da86737a91201d8f9
parent b890a07f7b002ee473986fa85ae3582de399a4cf
author Greg Kroah-Hartman <gregkh@suse.de> Sat, 22 Oct 2005 00:23:27 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:14 -0700

 drivers/i2c/i2c-dev.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 276ec42..ea14c8f 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -26,15 +26,11 @@
 
 /* The I2C_RDWR ioctl code is written by Kolja Waschk <waschk@telos.de> */
 
-/* The devfs code is contributed by Philipp Matthias Hahn 
-   <pmhahn@titan.lahn.de> */
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
@@ -431,8 +427,6 @@ static int i2cdev_attach_adapter(struct 
 	if (IS_ERR(i2c_dev))
 		return PTR_ERR(i2c_dev);
 
-	devfs_mk_cdev(MKDEV(I2C_MAJOR, i2c_dev->minor),
-			S_IFCHR|S_IRUSR|S_IWUSR, "i2c/%d", i2c_dev->minor);
 	pr_debug("i2c-dev: adapter [%s] registered as minor %d\n",
 		 adap->name, i2c_dev->minor);
 
@@ -465,7 +459,6 @@ static int i2cdev_detach_adapter(struct 
 		return -ENODEV;
 
 	init_completion(&i2c_dev->released);
-	devfs_remove("i2c/%d", i2c_dev->minor);
 	return_i2c_dev(i2c_dev);
 	class_device_unregister(&i2c_dev->class_dev);
 	wait_for_completion(&i2c_dev->released);
@@ -521,8 +514,6 @@ static int __init i2c_dev_init(void)
 	if (res)
 		goto out_unreg_class;
 
-	devfs_mk_dir("i2c");
-
 	return 0;
 
 out_unreg_class:
@@ -538,7 +529,6 @@ static void __exit i2c_dev_exit(void)
 {
 	i2c_del_driver(&i2cdev_driver);
 	class_unregister(&i2c_dev_class);
-	devfs_remove("i2c");
 	unregister_chrdev(I2C_MAJOR,"i2c");
 }
 

