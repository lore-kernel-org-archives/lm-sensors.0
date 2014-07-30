From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Jul 2014 13:58:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: lm85: Fix various errors on attribute writes
Message-Id: <53D8FA0E.5040505@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406698821-4276-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1406698821-4276-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/30/2014 03:29 AM, Axel Lin wrote:
> 2014-07-30 13:40 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
>> Temperature limit register writes did not account for negative numbers.
>> As a result, writing -127000 resulted in -126000 written into the
>> temperature limit register. This problem affected temp[1-3]_min,
>> temp[1-3]_max, temp[1-3]_auto_temp_crit, and temp[1-3]_auto_temp_min.
>>
>> When writing pwm[1-3]_freq, a long variable was auto-converted into an int
>> without range check. Wiring values larger than MAXINT resulted in unexpected
>> register values.
>>
>> When writing temp[1-3]_auto_temp_max, an unsigned long variable was
>> auto-converted into an int without range check. Writing values larger than
>> MAXINT resulted in unexpected register values.
>>
>> vrm is an u8, so the written value needs to be limited to [0, 255].
>>
>> Cc: Axel Lin <axel.lin@ingics.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Axel Lin <axel.lin@ingics.com>
>
>
Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
