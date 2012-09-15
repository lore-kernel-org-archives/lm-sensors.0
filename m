From: Parag Warudkar <parag.lkml@gmail.com>
Date: Sat, 15 Sep 2012 22:42:30 +0000
Subject: [lm-sensors] [PATCH] applesmc: Bump max wait and rearrange udelay
Message-Id: <alpine.DEB.2.02.1209151834120.2271@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: rydberg@euromail.se, khali@linux-fr.org, linux@roeck-us.net

I have been getting a steady stream of wait_read timeouts on my 2010 MBP.

After playing around with various values of APPLESMC_MAX_WAIT a value of 
0x10000 reduces the wait_read failures to zero under most normal workloads 
- with and without AC power plugged in, at idle and and at make -j4 loads.

While there I noticed we don't really need to udelay before first inb() - 
so I moved it down to after first and subsequent failures.

Been running this for couple days without any issues.

Signed-off-by: Parag Warudkar <parag.lkml@gmail.com>

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 2827088..46cb458 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -56,7 +56,7 @@
 /* wait up to 32 ms for a status change. */
 #define APPLESMC_MIN_WAIT	0x0010
 #define APPLESMC_RETRY_WAIT	0x0100
-#define APPLESMC_MAX_WAIT	0x8000
+#define APPLESMC_MAX_WAIT	0x10000
 
 #define APPLESMC_READ_CMD	0x10
 #define APPLESMC_WRITE_CMD	0x11
@@ -170,11 +170,11 @@ static int wait_read(void)
 	u8 status;
 	int us;
 	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
-		udelay(us);
 		status = inb(APPLESMC_CMD_PORT);
 		/* read: wait for smc to settle */
 		if (status & 0x01)
 			return 0;
+		udelay(us);
 	}
 
 	pr_warn("wait_read() fail: 0x%02x\n", status);
@@ -192,11 +192,12 @@ static int send_byte(u8 cmd, u16 port)
 
 	outb(cmd, port);
 	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
-		udelay(us);
 		status = inb(APPLESMC_CMD_PORT);
 		/* write: wait for smc to settle */
-		if (status & 0x02)
+		if (status & 0x02) {
+			udelay(us);
 			continue;
+		}
 		/* ready: cmd accepted, return */
 		if (status & 0x04)
 			return 0;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
