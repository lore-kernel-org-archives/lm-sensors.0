From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Fri, 27 Jan 2012 19:48:58 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon/mc13xxx-adc: add support for the MC13892 PMIC
Message-Id: <20120127194858.GB6305@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Jean,

first of all thanks for your thoughts.

On Fri, Jan 27, 2012 at 05:53:29PM +0100, Jean Delvare wrote:
> > diff --git a/Documentation/hwmon/mc13783-adc b/Documentation/hwmon/mc13=
783-adc
> > index 044531a..8b717f5 100644
> > --- a/Documentation/hwmon/mc13783-adc
> > +++ b/Documentation/hwmon/mc13783-adc
> > @@ -5,6 +5,9 @@ Supported chips:
> >    * Freescale Atlas MC13783
> >      Prefix: 'mc13783_adc'
> >      Datasheet: http://www.freescale.com/files/rf_if/doc/data_sheet/MC1=
3783.pdf?fsrch=3D1
> > +  * Freescale Atlas MC13892
> > +    Prefix: 'mc13892_adc'
> > +    Datasheet: http://cache.freescale.com/files/analog/doc/data_sheet/=
MC13892.pdf?fsrch=3D1&sr=3D1
> > =20
> >  Authors:
> >      Sascha Hauer <s.hauer@pengutronix.de>
> > @@ -13,20 +16,21 @@ Authors:
> >  Description
> >  -----------
> > =20
> > -The Freescale MC13783 is a Power Management and Audio Circuit. Among
> > -other things it contains a 10-bit A/D converter. The converter has 16
> > -channels which can be used in different modes.
> > -The A/D converter has a resolution of 2.25mV. Channels 0-4 have
> > -a dedicated meaning with chip internal scaling applied. Channels 5-7
> > -can be used as general purpose inputs or alternatively in a dedicated
> > -mode. Channels 12-15 are occupied by the touchscreen if it's active.
> > +The Freescale MC13783 and MC13892 are Power Management and Audio Circu=
its.
> > +Among other things they contain a 10-bit A/D converter. The converter =
has 16
> > +(MC13783) resp. 12 (MC13892) channels which can be used in different m=
odes. The
> > +A/D converter has a resolution of 2.25mV.
> > =20
> > -Currently the driver only supports channels 2 and 5-15 with no alterna=
tive
> > -modes for channels 5-7.
> > +Some channels can be used as General Purpose inputs or in a dedicated =
mode with
> > +a chip internal scaling applied .
> > =20
> > -See this table for the meaning of the different channels and their chip
> > -internal scaling:
> > +Currently the driver only supports BP, the General Purpose inputs and
> > +touchscreen.
>=20
> It might be a good idea to explain what BP is... Me, I have no idea.
It's in the table below and means the "Application Supply" channel. No
idea what the Freescale guys thought it should stand for.

> > +See the following tables for the meaning of the different channels and=
 their
> > +chip internal scaling:
> > +
> > +MC13783:
> >  Channel	Signal						Input Range	Scaling
> >  ----------------------------------------------------------------------=
---------
> >  0	Battery Voltage (BATT)				2.50 - 4.65V	-2.40V
> > @@ -34,7 +38,7 @@ Channel	Signal						Input Range	Scaling
> >  2	Application Supply (BP)				2.50 - 4.65V	-2.40V
> >  3	Charger Voltage (CHRGRAW)			0 - 10V /	/5
> >  							0 - 20V		/10
> > -4	Charger Current (CHRGISNSP-CHRGISNSN)		-0.25V - 0.25V	x4
> > +4	Charger Current (CHRGISNSP-CHRGISNSN)		-0.25 - 0.25V	x4
> >  5	General Purpose ADIN5 / Battery Pack Thermistor	0 - 2.30V	No
> >  6	General Purpose ADIN6 / Backup Voltage (LICELL)	0 - 2.30V /	No /
> >  							1.50 - 3.50V	-1.20V
> > @@ -48,3 +52,23 @@ Channel	Signal						Input Range	Scaling
> >  13	General Purpose TSX2 / Touchscreen X-plate 2	0 - 2.30V	No
> >  14	General Purpose TSY1 / Touchscreen Y-plate 1	0 - 2.30V	No
> >  15	General Purpose TSY2 / Touchscreen Y-plate 2	0 - 2.30V	No
> > +
> > +MC13892:
> > +Channel	Signal						Input Range	Scaling
> > +----------------------------------------------------------------------=
---------
> > +0	Battery Voltage (BATT)				0 - 4.8V	/2
> > +1	Battery Current (BATT - BATTISNSCC)		-60 - 60 mV	x20
> > +2	Application Supply (BPSNS)			0 - 4.8V	/2
> > +3	Charger Voltage (CHRGRAW)			0 - 12V /	/5
> > +							0 - 20V		/10
> > +4	Charger Current (CHRGISNS-BPSNS) /		-0.3 - 0.3V /	x4 /
> > +	Touchscreen X-plate 1				0 - 2.4V	No
> > +5	General Purpose ADIN5 /	Battery Pack Thermistor	0 - 2.4V	No
> > +6	General Purpose ADIN6 / Backup Voltage (LICELL)	0 - 2.4V /	No
> > +	Backup Voltage (LICELL)                        	0 - 3.6V	x2/3
> > +7	General Purpose ADIN7 / UID / Die Temperature	0 - 2.4V /	No /
> > +							0 - 4.8V	/2
> > +12	Touchscreen X-plate 1				0 - 2.4V	No
> > +13	Touchscreen X-plate 2				0 - 2.4V	No
> > +14	Touchscreen Y-plate 1				0 - 2.4V	No
> > +15	Touchscreen Y-plate 2				0 - 2.4V	No
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 0b62c3c..e3e3bc0 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1322,10 +1322,10 @@ config SENSORS_APPLESMC
> >  	  the awesome power of applesmc.
> > =20
> >  config SENSORS_MC13783_ADC
> > -        tristate "Freescale MC13783 ADC"
> > -        depends on MFD_MC13783
>=20
> BTW, isn't CONFIG_MFD_MC13783 supposed to go away now? It seems to be
> an alias for MFD_MC13XXX today. 4 drivers are still using it...
>=20
> > +        tristate "Freescale MC13783/MC13892 ADC"
> > +        depends on MFD_MC13XXX
Yeah, that's why I drop MFD_MC13783 in favour of MFD_MC13XXX :-)

