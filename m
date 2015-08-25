From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 25 Aug 2015 15:18:30 +0000
Subject: Re: [lm-sensors] [RFC] i2c: Revert back to old device naming for ACPI enumerated I2C slaves
Message-Id: <55DC8746.1060809@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com> <20150825052513.GI1654@sirena.org.uk> <20150825145756.GA4066@schokonusskuchen.bad>
In-Reply-To: <20150825145756.GA4066-oo5tB6JMkjKRinMKxDlMNPwbnWRJjS81@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dustin Byford <dustin-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>

On 08/25/2015 07:57 AM, Wolfram Sang wrote:
> On Tue, Aug 25, 2015 at 06:25:13AM +0100, Mark Brown wrote:
>> On Mon, Aug 24, 2015 at 01:52:02PM +0300, Jarkko Nikula wrote:
>>> Commit 70762abb9f89 ("i2c: Use stable dev_name for ACPI enumerated I2C
>>> slaves") broke the lm-sensors which relies on I2C hwmon slave devices under
>>> /sys/bus/i2c/devices/ to be named as "x-00yz". However if those hwmon
>>> devices are ACPI 5 enumerated their name became "i2c-INTABCD:ij" and sysfs
>>> code in lm-sensors does not find them anymore:
>>
>> Acked-by: Mark Brown <broonie@kernel.org>
>
> Don't you think there will be regressions given that the new naming
> scheme was around for 18 months?
>

acpi is pretty long term. New bindings don't show up quickly.
So I am not surprised that this only shows up now.

Will there be regressions ? Who knows. What we do know is
that there are regressions today due to the original change.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
