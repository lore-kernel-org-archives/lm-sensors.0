From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 09 Nov 2013 15:56:06 +0000
Subject: Re: [lm-sensors] [PATCHv0] hwmon: Add support for GMT G751 Temp. Sensor and Thermal Watchdog
Message-Id: <87siv5bmcp.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ob5uv5bv.fsf@natisbad.org> <527D9286.4080009@roeck-us.net>
In-Reply-To: <527D9286.4080009@roeck-us.net> (Guenter Roeck's message of "Fri,
	08 Nov 2013 17:40:22 -0800")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi,

Guenter Roeck <linux@roeck-us.net> writes:

> On 11/08/2013 03:31 PM, Arnaud Ebalard wrote:
>>
>> This patch adds support for GMT G751 Temperature Sensor and Thermal
>> Watchdog I2C chip. It has been tested via DT on a Netgear ReadyNAS
>> 2120 (Marvell Armada XP based ARM device).
>>
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>
> Arnaud,
>
> unless I am missing something, this is just an lm75 with a different
> name. 

Sadly (for me), you are not: I compared the GMT G751 datasheet to an
original (1996) National semiconductor LM75 datasheet and they are
identical. I mean both the structure and full content (text, diagrams,
etc) is the same. Lesson learned: next time I start a driver, I will ask
if it ressembles an existing supported chip beforehand.

> Please use the lm75 driver and add the g751 parameters to it.

I will test if the driver does indeed work as expected to drive the G751
and will send a patch to document compatibility w/ GMT G751 (Kconfig,
i2c_device_id struct and lm75_detect function). While I am at it, if you
see something in the patch I pushed which could be useful for current
lm75 driver (doc, sysfs, of_ part for polarity, ...), just tell me.

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
