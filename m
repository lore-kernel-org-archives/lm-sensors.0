From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Apr 2006 21:00:16 +0000
Subject: [lm-sensors] [PATCH] scx200_acb: Fix resource name use after free
Message-Id: <20060426230016.dca44e58.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This should go in 2.6.17. I'll backport it for -stable as well, as this
bug seems to be in there since the driver was added. It's even in the
2.4 tree, I'll have to backport the fix there too.

Content-Disposition: inline; filename=i2c-scx200_acb-fix-resource-name-use-after-free.patch

We can't pass a string on the stack to request_region. As soon as we
leave the function that stack is gone and the string is lost. Let's
use the same string we identify the i2c_adapter with instead, it's
more simple, more consistent, and just works.

This is the second half of fix to bug #6445.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/scx200_acb.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- linux-2.6.17-rc2.orig/drivers/i2c/busses/scx200_acb.c	2006-04-26 18:59:23.000000000 +0200
+++ linux-2.6.17-rc2/drivers/i2c/busses/scx200_acb.c	2006-04-26 19:01:39.000000000 +0200
@@ -415,7 +415,6 @@
 	struct scx200_acb_iface *iface;
 	struct i2c_adapter *adapter;
 	int rc;
-	char description[64];
 
 	iface = kzalloc(sizeof(*iface), GFP_KERNEL);
 	if (!iface) {
@@ -434,10 +433,7 @@
 
 	mutex_init(&iface->mutex);
 
-	snprintf(description, sizeof(description), "%s ACCESS.bus [%s]",
-		 text, adapter->name);
-
-	if (request_region(base, 8, description) = 0) {
+	if (!request_region(base, 8, adapter->name)) {
 		printk(KERN_ERR NAME ": can't allocate io 0x%x-0x%x\n",
 			base, base + 8-1);
 		rc = -EBUSY;

-- 
Jean Delvare

