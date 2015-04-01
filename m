From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Apr 2015 18:30:34 +0000
Subject: Re: [lm-sensors] [PATCH 07/15] hwmon: (it87) Add support for 6th fan of IT8620E
Message-Id: <551C394A.7040302@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427697235-23566-8-git-send-email-linux@roeck-us.net>
In-Reply-To: <1427697235-23566-8-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 04/01/2015 10:11 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sun, 29 Mar 2015 23:33:47 -0700, Guenter Roeck wrote:
>> IT8620E supports up to 6 fan tachometers.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/it87.c | 51 ++++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 36 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
>> index ee6d30960fce..24e9369f1b74 100644
>> --- a/drivers/hwmon/it87.c
>> +++ b/drivers/hwmon/it87.c
>> @@ -215,11 +215,11 @@ static bool fix_pwm_polarity;
>>
>>   /* Monitors: 9 voltage (0 to 7, battery), 3 temp (1 to 3), 3 fan (1 to 3) */
>
> The comment above it out of date, BTW.
>
Yes, I noticed earlier today. I'll address that later, when I add VIN7..9 and TEMP4..6.

>>
>> -static const u8 IT87_REG_FAN[]		= { 0x0d, 0x0e, 0x0f, 0x80, 0x82 };
>> -static const u8 IT87_REG_FAN_MIN[]	= { 0x10, 0x11, 0x12, 0x84, 0x86 };
>> -static const u8 IT87_REG_FANX[]		= { 0x18, 0x19, 0x1a, 0x81, 0x83 };
>> -static const u8 IT87_REG_FANX_MIN[]	= { 0x1b, 0x1c, 0x1d, 0x85, 0x87 };
>> -static const u8 IT87_REG_TEMP_OFFSET[]	= { 0x56, 0x57, 0x59 };
>> +static const u8 IT87_REG_FAN[]		= {0x0d, 0x0e, 0x0f, 0x80, 0x82, 0x4c};
>> +static const u8 IT87_REG_FAN_MIN[]	= {0x10, 0x11, 0x12, 0x84, 0x86, 0x4e};
>> +static const u8 IT87_REG_FANX[]		= {0x18, 0x19, 0x1a, 0x81, 0x83, 0x4d};
>> +static const u8 IT87_REG_FANX_MIN[]	= {0x1b, 0x1c, 0x1d, 0x85, 0x87, 0x4f};
>> +static const u8 IT87_REG_TEMP_OFFSET[]	= {0x56, 0x57, 0x59};
>
> I see why you removed the spaces inside the curly braces, but that's
> inconsistent with enum chips and the style used in the vast majority of
> other hwmon drivers. I would rather align with spaces instead of tabs
> so that you can move everything by a few columns to the left and
> everything fits again. (Until the next chip that will support 7 fans,
> that is ^^.)
>
> (That's typically the kind of comment you're free to ignore if you
> prefer the way you did.)
>
You are right, that is better. Done.

>>
>>   #define IT87_REG_FAN_MAIN_CTRL 0x13
>>   #define IT87_REG_FAN_CTL       0x14
>> (...)
>> @@ -2569,13 +2586,17 @@ static void it87_init_device(struct platform_device *pdev)
>>
>>   	/* Check for additional fans */
>>   	if (has_five_fans(data)) {
>> -		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
>>   		if (tmp & (1 << 4))
>>   			data->has_fan |= (1 << 3); /* fan4 enabled */
>>   		if (tmp & (1 << 5))
>>   			data->has_fan |= (1 << 4); /* fan5 enabled */
>>   	}
>>
>> +	if (has_six_fans(data)) {
>> +		if (tmp & (1 << 2))
>> +			data->has_fan |= (1 << 5); /* fan6 enabled */
>> +	}
>> +
>
> May I suggest the following optimization?
>
> 	/* Check for additional fans */
> 	if (has_five_fans(data)) {
> 		if (tmp & (1 << 4))
> 			data->has_fan |= (1 << 3); /* fan4 enabled */
> 		if (tmp & (1 << 5))
> 			data->has_fan |= (1 << 4); /* fan5 enabled */
> 		if (has_six_fans(data) && (tmp & (1 << 2)))
> 			data->has_fan |= (1 << 5); /* fan6 enabled */
> 	}
>
> This fits in fewer lines and saves a test for 3-fan chips.
>
Excellent idea. Done.

> Looks good otherwise:
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
Thanks a lot!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
