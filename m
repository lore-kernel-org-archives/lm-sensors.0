From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 29 Sep 2011 20:08:30 +0000
Subject: Re: [lm-sensors] [PATCH V3] hwmon: ad7314 driver (ported from IIO).
Message-Id: <4E84D03E.3010505@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E849EC4.5070603@cam.ac.uk>  <1317315004-1498-1-git-send-email-jic23@cam.ac.uk> <1317317119.3888.164.camel@groeck-laptop>
In-Reply-To: <1317317119.3888.164.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "Device-drivers-devel@blackfin.uclinux.org" <Device-drivers-devel@blackfin.uclinux.org>

On 09/29/11 18:25, Guenter Roeck wrote:
> Hi Jonathan,
> 
> On Thu, 2011-09-29 at 12:50 -0400, Jonathan Cameron wrote:
>> Currently dropped power down mode support.
>>
>> V3:
>> Guenter's suggestions
>> - typos
>> - DIV_ROUND_NEAREST use
>> - Actually register hwmon driver.
>>
>> V2: Fixes:
>> - messed up use of cache aligned store fixed.
>> - correct output format to be milli degrees.
>> - add documentation file.
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Applied to -next, with one other minor update.
> 
>> ---
>>  Documentation/hwmon/ad7314 |   25 ++++++
>>  drivers/hwmon/Kconfig      |   10 +++
>>  drivers/hwmon/Makefile     |    1 +
>>  drivers/hwmon/ad7314.c     |  185 ++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 221 insertions(+), 0 deletions(-)
>>
> [ ... ]
> 
>> +
>> +static const struct spi_device_id ad7314_id[] = {
>> +	{ "adt7301", adt7301 },
>> +	{ "adt7302", adt7302 },
>> +	{ "ad7314", ad7314 },
>> +	{}
>> +};
> 
> MODULE_DEVICE_TABLE(spi, ad7314_id);
Good point.  I'll kill off the IIO driver tomorrow.

Thanks,

Jonathan
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