> >          help
> > -          Support for the A/D converter on MC13783 PMIC.
> > +          Support for the A/D converter on MC13783 and MC13892 PMIC.
> > =20
> >  if ACPI
> > =20
> > diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> > index ef65ab5..0d796f7 100644
> > --- a/drivers/hwmon/mc13783-adc.c
> > +++ b/drivers/hwmon/mc13783-adc.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Driver for the Freescale Semiconductor MC13783 adc.
> > + * Driver for the adc on Freescale Semiconductor MC13783 and MC13892 P=
MICs.
>=20
> Would be better spelled ADC, methinks.
OK.

> >   *
> >   * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserv=
ed.
> >   * Copyright (C) 2009 Sascha Hauer, Pengutronix
> > @@ -18,7 +18,7 @@
> >   * Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
> >   */
> > =20
> > -#include <linux/mfd/mc13783.h>
> > +#include <linux/mfd/mc13xxx.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/hwmon-sysfs.h>
> >  #include <linux/kernel.h>
> > @@ -28,7 +28,11 @@
> >  #include <linux/init.h>
> >  #include <linux/err.h>
> > =20
> > -#define MC13783_ADC_NAME	"mc13783-adc"
> > +#define DRIVER_NAME	"mc13783-adc"
> > +
> > +/* platform device id driver data */
> > +#define MC13783_ADC_16CHANS	1
> > +#define MC13783_ADC_BPDIV2	2
> > =20
> >  struct mc13783_adc_priv {
> >  	struct mc13xxx *mc13xxx;
> > @@ -38,7 +42,13 @@ struct mc13783_adc_priv {
> >  static ssize_t mc13783_adc_show_name(struct device *dev, struct device=
_attribute
> >  			      *devattr, char *buf)
> >  {
> > -	return sprintf(buf, "mc13783_adc\n");
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	ssize_t ret =3D sprintf(buf, "%s\n", pdev->name);
> > +
> > +	if (ret > 7 && buf[7] =3D=3D '-')
> > +		buf[7] =3D '_';
> > +
> > +	return ret;
> >  }
>=20
> I share Guenter's concerns about this code. This is simply too fragile.
> Storing the right string, or a pointer thereto, in struct
> mc13783_adc_priv would be better. Your argument about the wasted memory
> size doesn't really hold, we're talking about 30 bytes here, tops.
OK.

> Or if you really want to dynamically turn "-" into "_" then you should
> do that in a robust way, for example:
>=20
> 	char *dash;
>=20
> 	dash =3D strchr(buf, '-');
> 	if (dash)
> 		*dash =3D '_';
>=20
> That way you no longer depend on the length of the string nor the
> position of the dash.
>=20
> As a side note, I'm not quite sure why the _adc suffix was preserved in
> the name attribute in the first place. Given that this is a hwmon
> device attribute, it seems redundant.
I'll drop it.
=20
> As another side note, if you really care about memory consumption, then
> you could call sysfs_remove_group() unconditionally everywhere, as it's
> OK to remove files which do not exist. This would let you mark
> mc13783_adc_use_touchscreen() as __init. It may also make sense to move
> file removal to a separate function to avoid code redundancy between
> mc13783_adc_probe() and mc13783_adc_remove() (or even adjust
> mc13783_adc_remove() so that it can be called straight from
> mc13783_adc_probe()'s error path.
>=20
> [...]
> > +/* these are only used if MC13783_ADC_16CHANS is provided in driver da=
ta */
> > +static struct attribute *mc13783_attr_16chan[] =3D {
>=20
> 16CHANS vs. 16chan. Would be good to decide for a spelling and stick to
> it.
I guess you only mean the 's' and not capitalisation?

> [...]
> Will you resend an updated patch, or should I update it myself with the
> changes above?
I will send you an update later today with your comments addressed.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
