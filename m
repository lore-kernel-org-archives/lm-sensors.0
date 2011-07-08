From: Sanjeev Premi <premi@ti.com>
Date: Fri, 08 Jul 2011 13:09:59 +0000
Subject: [lm-sensors] [PATCH] mfd: twl4030: Fix mismatch in mutex lock-unlock
Message-Id: <1310129879-4748-1-git-send-email-premi@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>, Keerthy <j-keerthy@ti.com>

A mutex is locked on entry into twl4030_madc_conversion().
Immediate return on some error conditions leaves the
mutex locked.

This patch ensures that mutex is always unlocked before
leaving the function.

Signed-off-by: Sanjeev Premi <premi@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
---

 Compile tested only.


 drivers/mfd/twl4030-madc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
index 3941ddc..b5d598c 100644
--- a/drivers/mfd/twl4030-madc.c
+++ b/drivers/mfd/twl4030-madc.c
@@ -530,13 +530,13 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
 	if (ret) {
 		dev_err(twl4030_madc->dev,
 			"unable to write sel register 0x%X\n", method->sel + 1);
-		return ret;
+		goto out;
 	}
 	ret = twl_i2c_write_u8(TWL4030_MODULE_MADC, ch_lsb, method->sel);
 	if (ret) {
 		dev_err(twl4030_madc->dev,
 			"unable to write sel register 0x%X\n", method->sel + 1);
-		return ret;
+		goto out;
 	}
 	/* Select averaging for all channels if do_avg is set */
 	if (req->do_avg) {
@@ -546,7 +546,7 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
 			dev_err(twl4030_madc->dev,
 				"unable to write avg register 0x%X\n",
 				method->avg + 1);
-			return ret;
+			goto out;
 		}
 		ret = twl_i2c_write_u8(TWL4030_MODULE_MADC,
 				       ch_lsb, method->avg);
@@ -554,7 +554,7 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
 			dev_err(twl4030_madc->dev,
 				"unable to write sel reg 0x%X\n",
 				method->sel + 1);
-			return ret;
+			goto out;
 		}
 	}
 	if (req->type = TWL4030_MADC_IRQ_ONESHOT && req->func_cb != NULL) {
-- 
1.7.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
