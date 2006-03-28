From: mgreer@mvista.com (Mark A. Greer)
Date: Tue, 28 Mar 2006 00:22:14 +0000
Subject: [lm-sensors] [PATCH 2.6.16-mm1 1/3] rtc: m41t00 driver should
Message-Id: <20060328002214.GC21077@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <440B4B6E.8080307@sh.cvut.cz> <zt2d4LqL.1141645514.2993990.khali@localhost> <20060307170107.GA5250@mag.az.mvista.com> <20060318001254.GA14079@mag.az.mvista.com> <20060323210856.f1bfd02b.khali@linux-fr.org> <20060323203843.GA18912@mag.az.mvista.com> <20060324011846.GC9560@mag.az.mvista.com> <20060327190358.742eafb3.khali@linux-fr.org>
In-Reply-To: <20060327190358.742eafb3.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Resend...
---

The m41t00 i2c/rtc driver currently uses a tasklet to schedule
interrupt-level writes to the rtc.  This patch causes the driver
to use a workqueue instead.

Signed-off-by: Mark A. Greer <mgreer at mvista.com>
---

 m41t00.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)
---

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

