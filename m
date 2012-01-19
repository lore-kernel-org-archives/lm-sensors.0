From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:10 +0000
Subject: [lm-sensors] [PATCH 16/82] hwmon: (asus_atk0110) Fix multi-line comments
Message-Id: <1327017376-20466-17-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Luca Tettamanti <kronos.it@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/asus_atk0110.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index 4000fee..351d1f4 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -38,7 +38,8 @@ static const struct dmi_system_id __initconst atk_force_new_if[] = {
 	{ }
 };
 
-/* Minimum time between readings, enforced in order to avoid
+/*
+ * Minimum time between readings, enforced in order to avoid
  * hogging the CPU.
  */
 #define CACHE_TIME		HZ
@@ -161,7 +162,8 @@ struct atk_sensor_data {
 	char const *acpi_name;
 };
 
-/* Return buffer format:
+/*
+ * Return buffer format:
  * [0-3] "value" is valid flag
  * [4-7] value
  * [8- ] unknown stuff on newer mobos
@@ -310,7 +312,8 @@ static union acpi_object *atk_get_pack_member(struct atk_data *data,
 }
 
 
-/* New package format is:
+/*
+ * New package format is:
  * - flag (int)
  *	class - used for de-muxing the request to the correct GITn
  *	type (volt, temp, fan)
@@ -613,7 +616,8 @@ static int atk_read_value_new(struct atk_sensor_data *sensor, u64 *value)
 
 	buf = (struct atk_acpi_ret_buffer *)obj->buffer.pointer;
 	if (buf->flags = 0) {
-		/* The reading is not valid, possible causes:
+		/*
+		 * The reading is not valid, possible causes:
 		 * - sensor failure
 		 * - enumeration was FUBAR (and we didn't notice)
 		 */
@@ -1311,7 +1315,8 @@ static int atk_probe_if(struct atk_data *data)
 		dev_dbg(dev, "method " METHOD_WRITE " not found: %s\n",
 				 acpi_format_exception(status));
 
-	/* Check for hwmon methods: first check "old" style methods; note that
+	/*
+	 * Check for hwmon methods: first check "old" style methods; note that
 	 * both may be present: in this case we stick to the old interface;
 	 * analysis of multiple DSDTs indicates that when both interfaces
 	 * are present the new one (GGRP/GITM) is not functional.
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
