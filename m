From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Sat, 26 Feb 2011 10:43:49 +0000
Subject: Re: [lm-sensors] [PATCH v4 4/5] hwmon: (pmbus) Add support for
Message-Id: <4D68D965.7040307@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297969217-9564-1-git-send-email-guenter.roeck@ericsson.com>	 <1297969217-9564-5-git-send-email-guenter.roeck@ericsson.com>	 <4D681425.3010503@cam.ac.uk> <1298669577.1735.99.camel@groeck-laptop>
In-Reply-To: <1298669577.1735.99.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <kernel@jic23.retrosnub.co.uk>, Randy Dunlap <rdunlap@xenotime.net>, Greg Schnorr <gschnorr@cisco.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 02/25/11 21:32, Guenter Roeck wrote:
> Hi Jonathan,
> 
> On Fri, 2011-02-25 at 15:42 -0500, Jonathan Cameron wrote:
>> One trivial formatting nitpick.
>> Dug out datasheet for this one..
>> I'm a little unclear how value from there map to those stored in here...
> [ ... ]
> 
>>> +static struct pmbus_driver_info max34440_info[] = {
>>> +	[max34440] = {
>>> +		.pages = 14,
>>> +		.direct[PSC_VOLTAGE_IN] = true,
>>> +		.direct[PSC_VOLTAGE_OUT] = true,
>>> +		.direct[PSC_TEMPERATURE] = true,
>>> +		.direct[PSC_CURRENT_OUT] = true,
>>> +		.m[PSC_VOLTAGE_IN] = 1,
>>> +		.b[PSC_VOLTAGE_IN] = 0,
>>> +		.R[PSC_VOLTAGE_IN] = 3,
>>> +		.m[PSC_VOLTAGE_OUT] = 1,
>>> +		.b[PSC_VOLTAGE_OUT] = 0,
>>> +		.R[PSC_VOLTAGE_OUT] = 3,
>>> +		.m[PSC_CURRENT_OUT] = 1,
>>> +		.b[PSC_CURRENT_OUT] = 0,
>>> +		.R[PSC_CURRENT_OUT] = 3,
>> Table 3 of datasheet says R for current is 0... I may be missing
>> something though!  
> 
> At least this one has a relatively simple reason ;).
> 
> The base unit (to which R is applied to) in the datasheet is mV and mA.
> The base unit used by max8688 and max16064 is V and A. Chips in linear
> mode also use V and A. I had the choice of either adjusting the code to
> expect mV and mA for all chips, or to expect V and A for all chips. I
> decided to use the latter for consistency, and to adjust R in the core
> driver to the units expected to be reported in the sysfs attributes. For
> max34440/max34441, the adjustment ends up being 0 either way (3 + (-3)
> in one direction and (-3) + 3 in the other).
This reason actually occurred to me whilst cycling home but thanks for
clarifying this.
> 
> Another option would be to not do any sysfs related adjustments in the
> core driver, but to do all adjustments via platform data instead. I
> decided against that because the code to handle linear mode (which
> expects V and A) would no longer match the code to handle direct mode,
> which might cause even more confusion.
What you have works fine for me though you'll have to keep a close eye
on any drivers submitted by others as this will be easy to get wrong
as people will blindly fill tables in from datasheets.

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Thanks,
> Guenter
> 
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
