From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 23 Jan 2016 13:52:50 +0000
Subject: Re: [lm-sensors] [PATCH v2] rtc: rtc-ds1307: add temperature sensor support for ds3231
Message-Id: <CAC5umyhVcZLHJBX38Tu4+qLRfJRg4W=A3Vj1n1OjMZ-P65aY_w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453485441-11667-1-git-send-email-akinobu.mita@gmail.com>
	<56A2CF6D.9040300@roeck-us.net>
In-Reply-To: <56A2CF6D.9040300@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org

2016-01-23 9:55 GMT+09:00 Guenter Roeck <linux@roeck-us.net>:
> On 01/22/2016 09:57 AM, Akinobu Mita wrote:
>>
>> DS3231 has the temperature registers with a resolution of 0.25
>> degree celsius.  This enables to get the value through hwmon.
>>
>>         # cat /sys/class/i2c-adapter/i2c-2/2-0068/hwmon/hwmon0/temp1_input
>>         21000
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: rtc-linux@googlegroups.com
>> Cc: Jean Delvare <jdelvare@suse.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: lm-sensors@lm-sensors.org
>> ---
>> * v2
>> - convert to use hwmon framework, suggested by Alexandre Belloni
>>
>>   drivers/rtc/rtc-ds1307.c | 122
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 122 insertions(+)
>>
>> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
>
>
> Something else, on top of my previous comments.
>
>> +#if IS_ENABLED(CONFIG_HWMON)
>
>
> I don't think this will work as intended. It will fail if the ds1307 driver
> is built into the kernel but hwmon is built as module.
>
> Check configurations such as BE2NET_HWMON or NET_DSA_HWMON for ideas
> on how to handle this problem.

OK.  I'll add CONFIG_RTC_DRV_DS1307_HWMON and do something similar.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
