From: Hartmut Knaack <knaack.h@gmx.de>
Date: Mon, 25 Feb 2013 21:30:30 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] hwmon: (adt7410) Don't re-read non-volatile registers
Message-Id: <512BD7F6.6040105@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361194739-16525-1-git-send-email-lars@metafoo.de> <51228D7A.8030608@gmx.de> <20130219010229.GA25124@roeck-us.net> <5123D4F5.5030001@gmx.de> <20130220012249.GA15948@roeck-us.net> <5128112C.4080909@gmx.de> <512B34E2.70709@metafoo.de>
In-Reply-To: <512B34E2.70709@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

Lars-Peter Clausen schrieb:
> On 02/23/2013 01:45 AM, Hartmut Knaack wrote:
>> Guenter Roeck schrieb:
>>> On Tue, Feb 19, 2013 at 08:39:33PM +0100, Hartmut Knaack wrote:
>>>> Guenter Roeck schrieb:
>>>>> On Mon, Feb 18, 2013 at 09:22:18PM +0100, Hartmut Knaack wrote:
>>>>>> Lars-Peter Clausen schrieb:
>>>>>>> Currently each time the temperature register is read the driver also reads the
>>>>>>> threshold and hysteresis registers. This increases the amount of I2C traffic and
>>>>>>> time needed to read the temperature by a factor of ~5. Neither the threshold nor
>>>>>>> the hysteresis change on their own, so once we've read them, we should be able
>>>>>>> to just use the cached value of the registers. This patch modifies the code
>>>>>>> accordingly and only reads the threshold and hysteresis registers once during
>>>>>>> probe.
>>>>>> I have been thinking about this a lot, and I am concerned about data integrity. From what I know about I2C, there is no data integrity verification specified in the protocol. So, what the master sends is not necessarily what the slave receives (not to mention other devices on the bus, which could potentially mess around with the slaves, or even reset of the slave). Reading back just cached values makes it pretty hard to verify, if there are issues. I think it might be better to call a read-temperature function with a parameter that indicates, which temperature register is required.
>>>>> I am not concerned about that, unless there is a known issue with the chip
>>>>> and it is known to return bad data under some circumstances. I am doing the
>>>>> same in the PMBus drivers, since there are simply too many limit registers
>>>>> to read on some of the chips (there may literally be more than a hundred).
>>>>> That works fine most of the time; if it does not work, it is a chip problem,
>>>>> an i2c bus master problem, a hardware signal problem, or a combination of all.
>>>>> I actually think it is better if the problem is exposed by cached bad readings.
>>>> Could you please outline the last sentence? I'm having trouble to understand your intention with cached bad readings.
>>> Someone will actually notice it (hopefully while testing) and provide feedback.
>>> This gives a chance to fix the problem instead of having it linger around ...
>>> which would likely be the case if the problem is not persistent.
>>>
>>> Guenter
>> Well, think about a use case where you optically decouple your master and slave using PCA9600 (may it be using optical fibers to cover a big distance, or just to operate the slave in a hazardous environment), where the slave is powered from a different source. Now, if the slaves Vcc drops for a certain time, all its registers get reset (especially min, max and crit) - without the master noticing anything.
>> Therefor I would prefer something like the following solution, where unnecessary load on the bus gets avoided and the cached values get used, until they expire and get read again from the sensor. This is mainly a draft, but do you see any reason against it?
>> Thanks
>>
> That's a bit of an artificially constructed situation, isn't it? Anyway,
> wouldn't it be better to not cache at all in that case. For the cache to be
> useful userspace would have to poll the file with period of less than 1.5
> seconds. I don't think anybody is going to do this for the threshold properties.
>
> - Lars
I could agree with not caching those registers - nobody would probably want to read them too often, intentionally (although bugged userspace code might DoS the bus). The other few i2c drivers I know also do uncached reads.
>
>
>> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
>> old mode 100644
>> new mode 100755
>> index 99a7290..dc11cac
>> --- a/drivers/hwmon/adt7410.c
>> +++ b/drivers/hwmon/adt7410.c
>> @@ -91,8 +91,13 @@ struct adt7410_data {
>>  	struct mutex		update_lock;
>>  	u8			config;
>>  	u8			oldconfig;
>> -	bool			valid;		/* true if registers valid */
>> -	unsigned long		last_updated;	/* In jiffies */
>> +	u8			valid;		/* true if registers valid */
>> +	unsigned long		last_updated[5];	/* In jiffies
>> +							   0 = input
>> +							   1 = high
>> +							   2 = low
>> +							   3 = critical
>> +							   4 = hysteresis */
>>  	s16			temp[4];	/* Register values,
>>  						   0 = input
>>  						   1 = high
>> @@ -119,25 +124,27 @@ static int adt7410_temp_ready(struct i2c_client *client)
>>  	return -ETIMEDOUT;
>>  }
>>  
>> -static struct adt7410_data *adt7410_update_device(struct device *dev)
>> +static struct adt7410_data *adt7410_update_device(struct device *dev, int i)
>>  {
>>  	struct i2c_client *client = to_i2c_client(dev);
>>  	struct adt7410_data *data = i2c_get_clientdata(client);
>>  	struct adt7410_data *ret = data;
>>  	mutex_lock(&data->update_lock);
>>  
>> -	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
>> -	    || !data->valid) {
>> -		int i, status;
>> +	if (time_after(jiffies, data->last_updated[i] + HZ + HZ / 2)
>> +	    || !(data->valid & ~(1 << i))) {
>> +		int status;
>>  
>>  		dev_dbg(&client->dev, "Starting update\n");
>>  
>> -		status = adt7410_temp_ready(client); /* check for new value */
>> -		if (unlikely(status)) {
>> -			ret = ERR_PTR(status);
>> -			goto abort;
>> -		}
>> -		for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
>> +		if (i >= 0 && i <=3) {
>> +			if (!i) {
>> +				status = adt7410_temp_ready(client); /* check for new value */
>> +				if (unlikely(status)) {
>> +					ret = ERR_PTR(status);
>> +					goto abort;
>> +				}
>> +			}
>>  			status = i2c_smbus_read_word_swapped(client,
>>  							ADT7410_REG_TEMP[i]);
>>  			if (unlikely(status < 0)) {
>> @@ -148,18 +155,24 @@ static struct adt7410_data *adt7410_update_device(struct device *dev)
>>  				goto abort;
>>  			}
>>  			data->temp[i] = status;
>> +			data->last_updated[i] = jiffies;
>> +			data->valid |= 1 << i;
>>  		}
>> -		status = i2c_smbus_read_byte_data(client, ADT7410_T_HYST);
>> -		if (unlikely(status < 0)) {
>> -			dev_dbg(dev,
>> -				"Failed to read value: reg %d, error %d\n",
>> -				ADT7410_T_HYST, status);
>> -			ret = ERR_PTR(status);
>> -			goto abort;
>> +		else if (i = 4) {
>> +			status = i2c_smbus_read_byte_data(client, ADT7410_T_HYST);
>> +			if (unlikely(status < 0)) {
>> +				dev_dbg(dev,
>> +					"Failed to read value: reg %d, error %d\n",
>> +					ADT7410_T_HYST, status);
>> +				ret = ERR_PTR(status);
>> +				goto abort;
>> +			}
>> +			data->hyst = status;
>> +			data->last_updated[i] = jiffies;
>> +			data->valid |= 1 << i;
>>  		}
>> -		data->hyst = status;
>> -		data->last_updated = jiffies;
>> -		data->valid = true;
>> +		else
>> +			ret = ERR_PTR(-EINVAL);
>>  	}
>>  
>>  abort:
>> @@ -193,7 +206,7 @@ static ssize_t adt7410_show_temp(struct device *dev,
>>  				 struct device_attribute *da, char *buf)
>>  {
>>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>> -	struct adt7410_data *data = adt7410_update_device(dev);
>> +	struct adt7410_data *data = adt7410_update_device(dev, attr->index);
>>  
>>  	if (IS_ERR(data))
>>  		return PTR_ERR(data);
>> @@ -236,7 +249,10 @@ static ssize_t adt7410_show_t_hyst(struct device *dev,
>>  	int nr = attr->index;
>>  	int hyst;
>>  
>> -	data = adt7410_update_device(dev);
>> +	data = adt7410_update_device(dev, nr);
>> +	if (IS_ERR(data))
>> +		return PTR_ERR(data);
>> +	data = adt7410_update_device(dev, 4);
>>  	if (IS_ERR(data))
>>  		return PTR_ERR(data);
>>  	hyst = (data->hyst & ADT7410_T_HYST_MASK) * 1000;
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
