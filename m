From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Oct 2007 14:01:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/sis5595: Add individual alarm files
Message-Id: <20071012160141.01388818@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <470E6494.7000408@gmail.com>
In-Reply-To: <470E6494.7000408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Thu, 11 Oct 2007 19:59:48 +0200, Pinkel wrote:
> Add individual alarm files needed by the new libsensors.
> 
> Signed-off-by: Ivo Manca <pinkel@gmail.com>
> 
> ---
>  drivers/hwmon/sis5595.c |   32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.22.9.orig/drivers/hwmon/sis5595.c    2007-10-11 
> 19:38:11.000000000 +0200
> +++ linux-2.6.22.9/drivers/hwmon/sis5595.c    2007-10-11 
> 19:41:56.000000000 +0200
> @@ -62,6 +62,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
> +#include <linux/hwmon-sysfs.h>
>  #include <asm/io.h>
>  
>  
> @@ -473,26 +474,47 @@
>  }
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
>  
> +static ssize_t show_alarm(struct device *dev, struct device_attribute 
> *da, char *buf)
> +{
> +    struct sis5595_data *data = sis5595_update_device(dev);
> +    int nr = to_sensor_dev_attr(da)->index;
> +    return sprintf(buf, "%u\n", (data->alarms >> nr) & 1);
> +}
> +    static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
> +    static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
> +    static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
> +    static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
> +    static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 15);
> +    static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
> +    static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
> +    static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 15);

Your mailer destroyed the patch formatting :( Can you please fix it or
resend the patch as an attachment?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
