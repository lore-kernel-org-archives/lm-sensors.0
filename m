From: Lukasz Majewski <l.majewski@samsung.com>
Date: Mon, 22 Dec 2014 16:27:41 +0000
Subject: [lm-sensors] [PATCH v2 1/8] thermal: Provide stub for thermal_of_cooling_device_register() function
Message-Id: <1419265668-32283-2-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1419265668-32283-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Odroid U3 fan can work without being registered as OF cooling device
(with CONFIG_THERMAL_OF disabled).
In this situation it can be controlled via PWM entry at
/sys/class/hwmon/hwmon0/pwm1.

Therefore, the thermal_of_cooling_device_register() function needs a stub
to allow clean compilation.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
---
 include/linux/thermal.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 2de3d9e..871123c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -328,6 +328,10 @@ thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
 				const struct thermal_zone_of_device_ops *ops);
 void thermal_zone_of_sensor_unregister(struct device *dev,
 				       struct thermal_zone_device *tz);
+struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np,
+				   char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *);
 #else
 static inline struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
@@ -342,6 +346,13 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 {
 }
 
+static inline struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np,
+				   char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops)
+{
+	return NULL;
+}
 #endif
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
@@ -357,9 +368,6 @@ void thermal_zone_device_update(struct thermal_zone_device *);
 
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 		const struct thermal_cooling_device_ops *);
-struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, char *, void *,
-				   const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp);
-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
