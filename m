From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 14 Nov 2005 23:08:21 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix missing boundary check when setting
Message-Id: <20051114230838.37a9f2d8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This one is for 2.6.15-rc2, and a candidate for -stable.

Thanks.

* * * * *

From: Yuan Mu <Ymu@winbond.com.tw>
Content-Disposition: inline; filename=hwmon-w83627hf-missing-in0-limit-check.patch

Add SENSORS_LIMIT in store VCore limit functions. This fixes a potential
u8 overflow on out-of-range user input.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---

 drivers/hwmon/w83627hf.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc1.orig/drivers/hwmon/w83627hf.c	2005-11-12 15:49:51.000000000 +0100
+++ linux-2.6.15-rc1/drivers/hwmon/w83627hf.c	2005-11-12 22:10:04.000000000 +0100
@@ -456,7 +456,9 @@
 		(w83627thf = data->type || w83637hf = data->type))
 
 		/* use VRM9 calculation */
-		data->in_min[0] = (u8)(((val * 100) - 70000 + 244) / 488);
+		data->in_min[0] +			SENSORS_LIMIT(((val * 100) - 70000 + 244) / 488, 0,
+					255);
 	else
 		/* use VRM8 (standard) calculation */
 		data->in_min[0] = IN_TO_REG(val);
@@ -481,7 +483,9 @@
 		(w83627thf = data->type || w83637hf = data->type))
 		
 		/* use VRM9 calculation */
-		data->in_max[0] = (u8)(((val * 100) - 70000 + 244) / 488);
+		data->in_max[0] +			SENSORS_LIMIT(((val * 100) - 70000 + 244) / 488, 0,
+					255);
 	else
 		/* use VRM8 (standard) calculation */
 		data->in_max[0] = IN_TO_REG(val);


-- 
Jean Delvare
