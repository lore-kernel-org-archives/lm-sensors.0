From: "Zhang, Rui" <rui.zhang@intel.com>
Date: Wed, 02 Apr 2008 08:09:12 +0000
Subject: [lm-sensors] [PATCH 3/3] thermal: update documentation
Message-Id: <1207123752.27304.9.camel@acpi-hp-zz.sh.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Hans de Goede <j.w.r.degoede@hhs.nl>


Update the documentation for the thermal driver hwmon sys I/F.

Change the ACPI thermal zone type to be consistent with hwmon.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/thermal/sysfs-api.txt |   31 +++++++++++++++++++++++++------
 drivers/acpi/thermal.c              |    2 +-
 2 files changed, 26 insertions(+), 7 deletions(-)

Index: linux-2.6/Documentation/thermal/sysfs-api.txt
=================================--- linux-2.6.orig/Documentation/thermal/sysfs-api.txt
+++ linux-2.6/Documentation/thermal/sysfs-api.txt
@@ -108,10 +108,11 @@ and throttle appropriate devices.
 RO	read only value
 RW	read/write value
 
-All thermal sysfs attributes will be represented under /sys/class/thermal
+Thermal sysfs attributes will be represented under /sys/class/thermal and
+/sys/class/hwmon.
 
 Thermal zone device sys I/F, created once it's registered:
-|thermal_zone[0-*]:
+/sys/class/thermal/thermal_zone[0-*]:
 	|-----type:			Type of the thermal zone
 	|-----temp:			Current temperature
 	|-----mode:			Working mode of the thermal zone
@@ -119,7 +120,7 @@ Thermal zone device sys I/F, created onc
 	|-----trip_point_[0-*]_type:	Trip point type
 
 Thermal cooling device sys I/F, created once it's registered:
-|cooling_device[0-*]:
+/sys/class/thermal/cooling_device[0-*]:
 	|-----type :			Type of the cooling device(processor/fan/...)
 	|-----max_state:		Maximum cooling state of the cooling device
 	|-----cur_state:		Current cooling state of the cooling device
@@ -130,10 +131,18 @@ They represent the relationship between 
 They are created/removed for each
 thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device successful execution.
 
-|thermal_zone[0-*]
+/sys/class/thermal/thermal_zone[0-*]
 	|-----cdev[0-*]:		The [0-*]th cooling device in the current thermal zone
 	|-----cdev[0-*]_trip_point:	Trip point that cdev[0-*] is associated with
 
+Besides the thermal zone device sys I/F and cooling device sys I/F,
+the generic thermal driver also creates a hwmon sys I/F for each _type_ of
+thermal zone device. E.g. one hwmon class device and the associated hwmon sys I/F
+for all the registered ACPI thermal zones.
+/sys/class/hwmon/hwmon[0-*]:
+	|-----name:			The type of the thermal zone devices.
+	|-----temp[1-*]_input:		The current temperature of thermal zone [1-*].
+	|-----temp[1-*]_critical:	The critical trip point of thermal zone [1-*].
 
 ***************************
 * Thermal zone attributes *
@@ -141,7 +150,10 @@ thermal_zone_bind_cooling_device/thermal
 
 type				Strings which represent the thermal zone type.
 				This is given by thermal zone driver as part of registration.
-				Eg: "ACPI thermal zone" indicates it's a ACPI thermal device
+				Eg: "acpitz" indicates it's an ACPI thermal device.
+				In order to keep it consistent with hwmon sys attribute,
+				this should be a short, lowercase string,
+				not containing spaces nor dashes.
 				RO
 				Required
 
@@ -218,7 +230,7 @@ the sys I/F structure will be built like
 /sys/class/thermal:
 
 |thermal_zone1:
-	|-----type:			ACPI thermal zone
+	|-----type:			acpitz
 	|-----temp:			37000
 	|-----mode:			kernel
 	|-----trip_point_0_temp:	100000
@@ -243,3 +255,10 @@ the sys I/F structure will be built like
 	|-----type:			Fan
 	|-----max_state:		2
 	|-----cur_state:		0
+
+/sys/class/hwmon:
+
+|hwmon0:
+	|-----name:			acpitz
+	|-----temp1_input:		37000
+	|-----temp1_crit:		100000
Index: linux-2.6/drivers/acpi/thermal.c
=================================--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -1123,7 +1123,7 @@ static int acpi_thermal_register_thermal
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 			tz->trips.active[i].flags.valid; i++, trips++);
-	tz->thermal_zone = thermal_zone_device_register("ACPI thermal zone",
+	tz->thermal_zone = thermal_zone_device_register("acpitz",
 					trips, tz, &acpi_thermal_zone_ops);
 	if (!tz->thermal_zone)
 		return -ENODEV;



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
