From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 05 Mar 2006 21:07:15 +0000
Subject: [lm-sensors] [PATCH 2.6.15-rc5] hwmon: add required idr locking
Message-Id: <20060305210715.GB3145@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060305152435.GA7990@jupiter.solarsys.private>
In-Reply-To: <20060305152435.GA7990@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Add required locking around idr_ routines, retry the idr_pre_get/idr_get_new
pair properly, and sprinkle in some likely/unlikely for good measure.

(Lack of idr locking didn't hurt when all callers were I2C clients, as the
i2c-core serialized for us anyway.  Now that we have non I2C hwmon drivers,
this is truly necessary.)

This patch should be considered for 2.6.16.

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>

--- linux-2.6.16-rc5.orig/drivers/hwmon/hwmon.c
+++ linux-2.6.16-rc5/drivers/hwmon/hwmon.c
@@ -17,6 +17,7 @@
 #include <linux/idr.h>
 #include <linux/hwmon.h>
 #include <linux/gfp.h>
+#include <linux/spinlock.h>
 
 #define HWMON_ID_PREFIX "hwmon"
 #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
@@ -24,6 +25,7 @@
 static struct class *hwmon_class;
 
 static DEFINE_IDR(hwmon_idr);
+static DEFINE_SPINLOCK(idr_lock);
 
 /**
  * hwmon_device_register - register w/ hwmon sysfs class
@@ -37,20 +39,30 @@ static DEFINE_IDR(hwmon_idr);
 struct class_device *hwmon_device_register(struct device *dev)
 {
 	struct class_device *cdev;
-	int id;
+	int id, err;
 
-	if (idr_pre_get(&hwmon_idr, GFP_KERNEL) = 0)
+again:
+	if (unlikely(idr_pre_get(&hwmon_idr, GFP_KERNEL) = 0))
 		return ERR_PTR(-ENOMEM);
 
-	if (idr_get_new(&hwmon_idr, NULL, &id) < 0)
-		return ERR_PTR(-ENOMEM);
+	spin_lock(&idr_lock);
+	err = idr_get_new(&hwmon_idr, NULL, &id);
+	spin_unlock(&idr_lock);
+
+	if (unlikely(err = -EAGAIN))
+		goto again;
+	else if (unlikely(err))
+		return ERR_PTR(err);
 
 	id = id & MAX_ID_MASK;
 	cdev = class_device_create(hwmon_class, NULL, MKDEV(0,0), dev,
 					HWMON_ID_FORMAT, id);
 
-	if (IS_ERR(cdev))
+	if (IS_ERR(cdev)) {
+		spin_lock(&idr_lock);
 		idr_remove(&hwmon_idr, id);
+		spin_unlock(&idr_lock);
+	}
 
 	return cdev;
 }
@@ -64,9 +76,11 @@ void hwmon_device_unregister(struct clas
 {
 	int id;
 
-	if (sscanf(cdev->class_id, HWMON_ID_FORMAT, &id) = 1) {
+	if (likely(sscanf(cdev->class_id, HWMON_ID_FORMAT, &id) = 1)) {
 		class_device_unregister(cdev);
+		spin_lock(&idr_lock);
 		idr_remove(&hwmon_idr, id);
+		spin_unlock(&idr_lock);
 	} else
 		dev_dbg(cdev->dev,
 			"hwmon_device_unregister() failed: bad class ID!\n");

-- 
Mark M. Hoffman
mhoffman at lightlink.com


