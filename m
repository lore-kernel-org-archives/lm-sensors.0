From: =?utf-8?Q?G=C3=B6ran_Uddeborg?= <goeran@uddeborg.se>
Date: Sun, 23 Sep 2012 15:39:22 +0000
Subject: Re: [lm-sensors] Configuration for Foxconn A7GM-S 2.0
Message-Id: <20575.11562.434970.609587@freddi.uddeborg>
List-Id: <lm-sensors.vger.kernel.org>
References: <20556.55176.173597.530756@freddi.uddeborg>
In-Reply-To: <20556.55176.173597.530756@freddi.uddeborg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare:
>    compure in3  @ * (1 + 6.8 / 10), @ / (1 + 6.8 / 10)

That gives me 4.92V, which seems reasonable for the 5V line, yes.
(Just check the spelling of "compute" before you cut and paste into
the wiki. :-)

> If in6 could be used, for
> example for -12V, but we can't label it. If it stays stable, you can
> leave it visible.

in6 seems to stay stable.  Even after a cold boot, it reads 1.12V.  So
it could be measuring SOMETHING.

> > > >      # Min and max for Athlon II X2 245e
> > > >      set in0_min  0.875
> > > >      set in0_max  1.4
> > > 
> > > Did you check if the BIOS had set proper limits on its own?
> > 
> > No.  Would that be the limits given before I did "sensors -s"?
> 
> Yes, after a cold boot.

I commented out those lines and restarted (with power off for a short
while).  After that, the limits seems unset:

    it8716-isa-0e80
    Adapter: ISA adapter
    CPU core:      +1.31 V  (min =  +0.00 V, max =  +4.08 V)

So I assume the BIOS does NOT set anything limits on its own.

B.t.w., I enabled in8/Vbat as you suggested.  I don't get any min or
max values for that sensor.  Not even if I try to explicitly set them
in the configuration file.  That is normal and reflects the hardware,
right?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
