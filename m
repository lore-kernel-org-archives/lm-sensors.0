From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 29 Aug 2011 12:34:07 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E8B36733@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314613983-3331-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1314613983-3331-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Some minor comments.
Removing the clean code, to reduce traffic.

> +Sysfs Interface
> +---------------
> +name		name of the temperature sensor
> +		RO
> +
> +temp1_input	temperature
> +		RO
> +
> +temp1_max	temperature for level_1 interrupt
> +		RO
> +
> +temp1_crit	temperature for level_2 interrupt
> +		RO
> +
> +temp1_emergency	temperature for level_3 interrupt
> +		RO
> +
> +temp1_max_alarm	alarm for level_1 interrupt
> +		RO
> +
> +temp1_crit_alarm
> +		alarm for level_2 interrupt
> +		RO
> +
> +temp1_emergency_alarm
> +		alarm for level_3 interrupt
> +		RO

All these are standard ABI for Thermal related Hwmon drivers.
So, Do we really need to have them explained here again ?

Guenter/Jean, I would like to see your inputs here.

> +static int exynos4_tmu_initialize(struct platform_device *pdev)
> +{
> +	struct exynos4_tmu_data *data = platform_get_drvdata(pdev);
> +	struct exynos4_tmu_platform_data *pdata = data->pdata;
> +	unsigned int status, trim_info;

Can the status be a 'u8' since we are populating it with readb(...) ?
I am blindly assuming readb returns a byte. Please correct me if I am wrong.

> +
> +static int exynos4_tmu_read(struct exynos4_tmu_data *data)

The return type can better be 'u8', since translate_code_to_temp(...)
returns a 'u8'.

> +static irqreturn_t exynos4_tmu_irq(int irq, void *id)
> +{
> +	struct exynos4_tmu_data *data = id;

I am not sure whether we _must_ cast 'id', as (struct exynos4_tmu_data *)..
 
> +static ssize_t exynos4_tmu_show_temp(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct exynos4_tmu_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = exynos4_tmu_read(data);
> +	if (ret < 0)
> +		return ret;
> +	/* convert from degree Celsius to millidegree Celsius */
> +	return sprintf(buf, "%d\n", ret * 1000);

One Opinion here:
I do not know what values your temp_code takes.
In the translate_code_to_temp function, we can add the code,
to convert the value directly into millidegree Celsius.
Basically, do the multiplication by 1000 there, to achieve a
little more accuracy.

> +static ssize_t exynos4_tmu_show_alarm(struct device *dev,
> +		struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct exynos4_tmu_data *data = dev_get_drvdata(dev);
> +	struct exynos4_tmu_platform_data *pdata = data->pdata;
> +	int temp, trigger_level;

trigger_level is an 'int' here and in the function below,
it is an unsigned int, but defined as an 'u8' in .h file.
Please keep the data type consistent across the code.

> +static ssize_t exynos4_tmu_show_level(struct device *dev,
> +		struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct exynos4_tmu_data *data = dev_get_drvdata(dev);
> +	struct exynos4_tmu_platform_data *pdata = data->pdata;
> +	unsigned int temp = pdata->threshold +
> +			pdata->trigger_levels[attr->index];

Pdata->threshold and pdata->trigger_levels, both are of type u8.
So, why is temp an unsigned int ?


> +static int __devexit exynos4_tmu_remove(struct platform_device *pdev)
> +{
> +	struct exynos4_tmu_data *data = platform_get_drvdata(pdev);
> +
> +	exynos4_tmu_control(pdev, false);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&pdev->dev.kobj, &exynos4_tmu_attr_group);

Shouldn't we send a KOBJ_REMOVE event here ?

> +/**
> + * struct exynos4_tmu_platform_data
> + * @threshold: basic temperature for generating interrupt
> + * @trigger_levels: array for each interrupt levels

Please specify the Unit. Since we convert between millidegree Celsius
Celsius, it is better to have a comment here, for thresholds and
trigger_levels. Something like the following would do:
@threshold: basic temperature(in Celsius) for generating interrupt.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
