From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Jul 2014 04:45:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm78) Fix overflow problems seen when writing large limits
Message-Id: <53D87851.6020804@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406692349-13923-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1406692349-13923-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/29/2014 09:32 PM, Axel Lin wrote:
> 2014-07-30 11:52 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
>> On platforms with sizeof(int) < sizeof(long), writing a temperature
>> limit larger than MAXINT will result in unpredictable limit values
>> written to the chip. Avoid auto-conversion from long to int to fix
>> the problem.
>>
>> Cc: Axel Lin <axel.lin@ingics.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> The patch looks good to me, so
> Reviewed-by: Axel Lin <axel.lin@ingics.com>
>
Thanks!

> BTW, seems other drivers have similar issue:
> $ grep "TEMP_TO_REG(int" drivers/hwmon/*.c
> drivers/hwmon/dme1737.c:static inline int TEMP_TO_REG(int val)
> drivers/hwmon/lm77.c:static inline s16 LM77_TEMP_TO_REG(int temp)
> drivers/hwmon/lm78.c:static inline s8 TEMP_TO_REG(int val)
> drivers/hwmon/lm92.c:static inline s16 TEMP_TO_REG(int val)
> drivers/hwmon/sis5595.c:static inline s8 TEMP_TO_REG(int val)
> drivers/hwmon/smsc47m192.c:static inline s8 TEMP_TO_REG(int val)
>

I usually find those problems when running module tests; one of the tests
explicitly tries to trigger this kind of overflow (long -> int).
Works pretty well...

Add lm85 to the list, with several issues all over the place. I am right
now working on that one. The smsc47m192 problem is already fixed; I found
that when I tested your patch. Patches for the others are welcome :-).
Those would take a bit to apply, though, since I'll want to have
module tests to ensure that the drivers don't have any other problems.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
