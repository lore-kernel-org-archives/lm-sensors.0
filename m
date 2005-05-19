From: vdovikin@jscc.ru (Oleg I. Vdovikin)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <004501c3528c$a1d51020$6628d0c3@mlab.cs.msu.su>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here's a snippet of my current patch to give you an idea:
>
>  static struct i2c_algo_bit_data tsunami_i2c_bit_data = {
> -
> -       bit_tsunami_setsda,
> -       bit_tsunami_setscl,
> -       bit_tsunami_getsda,
> -       bit_tsunami_getscl,
> -       10, 10, HZ/2    /* delays/timeout */
> +       .setsda         = bit_tsunami_setsda,
> +       .setscl         = bit_tsunami_setscl,
> +       .getsda         = bit_tsunami_getsda,
> +       .getscl         = bit_tsunami_getscl,
> +       .udelay         = 10,
> +       .mdelay         = 10,
> +       .timeout        = HZ/2,
>  };
>
> Apparently gcc-3.2.3/alpha doesn't grok the original method of
> static initialization.  It choked on it badly until I switched
> it.  gcc-2.95.3/x86 seems to like either way just fine.

    Hm... We're using Compaq RH 7.2 Alpha distribution. We've a choice of
weird redhat gcc-2.96 and a kgcc which is a egcs-2.91.66. Both compiling
this stuff with no errors. Where you have got a precompiled 3.2.3 for alpha?
In my opinion it's better to use kgcc then compiling a kernel on alpha
anyway. BTW, redhat guys use gcc-2.96 for the purpose...

> Maybe the C standard has changed, or maybe gcc3 is just being a
> fruitcake.  But as the other static structs use a different form
> of initialization, I decided to accomodate gcc3 and introduce
> proper consistency in one fell swoop.
    Sounds amazing. ;-))

>
> Hmmm...well, part of the tsunami_driver struct requires a PCI ID
> table (tsunami_ids).  I'm not sure what's supposed to go in that
> table?
>
> Could it be that someone tried to port the driver to the new API,
> half-finished it, and left it for dead?  lm_sensors-2.7.0 makes
> no mention of the tsunami_driver struct or the tsunami_ids
> table.  Maybe that little struct arrangement isn't supposed to
> be there?
    If you mean these things

      .id_table       = tsunami_ids,

    then I don't who is doing that... I've attached "reference" version of
the driver to this mail.

>
> > > CVS, as of 20030724, is no better.  Last entry for this
> > > driver was apparently back in January.
> > >
> > > This is especially annoying, as the Tsunami driver is the
> > > primary driver that makes lm_sensors useful at all on Alpha.
> >
> >     Just FYI. Tsunami i2c bus provides an access to a SPD
> > chips only. Other stuff (such as lm75, adm9240) are accessed
> > via i2c-elektor module. So, in fact UP2000 has to different
> > i2c buses.
>
> Ah, I never knew about that.  Good info to have, thanks.
    I've attached i2c-elektor.patch for proper readb/writeb support in
newest kernel. Please incorporate it with your Alpha fixes.

> What Alpha motherboards support sensors like that, btw?
    Tsunami chips are used on most low-end Alpha 21264 systems, both from
Compaq and Samsung (former Alpha Processor Inc.) systems. PCF8584 (elektor)
chips are used on Samsung UP2000, UP2000+ boards and similar systems (I do
not remember exactly) from Compaq.

> >     Wrong way. ;-))
>
> Eh?  Wrong way how?  I suppose I'm missing something about
> contributing kernel macros for PCI IDs?
    These chips are not PCI devices.

> Ah, so that's where you've been. ;)  How's the upgrade going so
> far?
    Thanks, smoothly. Sensors are working again. ;-))

Regards,
    Oleg.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-elektor.patch
Type: application/octet-stream
Size: 1064 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030725/de5ae5a1/i2c-elektor.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-tsunami.c
Type: application/octet-stream
Size: 3923 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030725/de5ae5a1/i2c-tsunami.obj
