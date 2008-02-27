From: "Zhang, Rui" <rui.zhang@intel.com>
Date: Wed, 27 Feb 2008 23:51:30 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] ACPI: show temperature in millidegree
Message-Id: <1204156290.10256.132.camel@acpi-hp-zz.sh.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1204072678.10256.112.camel@acpi-hp-zz.sh.intel.com>
	 <47C537E1.5090103@gmail.com>
In-Reply-To: <47C537E1.5090103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>


On Wed, 2008-02-27 at 18:13 +0800, Alexey Starikovskiy wrote:
> Rui,
> 
> As I remember, ACPI returns temperature in 10ths of degree. If you are
> going to report it in 1000ths of degree,
> there is no reason to round them to degree.
> 

Show the temperature in Millidegree Celsius.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/acpi/thermal.c
=================================--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -879,6 +879,8 @@ static void acpi_thermal_check(void *dat
 }
 
 /* sys I/F for generic thermal sysfs support */
+#define KELVIN_TO_MILLICELSIUS(t) (t * 100 - 273200)
+
 static int thermal_get_temp(struct thermal_zone_device *thermal, char *buf)
 {
 	struct acpi_thermal *tz = thermal->devdata;
@@ -886,7 +888,7 @@ static int thermal_get_temp(struct therm
 	if (!tz)
 		return -EINVAL;
 
-	return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(tz->temperature));
+	return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(tz->temperature));
 }
 
 static const char enabled[] = "kernel";
@@ -980,21 +982,21 @@ static int thermal_get_trip_temp(struct 
 
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
@@ -1002,7 +1004,7 @@ static int thermal_get_trip_temp(struct 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 		tz->trips.active[i].flags.valid; i++) {
 		if (!trip)
-			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
+			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
 					tz->trips.active[i].temperature));
 		trip--;
 	}



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
