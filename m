From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 05 Jul 2007 13:37:28 +0000
Subject: Re: [lm-sensors] [PATCH] Add LM93 support
Message-Id: <20070705133728.GJ18198@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704131723.42773.hjk@linutronix.de>
In-Reply-To: <200704131723.42773.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello:

* Hans-J=FCrgen Koch <hjk@linutronix.de> [2007-07-01 00:35:20 +0200]:
> Mark,
> sorry for not responding to your last review for so long. I hoped all the
> time I might be able to add LM94 support as well. But unfortunately, the
> LM94 datasheet is available under NDA only (hard to believe, but true).
> National Semiconductor Germany said it were no problem to get an NDA that
> still allows me to write an open source driver, but that National in USA
> must decide that. Now I'm waiting, still haven't got that NDA, let alone
> the datasheet.
>=20
> Good news is that I will get an i2c-tiny-usb interface soon, together
> with an LM94 test board. This means I'll have an LM94 always available
> and can perform all sorts of tests with it. I can therefore offer to
> become maintainer of this driver.
>=20
> Find attached my current version of the LM93 patch. I addressed all=20
> the issues you mentioned in your last review. There are a few things
> I'd be glad if you could check if I got it right:
>=20
> 1.) I replaced pwmN_override with pwmN_enable.

1825         case 0:
1826                 ctl2 |=3D 0x01; /* enable manual override */
1827                 ctl2 &=3D 0x0F; /* set PWM to zero */
1828                 break;

No... the value 0 must turn the fan full-on, not off.  Sorry if I was not
clear about that in my review comments.

See also: Documentation/hwmon/sysfs_interface.

> 2.) IMO, show_pwm() was actually buggy as you suspected. I had a look=20
>     at the datasheet and fixed it.

Yep, thanks.

> 3.) IMO, this code is also not correct:
>=20
> > +/* PWM: 0-255 per sensors documentation
> > + =A0 REG: 0-13 as mapped below... right justified */
> > +typedef enum { LM93_PWM_MAP_HI_FREQ, LM93_PWM_MAP_LO_FREQ } pwm_freq_t;
> > +static int lm93_pwm_map[2][14] =3D {
> > +=A0=A0=A0=A0=A0{
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00, /* =A0 0.00% */ 0x40, /* =
=A025.00% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x50, /* =A031.25% */ 0x60, /* =
=A037.50% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x70, /* =A043.75% */ 0x80, /* =
=A050.00% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x90, /* =A056.25% */ 0xa0, /* =
=A062.50% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00xb0, /* =A068.75% */ 0xc0, /* =
=A075.00% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00xd0, /* =A081.25% */ 0xe0, /* =
=A087.50% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00xf0, /* =A093.75% */ 0xff, /* =
100.00% */
> > +=A0=A0=A0=A0=A0},
> > +=A0=A0=A0=A0=A0{
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00, /* =A0 0.00% */ 0x40, /* =
=A025.00% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x49, /* =A028.57% */ 0x52, /* =
=A032.14% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x5b, /* =A035.71% */ 0x64, /* =
=A039.29% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x6d, /* =A042.86% */ 0x76, /* =
=A046.43% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x80, /* =A050.00% */ 0x89, /* =
=A053.57% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x92, /* =A057.14% */ 0xb6, /* =
=A071.43% */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00xdb, /* =A085.71% */ 0xff, /* =
100.00% */
> > +=A0=A0=A0=A0=A0},
> > +};
> > +
> > +static int LM93_PWM_FROM_REG(u8 reg, pwm_freq_t freq)
> > +{
> > +=A0=A0=A0=A0=A0return lm93_pwm_map[freq][reg & 0x0f];
> > +}
>=20
> OK, the values 14 and 15 for reg are reserved and should not occur.
> But if for some reason you read 0xff from the chip, the above
> code would access bytes beyond the end of the array. I added two
> more 0xff bytes so that all 16 possible values are valid.

Makes sense.

> I didn't have the time to test that patch until now. In fact, I
> cannot test everything with my current equipment. I'll test as
> good as I can until Monday evening, perhaps you or somebody else
> can help testing, too.
>=20
> As it might take some more weeks until I can add LM94 support,
> I think we should take LM93 as it is now and patch in LM94
> later. I'd really like to see this going mainline in the next
> merge window.

Agreed.

> Please have a look at my patch and let me know if there are
> still issues I need to fix.

Just the pwm_enable thing.

Thanks & regards,

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
