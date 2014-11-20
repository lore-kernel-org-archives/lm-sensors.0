From: Eduardo Valentin <edubezval@gmail.com>
Date: Thu, 20 Nov 2014 13:49:52 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] thermal: of: improve of-thermal sensor registration API
Message-Id: <20141120134950.GA24778@developer>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8961545832575755279=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1416321575-18348-1-git-send-email-edubezval@gmail.com>
 <1416321575-18348-2-git-send-email-edubezval@gmail.com>
 <546CBA3C.9020709@kapsi.fi>
 <546CBA98.1040607@kapsi.fi>
In-Reply-To: <546CBA98.1040607@kapsi.fi>
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: Linux PM <linux-pm@vger.kernel.org>, Caesar Wang <caesar.wang@rock-chips.com>, Wei Ni <wni@nvidia.com>, Lukasz Majewski <l.majewski@samsung.com>, Alexandre Courbot <gnurou@gmail.com>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, lm-sensors@lm-sensors.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Zhang Rui <rui.zhang@intel.com>


--===============8961545832575755279==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Mikko,

On Wed, Nov 19, 2014 at 05:43:20PM +0200, Mikko Perttunen wrote:
> On 11/19/2014 05:41 PM, Mikko Perttunen wrote:
> > On 11/18/2014 04:39 PM, Eduardo Valentin wrote:
> >> Different drivers request API extensions in of-thermal. For this reaso=
n,
> >> additional callbacks are required to fit the new drivers needs.
> >>
> >> The current API implementation expects the registering sensor driver
> >> to provide a get_temp and get_trend callbacks as function parameters.
> >> As the amount of callbacks is growing, this patch changes the existing
> >> implementation to use a .ops field to hold all the of thermal callbacks
> >> to sensor drivers.
> >>
> >> This patch also changes the existing of-thermal users to fit the new
> >> API design. No functional change is introduced in this patch.
> >>
> >> Cc: Alexandre Courbot <gnurou@gmail.com>
> >> Cc: devicetree@vger.kernel.org
> >> Cc: Grant Likely <grant.likely@linaro.org>
> >> Cc: Guenter Roeck <linux@roeck-us.net>
> >> Cc: Jean Delvare <jdelvare@suse.de>
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-pm@vger.kernel.org
> >> Cc: linux-tegra@vger.kernel.org
> >> Cc: lm-sensors@lm-sensors.org
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Stephen Warren <swarren@wwwdotorg.org>
> >> Cc: Thierry Reding <thierry.reding@gmail.com>
> >> Cc: Zhang Rui <rui.zhang@intel.com>
> >> Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
> >> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> >> ---
> >>   drivers/hwmon/lm75.c                               |  9 +++--
> >>   drivers/hwmon/ntc_thermistor.c                     |  6 +++-
> >>   drivers/hwmon/tmp102.c                             |  6 +++-
> >>   drivers/thermal/of-thermal.c                       | 40
> >> ++++++++++------------
> >>   drivers/thermal/tegra_soctherm.c                   |  7 ++--
> >>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  8 +++--
> >>   include/linux/thermal.h                            | 24 +++++++++----
> >>   7 files changed, 63 insertions(+), 37 deletions(-)
> >> ---
> >> Difference from V3:
> >>    - Keep the same behavior regarding callback checks.
> >>      Change in behavior may be sent in a separate patch.
> >> Difference from V2:
> >>    - Fix wrong assignment in tegra driver.
> >> Difference from V1:
> >>    - Fix error handling when .get_trend is not provided.
> >>
> >> @@ -356,8 +356,8 @@ thermal_zone_of_add_sensor(struct device_node *zon=
e,
> >>    *             than one sensors
> >>    * @data: a private pointer (owned by the caller) that will be passed
> >>    *        back, when a temperature reading is needed.
> >> - * @get_temp: a pointer to a function that reads the sensor temperatu=
re.
> >> - * @get_trend: a pointer to a function that reads the sensor
> >> temperature trend.
> >> + * @ops: struct thermal_zone_of_device *. Must contain at least
> >> .get_trend and
> >> + *       .get_temp.
> >
> > This comment seems to be incorrect, as .get_trend is optional.
>=20
> Also, the parameter is of type struct thermal_zone_of_device_ops *, not=
=20
> just thermal_zone_of_device.
>=20
> >
> >>    *
> >>    * This function will search the list of thermal zones described in
> >> device
> >>    * tree and look for the zone that refer to the sensor device
> >> pointed by
> >
> > With that minor one fixed,
> >
> > Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
> > Reviewed-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>

All the comments fixed now. Thanks for reviewing and testing.

> >
> > Cheers,
> > Mikko
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-tegra" =
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Cheers,

Eduardo Valentin

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbfF+AAoJEMLUO4d9pOJW8IEIAJvMZe9zKr47JQ8oKOHRurmp
rcR9eLeTW1spgbpXC4IOtOz6wzVbkUHsc3rODShgjXx17w7bCS/3zRXlWQ9b8teF
Hh3U8+7u1vFK7Pw0EM6kiKYXiL+pNyUdAXOKpUKyJlCG7oQRNS47LGGkvIpCPZoU
fJCXWC033V9ZyYY53kZe9e15Vj7nHYb9XwEu80H8ncaJ0KjcEZO6f/DHlZxoA98v
UUkhsPLsZ5TURJiM4EPikFaqLKjpsKoJvsSB2pzjeiZfpiASVem3+mLuu7vYYRBT
ZNkCkJY18s41Tz10OxVmUxLQcA6xId0jPXIBLqV77e/m3Bg3/oPe3jVGdMSpq7A=
=VrjL
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--


--===============8961545832575755279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8961545832575755279==--
