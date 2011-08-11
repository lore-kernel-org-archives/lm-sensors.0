From: Felipe Balbi <balbi@ti.com>
Date: Thu, 11 Aug 2011 18:54:09 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature
Message-Id: <20110811185408.GB15970@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3153806568964347833=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-7-git-send-email-j-keerthy@ti.com>
	<20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
	<CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
	<20110811103658.GG27742@legolas.emea.dhcp.ti.com>
	<CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
	<20110811141248.GK28500@legolas.emea.dhcp.ti.com>
	<CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
In-Reply-To: <CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, b-cousson@ti.com, Tony Lindgren <tony@atomide.com>, rnayak@ti.com, balbi@ti.com, lm-sensors@lm-sensors.org, khali@linux-fr.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, guenter.roeck@ericsson.com


--===============3153806568964347833==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 11, 2011 at 08:02:55PM +0530, J, KEERTHY wrote:
> On Thu, Aug 11, 2011 at 7:42 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, Aug 11, 2011 at 06:30:04PM +0530, J, KEERTHY wrote:
> >> >> >> diff --git a/drivers/hwmon/omap_temp_sensor.c b/drivers/hwmon/om=
ap_temp_sensor.c
> >> >> >> new file mode 100644
> >> >> >> index 0000000..15e2559
> >> >> >> --- /dev/null
> >> >> >> +++ b/drivers/hwmon/omap_temp_sensor.c
> >> >> >> @@ -0,0 +1,950 @@
> >> >> >> +/*
> >> >> >> + * OMAP4 Temperature sensor driver file
> >> >> >> + *
> >> >> >> + * Copyright (C) 2011 Texas Instruments Incorporated - http://w=
ww.ti.com/
> >> >> >> + * Author: J Keerthy <j-keerthy@ti.com>
> >> >> >> + * Author: Moiz Sonasath <m-sonasath@ti.com>
> >> >> >> + *
> >> >> >> + * This program is free software; you can redistribute it and/or
> >> >> >> + * modify it under the terms of the GNU General Public License
> >> >> >> + * version 2 as published by the Free Software Foundation.
> >> >> >> + *
> >> >> >> + * This program is distributed in the hope that it will be usef=
ul, but
> >> >> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> >> >> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See =
the GNU
> >> >> >> + * General Public License for more details.
> >> >> >> + *
> >> >> >> + * You should have received a copy of the GNU General Public Li=
cense
> >> >> >> + * along with this program; if not, write to the Free Software
> >> >> >> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> >> >> >> + * 02110-1301 USA
> >> >> >> + *
> >> >> >> + */
> >> >> >> +
> >> >> >> +#include <linux/interrupt.h>
> >> >> >> +#include <linux/clk.h>
> >> >> >
> >> >> > why ??
> >> >>
> >> >> Clock rate setting functions.
> >> >
> >> > you shouldn't need in drivers.
> >>
> >> It is a one time setting of the rate so keeping it in drivers.
> >
> > you need some other way to handle this. Why do you need to manually set
> > the rate rather than having hwmod handle this for you ?
> >
> > your argument that "it's a one time setting" is not enough to have this
> > in the driver. Drivers should not care about clocks anymore, this should
> > have been done on another layer.
>=20
> Hwmod will have no idea on the rate required.

does the rate need to change ? Also, I have not mentioned hwmod anytime
simply because I'm not sure where this should be placed, but hopefully
not in the driver.

If the clock doesn't need to change after you set the correct rate, then
there's really no point in adding complexity to the driver.

Tony, would you have any comment here ?

> >> >> >> +#include <plat/temperature_sensor.h>
> >> >> >
> >> >>
> >> >> It is the header file with the structure definitions
> >> >> used in the driver.
> >> >
> >> > why don't you put in <linux/platform_data/....> ??
> >>
> >> I saw many omap specific header files in plat-omap/include/plat.
> >> Any specific reason behind placing the header in linux/platform_data?
> >
> > because it's not a good idea to perpetuate the failure.
>=20
> May be Tony can give some inputs on where the OMAP specific header
> should be placed.

it's not omap-specific. It's specific to your driver and considering
it's platform_data, it should sit under include/linux/platform_data.h.
That directory was created (fairly recently) to hold platform_data...

--=20
balbi

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJORCVQAAoJEAv8Txj19kN1AOoH/RYlKWSNWbkHsNKe2eVsKF6T
F3DnyMQxHxzbF1FCAYmr6CP834Yvt7nbU6hxbX8iEj0gjFQkv3mYwjV/HW9vxQ1B
1i7VuvZSE+sVllMPvw4oo7FM4tVcB0R7Yeb/DAXrSY0Rhfh7lOoLe8H0zJQv5P9+
ejunE3+4855kVJGW8dX9Awj+f1D/yVt2ZZCVoYfJPAz9frLxUNiRZSQIUtxdX25E
2xOyF7mZx6gy3P7N9vCSNQ+7xN7TLoHdpB5VTM+kXrAS6mbKQZbXMQBjhhh2ZrBW
qUmzlflSDDpF6ll0l1T3qUc2veTEyXNTvsIp7kuvCAffa9uq9KoZcodS9iamxbQ=
=/QqP
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--


--===============3153806568964347833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3153806568964347833==--
