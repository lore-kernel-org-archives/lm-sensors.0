From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 01 Sep 2013 17:55:34 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/9] hwmon: Introduce hwmon_device_register_with_groups
Message-Id: <52237F96.2090008@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378003742-18685-1-git-send-email-linux@roeck-us.net> <1378003742-18685-2-git-send-email-linux@roeck-us.net> <20130901162441.GB32712@kroah.com>
In-Reply-To: <20130901162441.GB32712@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 09/01/2013 09:24 AM, Greg Kroah-Hartman wrote:
> This looks good, just one minor question about the
> non-driver-core-related code:
>
>> +struct device *
>> +hwmon_device_register_with_groups(struct device *dev, const char *name,
>> +				  void *drvdata,
>> +				  const struct attribute_group **groups)
>>   {
>> -	struct device *hwdev;
>> -	int id;
>> +	struct hwmon_device *hwdev;
>> +	int err, id;
>>
>>   	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
>>   	if (id < 0)
>>   		return ERR_PTR(id);
>
> Don't you need a lock around the ida_simple_get call to ensure hwmon_ida
> is not being used at the same time twice?  Or does the ida framework
> handle that ok?
>

ida_simple_get handles the locking as far as I can see. Other callers don't use
local locks either, so I guess it must be working.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
