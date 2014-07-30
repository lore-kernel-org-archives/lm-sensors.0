From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 30 Jul 2014 04:32:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm78) Fix overflow problems seen when writing large limits
Message-Id: <CAFRkauCGifb0kR=zxBtQqTdwcOUrZNFURMohZXfGBASHyTJUiQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406692349-13923-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1406692349-13923-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-07-30 11:52 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On platforms with sizeof(int) < sizeof(long), writing a temperature
> limit larger than MAXINT will result in unpredictable limit values
> written to the chip. Avoid auto-conversion from long to int to fix
> the problem.
>
> Cc: Axel Lin <axel.lin@ingics.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
The patch looks good to me, so
Reviewed-by: Axel Lin <axel.lin@ingics.com>

BTW, seems other drivers have similar issue:
$ grep "TEMP_TO_REG(int" drivers/hwmon/*.c
drivers/hwmon/dme1737.c:static inline int TEMP_TO_REG(int val)
drivers/hwmon/lm77.c:static inline s16 LM77_TEMP_TO_REG(int temp)
drivers/hwmon/lm78.c:static inline s8 TEMP_TO_REG(int val)
drivers/hwmon/lm92.c:static inline s16 TEMP_TO_REG(int val)
drivers/hwmon/sis5595.c:static inline s8 TEMP_TO_REG(int val)
drivers/hwmon/smsc47m192.c:static inline s8 TEMP_TO_REG(int val)

Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
