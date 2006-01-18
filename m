From: marcelo.tosatti@cyclades.com (Marcelo Tosatti)
Date: Wed, 18 Jan 2006 17:55:10 +0000
Subject: [lm-sensors] [PATCH] m41t00.c: sleepable i2c transfer cannot be
Message-Id: <20060118175510.GB13367@dmt.cnet>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Reported-by: Helio Fujimoto <Helio.Fujimoto at cyclades.com>

drivers/i2c/chips/m41t00.c RTC driver has a serious bug: it performs sleepable i2c 
transfer at soft interrupt context, resulting in:

[  667.412674] scheduling while atomic: swapper/0x00000100/0
[  667.418215] Call trace:
[  667.420724]  [c02016d8] schedule+0x6fc/0x7a4
[  667.425117]  [c0202170] schedule_timeout+0x74/0xd4
[  667.430040]  [c018e968] i2c_wait+0x17c/0x1e4
[  667.434476]  [c018ecf8] mpc_xfer+0x328/0x3a0
[  667.438868]  [c018c9c4] i2c_transfer+0x6c/0xb4
[  667.443437]  [c018d12c] i2c_smbus_xfer+0x30c/0x6d8
[  667.448360]  [c018d6d4] i2c_smbus_write_byte_data+0x34/0x44
[  667.454089]  [c018f5cc] m41t00_set_tlet+0x254/0x2e0
[  667.459106]  [c002811c] tasklet_action+0x78/0xe4
[  667.463850]  [c0027cd8] __do_softirq+0x7c/0xf4
[  667.468422]  [c0027da8] do_softirq+0x58/0x60
[  667.472810]  [c0004410] timer_interrupt+0xa0/0x20c
[  667.477738]  [c0002c0c] ret_from_except+0x0/0x18
[  667.482487]  [c0004314] default_idle+0x44/0x5c 
[  667.487059]  [c0004354] cpu_idle+0x28/0x44   

Other than that, m41t00_set_tlet() itself can sleep since it acquires a 
semaphore:

static void
m41t00_set_tlet(ulong arg)
{
        struct rtc_time tm;
        ulong   nowtime = *(ulong *)arg;
...
        down(&m41t00_mutex);


The following patch changes the post-processing of the i2c transfer to 
task context via schedule_work() which fixes the problem.

Signed-off-by: Marcelo Tosatti <marcelo.tosatti at cyclades.com>
Signed-off-by: Helio Fujimoto <Helio.Fujimoto at cyclades.com>

--- a/drivers/i2c/chips/m41t00.c.orig	2006-01-18 09:43:48.000000000 -0200
+++ b/drivers/i2c/chips/m41t00.c	2006-01-18 09:45:59.000000000 -0200
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
@@ -146,7 +147,7 @@
 
 static ulong	new_time;
 
-DECLARE_TASKLET_DISABLED(m41t00_tasklet, m41t00_set_tlet, (ulong)&new_time);
+DECLARE_WORK(m41t00_work, m41t00_set_tlet, (ulong)&new_time);
 
 int
 m41t00_set_rtc_time(ulong nowtime)
@@ -154,7 +155,7 @@
 	new_time = nowtime;
 
 	if (in_interrupt())
-		tasklet_schedule(&m41t00_tasklet);
+		schedule_work(&m41t00_work);
 	else
 		m41t00_set_tlet((ulong)&new_time);
 


