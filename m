From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 08 Apr 2014 16:00:55 +0000
Subject: Re: [lm-sensors] Ina219 with linux kernel driver
Message-Id: <20140408160055.GA14346@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK=2HV2_fnfPcK41i2fnAsgR7BMruKq1XB846Tt87wgmBP=NXA@mail.gmail.com>
In-Reply-To: <CAK=2HV2_fnfPcK41i2fnAsgR7BMruKq1XB846Tt87wgmBP=NXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 08, 2014 at 05:57:03PM +0200, Pierre Kancir wrote:
> ok! thank you!
> 
Please don't top-post.

> Is there another way to use ina2xx driver without devicetree?
> 
You should be able to use it as-is and correct the reported values in
the sensors configuration file. Another option would be to provide
the shunt resistor value with platform data. Since that would mean
patching your kernel, it might be easier to back-port the missing patch.

Guenter

> 
>  *Kancir Pierre*
> pierre.kancir@gmail.com
> LinkedIn <http://www.linkedin.com/pub/pierre-kancir/4b/a1a/32a> |
> Viadeo<http://www.viadeo.com/fr/profile/pierre.kancir>
> 
> 
> 2014-04-08 17:08 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
> 
> > On Tue, Apr 08, 2014 at 04:13:00PM +0200, Pierre Kancir wrote:
> > > Hi,
> > >
> > > I am using beaglebone black default kernel, here is its informations :
> > > Linux arm 3.8.13-bone40 #1 SMP Fri Jan 31 10:36:05 UTC 2014 armv7l
> > > DISTRIB_ID=Ubuntu
> > > DISTRIB_RELEASE.10
> > > DISTRIB_CODENAME=saucy
> > > DISTRIB_DESCRIPTION="Ubuntu 13.10"
> > >
> > Devicetree support was only added to the ina2xx driver with
> > kernel version 3.11. You would have to back-port commit 31e7ad7
> > into your kernel to get it.
> >
> > Guenter
> >

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
