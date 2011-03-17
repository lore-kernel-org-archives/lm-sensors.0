From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Thu, 17 Mar 2011 20:02:11 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/3] Support for all SHT15 features
Message-Id: <20110317200210.GA26660@v0n.mtl.sfl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for your comments Guenter,

> Two questions:
> - Which of the new attributes are really expected to change during
>   runtime ?
>   If an attribute is not expected to change during runtime, it should be
>   configured statically (eg with platform data or device tree), and not
>   with a sysfs attribute.

The battery_alarm and heater_enable attributes are expected to
change during runtime. The heater should not be enabled all the time, it
just needs to be set for a short period for validation purposes (e.g.
cross-validating the dew point calculation). And of course, the battery
fault alarm is important, as measurements become invalid if the sensor's
power source falls below 2.47 V (not all platforms have power regulators).

The ability to switch resolution will mainly impact transfer speeds and
power consumption, depending on the sensor. It makes sense to use the
number of bits rather than keywords or predefined codes as they will most
probably be different with each manufacturer.
Wether it might be a runtime attribute or not, I guess, will depend on the
ability to change the resolution depending on the power profile on mobile
platforms. Would it be insightful?

> - For any remaining attributes, does they really add value ?
>   If they adds value, it may add value for other drivers as well and may
>   warrant an ABI extension. If so, that should be discussed.

The checksumming attribute adds value in my opinion as not all sensors are
closely tied to the platform itself, and thus might suffer from data
corruption. Other devices supporting that feature will benefit from that.
We chose the "checksumming" attribute name based on the only example of
similar attribute found in drivers/s390/net/qeth_l3_sys.c.
I think the name is quite explicit for the feature.

The last feature, OTP reload, is very device-specific and allows saving
10ms for each measurement while loosing on precision. Here again, power
consumption will be affected.

> 
> Either case, I would expect attributes to be documented. If that means
> that driver documentation needs to be added in the first place because
> it does not exist - maybe that should be first priority anyway before
> adding new functionality to a driver.

I think that checksumming and resolution should become part of the
documentation. Do you see any impediment?

Concerning device-specific attributes, should their naming be normalized?
e.g. by prefixing the attribute name with the device driver name or
similar? In either case, I will add documentation to the patch.

Regards,
Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
