From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Thu, 29 Sep 2011 18:59:29 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon/mc13xxx-adc: add support for the
Message-Id: <20110929185929.GH6949@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, Sep 29, 2011 at 09:38:23AM -0700, Guenter Roeck wrote:
> On Tue, 2011-09-27 at 17:16 -0400, Uwe Kleine-K=F6nig wrote:
> > [...]
> > diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> > index ef65ab5..0d796f7 100644
> > --- a/drivers/hwmon/mc13783-adc.c
> > +++ b/drivers/hwmon/mc13783-adc.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Driver for the Freescale Semiconductor MC13783 adc.
> > + * Driver for the adc on Freescale Semiconductor MC13783 and MC13892 P=
MICs.
> >   *
> >   * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserv=
ed.
> >   * Copyright (C) 2009 Sascha Hauer, Pengutronix
> > @@ -18,7 +18,7 @@
> >   * Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
> >   */
> >=20
> > -#include <linux/mfd/mc13783.h>
> > +#include <linux/mfd/mc13xxx.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/hwmon-sysfs.h>
> >  #include <linux/kernel.h>
> > @@ -28,7 +28,11 @@
> >  #include <linux/init.h>
> >  #include <linux/err.h>
> >=20
> > -#define MC13783_ADC_NAME       "mc13783-adc"
> > +#define DRIVER_NAME    "mc13783-adc"
> > +
> > +/* platform device id driver data */
> > +#define MC13783_ADC_16CHANS    1
> > +#define MC13783_ADC_BPDIV2     2
> >=20
> I am all for using functional bitmaps if it serves a purpose. However,
> that is not the case here, and there is no indication that or if there
> will ever be a chip supporting more than one of the features in the bit
> map. With a bitmap like this, we get all the pain and none of the
> benefits of having a bitmap.
What exactly do you consider a pain here? I really like it that way and
want to keep it.
=20
> So please use an enum instead to distinguish chips, similar to other
> hwmon drivers. Something like
>=20
> 	enum chips { mc13783, mc13892 };
>=20
In my eyes this would be a step back. I've seen quite some places where
an if() used to decide based on a name (mostly cpu_is_mxyz()) and adding
support for a new cpu has to touch all these if()s.

> >  struct mc13783_adc_priv {
> >         struct mc13xxx *mc13xxx;
>=20
> It might actually make sense to store the chip id in mc13783_adc_priv to
> simplify access to it.
>=20
> > @@ -38,7 +42,13 @@ struct mc13783_adc_priv {
> >  static ssize_t mc13783_adc_show_name(struct device *dev, struct device=
_attribute
> >                               *devattr, char *buf)
> >  {
> > -       return sprintf(buf, "mc13783_adc\n");
> > +       struct platform_device *pdev =3D to_platform_device(dev);
> > +       ssize_t ret =3D sprintf(buf, "%s\n", pdev->name);
> > +
> > +       if (ret > 7 && buf[7] =3D '-')
> > +               buf[7] =3D '_';
> > +
> This is clumsy, and would get really ugly if there is ever a chip
> supported by this driver which doesn't have the '-' at the same
> position.
Right. But this can still be done when that new chip comes down the
road. And today this is IMHO good enough...
=20
> You could store the name with '_' in platform_device_id, or have a const
> char *name in mc13783_adc_priv and point it to the correct/expected
> string. No need to do a runtime string correction.
... and doesn't spend memory to save several nearly identical strings.
=20
> > [...]
> > +static const struct platform_device_id mc13783_adc_idtable[] =3D {
> > +       {
> > +               .name =3D "mc13783-adc",
> > +               .driver_data =3D MC13783_ADC_16CHANS,
> > +       }, {
> > +               .name =3D "mc13892-adc",
> > +               .driver_data =3D MC13783_ADC_BPDIV2,
> > +       }, {
> > +               /* sentinel */
> > +       }
> > +};
> > +MODULE_DEVICE_TABLE(platform, mc13783_adc_idtable);
> > +
> >  static struct platform_driver mc13783_adc_driver =3D {
> > -       .remove         =3D __devexit_p(mc13783_adc_remove),
> > +       .remove         =3D __devexit_p(mc13783_adc_remove),
> >         .driver         =3D {
> >                 .owner  =3D THIS_MODULE,
> > -               .name   =3D MC13783_ADC_NAME,
> > +               .name   =3D DRIVER_NAME,
> >         },
> > +       .id_table       =3D mc13783_adc_idtable,
> >  };
> >=20
> >  static int __init mc13783_adc_init(void)
> > @@ -243,4 +299,3 @@ module_exit(mc13783_adc_exit);
> >  MODULE_DESCRIPTION("MC13783 ADC driver");
> >  MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
> >  MODULE_LICENSE("GPL");
> > -MODULE_ALIAS("platform:" MC13783_ADC_NAME);
>=20
> Just for clarification - is the alias no longer needed because the name
> matches the one in mc13783_adc_driver ?
It is superseeded by the MODULE_DEVICE_TABLE above.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
