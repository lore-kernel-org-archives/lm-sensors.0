From: gregkh@suse.de (Greg KH)
Date: Tue, 12 Jul 2005 00:04:41 +0000
Subject: [lm-sensors] [PATCH] i2c: make better use of IDR in i2c-core
Message-Id: <1121119377358@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11211193773155@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: mhoffman@lightlink.com

[PATCH] i2c: make better use of IDR in i2c-core

This patch uses the already existing IDR mechanism to simplify and
improve the i2c_get_adapter function in i2c-core.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a0920e10438e9fe8b22aba607083347c84458ed8
tree 8953a2c3c19cab0d4e67fc0e396c23711388403b
parent 5da69ba42aa42a479c0f5d8cb8351ebb6b51c12e
author Mark M. Hoffman <mhoffman@lightlink.com> Tue, 28 Jun 2005 00:21:30 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:36 -0700

 drivers/i2c/i2c-core.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
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

