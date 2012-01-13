From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Jan 2012 16:32:22 +0000
Subject: [lm-sensors] [PATCH] sensors: Fix power interval output
Message-Id: <1326472342-3345-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Power interval is measured in seconds, not Watt.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Untested. Maybe a bit kludgy but should work.

 prog/sensors/chips.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/prog/sensors/chips.c b/prog/sensors/chips.c
index 677a617..fde33f6 100644
--- a/prog/sensors/chips.c
+++ b/prog/sensors/chips.c
@@ -574,11 +574,25 @@ static void print_chip_power(const sensors_chip_name *name,
 	} else
 		printf("     N/A  ");
 
-	for (i = 0; i < sensor_count; i++)
-		scale_value(&sensors[i].value, &sensors[i].unit);
-
+	for (i = 0; i < sensor_count; i++) {
+	    	/*
+		 * Unit is W and needs to be scaled for all attributes except
+		 * interval, which does not need to be scaled and is reported in
+		 * seconds.
+		 */
+	    	if (strcmp(sensors[i].name, "interval")) {
+		    	char *tmpstr;
+			
+			tmpstr = alloca(4);
+			scale_value(&sensors[i].value, &unit);
+			snprintf(tmpstr, 4, "%sW", unit);
+			sensors[i].unit = tmpstr;
+		} else {
+			sensors[i].unit = "s";
+		}
+	}
 	print_limits(sensors, sensor_count, alarms, alarm_count,
-		     label_size, "%s = %6.2f %sW");
+		     label_size, "%s = %6.2f %s");
 
 	printf("\n");
 }
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
