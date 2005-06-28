From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 28 Jun 2005 06:21:46 +0000
Subject: [lm-sensors] [PATCH 2.6.12-git5] i2c: make better use of IDR in
Message-Id: <20050628042130.GB32087@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch uses the already existing IDR mechanism to simplify and
improve the i2c_get_adapter function in i2c-core.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.12-git5/drivers/i2c/i2c-core.c
=================================--- linux-2.6.12-git5.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.12-git5/drivers/i2c/i2c-core.c
@@ -156,7 +156,7 @@ int i2c_add_adapter(struct i2c_adapter *
 		goto out_unlock;
 	}
 
-	res = idr_get_new(&i2c_adapter_idr, NULL, &id);
+	res = idr_get_new(&i2c_adapter_idr, adap, &id);
 	if (res < 0) {
 		if (res = -EAGAIN)
 			res = -ENOMEM;
@@ -765,20 +765,15 @@ int i2c_adapter_id(struct i2c_adapter *a
 
 struct i2c_adapter* i2c_get_adapter(int id)
 {
-	struct list_head   *item;
 	struct i2c_adapter *adapter;
 	
 	down(&core_lists);
-	list_for_each(item,&adapters) {
-		adapter = list_entry(item, struct i2c_adapter, list);
-		if (id = adapter->nr &&
-		    try_module_get(adapter->owner)) {
-			up(&core_lists);
-			return adapter;
-		}
-	}
+	adapter = (struct i2c_adapter *)idr_find(&i2c_adapter_idr, id);
+	if (adapter && !try_module_get(adapter->owner))
+		adapter = NULL;
+
 	up(&core_lists);
-	return NULL;
+	return adapter;
 }
 
 void i2c_put_adapter(struct i2c_adapter *adap)

-- 
Mark M. Hoffman
mhoffman@lightlink.com

