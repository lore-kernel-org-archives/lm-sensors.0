From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 May 2011 10:01:54 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Fix section mismatch
Message-Id: <20110526120154.2b7b6c4e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

chk_ucode_version() is only called from coretemp_probe() which is
__devinit, so it can be marked __devinit too.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Durgadoss R <durgadoss.r@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/coretemp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.40-rc0.orig/drivers/hwmon/coretemp.c	2011-05-26 10:06:59.000000000 +0200
+++ linux-2.6.40-rc0/drivers/hwmon/coretemp.c	2011-05-26 10:29:58.000000000 +0200
@@ -422,7 +422,7 @@ static void update_ttarget(__u8 cpu_mode
 	}
 }
 
-static int chk_ucode_version(struct platform_device *pdev)
+static int __devinit chk_ucode_version(struct platform_device *pdev)
 {
 	struct cpuinfo_x86 *c = &cpu_data(pdev->id);
 	int err;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
