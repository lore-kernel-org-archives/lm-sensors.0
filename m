From: Donggeun Kim <dg77.kim@samsung.com>
Date: Tue, 30 Aug 2011 10:46:51 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <4E5CBF9B.9070606@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314613983-3331-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1314613983-3331-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 2011년 08월 29일 21:22, R, Durgadoss wrote:
> Hi,
> 
> Some minor comments.
> Removing the clean code, to reduce traffic.
[snip]
>> +static int exynos4_tmu_read(struct exynos4_tmu_data *data)
> 
> The return type can better be 'u8', since translate_code_to_temp(...)
> returns a 'u8'.
> 
The read function returns error code (-ENODATA) for abnormal case.
So, the return type should be 'int'.
>> +static irqreturn_t exynos4_tmu_irq(int irq, void *id)
>> +{
>> +	struct exynos4_tmu_data *data = id;
> 
> I am not sure whether we _must_ cast 'id', as (struct exynos4_tmu_data *)..
>  
In exynos4_tmu_irq function, 'irq_work' field in 'exynos4_tmu_data' is
accessed. Thus, it should be casted.
[snip]
>> +static ssize_t exynos4_tmu_show_alarm(struct device *dev,
>> +		struct device_attribute *devattr, char *buf)
>> +{
>> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +	struct exynos4_tmu_data *data = dev_get_drvdata(dev);
>> +	struct exynos4_tmu_platform_data *pdata = data->pdata;
>> +	int temp, trigger_level;
> 
> trigger_level is an 'int' here and in the function below,
> it is an unsigned int, but defined as an 'u8' in .h file.
> Please keep the data type consistent across the code.
> 
Okay, it would be better to change type from 'int' to 'unsigned int' or
'u8'.
[snip]
>> +/**
>> + * struct exynos4_tmu_platform_data
>> + * @threshold: basic temperature for generating interrupt
>> + * @trigger_levels: array for each interrupt levels
> 
> Please specify the Unit. Since we convert between millidegree Celsius
> Celsius, it is better to have a comment here, for thresholds and
> trigger_levels. Something like the following would do:
> @threshold: basic temperature(in Celsius) for generating interrupt.
> 
I will specify the unit for the both fields.
> Thanks,
> Durga
> 

Thanks for your comment.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
