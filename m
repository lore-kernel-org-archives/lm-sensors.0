From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Feb 2006 22:28:21 +0000
Subject: [lm-sensors] [PATCH 08/11] i2c: Optimize core_lists mutex usage
Message-Id: <20060205232821.25bd8615.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-core-optimize-mutex-use.patch

Stop holding the core_lists mutex when we don't actually need it.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/i2c-core.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- linux-2.6.16-rc1.orig/drivers/i2c/i2c-core.c	2006-01-20 19:50:19.000000000 +0100
+++ linux-2.6.16-rc1/drivers/i2c/i2c-core.c	2006-01-20 20:04:05.000000000 +0100
@@ -288,9 +288,7 @@
 {
 	struct list_head   *item;
 	struct i2c_adapter *adapter;
-	int res = 0;
-
-	mutex_lock(&core_lists);
+	int res;
 
 	/* add the driver to the list of i2c drivers in the driver core */
 	driver->driver.owner = owner;
@@ -298,8 +296,10 @@
 
 	res = driver_register(&driver->driver);
 	if (res)
-		goto out_unlock;
+		return res;
 	
+	mutex_lock(&core_lists);
+
 	list_add_tail(&driver->list,&drivers);
 	pr_debug("i2c-core: driver [%s] registered\n", driver->driver.name);
 
@@ -311,9 +311,8 @@
 		}
 	}
 
- out_unlock:
 	mutex_unlock(&core_lists);
-	return res;
+	return 0;
 }
 EXPORT_SYMBOL(i2c_register_driver);
 

-- 
Jean Delvare

