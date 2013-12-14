From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Dec 2013 19:50:13 +0000
Subject: Re: [lm-sensors] [PATCH 00/12] i8k patch series
Message-Id: <52ACB675.6060304@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387042221-3671-1-git-send-email-linux@roeck-us.net>	<201312141945.20348.arnd@arndb.de> <20131214200309.3a2007f4@endymion.delvare>
In-Reply-To: <20131214200309.3a2007f4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Matthew Garrett <mjg59@srcf.ucam.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>

On 12/14/2013 11:03 AM, Jean Delvare wrote:
> On Sat, 14 Dec 2013 19:45:19 +0100, Arnd Bergmann wrote:
>> On Saturday 14 December 2013, Guenter Roeck wrote:
>>> Clean up and simplify the driver, add support for additional temperature
>>> sensors, fix a problem seen with multi-core CPU, and add support
>>> for additional systems.
>>>
>>> ----------------------------------------------------------------
>>> Guenter Roeck (14):
>>>        i8k: Convert to use pr_ functions instead of printk
>>>        i8k: Fix various checkpatch warnings and errors
>>>        i8k: Convert to use to hwmon_device_register_with_groups hwmon API
>>>        i8k: Support additional temperature sensors
>>>        MAINTAINERS: Add myself as i8k maintainer
>>>        i8k: Remove obsolete link to out-of-tree driver
>>>        i8k: Drop driver version number and info message at startup
>>>        i8k: Force SMM to run on CPU 0
>>>        i8k: Add copyright
>>>        i8k: Add support for Dell Studio laptops
>>>        i8k: Add support for Dell XPS M140
>>>        i8k: Use driver_data field of dmi_system_id to override fan multiplier
>>>        i8k: Stop reading SMM BIOS version during driver probe
>>>        i8k: Implement hwmon based fan speed control
>>>
>>>   MAINTAINERS        |    2 +-
>>>   drivers/char/i8k.c |  358 +++++++++++++++++++++++++++++-----------------------
>>>   2 files changed, 201 insertions(+), 159 deletions(-)
>>>
>>
>> All changes in this patch set look good to me.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>
>> I wonder if it makes sense to move the driver to drivers/platform/x86/, which
>> has a bunch of similar ones already.
>
> That would be a good idea IMHO.
>

I agree; drivers/char doesn't seem to be a good location. Guess it is mostly historic
that it is there in the first place. Maybe it can even use the API provided by the
dell-laptop driver if I can ever figure out how that works.

Copying the platform-x86 mailing list and Matthew for additional input.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
