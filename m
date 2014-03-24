From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Date: Mon, 24 Mar 2014 07:48:37 +0000
Subject: Re: [lm-sensors] [RFC V1 1/3] hwmon: da9063: HWMON driver
Message-Id: <6ED8E3B22081A4459DAC7699F3695FB7A2AFC2F2@SW-EX-MBX01.diasemi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1395607051.git.stwiss.opensource@diasemi.com>
 <420d4f5c8436a66b511693531cfeda131258ce69.1395607051.git.stwiss.opensource@diasemi.com>
 <532FA8ED.2090201@roeck-us.net>
In-Reply-To: <532FA8ED.2090201@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: David Dajun Chen <david.chen@diasemi.com>, LINUX-DOC <linux-doc@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LM-SENSORS <lm-sensors@lm-sensors.org>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Landley <rob@landley.net>, Samuel Ortiz <sameo@linux.intel.com>

On 24 March 2014 03:39, Guenter Roeck wrote:

>On 03/23/2014 01:37 PM, Opensource [Steve Twiss] wrote:
>> From: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
>>
>> Add the HWMON driver for DA9063
>>
>> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
>> ---
>> Checks performed with linux-next/next-20140321/scripts/checkpatch.pl
>>   da9063-hwmon.c            total: 0 errors, 0 warnings, 456 lines checked
>>   Kconfig                   total: 1 errors, 3 warnings, 1643 lines checked
>>   Makefile                  total: 0 errors, 0 warnings, 154 lines checked
>>   registers.h               total: 0 errors, 0 warnings, 1066 lines checked
>> There are errors and warning in Kconfig, however they are not caused
>> by this patch.
>>
>> This is the hardware monitor driver component for DA9063 PMIC.
>>
>> The manual measurement allows monitoring of the system voltage
>> VSYS, the auxiliary channels ADCIN1, ADCIN2 and ADCIN3, VBBAT
>> measures of the backup battery voltage and a Tjunc value for the
>> internal junction temperature sensor.
>>
>
>At least this part belongs into the summary.
>
>After browsing through patch 2/3, I got suspicious and tried to compile
>the driver after applying this patch.
>
>Here is the result:
>
>drivers/hwmon/da9063-hwmon.c: In function 'da9063_adc_manual_read':
>drivers/hwmon/da9063-hwmon.c:155:2: warning: suggest parentheses around
>comparison in operand of '&' [-Wparentheses]
>drivers/hwmon/da9063-hwmon.c: In function 'da9063_hwmon_probe':
>drivers/hwmon/da9063-hwmon.c:386:14: error: 'struct da9063_pdata' has no
>member named 'hwmon_pdata'
>drivers/hwmon/da9063-hwmon.c:387:14: error: 'struct da9063_pdata' has no
>member named 'hwmon_pdata'
>drivers/hwmon/da9063-hwmon.c:388:14: error: 'struct da9063_pdata' has no
>member named 'hwmon_pdata'
>drivers/hwmon/da9063-hwmon.c:417:50: error: 'struct da9063' has no member
>named 't_offset'
>make[1]: *** [drivers/hwmon/da9063-hwmon.o] Error 1
>make: *** [drivers/hwmon/da9063-hwmon.ko] Error 2
>
>Please make sure that each patch, if applied one after another, compiles.
>Patch 1/3 must not depend on patch 2/3.

Hi Guenter,

Thank you for this fast response.

Ah, the dependencies were not in order. I will check for that in future.

I will also look into using the API with devm_hwmon_device_register_with_groups
and will resubmit with a RFC V2 later.

Thank you,
Steve

>
>Thanks,
>Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
