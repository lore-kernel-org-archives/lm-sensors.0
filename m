From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 09 Nov 2013 17:28:46 +0000
Subject: Re: [lm-sensors] [PATCHv0] hwmon: Add support for GMT G751 Temp. Sensor and Thermal Watchdog
Message-Id: <87fvr5h4c1.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ob5uv5bv.fsf@natisbad.org> <527D9286.4080009@roeck-us.net>
	<87siv5bmcp.fsf@natisbad.org> <527E6908.2000703@roeck-us.net>
In-Reply-To: <527E6908.2000703@roeck-us.net> (Guenter Roeck's message of "Sat,
	09 Nov 2013 08:55:36 -0800")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Guenter,

Guenter Roeck <linux@roeck-us.net> writes:

>> Sadly (for me), you are not: I compared the GMT G751 datasheet to an
>> original (1996) National semiconductor LM75 datasheet and they are
>> identical. I mean both the structure and full content (text, diagrams,
>> etc) is the same. Lesson learned: next time I start a driver, I will ask
>> if it ressembles an existing supported chip beforehand.
>>
>
> Hi Arnaud,
>
> that is interesting; I thought it is Yet Another Clone, not really exactly
> the same chip.

If you want to compare:

http://www.ieap.uni-kiel.de/surface/ag-berndt/lehre/fpmc/ns/lm75.pdf
http://natisbad.org/NAS4/refs/GMT_G751.pdf

>>> Please use the lm75 driver and add the g751 parameters to it.
>>
>> I will test if the driver does indeed work as expected to drive the G751
>> and will send a patch to document compatibility w/ GMT G751 (Kconfig,
>> i2c_device_id struct and lm75_detect function). While I am at it, if you
>> see something in the patch I pushed which could be useful for current
>> lm75 driver (doc, sysfs, of_ part for polarity, ...), just tell me.
>>
>
> Depends on what you need. The fault_queue and mode sysfs attributes are neither
> necessary nor  acceptable - hwmon has well defined attributes, and new ones
> are only added after discussion. If you _need_ to configure polarity,
> interrupt mode, or fault queue depth in your application to anything but
> the default, we might discuss adding those as devicetree properties.
> However, you would have to make sure that it does not negatively affect
> the other chips supported by the driver, and we should then discuss
> if other properties should be supported as well. Overall, I strongly suspect
> that the HW is happy with the default configuration. If so, we should just leave
> it alone.

Let's keep lm75 in I2C trivial devices list.

> Power control (the shutdown attribute) should be handled through the PM
> subsystem; see CONFIG_PM / CONFIG_PM_SLEEP in other drivers. If your hardware
> can sleep (which may be somewhat unlikely for a NAS),

lm75 driver does have #ifdef CONFIG_PM (or am I missing something?), but
you are right, I don't think the NAS can take advantage of it ATM.

I just finished the a first version of a patch for lm75 to reference
g751. I'll send it in a separate email.

Anyway, thanks for the quick feedback.

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
