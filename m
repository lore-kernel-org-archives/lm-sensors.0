From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 25 Jul 2014 14:05:08 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (pwm-fan) Add proper #ifdef CONFIG_OF guard for of_device_id tab
Message-Id: <53D26414.2040301@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406258073.9778.3.camel@phoenix>
In-Reply-To: <1406258073.9778.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/25/2014 12:50 AM, Jean Delvare wrote:
> Hi Guenter, Axel,
>
> On Thu, 24 Jul 2014 21:56:00 -0700, Guenter Roeck wrote:
>> On 07/24/2014 09:46 PM, Axel Lin wrote:
>>> 2014-07-25 12:29 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
>>>> The driver won't instantiate if OF is not configured.
>>> You are right.
>>> Then how about adding OF dependency to config SENSORS_PWM_FAN?
>>
>> Then it won't compile with allmodconfig on x86. I prefer to be able
>> to compile it. So we would have to add COMPILE_TEST as secondary
>> dependency, and things would get more and more complex.
>> Not really sure if I want to go along that route.
>>
>> Jean, any thoughts ?
>
> depends on OF || COMPILE_TEST
>
> is good and not complex at all, just do that :) Note that you can put
> this on a line on its own, this is the recommended way to keep
> functional (build-time) dependencies and run-time dependencies clearly
> separated.
>
Ok. Axel, please send a patch.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
