From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 25 Jul 2014 04:46:07 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (pwm-fan) Add proper #ifdef CONFIG_OF guard for of_device_id tab
Message-Id: <CAFRkauCtWJSuyHVEiyU=5sxUHeZeuo4Stnw3ukrSgHrdLdSeyg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406258073.9778.3.camel@phoenix>
In-Reply-To: <1406258073.9778.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-07-25 12:29 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On 07/24/2014 08:14 PM, Axel Lin wrote:
>>
>> Use of_match_ptr and proper #ifdef CONFIG_OF guard for of_device_id table.
>> Also makes of_pwm_fan_match const.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
>
> The driver won't instantiate if OF is not configured.
You are right.
Then how about adding OF dependency to config SENSORS_PWM_FAN?

Thanks,
Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
