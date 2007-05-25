From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 May 2007 12:15:52 +0000
Subject: [lm-sensors] [PATCH] hwmon-vid: Don't spam the logs when VRM
Message-Id: <20070525141552.694337fc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If we cannot guess which VRM version the CPU uses, we set it to 0 and
log it. So we shouldn't spam the log each time vid_from_reg() is
later called with vrm 0.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Rudolf Marek <r.marek@assembler.cz>
---
Rudolf, is it OK with you? Please ack or nack.

 drivers/hwmon/hwmon-vid.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.22-rc2.orig/drivers/hwmon/hwmon-vid.c	2007-05-13 10:01:15.000000000 +0200
+++ linux-2.6.22-rc2/drivers/hwmon/hwmon-vid.c	2007-05-25 14:09:55.000000000 +0200
@@ -132,7 +132,9 @@ int vid_from_reg(int val, u8 vrm)
 		val &= 0x7f;
 		return(val > 0x77 ? 0 : (1500000 - (val * 12500) + 500) / 1000);
 	default:		/* report 0 for unknown */
-		printk(KERN_INFO "hwmon-vid: requested unknown VRM version\n");
+		if (vrm)
+			printk(KERN_WARNING "hwmon-vid: requested unknown "
+			       "VRM version (%u)\n", (unsigned int)vrm);
 		return 0;
 	}
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
