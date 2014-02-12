From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Feb 2014 14:30:31 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (emc2103) Return error from i2c_smbus_read_byte_data
Message-Id: <52FB8587.7010400@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392184009-5683-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392184009-5683-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/12/2014 12:40 AM, Jean Delvare wrote:
> On Tue, 11 Feb 2014 21:46:48 -0800, Guenter Roeck wrote:
>> There is no reason to replace one error with another.
>>
>> smatch message:
>> drivers/hwmon/emc2103.c:352 set_fan_div() info: why not propagate 'status'
>> from i2c_smbus_read_byte_data() instead of (-5)?
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/emc2103.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
>> index 2c137b2..fd892dd 100644
>> --- a/drivers/hwmon/emc2103.c
>> +++ b/drivers/hwmon/emc2103.c
>> @@ -349,7 +349,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
>>   		dev_dbg(&client->dev, "reg 0x%02x, err %d\n",
>>   			REG_FAN_CONF1, status);
>>   		mutex_unlock(&data->update_lock);
>> -		return -EIO;
>> +		return status;
>>   	}
>>   	status &= 0x9F;
>>   	status |= (new_range_bits << 5);
>
> Good catch.
>

Hi Jean.

Easy with an auto-builder ...

This is the current list of problems reported by smatch.

drivers/hwmon/lm90.c:1204 lm90_detect() info: why not propagate 'config2' from i2c_smbus_read_byte_data() instead of (-19)?
drivers/hwmon/w83627hf.c:1857 w83627hf_update_device() error: buffer overflow 'regpwm_627hf' 2 <= 2
drivers/hwmon/f71882fg.c:2374 f71882fg_probe() warn: missing break? reassigning 'data->auto_point_temp_signed'
drivers/hwmon/max1668.c:386 max1668_detect() info: why not propagate 'dev_id' from i2c_smbus_read_byte_data() instead of (-19)?
drivers/hwmon/tmp401.c:214 tmp401_update_device_reg16() error: buffer overflow 'TMP432_TEMP_MSB_READ' 4 <= 5
drivers/hwmon/tmp401.c:215 tmp401_update_device_reg16() error: buffer overflow 'TMP401_TEMP_MSB_READ[j]' 2 <= 2
drivers/hwmon/tmp401.c:222 tmp401_update_device_reg16() error: buffer overflow 'TMP432_TEMP_LSB' 3 <= 5
drivers/hwmon/tmp401.c:223 tmp401_update_device_reg16() error: buffer overflow 'TMP401_TEMP_LSB[j]' 2 <= 2
drivers/hwmon/w83791d.c:996 store_temp23() warn: '32768' 32768 can't fit into 32767 'data->temp_add[nr][index]'
drivers/hwmon/lm63.c:594 set_temp11() warn: '65504' 65504 can't fit into 32767 'data->temp11[nr]'
drivers/hwmon/lm63.c:596 set_temp11() warn: '32768' 32768 can't fit into 32767 'data->temp11[nr]'

All false positives as far as I can see, but except
for the detect functions, it points to less than perfect code.
No idea how to make it better without making the code more
complicated, though. Just in case you have too much time
and want to have a look :-)

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
