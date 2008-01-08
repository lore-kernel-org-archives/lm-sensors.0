From: Grant Coady <grant_lkml@dodo.com.au>
Date: Tue, 08 Jan 2008 20:51:02 +0000
Subject: Re: [lm-sensors] hwmon: (adm9240) Add individual alarm files
Message-Id: <3do7o3h8926tcicjfs4fmv58901hjtg0oh@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106154919.1290ac85@hyperion.delvare>
In-Reply-To: <20080106154919.1290ac85@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 6 Jan 2008 15:49:19 +0100, Jean Delvare <khali@linux-fr.org> wrote:

>The new libsensors needs these individual alarm files.
>
>Signed-off-by: Jean Delvare <khali@linux-fr.org>
>Cc: Grant Coady <gcoady.lk@gmail.com>
>---
>Grant, could you please test and/or review this patch?

Tested okay here.  Do you need a signed off line?  Just in case :)

Signed-off-by: Grant Coady <gcoady.lk@gmail.com>
>
> drivers/hwmon/adm9240.c |   26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)
>
>--- linux-2.6.24-rc6.orig/drivers/hwmon/adm9240.c	2007-12-26 14:39:06.000000000 +0100
>+++ linux-2.6.24-rc6/drivers/hwmon/adm9240.c	2008-01-02 10:46:33.000000000 +0100
>@@ -414,6 +414,23 @@ static ssize_t show_alarms(struct device
> }
> static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> 
>+static ssize_t show_alarm(struct device *dev,
>+		struct device_attribute *attr, char *buf)
>+{
>+	int bitnr = to_sensor_dev_attr(attr)->index;
>+	struct adm9240_data *data = adm9240_update_device(dev);
>+	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
>+}
>+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
>+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
>+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
>+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
>+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
>+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9);
>+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
>+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
>+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
>+
> /* vid */
> static ssize_t show_vid(struct device *dev,
> 		struct device_attribute *attr, char *buf)
>@@ -468,30 +485,39 @@ static struct attribute *adm9240_attribu
> 	&sensor_dev_attr_in0_input.dev_attr.attr,
> 	&sensor_dev_attr_in0_min.dev_attr.attr,
> 	&sensor_dev_attr_in0_max.dev_attr.attr,
>+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
> 	&sensor_dev_attr_in1_input.dev_attr.attr,
> 	&sensor_dev_attr_in1_min.dev_attr.attr,
> 	&sensor_dev_attr_in1_max.dev_attr.attr,
>+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
> 	&sensor_dev_attr_in2_input.dev_attr.attr,
> 	&sensor_dev_attr_in2_min.dev_attr.attr,
> 	&sensor_dev_attr_in2_max.dev_attr.attr,
>+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
> 	&sensor_dev_attr_in3_input.dev_attr.attr,
> 	&sensor_dev_attr_in3_min.dev_attr.attr,
> 	&sensor_dev_attr_in3_max.dev_attr.attr,
>+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
> 	&sensor_dev_attr_in4_input.dev_attr.attr,
> 	&sensor_dev_attr_in4_min.dev_attr.attr,
> 	&sensor_dev_attr_in4_max.dev_attr.attr,
>+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
> 	&sensor_dev_attr_in5_input.dev_attr.attr,
> 	&sensor_dev_attr_in5_min.dev_attr.attr,
> 	&sensor_dev_attr_in5_max.dev_attr.attr,
>+	&sensor_dev_attr_in5_alarm.dev_attr.attr,
> 	&dev_attr_temp1_input.attr,
> 	&sensor_dev_attr_temp1_max.dev_attr.attr,
> 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
> 	&sensor_dev_attr_fan1_input.dev_attr.attr,
> 	&sensor_dev_attr_fan1_div.dev_attr.attr,
> 	&sensor_dev_attr_fan1_min.dev_attr.attr,
>+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
> 	&sensor_dev_attr_fan2_input.dev_attr.attr,
> 	&sensor_dev_attr_fan2_div.dev_attr.attr,
> 	&sensor_dev_attr_fan2_min.dev_attr.attr,
>+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
> 	&dev_attr_alarms.attr,
> 	&dev_attr_aout_output.attr,
> 	&dev_attr_chassis_clear.attr,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
