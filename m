From: "Zhang, Rui" <rui.zhang@intel.com>
Date: Thu, 10 Apr 2008 08:20:23 +0000
Subject: [lm-sensors] [PATCH 6/6] ACPI:  update thermal temperature
Message-Id: <1207815623.27304.49.camel@acpi-hp-zz.sh.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>


Fix the problem that thermal_get_temp returns the cached value,
which causes the temperature in generic thermal never updates.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/drivers/acpi/thermal.c
=================================--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -884,10 +884,15 @@ static void acpi_thermal_check(void *dat
 static int thermal_get_temp(struct thermal_zone_device *thermal, char *buf)
 {
 	struct acpi_thermal *tz = thermal->devdata;
+	int result;
 
 	if (!tz)
 		return -EINVAL;
 
+	result = acpi_thermal_get_temperature(tz);
+	if (result)
+		return result;
+
 	return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(tz->temperature));
 }
 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
