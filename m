From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 20 Jul 2014 23:44:42 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (tmp421) Add support for TMP441 and TMP442
Message-Id: <53CC546A.5030707@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404680101-8843-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1404680101-8843-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/20/2014 10:08 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sun,  6 Jul 2014 13:55:00 -0700, Guenter Roeck wrote:
>> TMP441 and TMP442 are compatible to TMP421 and TMP422.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   Documentation/hwmon/tmp421 | 22 +++++++++++++++-------
>>   drivers/hwmon/Kconfig      |  2 +-
>>   drivers/hwmon/tmp421.c     | 19 ++++++++++++++++---
>>   3 files changed, 32 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/hwmon/tmp421 b/Documentation/hwmon/tmp421
>> index d0e7714..eac5423 100644
>> --- a/Documentation/hwmon/tmp421
>> +++ b/Documentation/hwmon/tmp421
>> @@ -14,6 +14,14 @@ Supported chips:
>>       Prefix: 'tmp423'
>>       Addresses scanned: I2C 0x4c and 0x4d
>>       Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
>> +  * Texas Instruments TMP441
>> +    Prefix: 'tmp441'
>> +    Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
>> +    Datasheet: http://www.ti.com/product/tmp441
>> +  * Texas Instruments TMP442
>> +    Prefix: 'tmp442'
>> +    Addresses scanned: I2C 0x4c and 0x4d
>> +    Datasheet: http://www.ti.com/product/tmp441
>
> /tmp442
>
>>
>>   Authors:
>>   	Andre Prendel <andre.prendel@gmx.de>
>> (...)
>
> Everything else looks good. You may want to update the
> MODULE_DESCRIPTION too, as it says TMP421/422/423.
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
> Please also add the TMP441 and TMP442 to wiki/Devices.
>

Fixed, and done.

Thanks a lot for the reviews!

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
