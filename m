From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Apr 2013 06:21:09 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Enable both AUXTIN and VIN3 on NCT6776
Message-Id: <1365229269-5036-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Per datasheet, VIN3 and AUXTIN share the same external pin. However, there
is no clean way to detect this condition. Furthermore, both are reported
by the BIOS on Supermicro C7H61. It may thus be possible that chip revisions
exist where both attributes are supported at the same time.
Better play safe and report both.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |   37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index d05a700..8d0e4c4 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -3721,43 +3721,6 @@ static int nct6775_probe(struct platform_device *pdev)
 	}
 #endif /* USE_ALTERNATE */
 
-	switch (data->kind) {
-	case nct6775:
-		break;
-	case nct6776:
-		/*
-		 * On NCT6776, AUXTIN and VIN3 pins are shared.
-		 * Only way to detect it is to check if AUXTIN is used
-		 * as a temperature source, and if that source is
-		 * enabled.
-		 *
-		 * If that is the case, disable in6, which reports VIN3.
-		 * Otherwise disable temp3.
-		 */
-		if (data->have_temp & (1 << 2)) {
-			u8 reg = nct6775_read_value(data,
-						    data->reg_temp_config[2]);
-			if (reg & 0x01)
-				data->have_temp &= ~(1 << 2);
-			else
-				data->have_in &= ~(1 << 6);
-		}
-		break;
-	case nct6779:
-		/*
-		 * Shared pins:
-		 *	VIN4 / AUXTIN0
-		 *	VIN5 / AUXTIN1
-		 *	VIN6 / AUXTIN2
-		 *	VIN7 / AUXTIN3
-		 *
-		 * There does not seem to be a clean way to detect if VINx or
-		 * AUXTINx is active, so for keep both sensor types enabled
-		 * for now.
-		 */
-		break;
-	}
-
 	/* Initialize the chip */
 	nct6775_init_device(data);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
