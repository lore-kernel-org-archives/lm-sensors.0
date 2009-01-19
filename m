From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 19 Jan 2009 20:13:23 +0000
Subject: [lm-sensors] [PATCH] hwmon: (f71882fg) Hide misleading error message
Message-Id: <20090119211323.02f4df9c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: (f71882fg) Hide misleading error message

If the F71882FG chip is at address 0x4e, then the probe at 0x2e will
fail with the following message in the logs:
f71882fg: Not a Fintek device

This is misleading because there is a Fintek device, just at a
different address. So I propose to degrade this message to a debug
message.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.29-rc2.orig/drivers/hwmon/f71882fg.c	2009-01-11 10:57:18.000000000 +0100
+++ linux-2.6.29-rc2/drivers/hwmon/f71882fg.c	2009-01-19 20:11:16.000000000 +0100
@@ -1872,7 +1872,7 @@ static int __init f71882fg_find(int sioa
 
 	devid = superio_inw(sioaddr, SIO_REG_MANID);
 	if (devid != SIO_FINTEK_ID) {
-		printk(KERN_INFO DRVNAME ": Not a Fintek device\n");
+		pr_debug(DRVNAME ": Not a Fintek device\n");
 		goto exit;
 	}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
