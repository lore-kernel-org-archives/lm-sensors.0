From: greg@kroah.com (Greg KH)
Date: Tue, 09 May 2006 20:08:25 +0000
Subject: [lm-sensors] [PATCH 2/3] scx200_acb: Fix resource name use after
Message-Id: <11472053061587-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

We can't pass a string on the stack to request_region. As soon as we
leave the function that stack is gone and the string is lost. Let's
use the same string we identify the i2c_adapter with instead, it's
more simple, more consistent, and just works.

This is the second half of fix to bug #6445.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/busses/scx200_acb.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

b33d0798e6cfae1fcee75afc808fe5690a48a814
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index f2dae68..42e4e00 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -415,7 +415,6 @@ static int  __init scx200_acb_create(con
 	struct scx200_acb_iface *iface;
 	struct i2c_adapter *adapter;
 	int rc;
-	char description[64];
 
 	iface = kzalloc(sizeof(*iface), GFP_KERNEL);
 	if (!iface) {
@@ -434,10 +433,7 @@ static int  __init scx200_acb_create(con
 
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
1.3.2


