From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 16:11:51 +0000
Subject: [lm-sensors] [PATCH 08/11] i2c: I2C_DF_NOTIFY removal comment
Message-Id: <20051218171151.6c56a057.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-drop-driver-flags-04-drop-outdated-comments.patch

The removal of I2C_DF_NOTIFY left some out of date comments in the
code. Drop them.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/i2c-core.c |    8 --------
 1 file changed, 8 deletions(-)

--- linux-2.6.15-rc5.orig/drivers/i2c/i2c-core.c	2005-12-07 20:02:37.000000000 +0100
+++ linux-2.6.15-rc5/drivers/i2c/i2c-core.c	2005-12-07 22:22:55.000000000 +0100
@@ -246,10 +246,6 @@
 	list_for_each_safe(item, _n, &adap->clients) {
 		client = list_entry(item, struct i2c_client, list);
 
-		/* detaching devices is unconditional of the set notify
-		 * flag, as _all_ clients that reside on the adapter
-		 * must be deleted, as this would cause invalid states.
-		 */
 		if ((res=client->driver->detach_client(client))) {
 			dev_err(&adap->dev, "detach_client failed for client "
 				"[%s] at address 0x%02x\n", client->name,
@@ -335,10 +331,6 @@
 	/* Have a look at each adapter, if clients of this driver are still
 	 * attached. If so, detach them to be able to kill the driver 
 	 * afterwards.
-	 *
-	 * Removing clients does not depend on the notify flag, else
-	 * invalid operation might (will!) result, when using stale client
-	 * pointers.
 	 */
 	list_for_each(item1,&adapters) {
 		adap = list_entry(item1, struct i2c_adapter, list);

-- 
Jean Delvare

