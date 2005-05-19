From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Question about VID
Message-Id: <3FA428C3.A0AAF705@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031031055903.GB20640@earth.solarsys.private>
In-Reply-To: <20031031055903.GB20640@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

but the only way to tell if the pins are used for VID is to
enable VID and see what the value is.
(oops, there is one way, look at the GPIO direction
programming, if they are set for outputs you know they
aren't VID..)

As I said, the driver doesn't use the VID value internally,
only libsensors may use it for calculations of limits,
so it does no harm.

If the VID is bogus, the user can take care of it by ignoring
it in sensors.conf. Why bother telling the driver not
to return the values of the GPIO inputs?


Jean Delvare wrote:
> 
> > just assume the vid pins are always there.
> > If they aren't hooked up, it's no different than for any
> > other chip or driver.
> 
> But if the pins are connected to something else, we'll be claiming a bad
> VID value, which is IMHO worst that clearly stating that VID isn't
> supported for that chip.
> 
> > vid is only used for calculation of limits in sensors.conf.
> > how many people bother to program the correct "VRM" specification
> > setting anyway, I don't know, probably isn't that high...
> 
> Maybe more than you think. From my own experience, few people read docs,
> but much more do read and tweek config files. And I also guess that our
> users are somewhat more experienced ans serious than the average. If
> they made it through the installation process, which isn't an easy one,
> and the detection process, and are finally getting some results, I think
> they are very likely to try fixing incorrect values, either by
> themselves or by asking for help on the mailing-list.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
