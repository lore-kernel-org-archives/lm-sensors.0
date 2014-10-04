From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Oct 2014 13:34:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (iio_hwmon) Add support for humidity and power sensors
Message-Id: <542FF757.5020204@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1411832985-12619-1-git-send-email-linux@roeck-us.net> <5429988D.9060504@kernel.org> <20140929191343.GC20189@roeck-us.net> <542FDC0A.3070904@kernel.org>
In-Reply-To: <542FDC0A.3070904@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>
Cc: lm-sensors <lm-sensors@lm-sensors.org>, linux-iio@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>

On 10/04/2014 04:37 AM, Jonathan Cameron wrote:
> On 29/09/14 20:13, Guenter Roeck wrote:
>> On Mon, Sep 29, 2014 at 06:36:13PM +0100, Jonathan Cameron wrote:
>>> On 27/09/14 16:49, Guenter Roeck wrote:
>>>> The iio subsystem supports power and humidity sensors, so it makes sense
>>>> to support those sensor types in the iio-hwmon bridge as well.
>>>>
>>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> Looks good.
>>>> ---
>>>> Compile tested only.
>>>>
>>>> Question is if I got the scale conversion correct for power measurements.
>>>> I _assume_ that iio always reports processed values in milli-units,
>>>> but I am not entirely sure.
>>>
>>> IIO actually only keeps to milli units where we were copying from hwmom
>>> back when originally working this stuff out.  Given we have the double
>>> int32 representation and IIO_TYPE_* we try to keep to the base SI units
>>> everywhere else. (If we were doing it again today, I'd be advocating
>>> using base units everywhere for consistency reasons)
>>>
>> What does that mean for the iio-hwmon bridge ? Should I get the base
>> units (or scaling factors) on a per-sensor basis, or does the above apply
>> on a per-type basis ? I checked the humidity ABI (which is documented),
>> and it says that humidity is reported in milli-units.
> It's per type unfortunately.  Humidity is indeed in milli-units
> but power is probably in micro-units (as per hwmon).
> Right now it is undocumented and we only have one user so pretty much
> need to go with whatever that does (unless it's really silly).
>
> I haven't had a chance to go datasheet diving to work out what it is
> using as yet.

No problem. I'll simplify the patch and only add support for humidity for now.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
