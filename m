From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 12 Jun 2014 12:06:23 +0000
Subject: Re: [lm-sensors] [PATCH 09/13] hwmon: Driver for TI TMP103 temperature sensor
Message-Id: <539997BF.7040906@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402468095-14678-1-git-send-email-hs@denx.de> <53988DC1.7000203@roeck-us.net> <53997544.5090106@denx.de>
In-Reply-To: <53997544.5090106@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hs@denx.de
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org

On 06/12/2014 02:39 AM, Heiko Schocher wrote:
> Hello Guenter,
[ ... ]
>>
>> Overall you might consider dropping the update function and using regmap instead.
>> It would be an excellent fit for this driver; while it doesn't do timed caching
>> it supports per-register caching which is ultimately more useful anyway.
>> Some of the drivers in the hwmon directory use it, so you could use that
>> as example. Not mandatory, though; just a suggestion.
>
> Could you give me an example?
>
Hello Heiko,

check for the use of regmap in drivers/hwmon. Any of the drivers using it can serve
as example.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
