From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sat, 16 Feb 2013 15:54:18 +0000
Subject: Re: [lm-sensors] [PATCH 7/9] hwmon: (adt7410) Add support for the adt7310/adt7320
Message-Id: <511FABAA.90400@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de> <1360947438-2550-7-git-send-email-lars@metafoo.de> <511E951C.6090604@gmx.de>
In-Reply-To: <511E951C.6090604@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On 02/15/2013 09:05 PM, Hartmut Knaack wrote:
> I had a quick look over your patches and found some minor typo, see below. I will apply all the patches to see the result.
> Also keep in mind to add some changes to Documentation/hwmon/adt7410 (and add an adt7310 as well?).

yep, forgot about the documentation, will do this in v2. But I don't think it
makes sense to have to separate documents for the adt7410 and adt7310, the
devices really only differ in their interface and all of the real driver logic
is implemented in the common code.

> 
> Lars-Peter Clausen schrieb:
> <...>
>> diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
>> new file mode 100644
>> index 0000000..0483e6c
>> --- /dev/null
>> +++ b/drivers/hwmon/adt7310.c
>> @@ -0,0 +1,160 @@
>> +/*
>> + * ADT7310/ADT7310 digital temperature sensor driver
>> + *
>> + * Copyright 2010-2013 Analog Devices Inc.
>> + *   Author: Lars-Peter Clausen <lars@metafoo.de>
>> + *
>> + * Licensed under the GPL-2 or later.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include "adt7x10.h"
>> +
>> +static const u8 adt7371_reg_table[] = {
>> +	[ADT7410_TEMPERATURE]   = ADT7310_TEMPERATURE,
>> +	[ADT7410_STATUS]	= ADT7310_STATUS,
>> +	[ADT7410_CONFIG]	= ADT7310_CONFIG,
>> +	[ADT7410_T_ALARM_HIGH]	= ADT7310_T_ALARM_HIGH,
>> +	[ADT7410_T_ALARM_LOW]	= ADT7310_T_ALARM_LOW,
>> +	[ADT7410_T_CRIT]	= ADT7310_T_CRIT,
>> +	[ADT7410_T_HYST]	= ADT7310_T_HYST,
>> +	[ADT7410_ID]		= ADT7310_ID,
>> +};
> Just out of curiousity, whats the reason for the name adt7371 here?

That's also a typo. And don't ask we how I got from adt7310 to adt7371, I have
no idea.

[...]
>> +
>> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>> +MODULE_DESCRIPTION("ADT7310/ADT7420 driver");
> This should be ADT7310/ADT7320, right?

Yes, fixed.

>> +MODULE_LICENSE("GPL");
> <...>
>> --- /dev/null
>> +++ b/drivers/hwmon/adt7x10.c
>> @@ -0,0 +1,476 @@
[...]
>> +
>> +MODULE_AUTHOR("Hartmut Knaack");
>> +MODULE_DESCRIPTION("ADT7410 driver");
> This description does not seem appropriate any longer.

Changed it to "ADT7410/ADT7420, ADT7310/ADT7320 common code".

Thanks,
- Lars

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
