From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Mon, 28 Feb 2011 03:51:36 +0000
Subject: Re: [lm-sensors] [PATCH 2/2 v2] hwmon: twl4030: Hwmon Driver for
Message-Id: <AANLkTinUbBsRhWnVHMA_1BKq3StH+xrTOEnXHCwkKMPL@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298560730-18826-1-git-send-email-j-keerthy@ti.com>
	<20110228010306.GE2749@sortiz-mobl>
	<20110228034108.GA2584@ericsson.com>
In-Reply-To: <20110228034108.GA2584@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Feb 28, 2011 at 9:11 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Sun, Feb 27, 2011 at 08:03:07PM -0500, Samuel Ortiz wrote:
>> Hi Keerthy,
>>
>> On Thu, Feb 24, 2011 at 08:48:50PM +0530, Keerthy wrote:
>> > This driver exposes the sysfs nodes of the TWL4030 MADC module.
>> > All the voltage channel values are expressed in terms of mV. Channel 13
>> > and channel 14 are reserved. There are channels which represent
>> > temperature and current the output is represented by celcius
>> > and mA respectively.
>> It would make sense for me to carry both patches through the MFD tree, but
>> I'd like to get Guenter's ACK before pushing it upstream.
>>
> Main problem I have with the hwmon part is the sensor index value
> and how it maps to adc channels. Specifically, channels 13 and 14 are
> listed as reserved, yet index value 13 is used without further explanation
> as bit map value passed on to twl4030_madc_conversion() to obtain the value
> for channel 15. Either this is wrong, or it asks for a detailed explanation.
> I didn't have time to track down which one it is. And even if it isn't wrong,
> it doesn't seem to be the right thing to do since it adds a lot of confusion.
>
> Guenter
>

Guenter,

It should be 15. I will repost with the changed value.
Sorry for the confusion.

Regards,
Keerthy



-- 
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
