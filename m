From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 06 Feb 2013 11:10:39 +0000
Subject: [lm-sensors] [PATCH v2 2/2] ab8500_btemp: export two symblols
Message-Id: <1360149039-7038-3-git-send-email-hongbo.zhang@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Export ab8500_btemp_get and ab8500_btemp_get_batctrl_temp, thus the ab8500
hwmon driver can be compiled as module.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
---
 drivers/power/ab8500_btemp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index 20e2a7d..852f14a8 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -123,6 +123,7 @@ struct ab8500_btemp *ab8500_btemp_get(void)
 
 	return btemp;
 }
+EXPORT_SYMBOL(ab8500_btemp_get);
 
 /**
  * ab8500_btemp_batctrl_volt_to_res() - convert batctrl voltage to resistance
@@ -774,6 +775,7 @@ int ab8500_btemp_get_batctrl_temp(struct ab8500_btemp *btemp)
 {
 	return btemp->bat_temp * 1000;
 }
+EXPORT_SYMBOL(ab8500_btemp_get_batctrl_temp);
 
 /**
  * ab8500_btemp_get_property() - get the btemp properties
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
