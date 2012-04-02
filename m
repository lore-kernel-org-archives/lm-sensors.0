From: Kyle McMartin <kyle@redhat.com>
Date: Mon, 02 Apr 2012 18:19:04 +0000
Subject: [lm-sensors] [PATCH 5/5] acpi_power_meter: clean up code around setup_attrs
Message-Id: <bb853f6e30c78b3e61173cd224856e52a13d6c00.1333390501.git.kyle@mcmartin.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Kyle McMartin <kyle@mcmartin.ca>

We don't need to duplicate if (res) checks if we're always running
one or the other.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 drivers/hwmon/acpi_power_meter.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 16ab439..ac0708f 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -695,21 +695,20 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
 			goto skip_unsafe_cap;
 		}
 
-		if (resource->caps.configurable_cap) {
+		if (resource->caps.configurable_cap)
 			res = register_attrs(resource, rw_cap_attrs);
-			if (res)
-				goto error;
-		} else {
+		else
 			res = register_attrs(resource, ro_cap_attrs);
-			if (res)
-				goto error;
-		}
+
+		if (res)
+			goto error;
+
 		res = register_attrs(resource, misc_cap_attrs);
 		if (res)
 			goto error;
 	}
-skip_unsafe_cap:
 
+skip_unsafe_cap:
 	if (resource->caps.flags & POWER_METER_CAN_TRIP) {
 		res = register_attrs(resource, trip_attrs);
 		if (res)
-- 
1.7.7.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
