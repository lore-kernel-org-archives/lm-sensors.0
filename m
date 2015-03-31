From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 31 Mar 2015 16:19:19 +0000
Subject: Re: [lm-sensors] [PATCH 04/15] hwmon: (it87) Introduce feature flag to reflect internal in7 sensor
Message-Id: <551AC907.3090703@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427697235-23566-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1427697235-23566-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/31/2015 08:44 AM, Jean Delvare wrote:
> On Sun, 29 Mar 2015 23:33:44 -0700, Guenter Roeck wrote:
>> @@ -379,6 +381,7 @@ static const struct it87_devices it87_devices[] = {
>>   #define has_fan16_config(data)	((data)->features & FEAT_FAN16_CONFIG)
>>   #define has_five_fans(data)	((data)->features & FEAT_FIVE_FANS)
>>   #define has_vid(data)		((data)->features & FEAT_VID)
>> +#define has_in7_internal(data)	((data)->features & FEAT_IN7_INTERNAL)
>
> I just noticed that you never actually call this macro. Where you could
> do so, you open-coded it instead:
>
>> @@ -1862,6 +1865,11 @@ static int __init it87_find(unsigned short *address,
>>
>>   	/* in8 (Vbat) is always internal */
>>   	sio_data->internal = (1 << 2);
>> +
>> +	/* in7 (VSB or VCCH5V) is always internal on some chips */
>> +	if (it87_devices[sio_data->type].features & FEAT_IN7_INTERNAL)
>> +		sio_data->internal |= (1 << 1);
>> +
>

Good point. The idea was to use the macros on data, but of course they work on
sio_data as well. I'll rework the patches to do that.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
