From: Pierre Kancir <pierre.kancir@gmail.com>
Date: Tue, 08 Apr 2014 15:57:03 +0000
Subject: Re: [lm-sensors] Ina219 with linux kernel driver
Message-Id: <CAK=2HV1OMF764dk7uyMCfVo+b6SzPxbpOKe2a3Bhj0Ve_92igA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK=2HV2_fnfPcK41i2fnAsgR7BMruKq1XB846Tt87wgmBP=NXA@mail.gmail.com>
In-Reply-To: <CAK=2HV2_fnfPcK41i2fnAsgR7BMruKq1XB846Tt87wgmBP=NXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ok! thank you!

Is there another way to use ina2xx driver without devicetree?


 *Kancir Pierre*
pierre.kancir@gmail.com
LinkedIn <http://www.linkedin.com/pub/pierre-kancir/4b/a1a/32a> |
Viadeo<http://www.viadeo.com/fr/profile/pierre.kancir>


2014-04-08 17:08 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:

> On Tue, Apr 08, 2014 at 04:13:00PM +0200, Pierre Kancir wrote:
> > Hi,
> >
> > I am using beaglebone black default kernel, here is its informations :
> > Linux arm 3.8.13-bone40 #1 SMP Fri Jan 31 10:36:05 UTC 2014 armv7l
> > DISTRIB_ID=Ubuntu
> > DISTRIB_RELEASE.10
> > DISTRIB_CODENAME=saucy
> > DISTRIB_DESCRIPTION="Ubuntu 13.10"
> >
> Devicetree support was only added to the ina2xx driver with
> kernel version 3.11. You would have to back-port commit 31e7ad7
> into your kernel to get it.
>
> Guenter
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
