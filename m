From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 10 Sep 2008 09:47:32 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc6 2/6] hwmon/pc87360 separate
Message-Id: <48C797B4.4030707@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090904080001010601050102"
List-Id: <lm-sensors.vger.kernel.org>
References: <48C79487.1010105@gmail.com>
In-Reply-To: <48C79487.1010105@gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090904080001010601050102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jim Cromie wrote:
>
> inlined & attached
>
now attached.  sorry.

> From 92e4abc519b51ed3c80ec69854bdb6fc35c41e4b Mon Sep 17 00:00:00 2001
> From: Jim Cromie <jim.cromie@gmail.com>
> Date: Sat, 28 Jun 2008 12:25:52 -0600
> Subject: [PATCH] hwmon/pc87360 separate alarm files - add 
> in-min/max-alarms
>
> Adds vin-min/max-alarm callbacks, sensor-device-attribute
> declarations, and refs to those new decls in the macro used to
> initialize the vin_group (of sysfs files)
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> drivers/hwmon/pc87360.c |   52 
> ++++++++++++++++++++++++++++++++++++++++++++++-
> 1 files changed, 51 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
> index 1043b11..3b6ea7b 100644
> --- a/drivers/hwmon/pc87360.c
> +++ b/drivers/hwmon/pc87360.c
> @@ -494,11 +494,61 @@ static struct sensor_device_attribute in_max[] = {
> #define CHAN_ALM_MAX    0x04    /* max limit exceeded */
> #define TEMP_ALM_CRIT    0x08    /* temp crit exceeded (temp only) */
>
> +/* show_in_min/max_alarm() reads data from the per-channel status
> +   register (sec 11.5.12), not the vin event status registers (sec
> +   11.5.2) that (legacy) show_in_alarm() resds (via data->in_alarms) */
> +
> +static ssize_t show_in_min_alarm(struct device *dev, struct 
> device_attribute
> +                 *devattr, char *buf)
> +{
> +    struct pc87360_data *data = pc87360_update_device(dev);
> +    unsigned nr = to_sensor_dev_attr(devattr)->index;
> +
> +    return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MIN));
> +}
> +static ssize_t show_in_max_alarm(struct device *dev, struct 
> device_attribute
> +                 *devattr, char *buf)
> +{
> +    struct pc87360_data *data = pc87360_update_device(dev);
> +    unsigned nr = to_sensor_dev_attr(devattr)->index;
> +
> +    return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MAX));
> +}
> +
> +static struct sensor_device_attribute in_min_alarm[] = {
> +    SENSOR_ATTR(in0_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 0),
> +    SENSOR_ATTR(in1_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 1),
> +    SENSOR_ATTR(in2_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 2),
> +    SENSOR_ATTR(in3_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 3),
> +    SENSOR_ATTR(in4_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 4),
> +    SENSOR_ATTR(in5_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 5),
> +    SENSOR_ATTR(in6_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 6),
> +    SENSOR_ATTR(in7_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 7),
> +    SENSOR_ATTR(in8_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 8),
> +    SENSOR_ATTR(in9_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 9),
> +    SENSOR_ATTR(in10_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 10),
> +};
> +static struct sensor_device_attribute in_max_alarm[] = {
> +    SENSOR_ATTR(in0_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 0),
> +    SENSOR_ATTR(in1_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 1),
> +    SENSOR_ATTR(in2_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 2),
> +    SENSOR_ATTR(in3_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 3),
> +    SENSOR_ATTR(in4_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 4),
> +    SENSOR_ATTR(in5_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 5),
> +    SENSOR_ATTR(in6_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 6),
> +    SENSOR_ATTR(in7_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 7),
> +    SENSOR_ATTR(in8_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 8),
> +    SENSOR_ATTR(in9_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 9),
> +    SENSOR_ATTR(in10_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 10),
> +};
> +
> #define VIN_UNIT_ATTRS(X) \
>     &in_input[X].dev_attr.attr,    \
>     &in_status[X].dev_attr.attr,    \
>     &in_min[X].dev_attr.attr,    \
> -    &in_max[X].dev_attr.attr
> +    &in_max[X].dev_attr.attr,    \
> +    &in_min_alarm[X].dev_attr.attr,    \
> +    &in_max_alarm[X].dev_attr.attr
>
> static ssize_t show_vid(struct device *dev, struct device_attribute 
> *attr, char *buf)
> {


--------------090904080001010601050102
Content-Type: text/x-patch;
	name="0002-hwmon-pc87360-separate-alarm-files-add-in-min-max.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0002-hwmon-pc87360-separate-alarm-files-add-in-min-max.patch"

From 92e4abc519b51ed3c80ec69854bdb6fc35c41e4b Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 12:25:52 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - add in-min/max-alarms

Adds vin-min/max-alarm callbacks, sensor-device-attribute
declarations, and refs to those new decls in the macro used to
initialize the vin_group (of sysfs files)

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 1043b11..3b6ea7b 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -494,11 +494,61 @@ static struct sensor_device_attribute in_max[] = {
 #define CHAN_ALM_MAX	0x04	/* max limit exceeded */
 #define TEMP_ALM_CRIT	0x08	/* temp crit exceeded (temp only) */
 
+/* show_in_min/max_alarm() reads data from the per-channel status
+   register (sec 11.5.12), not the vin event status registers (sec
+   11.5.2) that (legacy) show_in_alarm() resds (via data->in_alarms) */
+
+static ssize_t show_in_min_alarm(struct device *dev, struct device_attribute
+			     *devattr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MIN));
+}
+static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute
+			     *devattr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MAX));
+}
+
+static struct sensor_device_attribute in_min_alarm[] = {
+	SENSOR_ATTR(in0_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 0),
+	SENSOR_ATTR(in1_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 1),
+	SENSOR_ATTR(in2_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 2),
+	SENSOR_ATTR(in3_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 3),
+	SENSOR_ATTR(in4_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 4),
+	SENSOR_ATTR(in5_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 5),
+	SENSOR_ATTR(in6_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 6),
+	SENSOR_ATTR(in7_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 7),
+	SENSOR_ATTR(in8_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 8),
+	SENSOR_ATTR(in9_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 9),
+	SENSOR_ATTR(in10_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 10),
+};
+static struct sensor_device_attribute in_max_alarm[] = {
+	SENSOR_ATTR(in0_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 0),
+	SENSOR_ATTR(in1_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 1),
+	SENSOR_ATTR(in2_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 2),
+	SENSOR_ATTR(in3_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 3),
+	SENSOR_ATTR(in4_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 4),
+	SENSOR_ATTR(in5_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 5),
+	SENSOR_ATTR(in6_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 6),
+	SENSOR_ATTR(in7_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 7),
+	SENSOR_ATTR(in8_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 8),
+	SENSOR_ATTR(in9_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 9),
+	SENSOR_ATTR(in10_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 10),
+};
+
 #define VIN_UNIT_ATTRS(X) \
 	&in_input[X].dev_attr.attr,	\
 	&in_status[X].dev_attr.attr,	\
 	&in_min[X].dev_attr.attr,	\
-	&in_max[X].dev_attr.attr
+	&in_max[X].dev_attr.attr,	\
+	&in_min_alarm[X].dev_attr.attr,	\
+	&in_max_alarm[X].dev_attr.attr
 
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
-- 
1.5.5.1


--------------090904080001010601050102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090904080001010601050102--
