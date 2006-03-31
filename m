From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 31 Mar 2006 21:05:01 +0000
Subject: [lm-sensors] [PATCH 1/3] i2c: convert ds1374 to use a workqueue
Message-Id: <20060331230501.c9858518.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=rtc-ds1374-convert-tasklet-to-workqueue.patch

A tasklet is not suitable for what the ds1374 driver does: neither sleeping
nor mutex operations are allowed in tasklets, and ds1374_set_tlet may do
both.

We can use a workqueue instead, where both sleeping and mutex operations
are allowed.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Randy Vinson <rvinson at mvista.com>
---
 drivers/i2c/chips/ds1374.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- linux-2.6.16-git.orig/drivers/i2c/chips/ds1374.c	2006-03-27 18:25:17.000000000 +0200
+++ linux-2.6.16-git/drivers/i2c/chips/ds1374.c	2006-03-27 18:59:05.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 #define DS1374_REG_TOD0		0x00
 #define DS1374_REG_TOD1		0x01
@@ -139,7 +140,7 @@
 	return t1;
 }
 
-static void ds1374_set_tlet(ulong arg)
+static void ds1374_set_work(void *arg)
 {
 	ulong t1, t2;
 	int limit = 10;		/* arbitrary retry limit */
@@ -168,17 +169,18 @@
 
 static ulong new_time;
 
-static DECLARE_TASKLET_DISABLED(ds1374_tasklet, ds1374_set_tlet,
-				(ulong) & new_time);
+static struct workqueue_struct *ds1374_workqueue;
+
+static DECLARE_WORK(ds1374_work, ds1374_set_work, &new_time);
 
 int ds1374_set_rtc_time(ulong nowtime)
 {
 	new_time = nowtime;
 
 	if (in_interrupt())
-		tasklet_schedule(&ds1374_tasklet);
+		queue_work(ds1374_workqueue, &ds1374_work);
 	else
-		ds1374_set_tlet((ulong) & new_time);
+		ds1374_set_work(&new_time);
 
 	return 0;
 }
@@ -204,6 +206,8 @@
 	client->adapter = adap;
 	client->driver = &ds1374_driver;
 
+	ds1374_workqueue = create_singlethread_workqueue("ds1374");
+
 	if ((rc = i2c_attach_client(client)) != 0) {
 		kfree(client);
 		return rc;
@@ -227,7 +231,7 @@
 
 	if ((rc = i2c_detach_client(client)) = 0) {
 		kfree(i2c_get_clientdata(client));
-		tasklet_kill(&ds1374_tasklet);
+		destroy_workqueue(ds1374_workqueue);
 	}
 	return rc;
 }

-- 
Jean Delvare

