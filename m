From: Henrik Rydberg <rydberg@euromail.se>
Date: Fri, 05 Nov 2010 08:34:48 +0000
Subject: Re: [lm-sensors] [PATCH 4/8] hwmon: applesmc: Handle new
Message-Id: <4CD3C1A8.5050305@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288511434-5662-1-git-send-email-rydberg@euromail.se> <1288511434-5662-5-git-send-email-rydberg@euromail.se> <20101105023525.GC28308@ericsson.com>
In-Reply-To: <20101105023525.GC28308@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

>>

>> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
>> index 0207618..ec92aff 100644
>> --- a/drivers/hwmon/applesmc.c
>> +++ b/drivers/hwmon/applesmc.c
>> @@ -733,13 +733,19 @@ static ssize_t applesmc_show_temperature(struct device *dev,
>>  	ret = applesmc_get_entry_by_index(index, &entry);
>>  	if (ret)
>>  		return ret;
>> +	if (entry.len > 2)
>> +		return -EINVAL;
>>  
>> -	ret = applesmc_read_entry(&entry, buffer, 2);
>> +	ret = applesmc_read_entry(&entry, buffer, entry.len);
>>  	if (ret)
>>  		return ret;
>>  
>> -	temp = buffer[0]*1000;
>> -	temp += (buffer[1] >> 6) * 250;
>> +	if (entry.len = 2) {
>> +		temp = buffer[0]*1000;
>> +		temp += (buffer[1] >> 6) * 250;
>> +	} else {
>> +		temp = buffer[0] * 4000;
>> +	}
> 
> Another comment - in the next patch, you check for entry.len = 0.
> If that can happen, you would need to check it here as well.


It cannot happen after a succesful return from get_entry(), but I will check it
again. Earlier versions used entry.len rather than entry.valid, which can still
be seen in a few places.

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
