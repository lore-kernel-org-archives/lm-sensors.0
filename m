From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 12:37:54 +0000
Subject: [lm-sensors] [PATCH 10/14] it87: Overwrite broken default limits
Message-Id: <20060828143754.a55b6cb6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-it87-sane-limit-defaults.patch

it87: Overwrite broken default limits

Some IT8716F chips where seen with unreasonable defaults for low
voltage and high temperature limits. Overwrite them with sane defaults
so as to not generate meaningless alarms.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/it87.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- linux-2.6.18-rc5.orig/drivers/hwmon/it87.c	2006-08-28 10:21:48.000000000 +0200
+++ linux-2.6.18-rc5/drivers/hwmon/it87.c	2006-08-28 14:36:52.000000000 +0200
@@ -1201,6 +1201,22 @@
 		data->manual_pwm_ctl[i] = 0xff;
 	}
 
+	/* Some chips seem to have default value 0xff for all limit
+	 * registers. For low voltage limits it makes no sense and triggers
+	 * alarms, so change to 0 instead. For high temperature limits, it
+	 * means -1 degree C, which surprisingly doesn't trigger an alarm,
+	 * but is still confusing, so change to 127 degrees C. */
+	for (i = 0; i < 8; i++) {
+		tmp = it87_read_value(client, IT87_REG_VIN_MIN(i));
+		if (tmp = 0xff)
+			it87_write_value(client, IT87_REG_VIN_MIN(i), 0);
+	}
+	for (i = 0; i < 3; i++) {
+		tmp = it87_read_value(client, IT87_REG_TEMP_HIGH(i));
+		if (tmp = 0xff)
+			it87_write_value(client, IT87_REG_TEMP_HIGH(i), 127);
+	}
+
 	/* Check if temperature channnels are reset manually or by some reason */
 	tmp = it87_read_value(client, IT87_REG_TEMP_ENABLE);
 	if ((tmp & 0x3f) = 0) {

-- 
Jean Delvare

