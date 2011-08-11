From: Felipe Balbi <balbi@ti.com>
Date: Thu, 11 Aug 2011 14:12:49 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature
Message-Id: <20110811141248.GK28500@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7558241985892254912=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
 <1312979122-5896-7-git-send-email-j-keerthy@ti.com>
 <20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
 <CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
 <20110811103658.GG27742@legolas.emea.dhcp.ti.com>
 <CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
In-Reply-To: <CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: balbi@ti.com, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, khali@linux-fr.org, guenter.roeck@ericsson.com


--===============7558241985892254912==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZrCu0B0FMx3UnjE2"
Content-Disposition: inline


--ZrCu0B0FMx3UnjE2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 11, 2011 at 06:30:04PM +0530, J, KEERTHY wrote:
> >> >> diff --git a/drivers/hwmon/omap_temp_sensor.c b/drivers/hwmon/omap_=
temp_sensor.c
> >> >> new file mode 100644
> >> >> index 0000000..15e2559
> >> >> --- /dev/null
> >> >> +++ b/drivers/hwmon/omap_temp_sensor.c
> >> >> @@ -0,0 +1,950 @@
> >> >> +/*
> >> >> + * OMAP4 Temperature sensor driver file
> >> >> + *
> >> >> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.=
ti.com/
> >> >> + * Author: J Keerthy <j-keerthy@ti.com>
> >> >> + * Author: Moiz Sonasath <m-sonasath@ti.com>
> >> >> + *
> >> >> + * This program is free software; you can redistribute it and/or
> >> >> + * modify it under the terms of the GNU General Public License
> >> >> + * version 2 as published by the Free Software Foundation.
> >> >> + *
> >> >> + * This program is distributed in the hope that it will be useful,=
 but
> >> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> >> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the=
 GNU
> >> >> + * General Public License for more details.
> >> >> + *
> >> >> + * You should have received a copy of the GNU General Public Licen=
se
> >> >> + * along with this program; if not, write to the Free Software
> >> >> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> >> >> + * 02110-1301 USA
> >> >> + *
> >> >> + */
> >> >> +
> >> >> +#include <linux/interrupt.h>
> >> >> +#include <linux/clk.h>
> >> >
> >> > why ??
> >>
> >> Clock rate setting functions.
> >
> > you shouldn't need in drivers.
>=20
> It is a one time setting of the rate so keeping it in drivers.

you need some other way to handle this. Why do you need to manually set
the rate rather than having hwmod handle this for you ?

your argument that "it's a one time setting" is not enough to have this
in the driver. Drivers should not care about clocks anymore, this should
have been done on another layer.

> >> >> +#include <linux/delay.h>
> >> >> +#include <linux/slab.h>
> >> >> +#include <linux/platform_device.h>
> >> >> +#include <linux/init.h>
> >> >> +#include <plat/omap_device.h>
> >> >
> >> > why ??
> >> >
> >>
> >> Context loss count
> >
> > shouldn't use in drivers.
>=20
> I guess already mmc and display are using
> omap_pm_get_dev_context_loss_count but are
> populating this function in pdata as a function pointer.
> I will add that code.

at least ;-) better than accessing that function directly. But think
carefully how you will make this work when we move to DT.

> >> >> +#include <plat/temperature_sensor.h>
> >> >
> >>
> >> It is the header file with the structure definitions
> >> used in the driver.
> >
> > why don't you put in <linux/platform_data/....> ??
>=20
> I saw many omap specific header files in plat-omap/include/plat.
> Any specific reason behind placing the header in linux/platform_data?

because it's not a good idea to perpetuate the failure.

> >> >> +#include <mach/ctrl_module_core_44xx.h>
> >> >
> >> > why ?
> >>
> >> It will be removed
> >>
> >> >
> >> >> +#include <mach/gpio.h>
> >> >
> >> > linux/gpio.h for crying out loud... how many times Russell has to say
> >> > the exact same thing ??????
> >> >
> >>
> >> It will be removed
> >
> > oh, you don't even use any gpio ? Why do you blindly add so many headers
> > if you don't need them ???
>=20
> It is not required.

this is my point, be careful when adding new drivers... You're consuming
"review bandwidth" when you send code/patch/new-drivers and reviewers
are part of an endangered species. If you keep on making such silly
mistakes, you consume time from reviewers to let you know about things
which are obvious, to say the least. So be careful when sending code,
nobody is perfect, for sure, but by being careful you can help your code
being accepted earlier.

--=20
balbi

--ZrCu0B0FMx3UnjE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOQ+NgAAoJEAv8Txj19kN1CscIAK2nqwpUd++yArvjN6n645PM
p1PxcgblBQA7AC1R1rCWPo93itVUudR/u4l03CRhzpauej+oOaWv5pLXYFzC/KNw
h5+fR2nV4nlRCC9Yo+Vua99AG7U+pvWB03QbLks/sHdFpchmdhYTwmlIJnk+keTR
YA7/NJetkoU1M+dzL0hpTo7BpCYIY1RTY2aj17XJZq8FmvXCk4bJ84cOK0CWiePk
+CT5rN0V5tR880lFCRM7Ej7TkJnqNtJoFr0ywB0chVdG8xibnhxJVu3+pg6STeMm
jl6XHhWAPwj2xSxtcX0H8khE0JUmw5jLljYlw4mCgYhGl60ZnFRsbI32hulSEL0=
=iiU+
-----END PGP SIGNATURE-----

--ZrCu0B0FMx3UnjE2--


--===============7558241985892254912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7558241985892254912==--
