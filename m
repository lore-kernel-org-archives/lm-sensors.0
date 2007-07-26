From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 26 Jul 2007 17:04:33 +0000
Subject: Re: [lm-sensors] [PATCH v2] adt7470: Update sensors periodically
Message-Id: <46A8D421.1060301@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726165842.GQ19586@tree.beaverton.ibm.com>
In-Reply-To: <20070726165842.GQ19586@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Darrick J. Wong wrote:
> To avoid blocking for 1s in the sysfs read functions, make it so
> that adt7470 updates are done periodically with a delayed workqueue
> instead of being called from the read functions directly.  This
> causes near-instant reading of sensors at the cost of reading them
> even if nobody's watching them.
> 

As already explained in a previous thread, I'm not sure we want this. It seems 
that other drivers have been having 1.5 second delays too and that hasn't 
caused any problems, so I think that we shouldn't do this.

Again sorry for the inconvenience .

Regards,

Hans


> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  drivers/hwmon/adt7470.c |  103 +++++++++++++++++++++++++++++++++++------------
>  1 files changed, 76 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index 75aee3b..78d858e 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -28,6 +28,7 @@
>  #include <linux/mutex.h>
>  #include <linux/delay.h>
>  #include <linux/log2.h>
> +#include <linux/workqueue.h>
>  
>  /* Addresses to scan */
>  static unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
> @@ -105,7 +106,8 @@ I2C_CLIENT_INSMOD_1(adt7470);
>  /* "all temps" according to hwmon sysfs interface spec */
>  #define ADT7470_PWM_ALL_TEMPS	0x3FF
>  
> -#define REFRESH_INTERVAL	(5 * HZ)
> +/* update sensors every 5 seconds */
> +#define DEFAULT_REFRESH_INTERVAL	5000
>  
>  /* sleep 1s while gathering temperature data */
>  #define TEMP_COLLECTION_TIME	1000
> @@ -118,12 +120,19 @@ I2C_CLIENT_INSMOD_1(adt7470);
>  #define FAN_PERIOD_INVALID	65535
>  #define FAN_DATA_VALID(x)	((x) && (x) != FAN_PERIOD_INVALID)
>  
> +static int refresh_interval = DEFAULT_REFRESH_INTERVAL;
> +module_param_named(refresh_interval, refresh_interval, int, S_IRUGO);
> +MODULE_PARM_DESC(refresh_interval, "\n"
> +	"\tHow often (in ms) to update the sensor readings.\n"
> +	"\tDefault: 5000 (5s)");
> +
>  struct adt7470_data {
>  	struct i2c_client	client;
>  	struct class_device	*class_dev;
>  	struct mutex		lock;
>  	char			valid;
> -	unsigned long		last_updated;	/* In jiffies */
> +	struct delayed_work	ref_start;
> +	struct delayed_work	ref_finish;
>  
>  	s8			temp[ADT7470_TEMP_COUNT];
>  	s8			temp_min[ADT7470_TEMP_COUNT];
> @@ -184,17 +193,12 @@ static void adt7470_init_client(struct i2c_client *client)
>  	}
>  }
>  
> -static struct adt7470_data *adt7470_update_device(struct device *dev)
> +static void adt7470_begin_update(struct adt7470_data *data)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7470_data *data = i2c_get_clientdata(client);
> +	struct i2c_client *client = &data->client;
>  	u8 cfg;
> -	int i;
>  
>  	mutex_lock(&data->lock);
> -	if (time_before(jiffies, data->last_updated + REFRESH_INTERVAL)
> -		&& data->valid)
> -		goto out;
>  
>  	/* start reading temperature sensors */
>  	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> @@ -205,9 +209,19 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
>  	 * Delay is 200ms * number of tmp05 sensors.  Too bad
>  	 * there's no way to figure out how many are connected.
>  	 * For now, assume 1s will work.
> +	 *
> +	 * (Sleep now handled by delayed workqueue)
>  	 */
> -	msleep(TEMP_COLLECTION_TIME);
> +	mutex_unlock(&data->lock);
> +}
> +
> +static void adt7470_end_update(struct adt7470_data *data)
> +{
> +	struct i2c_client *client = &data->client;
> +	u8 cfg;
> +	int i;
>  
> +	mutex_lock(&data->lock);
>  	/* done reading temperature sensors */
>  	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
>  	cfg &= ~0x80;
> @@ -272,11 +286,36 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
>  	data->alarms_mask = adt7470_read_word_data(client,
>  						   ADT7470_REG_ALARM1_MASK);
>  
> -	data->last_updated = jiffies;
>  	data->valid = 1;
>  
> -out:
>  	mutex_unlock(&data->lock);
> +}
> +
> +static void adt7470_start_reading(struct work_struct *work)
> +{
> +	struct adt7470_data *data > +		container_of(work, struct adt7470_data, ref_start.work);
> +
> +	adt7470_begin_update(data);
> +	schedule_delayed_work(&data->ref_finish,
> +			      msecs_to_jiffies(TEMP_COLLECTION_TIME));
> +}
> +
> +static void adt7470_finish_reading(struct work_struct *work)
> +{
> +	struct adt7470_data *data > +		container_of(work, struct adt7470_data, ref_finish.work);
> +
> +	adt7470_end_update(data);
> +	schedule_delayed_work(&data->ref_start,
> +			      msecs_to_jiffies(refresh_interval));
> +}
> +
> +static struct adt7470_data *dev_to_adt7470_data(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +
>  	return data;
>  }
>  
> @@ -285,7 +324,7 @@ static ssize_t show_temp_min(struct device *dev,
>  			     char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  	return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
>  }
>  
> @@ -313,7 +352,7 @@ static ssize_t show_temp_max(struct device *dev,
>  			     char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  	return sprintf(buf, "%d\n", 1000 * data->temp_max[attr->index]);
>  }
>  
> @@ -340,7 +379,7 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
>  			 char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  	return sprintf(buf, "%d\n", 1000 * data->temp[attr->index]);
>  }
>  
> @@ -349,7 +388,7 @@ static ssize_t show_alarms(struct device *dev,
>  			   char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  
>  	if (attr->index)
>  		return sprintf(buf, "%x\n", data->alarms);
> @@ -362,7 +401,7 @@ static ssize_t show_fan_max(struct device *dev,
>  			    char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  
>  	if (FAN_DATA_VALID(data->fan_max[attr->index]))
>  		return sprintf(buf, "%d\n",
> @@ -397,7 +436,7 @@ static ssize_t show_fan_min(struct device *dev,
>  			    char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  
>  	if (FAN_DATA_VALID(data->fan_min[attr->index]))
>  		return sprintf(buf, "%d\n",
> @@ -431,7 +470,7 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
>  			char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  
>  	if (FAN_DATA_VALID(data->fan[attr->index]))
>  		return sprintf(buf, "%d\n",
> @@ -444,7 +483,7 @@ static ssize_t show_force_pwm_max(struct device *dev,
>  				  struct device_attribute *devattr,
>  				  char *buf)
>  {
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  	return sprintf(buf, "%d\n", data->force_pwm_max);
>  }
>  
> @@ -475,7 +514,7 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
>  			char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  	return sprintf(buf, "%d\n", data->pwm[attr->index]);
>  }
>  
> @@ -500,7 +539,7 @@ static ssize_t show_pwm_max(struct device *dev,
>  			    char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  	return sprintf(buf, "%d\n", data->pwm_max[attr->index]);
>  }
>  
> @@ -528,7 +567,7 @@ static ssize_t show_pwm_min(struct device *dev,
>  			    char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  	return sprintf(buf, "%d\n", data->pwm_min[attr->index]);
>  }
>  
> @@ -556,7 +595,7 @@ static ssize_t show_pwm_tmax(struct device *dev,
>  			     char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  	/* the datasheet says that tmax = tmin + 20C */
>  	return sprintf(buf, "%d\n", 1000 * (20 + data->pwm_tmin[attr->index]));
>  }
> @@ -566,7 +605,7 @@ static ssize_t show_pwm_tmin(struct device *dev,
>  			     char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  	return sprintf(buf, "%d\n", 1000 * data->pwm_tmin[attr->index]);
>  }
>  
> @@ -594,7 +633,7 @@ static ssize_t show_pwm_auto(struct device *dev,
>  			     char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  	return sprintf(buf, "%d\n", 1 + data->pwm_automatic[attr->index]);
>  }
>  
> @@ -638,7 +677,7 @@ static ssize_t show_pwm_auto_temp(struct device *dev,
>  				  char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> +	struct adt7470_data *data = dev_to_adt7470_data(dev);
>  	u8 ctrl = data->pwm_auto_temp[attr->index];
>  
>  	if (ctrl)
> @@ -913,6 +952,13 @@ static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind)
>  		goto exit_remove;
>  	}
>  
> +	/* Initialize automatic sensor refresh mechanism */
> +	INIT_DELAYED_WORK(&data->ref_start, adt7470_start_reading);
> +	INIT_DELAYED_WORK(&data->ref_finish, adt7470_finish_reading);
> +
> +	/* Start reading sensors immediately */
> +	schedule_delayed_work(&data->ref_start, 0);
> +
>  	return 0;
>  
>  exit_remove:
> @@ -930,6 +976,9 @@ static int adt7470_detach_client(struct i2c_client *client)
>  	struct adt7470_data *data = i2c_get_clientdata(client);
>  	int i;
>  
> +	flush_scheduled_work();
> +	cancel_delayed_work_sync(&data->ref_start);
> +	cancel_delayed_work_sync(&data->ref_finish);
>  	hwmon_device_unregister(data->class_dev);
>  	for (i = 0; i < ARRAY_SIZE(adt7470_attr); i++)
>  		device_remove_file(&client->dev, &adt7470_attr[i].dev_attr);
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
