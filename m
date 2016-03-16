From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
Date: Wed, 16 Mar 2016 15:16:37 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] Add support for MAX31722/MAX31723 temperature sensors
Message-Id: <4586F61A4A291F4DA44D32824E7C0F4023569024@IRSMSX109.ger.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457530252-4984-1-git-send-email-tiberiu.a.breana@intel.com>
 <56E08834.40704@kernel.org>
 <4586F61A4A291F4DA44D32824E7C0F4023568DEC@IRSMSX109.ger.corp.intel.com>
 <56E80F61.4000304@roeck-us.net>
 <C29C9659-14E3-434B-ACC8-374BBCB2EB72@jic23.retrosnub.co.uk>
 <20160315183015.GA18236@roeck-us.net>
In-Reply-To: <20160315183015.GA18236@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "Baluta, Daniel" <daniel.baluta@intel.com>

> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-
> owner@vger.kernel.org] On Behalf Of Guenter Roeck
> Sent: Tuesday, March 15, 2016 8:30 PM
> To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> Cc: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; LM Sensors <lm-
> sensors@lm-sensors.org>; Jonathan Cameron <jic23@kernel.org>; linux-
> iio@vger.kernel.org; Baluta, Daniel <daniel.baluta@intel.com>
> Subject: Re: [PATCH 0/2] Add support for MAX31722/MAX31723
> temperature sensors
> 
> On Tue, Mar 15, 2016 at 05:28:58PM +0000, Jonathan Cameron wrote:
> >
> >
> > On 15 March 2016 13:34:25 GMT+00:00, Guenter Roeck <linux@roeck-
> us.net> wrote:
> > >On 03/15/2016 05:58 AM, Breana, Tiberiu A wrote:
> > >> Hello Guenter, hwmon,
> > >>
> > >> We have a dilemma as to wether this device driver belongs in IIO or
> > >hwmon:
> > >> https://datasheets.maximintegrated.com/en/ds/MAX31722-
> MAX31723.pdf
> > >>
> > >> Could you please give us your opinion on this?
> > >
> > >The chip has limit registers and an alarm signal output, suggesting
> > >that its intended use is for hardware monitoring purposes.
> > >
> > >The conversion time is between 50ms and 200ms, which suggests that
> > >the faster ABI provided by iio isn't really beneficial.
> > >
> > >Given all that, I think that hwmon would be a better place.
> > Agreed.
> > >
> > >If you want to keep the driver in iio, I would suggest to consider
> > >enhancing the iio-hwmon bridge with threshold/limit support if that
> > >is possible.
> >
> > Possible but non trivial as no one has yet implemented the core
> > support for allowing in kernel consumers to get events. It has been on
> > the to-do list as a blocker of iio  on IIO (which is really about
> > reaching the point where the IIO userspace front end is an optional
> > nonspecial case consumer of  IIO backends). Would be excellent to have
> this but may not be that straight forward.
> >
> I concluded that much as well after looking into it a bit more. Not just event
> handling, but the ability to set and get thresholds is missing from the kernel
> API as well. Yes, this will need some work. It would be useful, though, for
> other drivers such as max1363. If it ever gets done, please let me know, and
> I'll see if I can help testing it.
> 
> Guenter

Thanks for your insight on this. I'll rewrite the driver for hwmon.

Tiberiu

> 
> > Jonathan
> > >This would ensure that the chip can be used for its intended purpose.
> > >
> > >Thanks,
> > >Guenter
> > >
> > >> Thanks,
> > >>
> > >> Tiberiu
> > >>
> > >>> -----Original Message-----
> > >>> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-
> > >>> owner@vger.kernel.org] On Behalf Of Jonathan Cameron
> > >>> Sent: Wednesday, March 9, 2016 10:32 PM
> > >>> To: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; linux-
> > >>> iio@vger.kernel.org
> > >>> Subject: Re: [PATCH 0/2] Add support for MAX31722/MAX31723
> > >>> temperature sensors
> > >>>
> > >>> On 09/03/16 13:30, Tiberiu Breana wrote:
> > >>>> This patch set adds support for the MAX31722/MAX31723
> temperature
> > >>>> sensors / thermostats.
> > >>>> Patch 1 adds basic support and power management.
> > >>>> Patch 2 adds threshold interrupt support.
> > >>>>
> > >>>> Tiberiu Breana (2):
> > >>>>    iio: temperature: Add support for MAX31722/MAX31723
> temperature
> > >>>>      sensors
> > >>>>    iio: temperature: Add threshold interrupt support for max31722
> > >>>>
> > >>>>   drivers/iio/temperature/Kconfig    |  12 +
> > >>>>   drivers/iio/temperature/Makefile   |   1 +
> > >>>>   drivers/iio/temperature/max31722.c | 673
> > >>>> +++++++++++++++++++++++++++++++++++++
> > >>>>   3 files changed, 686 insertions(+)
> > >>>>   create mode 100644 drivers/iio/temperature/max31722.c
> > >>>>
> > >>> Hi Tiberiu,
> > >>>
> > >>> When proposing a temperature sensor driver, we need some
> > >>> additional justification for why it is suited for IIO rather than
> > >>> the more
> > >focused (and in
> > >>> someways simpler) hwmon.
> > >>>
> > >>> So far we have had thermophiles that don't fit in as devices
> > >typically used for
> > >>> hardware monitoring. Also in there are a few drivers which are for
> > >parts
> > >>> where they are a cut down version of a more complex sensor (the
> > >>> measurement specialties parts are either pressure sensors or
> > >>> humidty sensors at least in terms of what they share interfaces
> > >>> with)
> > >>>
> > >>> Also, please cc the hwmon maintainers (and probably list) as we
> > >>> want
> > >their
> > >>> agreement.
> > >>>
> > >>> Jonathan
> > >>> --
> > >>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
> > >in the body
> > >>> of a message to majordomo@vger.kernel.org More majordomo info at
> > >>> http://vger.kernel.org/majordomo-info.html
> > >>
> > >
> > >--
> > >To unsubscribe from this list: send the line "unsubscribe linux-iio"
> > >in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > >info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > Sent from my Android device with K-9 Mail. Please excuse my brevity.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
