From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
Date: Tue, 15 Mar 2016 13:16:56 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] Add support for MAX31722/MAX31723 temperature sensors
Message-Id: <4586F61A4A291F4DA44D32824E7C0F4023568E0D@IRSMSX109.ger.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457530252-4984-1-git-send-email-tiberiu.a.breana@intel.com>
 <56E08834.40704@kernel.org>,<4586F61A4A291F4DA44D32824E7C0F4023568DEC@IRSMSX109.ger.corp.intel.com>
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F4023568DEC@IRSMSX109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux@roeck-us.net" <linux@roeck-us.net>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>
Cc: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "Baluta, Daniel" <daniel.baluta@intel.com>

Forwarding to the proper list address.
________________________________________
From: linux-iio-owner@vger.kernel.org [linux-iio-owner@vger.kernel.org] on behalf of Breana, Tiberiu A [tiberiu.a.breana@intel.com]
Sent: Tuesday, March 15, 2016 2:58 PM
To: linux@roeck-us.net; lm-sensors@vger.kernel.org
Cc: Jonathan Cameron; linux-iio@vger.kernel.org; Baluta, Daniel
Subject: RE: [PATCH 0/2] Add support for MAX31722/MAX31723 temperature sensors

Hello Guenter, hwmon,

We have a dilemma as to wether this device driver belongs in IIO or hwmon:
https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf

Could you please give us your opinion on this?
Thanks,

Tiberiu

> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-
> owner@vger.kernel.org] On Behalf Of Jonathan Cameron
> Sent: Wednesday, March 9, 2016 10:32 PM
> To: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; linux-
> iio@vger.kernel.org
> Subject: Re: [PATCH 0/2] Add support for MAX31722/MAX31723
> temperature sensors
>
> On 09/03/16 13:30, Tiberiu Breana wrote:
> > This patch set adds support for the MAX31722/MAX31723 temperature
> > sensors / thermostats.
> > Patch 1 adds basic support and power management.
> > Patch 2 adds threshold interrupt support.
> >
> > Tiberiu Breana (2):
> >   iio: temperature: Add support for MAX31722/MAX31723 temperature
> >     sensors
> >   iio: temperature: Add threshold interrupt support for max31722
> >
> >  drivers/iio/temperature/Kconfig    |  12 +
> >  drivers/iio/temperature/Makefile   |   1 +
> >  drivers/iio/temperature/max31722.c | 673
> > +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 686 insertions(+)
> >  create mode 100644 drivers/iio/temperature/max31722.c
> >
> Hi Tiberiu,
>
> When proposing a temperature sensor driver, we need some additional
> justification for why it is suited for IIO rather than the more focused (and in
> someways simpler) hwmon.
>
> So far we have had thermophiles that don't fit in as devices typically used for
> hardware monitoring. Also in there are a few drivers which are for parts
> where they are a cut down version of a more complex sensor (the
> measurement specialties parts are either pressure sensors or humidty
> sensors at least in terms of what they share interfaces with)
>
> Also, please cc the hwmon maintainers (and probably list) as we want their
> agreement.
>
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
