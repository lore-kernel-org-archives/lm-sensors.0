From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 25 Jul 2014 04:56:00 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (pwm-fan) Add proper #ifdef CONFIG_OF guard for of_device_id tab
Message-Id: <53D1E360.6090908@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406258073.9778.3.camel@phoenix>
In-Reply-To: <1406258073.9778.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/24/2014 09:46 PM, Axel Lin wrote:
> 2014-07-25 12:29 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
>> On 07/24/2014 08:14 PM, Axel Lin wrote:
>>>
>>> Use of_match_ptr and proper #ifdef CONFIG_OF guard for of_device_id table.
>>> Also makes of_pwm_fan_match const.
>>>
>>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>>
>>
>> The driver won't instantiate if OF is not configured.
> You are right.
> Then how about adding OF dependency to config SENSORS_PWM_FAN?
>

Then it won't compile with allmodconfig on x86. I prefer to be able
to compile it. So we would have to add COMPILE_TEST as secondary
dependency, and things would get more and more complex.
Not really sure if I want to go along that route.

Jean, any thoughts ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
