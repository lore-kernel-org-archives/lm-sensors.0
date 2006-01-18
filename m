From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Jan 2006 21:46:26 +0000
Subject: [lm-sensors] [PATCH 05/17] i2c: scx200_acb remove use of lock_kernel
Message-Id: <20060118224626.03f91248.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Ben Gardner <bgardner at wabtec.com>
Content-Disposition: inline; filename=i2c-scx200_acb-04-lock_kernel.patch

scx200_acb: remove use of lock_kernel()

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/scx200_acb.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

--- linux-2.6.15-rc5-mm3.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2.6.15-rc5-mm3/drivers/i2c/busses/scx200_acb.c
@@ -378,6 +378,7 @@ static struct i2c_algorithm scx200_acb_a
 };
 
 static struct scx200_acb_iface *scx200_acb_list;
+static DECLARE_MUTEX(scx200_acb_list_mutex);
 
 static int scx200_acb_probe(struct scx200_acb_iface *iface)
 {
@@ -463,10 +464,10 @@ static int  __init scx200_acb_create(int
 		goto errout_release;
 	}
 
-	lock_kernel();
+	down(&scx200_acb_list_mutex);
 	iface->next = scx200_acb_list;
 	scx200_acb_list = iface;
-	unlock_kernel();
+	up(&scx200_acb_list_mutex);
 
 	return 0;
 
@@ -509,17 +510,17 @@ static void __exit scx200_acb_cleanup(vo
 {
 	struct scx200_acb_iface *iface;
 
-	lock_kernel();
+	down(&scx200_acb_list_mutex);
 	while ((iface = scx200_acb_list) != NULL) {
 		scx200_acb_list = iface->next;
-		unlock_kernel();
+		up(&scx200_acb_list_mutex);
 
 		i2c_del_adapter(&iface->adapter);
 		release_region(iface->base, 8);
 		kfree(iface);
-		lock_kernel();
+		down(&scx200_acb_list_mutex);
 	}
-	unlock_kernel();
+	up(&scx200_acb_list_mutex);
 }
 
 module_init(scx200_acb_init);


-- 
Jean Delvare

