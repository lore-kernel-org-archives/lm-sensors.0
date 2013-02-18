From: Wei Ni <wni@nvidia.com>
Date: Mon, 18 Feb 2013 11:30:27 +0000
Subject: [lm-sensors] [RFC PATCH 5/9] Thermal: Support using dt node to get sensor
Message-Id: <1361187031-3679-6-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Add functions to support using dt node with args to get sensor.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/thermal_sys.c |   30 ++++++++++++++++++++++++++++++
 include/linux/thermal.h       |    9 +++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index e284b67..b5bedab 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -2183,6 +2183,28 @@ struct thermal_sensor *get_sensor_by_name(const char *name)
 }
 EXPORT_SYMBOL(get_sensor_by_name);
 
+struct thermal_sensor *get_sensor_by_node(struct node_args *np_args)
+{
+	struct thermal_sensor *pos;
+	struct thermal_sensor *ts = NULL;
+	struct node_args *args;
+
+	mutex_lock(&sensor_list_lock);
+	for_each_thermal_sensor(pos) {
+		args = &pos->np_args;
+		if (args->np) {
+			if ((args->np = np_args->np) &&
+			   (args->index = np_args->index)) {
+				ts = pos;
+				break;
+			}
+		}
+	}
+	mutex_unlock(&sensor_list_lock);
+	return ts;
+}
+EXPORT_SYMBOL(get_sensor_by_node);
+
 static int create_map_attrs(struct thermal_zone *tz, int indx)
 {
 	int ret, i;
@@ -2368,6 +2390,7 @@ EXPORT_SYMBOL(add_sensor_trip_info);
  * @devdata:	private device data
  */
 struct thermal_sensor *thermal_sensor_register(const char *name, int count,
+			struct node_args *np_args,
 			struct thermal_sensor_ops *ops, void *devdata)
 {
 	struct thermal_sensor *ts;
@@ -2412,6 +2435,13 @@ struct thermal_sensor *thermal_sensor_register(const char *name, int count,
 			goto exit_temp;
 	}
 
+	if (np_args) {
+		ts->np_args.np = np_args->np;
+		ts->np_args.index = np_args->index;
+	} else {
+		ts->np_args.np = NULL;
+	}
+
 	/* Add this sensor to the global list of sensors */
 	mutex_lock(&sensor_list_lock);
 	list_add_tail(&ts->node, &thermal_sensor_list);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 4389599..b560ffa 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -113,6 +113,12 @@ enum {
 };
 #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
 
+/* support to parse node with args to get sensor or cooling device */
+struct node_args {
+	struct device_node *np;
+	int index;
+};
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
@@ -223,6 +229,7 @@ struct thermal_sensor {
 	void *devdata;
 	struct idr idr;
 	struct device device;
+	struct node_args np_args;
 	struct list_head node;
 	struct thermal_sensor_ops *ops;
 	struct thermal_attr *thresh_attrs;
@@ -350,6 +357,7 @@ int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
 
 struct thermal_sensor *thermal_sensor_register(const char *, int,
+				struct node_args *,
 				struct thermal_sensor_ops *, void *);
 void thermal_sensor_unregister(struct thermal_sensor *);
 
@@ -357,6 +365,7 @@ struct thermal_zone *create_thermal_zone(const char *, void *);
 void remove_thermal_zone(struct thermal_zone *);
 int add_sensor_to_zone(struct thermal_zone *, struct thermal_sensor *);
 struct thermal_sensor *get_sensor_by_name(const char *);
+struct thermal_sensor *get_sensor_by_node(struct node_args *);
 
 int add_cdev_to_zone(struct thermal_zone *, struct thermal_cooling_device *);
 struct thermal_cooling_device *get_cdev_by_name(const char *);
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
