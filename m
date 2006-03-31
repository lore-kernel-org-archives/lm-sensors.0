From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 31 Mar 2006 21:06:03 +0000
Subject: [lm-sensors] [PATCH 2/3] i2c: convert m41t00 to use a workqueue
Message-Id: <20060331230603.4a8bc540.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: "Mark A. Greer" <mgreer at mvista.com>
Content-Disposition: inline; filename=rtc-m41t00-driver-should-use-workqueue-instead-of-tasklet.patch

The m41t00 i2c/rtc driver currently uses a tasklet to schedule
interrupt-level writes to the rtc.  This patch causes the driver
to use a workqueue instead.

Signed-off-by: Mark A. Greer <mgreer at mvista.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 m41t00.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff -Nurp linux-2.6.16-mm1/drivers/i2c/chips/m41t00.c linux-2.6.16-mm1-wq/drivers/i2c/chips/m41t00.c
--- linux-2.6.16-mm1/drivers/i2c/chips/m41t00.c	2006-03-23 15:04:55.000000000 -0700
+++ linux-2.6.16-mm1-wq/drivers/i2c/chips/m41t00.c	2006-03-27 15:29:35.000000000 -0700
@@ -25,6 +25,7 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 #include <asm/time.h>
 #include <asm/rtc.h>
@@ -111,7 +112,7 @@ m41t00_get_rtc_time(void)
 }
 
 static void
-m41t00_set_tlet(ulong arg)
+m41t00_set(void *arg)
 {
 	struct rtc_time	tm;
 	ulong	nowtime = *(ulong *)arg;
@@ -145,9 +146,9 @@ m41t00_set_tlet(ulong arg)
 	return;
 }
 
-static ulong	new_time;
-
-DECLARE_TASKLET_DISABLED(m41t00_tasklet, m41t00_set_tlet, (ulong)&new_time);
+static ulong new_time;
+static struct workqueue_struct *m41t00_wq;
+static DECLARE_WORK(m41t00_work, m41t00_set, &new_time);
 
 int
 m41t00_set_rtc_time(ulong nowtime)
@@ -155,9 +156,9 @@ m41t00_set_rtc_time(ulong nowtime)
 	new_time = nowtime;
 
 	if (in_interrupt())
-		tasklet_schedule(&m41t00_tasklet);
+		queue_work(m41t00_wq, &m41t00_work);
 	else
-		m41t00_set_tlet((ulong)&new_time);
+		m41t00_set(&new_time);
 
 	return 0;
 }
@@ -189,6 +190,7 @@ m41t00_probe(struct i2c_adapter *adap, i
 		return rc;
 	}
 
+	m41t00_wq = create_singlethread_workqueue("m41t00");
 	save_client = client;
 	return 0;
 }
@@ -206,7 +208,7 @@ m41t00_detach(struct i2c_client *client)
 
 	if ((rc = i2c_detach_client(client)) = 0) {
 		kfree(client);
-		tasklet_kill(&m41t00_tasklet);
+		destroy_workqueue(m41t00_wq);
 	}
 	return rc;
 }

-- 
Jean Delvare

