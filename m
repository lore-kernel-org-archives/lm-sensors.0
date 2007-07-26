From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 26 Jul 2007 01:19:22 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Update sensors periodically via
Message-Id: <191fb4ca0707251819u120e1682u675efaec60991461@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726010421.GM19586@tree.beaverton.ibm.com>
In-Reply-To: <20070726010421.GM19586@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

Why using a workqueue at all? Can't you just run a timer and do the
update when it expires and restart the timer?


...juerg


On 7/25/07, Darrick J. Wong <djwong@us.ibm.com> wrote:
> To avoid blocking for 1s in the sysfs read functions, make it so
> that adt7470 updates are done periodically with a timer instead
> of being called from the read functions directly.
>
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
>
>  drivers/hwmon/adt7470.c |   71 +++++++++++++++++++++++++++++++++++------------
>  1 files changed, 53 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index 75aee3b..bfb0072 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -28,6 +28,7 @@
>  #include <linux/mutex.h>
>  #include <linux/delay.h>
>  #include <linux/log2.h>
> +#include <linux/timer.h>
>
>  /* Addresses to scan */
>  static unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
> @@ -124,6 +125,8 @@ struct adt7470_data {
>         struct mutex            lock;
>         char                    valid;
>         unsigned long           last_updated;   /* In jiffies */
> +       struct timer_list       timer;
> +       struct work_struct      ref_work;
>
>         s8                      temp[ADT7470_TEMP_COUNT];
>         s8                      temp_min[ADT7470_TEMP_COUNT];
> @@ -184,10 +187,9 @@ static void adt7470_init_client(struct i2c_client *client)
>         }
>  }
>
> -static struct adt7470_data *adt7470_update_device(struct device *dev)
> +static void adt7470_update_data(struct adt7470_data *data)
>  {
> -       struct i2c_client *client = to_i2c_client(dev);
> -       struct adt7470_data *data = i2c_get_clientdata(client);
> +       struct i2c_client *client = &data->client;
>         u8 cfg;
>         int i;
>
> @@ -277,6 +279,29 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
>
>  out:
>         mutex_unlock(&data->lock);
> +}
> +
> +static void adt7470_work_function(struct work_struct *work)
> +{
> +       struct adt7470_data *data > +               container_of(work, struct adt7470_data, ref_work);
> +
> +       adt7470_update_data(data);
> +       mod_timer(&data->timer, jiffies + REFRESH_INTERVAL);
> +}
> +
> +static void adt7470_timer_function(unsigned long x)
> +{
> +       struct adt7470_data *data = (struct adt7470_data *)x;
> +
> +       schedule_work(&data->ref_work);
> +}
> +
> +static struct adt7470_data *dev_to_adt7470_data(struct device *dev)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct adt7470_data *data = i2c_get_clientdata(client);
> +
>         return data;
>  }
>
> @@ -285,7 +310,7 @@ static ssize_t show_temp_min(struct device *dev,
>                              char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>         return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
>  }
>
> @@ -313,7 +338,7 @@ static ssize_t show_temp_max(struct device *dev,
>                              char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>         return sprintf(buf, "%d\n", 1000 * data->temp_max[attr->index]);
>  }
>
> @@ -340,7 +365,7 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
>                          char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>         return sprintf(buf, "%d\n", 1000 * data->temp[attr->index]);
>  }
>
> @@ -349,7 +374,7 @@ static ssize_t show_alarms(struct device *dev,
>                            char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>
>         if (attr->index)
>                 return sprintf(buf, "%x\n", data->alarms);
> @@ -362,7 +387,7 @@ static ssize_t show_fan_max(struct device *dev,
>                             char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>
>         if (FAN_DATA_VALID(data->fan_max[attr->index]))
>                 return sprintf(buf, "%d\n",
> @@ -397,7 +422,7 @@ static ssize_t show_fan_min(struct device *dev,
>                             char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>
>         if (FAN_DATA_VALID(data->fan_min[attr->index]))
>                 return sprintf(buf, "%d\n",
> @@ -431,7 +456,7 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
>                         char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>
>         if (FAN_DATA_VALID(data->fan[attr->index]))
>                 return sprintf(buf, "%d\n",
> @@ -444,7 +469,7 @@ static ssize_t show_force_pwm_max(struct device *dev,
>                                   struct device_attribute *devattr,
>                                   char *buf)
>  {
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>         return sprintf(buf, "%d\n", data->force_pwm_max);
>  }
>
> @@ -475,7 +500,7 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
>                         char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>         return sprintf(buf, "%d\n", data->pwm[attr->index]);
>  }
>
> @@ -500,7 +525,7 @@ static ssize_t show_pwm_max(struct device *dev,
>                             char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>         return sprintf(buf, "%d\n", data->pwm_max[attr->index]);
>  }
>
> @@ -528,7 +553,7 @@ static ssize_t show_pwm_min(struct device *dev,
>                             char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>         return sprintf(buf, "%d\n", data->pwm_min[attr->index]);
>  }
>
> @@ -556,7 +581,7 @@ static ssize_t show_pwm_tmax(struct device *dev,
>                              char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>         /* the datasheet says that tmax = tmin + 20C */
>         return sprintf(buf, "%d\n", 1000 * (20 + data->pwm_tmin[attr->index]));
>  }
> @@ -566,7 +591,7 @@ static ssize_t show_pwm_tmin(struct device *dev,
>                              char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>         return sprintf(buf, "%d\n", 1000 * data->pwm_tmin[attr->index]);
>  }
>
> @@ -594,7 +619,7 @@ static ssize_t show_pwm_auto(struct device *dev,
>                              char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>         return sprintf(buf, "%d\n", 1 + data->pwm_automatic[attr->index]);
>  }
>
> @@ -638,7 +663,7 @@ static ssize_t show_pwm_auto_temp(struct device *dev,
>                                   char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct adt7470_data *data = adt7470_update_device(dev);
> +       struct adt7470_data *data = dev_to_adt7470_data(dev);
>         u8 ctrl = data->pwm_auto_temp[attr->index];
>
>         if (ctrl)
> @@ -913,6 +938,14 @@ static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind)
>                 goto exit_remove;
>         }
>
> +       /* Initialize automatic sensor refresh */
> +       INIT_WORK(&data->ref_work, adt7470_work_function);
> +       init_timer(&data->timer);
> +       data->timer.expires = jiffies + REFRESH_INTERVAL;
> +       data->timer.data = (unsigned long)data;
> +       data->timer.function = adt7470_timer_function;
> +       add_timer(&data->timer);
> +
>         return 0;
>
>  exit_remove:
> @@ -930,6 +963,8 @@ static int adt7470_detach_client(struct i2c_client *client)
>         struct adt7470_data *data = i2c_get_clientdata(client);
>         int i;
>
> +       del_timer_sync(&data->timer);
> +       cancel_work_sync(&data->ref_work);
>         hwmon_device_unregister(data->class_dev);
>         for (i = 0; i < ARRAY_SIZE(adt7470_attr); i++)
>                 device_remove_file(&client->dev, &adt7470_attr[i].dev_attr);
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
>
> iD8DBQFGp/MVa6vRYYgWQuURApPtAKCc8OrLqZ8C7jdpSWfczMPqLcsuuQCfQkSA
> x10Dhzi/rneNPrH4e2pW9WY> =By5u
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
