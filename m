From: "Zhang, Rui" <rui.zhang@intel.com>
Date: Mon, 25 Feb 2008 21:31:46 +0000
Subject: [lm-sensors] [PATCH 2/2] ACPI: show temperature in millidegree
Message-Id: <1203975106.10256.83.camel@acpi-hp-zz.sh.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, Jean Delvare <khali@linux-fr.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>


Show the temperature in Millidegree Celsius.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: linux-2.6.25-rc2/drivers/acpi/thermal.c
=================================--- linux-2.6.25-rc2.orig/drivers/acpi/thermal.c	2008-02-25 22:43:29.000000000 -0500
+++ linux-2.6.25-rc2/drivers/acpi/thermal.c	2008-02-26 01:11:08.000000000 -0500
@@ -879,6 +879,8 @@
 }
 
 /* sys I/F for generic thermal sysfs support */
+#define KELVIN_TO_MILLICELSIUS(t) (KELVIN_TO_CELSIUS(t) * 1000)
+
 static int thermal_get_temp(struct thermal_zone_device *thermal, char *buf)
 {
 	struct acpi_thermal *tz = thermal->devdata;
@@ -886,7 +888,7 @@
 	if (!tz)
 		return -EINVAL;
 
-	return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(tz->temperature));
+	return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(tz->temperature));
 }
 
 static const char enabled[] = "kernel";
@@ -980,21 +982,21 @@
 
 	if (tz->trips.critical.flags.valid) {
 		if (!trip)
-			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
+			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
 				tz->trips.critical.temperature));
 		trip--;
 	}
 
 	if (tz->trips.hot.flags.valid) {
 		if (!trip)
-			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
+			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
 					tz->trips.hot.temperature));
 		trip--;
 	}
 
 	if (tz->trips.passive.flags.valid) {
 		if (!trip)
-			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
+			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
 					tz->trips.passive.temperature));
 		trip--;
 	}
@@ -1002,7 +1004,7 @@
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 		tz->trips.active[i].flags.valid; i++) {
 		if (!trip)
-			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
+			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
 					tz->trips.active[i].temperature));
 		trip--;
 	}
@@ -1121,7 +1123,7 @@
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 			tz->trips.active[i].flags.valid; i++, trips++);
-	tz->thermal_zone = thermal_zone_device_register("ACPI thermal zone",
+	tz->thermal_zone = thermal_zone_device_register("ACPI",
 					trips, tz, &acpi_thermal_zone_ops);
 	if (!tz->thermal_zone)
 		return -ENODEV;



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
