From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH] I2C update for 2.6.10-rc1
Message-Id: <10999778552805@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10999778551345@kroah.com>
References: <10999778552595@kroah.com>
In-Reply-To: <10999778552595@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2014.1.5, 2004/11/05 13:40:43-08:00, johnpol@2ka.mipt.ru

[PATCH] w1/dscore: replace schedule_timeout() with msleep_interruptible()

Description: Uses msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/dscore.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/drivers/w1/dscore.c b/drivers/w1/dscore.c
--- a/drivers/w1/dscore.c	2004-11-08 18:56:04 -08:00
+++ b/drivers/w1/dscore.c	2004-11-08 18:56:04 -08:00
@@ -733,10 +733,8 @@
 	while (atomic_read(&dev->refcnt)) {
 		printk(KERN_INFO "Waiting for DS to become free: refcnt=%d.\n",
 				atomic_read(&dev->refcnt));
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ);
 
-		if (signal_pending(current))
+		if (msleep_interruptible(1000))
 			flush_signals(current);
 	}
 

