From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 11 Sep 2008 00:03:27 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc6 2/6] hwmon/pc87360 separate
Message-Id: <20080910170327.a332ee30.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C79487.1010105@gmail.com>
In-Reply-To: <48C79487.1010105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 10 Sep 2008 03:47:32 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> +static ssize_t show_in_min_alarm(struct device *dev, struct device_attribute
> +			     *devattr, char *buf)
> +{
> +	struct pc87360_data *data = pc87360_update_device(dev);
> +	unsigned nr = to_sensor_dev_attr(devattr)->index;
> +
> +	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MIN));
> +}
> +static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute
> +			     *devattr, char *buf)

coding-style nit: it is highly unusual to put a newline between the
argument's type and its identifier.

This:

--- a/drivers/hwmon/pc87360.c~hwmon-pc87360-separate-alarm-files-add-in-min-max-alarms-cleanup
+++ a/drivers/hwmon/pc87360.c
@@ -498,16 +498,16 @@ static struct sensor_device_attribute in
    register (sec 11.5.12), not the vin event status registers (sec
    11.5.2) that (legacy) show_in_alarm() resds (via data->in_alarms) */
 
-static ssize_t show_in_min_alarm(struct device *dev, struct device_attribute
-			     *devattr, char *buf)
+static ssize_t show_in_min_alarm(struct device *dev,
+			struct device_attribute *devattr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	unsigned nr = to_sensor_dev_attr(devattr)->index;
 
 	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MIN));
 }
-static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute
-			     *devattr, char *buf)
+static ssize_t show_in_max_alarm(struct device *dev,
+			struct device_attribute *devattr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	unsigned nr = to_sensor_dev_attr(devattr)->index;
_

is not really any better-looking, but it's more conventional.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
