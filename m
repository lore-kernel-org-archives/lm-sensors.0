From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:51 +0000
Subject: [lm-sensors] [PATCH 26/36] i2c: Optimize core_lists mutex usage
Message-Id: <1143153831322-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Stop holding the core_lists mutex when we don't actually need it.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/i2c-core.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

7eebcb7c0f4d45168265bdca79cc3e609d68d436
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 975cb64..45e2cdf 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -288,9 +288,7 @@ int i2c_register_driver(struct module *o
 {
 	struct list_head   *item;
 	struct i2c_adapter *adapter;
-	int res = 0;
-
-	mutex_lock(&core_lists);
+	int res;
 
 	/* add the driver to the list of i2c drivers in the driver core */
 	driver->driver.owner = owner;
@@ -298,8 +296,10 @@ int i2c_register_driver(struct module *o
 
 	res = driver_register(&driver->driver);
 	if (res)
-		goto out_unlock;
+		return res;
 	
+	mutex_lock(&core_lists);
+
 	list_add_tail(&driver->list,&drivers);
 	pr_debug("i2c-core: driver [%s] registered\n", driver->driver.name);
 
@@ -311,9 +311,8 @@ int i2c_register_driver(struct module *o
 		}
 	}
 
- out_unlock:
 	mutex_unlock(&core_lists);
-	return res;
+	return 0;
 }
 EXPORT_SYMBOL(i2c_register_driver);
 
-- 
1.2.4



