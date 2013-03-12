From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Mar 2013 14:44:42 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon: (lm75) Per-chip configuration register initialization
Message-Id: <20130312154442.37fe765f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There is no standard for the configuration register bits of LM75-like
chips. We shouldn't blindly clear bits setting the resolution as they
are either unused or used for something else on some of the supported
chips.

So, switch to per-chip configuration initialization. This will allow
for better tuning later, for example using more resolution bits when
available.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm75.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

--- linux-3.9-rc2.orig/drivers/hwmon/lm75.c	2013-03-12 11:04:52.475912290 +0100
+++ linux-3.9-rc2/drivers/hwmon/lm75.c	2013-03-12 13:37:45.206041683 +0100
@@ -167,8 +167,28 @@ lm75_probe(struct i2c_client *client, co
 	 * Then tweak to be more precise when appropriate.
 	 */
 	set_mask = 0;
-	clr_mask = (1 << 0)			/* continuous conversions */
-		| (1 << 6) | (1 << 5);		/* 9-bit mode */
+	clr_mask = LM75_SHUTDOWN;		/* continuous conversions */
+
+	switch (id->driver_data) {
+	case adt75:
+		clr_mask |= 1 << 5;		/* not one-shot mode */
+		break;
+	case ds1775:
+	case ds75:
+	case stds75:
+		clr_mask |= 3 << 5;		/* 9-bit mode */
+		break;
+	case mcp980x:
+	case tmp100:
+	case tmp101:
+	case tmp105:
+	case tmp175:
+	case tmp275:
+	case tmp75:
+		clr_mask |= 3 << 5;		/* 9-bit mode */
+		clr_mask |= 1 << 7;		/* not one-shot mode */
+		break;
+	}
 
 	/* configure as specified */
 	status = lm75_read_value(client, LM75_REG_CONF);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
