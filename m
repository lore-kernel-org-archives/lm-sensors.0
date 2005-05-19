From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041130033904.GA32741@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Zwane:

Thanks for the reply!

* Zwane Mwaikambo <zwane@linuxpower.ca> [2004-11-29 15:52:12 -0700]:
> Looking at the driver, algo_data->lock only protects status, which can 
> easily be overwritten if the reader doesn't read it before the next 
> interrupt.

For this driver at least: after one interrupt sets the status, the
next interrupt will either be 1) caused by an asynchronous event
(wrt normal bus transfers) like SMBAlert that we silently ignore, or
2) caused by the next transfer, which cannot have been started until
the status from the first one is consumed.

> In which case it seems like overkill using a lock, why not just 
> do an atomic xchg?

I.e. the way I wrote it was correct but non-optimal?  How about this?
It compiles & runs at least, and it looks correct to me.

--- i2c-i801.c.orig	2004-11-29 22:08:48.000000000 -0500
+++ i2c-i801.c	2004-11-29 22:17:32.000000000 -0500
@@ -64,7 +64,6 @@
 #include "i2c-i801.h"
 
 struct i2c_i801_algo_data {
-	spinlock_t lock;
 	wait_queue_head_t waitq;
 	int status; /* copy of h/w register */
 };
@@ -94,15 +93,7 @@ static void i801_abort(struct i2c_adapte
 /* fetch & consume host status out of algo_data */
 static inline int i801_get_status(struct i2c_i801_algo_data *algo_data)
 {
-	unsigned long flags;
-        int status;
-
-	spin_lock_irqsave(&algo_data->lock, flags);
-	status = algo_data->status;
-	algo_data->status = 0;
-	spin_unlock_irqrestore(&algo_data->lock, flags);
-
-	return status;
+	return xchg(&algo_data->status,0);
 }
 
 static int i801_transaction(struct i2c_adapter *adap, int smbcmd)
@@ -246,11 +237,8 @@ static irqreturn_t i801_isr(int irq, voi
 	if (likely(status & I801_HST_STS_MASK_NORM)) {
 		struct i2c_adapter *adap = dev_id;
 		struct i2c_i801_algo_data *algo_data = adap->algo_data;
-		unsigned long flags;
 
-		spin_lock_irqsave(&algo_data->lock, flags);
 		algo_data->status = status;
-		spin_unlock_irqrestore(&algo_data->lock, flags);
 		wake_up_interruptible(&algo_data->waitq);
 	}
 
@@ -317,7 +305,6 @@ static int __devinit i801_probe(struct p
 	}
 
 	init_waitqueue_head(&algo_data->waitq);
-	spin_lock_init(&algo_data->lock);
 
 	/* grab interrupt */
 	if ((ret = request_irq(pcidev->irq, i801_isr, SA_SHIRQ,

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
