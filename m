From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 24 Feb 2015 14:23:40 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (it87) Add feature flags for fans count and 16-bit fan configura
Message-Id: <54EC896C.5080700@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423858433-1416-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1423858433-1416-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 02/24/2015 01:31 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Fri, 13 Feb 2015 12:13:51 -0800, Guenter Roeck wrote:
[ ... ]
>
>> +	if (has_fan16_config(data)) {
>
> If I read the changes properly, we were executing the code below on all
> 16-bit fan capable chips except the IT8603E before, and now you also
> exclude the IT8728F, the IT8771E and the IT8772E. This may or may not
> be correct, but it definitely should NOT happen in this patch. Adding
> feature flags to make the core more readable is great but it should not
> come with hidden changes in code behavior.
>
> (For the IT8772E and IT8728F this change seems correct according to the
> datasheets, I can't say for the IT8771E as I have no datasheet.)
>
I'll split it into a separate patch. For IT8771E it is guesswork,
based on its usage on the boards I could find, for the others I checked
the datasheet.

>>   		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
>>   		if (~tmp & 0x07 & data->has_fan) {
>>   			dev_dbg(&pdev->dev,
>> @@ -2473,17 +2483,15 @@ static void it87_init_device(struct platform_device *pdev)
>>   			it87_write_value(data, IT87_REG_FAN_16BIT,
>>   					 tmp | 0x07);
>>   		}
>> -		/*
>> -		 * IT8705F, IT8781F, IT8782F, and IT8783E/F only support
>> -		 * three fans.
>> -		 */
>> -		if (data->type != it87 && data->type != it8781 &&
>> -		    data->type != it8782 && data->type != it8783) {
>> -			if (tmp & (1 << 4))
>> -				data->has_fan |= (1 << 3); /* fan4 enabled */
>> -			if (tmp & (1 << 5))
>> -				data->has_fan |= (1 << 4); /* fan5 enabled */
>> -		}
>> +	}
>> +
>> +	/* Check for additional fans */
>> +	if (has_five_fans(data)) {
>> +		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
>
> This makes us read the same register twice, but I suppose this is a
> reasonable to price to pay for cleaner code, so no objection from me.
>
I know, that is why I did it.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
