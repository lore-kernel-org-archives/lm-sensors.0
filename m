From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Jun 2014 07:00:15 +0000
Subject: Re: [lm-sensors] [PATCH]: hwmon: (pmbus) Add tps40422 front-end driver
Message-Id: <53B10AFF.80105@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <E9BC5E534B6C564CA4B01BC388FD1B5A344175BE@SGSIMBX007.nsn-intra.net>
In-Reply-To: <E9BC5E534B6C564CA4B01BC388FD1B5A344175BE@SGSIMBX007.nsn-intra.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/29/2014 11:50 PM, Guenter Roeck wrote:
> On 06/29/2014 11:16 PM, Zhu, Richard (NSN - CN/Beijing) wrote:
>> Hi Guenter,
>>
>> This is the re-work version of the driver, I fixed the errors except this one:
>> "Please drop the GNU mailing address (checkpatch notifies you about this)."
>> Because I don't know what the email is, and checkpatch output is paste below:
>> [e12606@ulegcptom linux]$ ./scripts/checkpatch.pl  patches/tps40422.patch
>> total: 0 errors, 0 warnings, 107 lines checked
>>
>> patches/ tps40422.patch has no obvious style problems and is ready for submission.
>>
> I didn't say e-mail address, I said mailing address. See below.
>
>> Thanks,
>>
>> BR
>> Richard
>>
>>
>> [PATCH]: hwmon: (pmbus) Add tps40422 front-end driver
>>
>> For TI power management chip TPS40422, READ_TEMPERATURE_2 command is supported on
>> page 1 of the chip, but the original driver(pmbus.c) only tried to detect this command
>> on page 0, this will lead to a result that the temperature sensor in page 1 couldn't
>> be detected. This change is to isolate the tps40422 driver from pmbus.c into a solo
>> front-end driver.
>>
>> Signed-off-by: Zhu Laiwen <richard.zhu@nsn.com>
>>
>> diff -uprN a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>> --- a/drivers/hwmon/pmbus/Kconfig    2014-06-27 10:07:38.728983000 +0200
>> +++ b/drivers/hwmon/pmbus/Kconfig    2014-06-30 07:58:32.017883000 +0200
>> @@ -20,8 +20,7 @@ config SENSORS_PMBUS
>>       help
>>         If you say yes here you get hardware monitoring support for generic
>>         PMBus devices, including but not limited to ADP4000, BMR453, BMR454,
>> -      MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012, UDT020, TPS40400,
>> -      and TPS40422.
>> +      MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012, UDT020, and TPS40400.
>>
>>         This driver can also be built as a module. If so, the module will
>>         be called pmbus.
>> @@ -87,6 +86,16 @@ config SENSORS_MAX8688
>>         This driver can also be built as a module. If so, the module will
>>         be called max8688.
>>
>> +config SENSORS_TPS40422
>> +    tristate "TI TPS40422"
>> +    default n
>> +    help
>> +      If you say yes here you get hardware monitoring support for TI
>> +      TPS40422.
>> +
>> +      This driver can also be built as a module. If so, the module will
>> +      be called tps40422.
>> +
>>   config SENSORS_UCD9000
>>       tristate "TI UCD90120, UCD90124, UCD9090, UCD90910"
>>       default n
>> diff -uprN a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>> --- a/drivers/hwmon/pmbus/Makefile    2014-06-27 10:07:38.716971000 +0200
>> +++ b/drivers/hwmon/pmbus/Makefile    2014-06-30 07:29:31.045045000 +0200
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_SENSORS_LTC2978)    += ltc2978
>>   obj-$(CONFIG_SENSORS_MAX16064)    += max16064.o
>>   obj-$(CONFIG_SENSORS_MAX34440)    += max34440.o
>>   obj-$(CONFIG_SENSORS_MAX8688)    += max8688.o
>> +obj-$(CONFIG_SENSORS_TPS40422)    += tps40422.o
>>   obj-$(CONFIG_SENSORS_UCD9000)    += ucd9000.o
>>   obj-$(CONFIG_SENSORS_UCD9200)    += ucd9200.o
>>   obj-$(CONFIG_SENSORS_ZL6100)    += zl6100.o
>> diff -uprN a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
>> --- a/drivers/hwmon/pmbus/pmbus.c    2014-06-27 10:07:38.748979000 +0200
>> +++ b/drivers/hwmon/pmbus/pmbus.c    2014-06-27 10:08:20.023123000 +0200
>> @@ -193,7 +193,6 @@ static const struct i2c_device_id pmbus_
>>       {"pdt012", 1},
>>       {"pmbus", 0},
>>       {"tps40400", 1},
>> -    {"tps40422", 2},
>>       {"udt020", 1},
>>       {}
>>   };
>> diff -uprN a/drivers/hwmon/pmbus/tps40422.c b/drivers/hwmon/pmbus/tps40422.c
>> --- a/drivers/hwmon/pmbus/tps40422.c    1970-01-01 01:00:00.000000000 +0100
>> +++ b/drivers/hwmon/pmbus/tps40422.c    2014-06-30 07:43:11.994794000 +0200
>> @@ -0,0 +1,68 @@
>> +/*
>> + * Hardware monitoring driver for TI TPS40422
>> + *
>> + * Copyright (c) 2014 Nokia Solutions and Networks.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>
> Above paragraph. Reasoning is that the mailing address keeps changing,
> the paragraph is unnecessary, and should thus not be provided in source
> files. No need to re-send, though; I can fix that up myself.
>
> Unless I find some other problem, consider the patch applied to -next.
>

Hi Richard,

found something, after all.

Documentation/hwmon/pmbus - need to drop tps40422.
Also, you'll need to provide Documentation/hwmon/tps40422.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
