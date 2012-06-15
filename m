From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Jun 2012 12:43:53 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Drop needless initialization
Message-Id: <20120615144353.29025111@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The value is overridden a few lines later.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/coretemp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.5-rc2.orig/drivers/hwmon/coretemp.c	2012-06-15 14:26:40.000000000 +0200
+++ linux-3.5-rc2/drivers/hwmon/coretemp.c	2012-06-15 14:39:06.690271631 +0200
@@ -801,7 +801,7 @@ MODULE_DEVICE_TABLE(x86cpu, coretemp_ids
 
 static int __init coretemp_init(void)
 {
-	int i, err = -ENODEV;
+	int i, err;
 
 	/*
 	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
