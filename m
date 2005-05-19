From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [PATCH 39/39] w1/w1_therm: replace schedule_timeout() with
Message-Id: <20050122011746.55a3585b@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050121214307.GT3340@us.ibm.com>
In-Reply-To: <20050121214307.GT3340@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

> Hi,

> Please consider applying.

> Description: Use msleep_interruptible() instead of schedule_timeout() to
> guarantee the task delays as expected. Changed tm to an int, as it now is in
> terms of msecs, not jiffies.

I've applied it to my tree, thank you.

Greg please push it upstream.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

--- 2.6.11-rc1-kj-v/drivers/w1/w1_therm.c	2005-01-15 16:55:44.000000000 -0800
+++ 2.6.11-rc1-kj/drivers/w1/w1_therm.c	2005-01-21 13:41:08.000000000 -0800
@@ -26,6 +26,7 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/types.h>
+#include <linux/delay.h>
 
 #include "w1.h"
 #include "w1_io.h"
@@ -128,7 +129,7 @@ static ssize_t w1_therm_read_bin(struct 
 		if (!w1_reset_bus (dev)) {
 			int count = 0;
 			u8 match[9] = {W1_MATCH_ROM, };
-			unsigned long tm;
+			unsigned int tm = 750;
 
 			memcpy(&match[1], (u64 *) & sl->reg_num, 8);
 			
@@ -136,11 +137,8 @@ static ssize_t w1_therm_read_bin(struct 
 
 			w1_write_8(dev, W1_CONVERT_TEMP);
 
-			tm = jiffies + msecs_to_jiffies(750);
-			while(time_before(jiffies, tm)) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(tm-jiffies);
-
+			while (tm) {
+				tm = msleep_interruptible(tm);
 				if (signal_pending(current))
 					flush_signals(current);
 			}


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
