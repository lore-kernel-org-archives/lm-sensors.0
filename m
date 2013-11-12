From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Tue, 12 Nov 2013 19:46:03 +0000
Subject: [lm-sensors] [PATCHv5 01/20] thermal: allow registering without .get_temp
Message-Id: <1384285582-16933-2-git-send-email-eduardo.valentin@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com
Cc: wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

This patch changes the thermal core driver to allow
registration of thermal zones without the .get_temp callback.

The idea behind this change is to allow lazy registration
of sensor callbacks.

The thermal zone will be disabled whenever the ops
does not contain a .get_temp callback. The sysfs interface
will be returning -EINVAL on any temperature read operation.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/thermal_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 03a5671..f4c9021 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -403,7 +403,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
 	enum thermal_trip_type type;
 #endif
 
-	if (!tz || IS_ERR(tz))
+	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
 		goto exit;
 
 	mutex_lock(&tz->lock);
@@ -456,6 +456,9 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 {
 	int count;
 
+	if (!tz->ops->get_temp)
+		return;
+
 	update_temperature(tz);
 
 	for (count = 0; count < tz->trips; count++)
@@ -1386,7 +1389,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips)
 		return ERR_PTR(-EINVAL);
 
-	if (!ops || !ops->get_temp)
+	if (!ops)
 		return ERR_PTR(-EINVAL);
 
 	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
@@ -1490,6 +1493,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
 
+	if (!tz->ops->get_temp)
+		thermal_zone_device_set_polling(tz, 0);
+
 	thermal_zone_device_update(tz);
 
 	if (!result)
-- 
1.8.2.1.342.gfa7285d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
