From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Mar 2015 15:10:40 +0000
Subject: Re: [lm-sensors] [PATCH 01/15] hwmon: (it87) Fix pwm frequency display for chips with newer pwm cont
Message-Id: <55196770.6080908@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427697235-23566-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1427697235-23566-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/30/2015 04:07 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sun, 29 Mar 2015 23:33:41 -0700, Guenter Roeck wrote:
>> On chips with newer pwm control, the pwm frequency divider is 256
>> instead of 128. Since the base pwm frequency remained the same, the actual
>> pwm frequency is half of what it used to be with the older pwm control
>> mechanism.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/it87.c | 34 +++++++++++++++++++++++++---------
>>   1 file changed, 25 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
>> index ab12dc2eb896..7ab5bd026e91 100644
>> --- a/drivers/hwmon/it87.c
>> +++ b/drivers/hwmon/it87.c
>> @@ -502,15 +502,25 @@ static int DIV_TO_REG(int val)
>>   }
>>   #define DIV_FROM_REG(val) (1 << (val))
>>
>> +/*
>> + * pwm base frequencies. The frequency has to be divided by either 128 or 256,
>> + * depending on the chip type, to calculate the actual pwm frequency.
>> + *
>> + * Some of the chip datasheets suggest a base frequency of 51kHz instead
>> + * of 750kHz for the slowest base frequency, resulting in a pwm frequency
>> + * of 200Hz. Sometimes both pwm frequency select registers are affected,
>> + * sometimes just one. It is unknown if this is a datasheet error or real,
>> + * so this is ignored for now.
>
> Leaving a space between the number and kHz or Hz makes it easier to
> read IMHO. I would also capitalize PWM everywhere.
>
> Other than these minor suggestions, this looks good, good catch! I never
> noticed this difference between the various chips.
>

Hi Jean,

I made those changes. Should I resubmit, or do I have your Reviewed-by: ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
