From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Jan 2012 17:27:53 +0000
Subject: [lm-sensors] [PATCH] sensors: Display both instantaneous and
Message-Id: <1326130073-4791-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some sensor chips report both instantaneous and average power.
Add support to display both.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 prog/sensors/chips.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/prog/sensors/chips.c b/prog/sensors/chips.c
index b70b859..1390b3f 100644
--- a/prog/sensors/chips.c
+++ b/prog/sensors/chips.c
@@ -505,6 +505,11 @@ static const struct sensor_subfeature_list power_common_sensors[] = {
 static const struct sensor_subfeature_list power_inst_sensors[] = {
 	{ SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, NULL, 0, "lowest" },
 	{ SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, NULL, 0, "highest" },
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST, NULL, 0, "avg lowest" },
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST, NULL, 0, "avg highest" },
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL, NULL, 0,
+		"interval" },
 	{ -1, NULL, 0, NULL }
 };
 
@@ -516,11 +521,9 @@ static const struct sensor_subfeature_list power_avg_sensors[] = {
 	{ -1, NULL, 0, NULL }
 };
 
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
 #define NUM_POWER_ALARMS	4
 #define NUM_POWER_SENSORS	(ARRAY_SIZE(power_common_sensors) \
-				 + MAX(ARRAY_SIZE(power_inst_sensors), \
-				       ARRAY_SIZE(power_avg_sensors)) \
+				 + ARRAY_SIZE(power_inst_sensors) \
 				 - NUM_POWER_ALARMS - 2)
 
 static void print_chip_power(const sensors_chip_name *name,
@@ -546,9 +549,13 @@ static void print_chip_power(const sensors_chip_name *name,
 
 	sensor_count = alarm_count = 0;
 
-	/* Power sensors come in 2 flavors: instantaneous and averaged.
-	   To keep things simple, we assume that each sensor only implements
-	   one flavor. */
+	/*
+	 * Power sensors come in 2 flavors: instantaneous and averaged.
+	 * Most devices only support one flavor, so we try to display the
+	 * average power if the instantaneous power attribute does not exist.
+	 * If both instantaneous power and average power are supported,
+	 * average power is displayed as limit.
+	 */
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_POWER_INPUT);
 	get_sensor_limit_data(name, feature,
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
