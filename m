From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jul 2014 14:57:15 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (adm1026) Use DIV_ROUND_CLOSEST to simplify implementation for S
Message-Id: <CAFRkauCLfag6mF8TV9_5XVhh1k7WK+vgZhAgmRkVx1RaWBUKbw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405741079.13406.2.camel@phoenix>
In-Reply-To: <1405741079.13406.2.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-07-19 22:49 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On 07/18/2014 08:37 PM, Axel Lin wrote:
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>   drivers/hwmon/adm1026.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
>> index ca8430f..c632e46 100644
>> --- a/drivers/hwmon/adm1026.c
>> +++ b/drivers/hwmon/adm1026.c
>> @@ -196,7 +196,7 @@ static int adm1026_scaling[] = { /* .001 Volts */
>>                 3330, 4995, 2250, 12000, 13875
>>         };
>>   #define NEG12_OFFSET  16000
>> -#define SCALE(val, from, to) (((val)*(to) + ((from)/2))/(from))
>> +#define SCALE(val, from, to) DIV_ROUND_CLOSEST((val) * (to), (from))
>>   #define INS_TO_REG(n, val)  (clamp_val(SCALE(val, adm1026_scaling[n],
>> 192),\
>>         0, 255))
>>   #define INS_FROM_REG(n, val) (SCALE(val, 192, adm1026_scaling[n]))
>>
> Hi Axel,
>
> I don't really see the value in this series. It does not really improve
> anything,
> or make the code smaller.

Though there is nothing wrong in original code.
IMHO, I think use DIV_ROUND_CLOSEST is less error prone than having
the similar calculation in various drivers.

Regards,
Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
