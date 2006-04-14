From: greg@kroah.com (Greg KH)
Date: Fri, 14 Apr 2006 20:10:47 +0000
Subject: [lm-sensors] [PATCH 1/5] i2c: convert ds1374 to use a workqueue
Message-Id: <11450454473398-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A tasklet is not suitable for what the ds1374 driver does: neither sleeping
nor mutex operations are allowed in tasklets, and ds1374_set_tlet may do
both.

We can use a workqueue instead, where both sleeping and mutex operations
are allowed.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Randy Vinson <rvinson at mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/chips/ds1374.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

524465df2accf54604cb89c04dbaab0c8aaa5bb4
diff --git a/drivers/i2c/chips/ds1374.c b/drivers/i2c/chips/ds1374.c
index 03d09ed..4630f19 100644
--- a/drivers/i2c/chips/ds1374.c
+++ b/drivers/i2c/chips/ds1374.c
@@ -27,6 +27,7 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 #define DS1374_REG_TOD0		0x00
 #define DS1374_REG_TOD1		0x01
@@ -139,7 +140,7 @@ ulong ds1374_get_rtc_time(void)
 	return t1;
 }
 
-static void ds1374_set_tlet(ulong arg)
+static void ds1374_set_work(void *arg)
 {
 	ulong t1, t2;
 	int limit = 10;		/* arbitrary retry limit */
@@ -168,17 +169,18 @@ static void ds1374_set_tlet(ulong arg)
 
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
@@ -204,6 +206,8 @@ static int ds1374_probe(struct i2c_adapt
 	client->adapter = adap;
 	client->driver = &ds1374_driver;
 
+	ds1374_workqueue = create_singlethread_workqueue("ds1374");
+
 	if ((rc = i2c_attach_client(client)) != 0) {
 		kfree(client);
 		return rc;
@@ -227,7 +231,7 @@ static int ds1374_detach(struct i2c_clie
 
 	if ((rc = i2c_detach_client(client)) = 0) {
 		kfree(i2c_get_clientdata(client));
-		tasklet_kill(&ds1374_tasklet);
+		destroy_workqueue(ds1374_workqueue);
 	}
 	return rc;
 }
-- 
1.2.6



