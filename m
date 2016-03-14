From: Eduardo Valentin <edubezval@gmail.com>
Date: Mon, 14 Mar 2016 21:16:08 +0000
Subject: Re: [lm-sensors] [PATCH 12/13] thermal: convert tegra_thermal to use devm_thermal_zone_of_sensor_reg
Message-Id: <20160314211607.GC4740@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3707097250566611804=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
 <1457559336-17652-13-git-send-email-edubezval@gmail.com>
 <56E1347F.8040406@nvidia.com>
In-Reply-To: <56E1347F.8040406@nvidia.com>
To: Wei Ni <wni@nvidia.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org


--===============3707097250566611804==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2016 at 04:46:55PM +0800, Wei Ni wrote:
>=20
>=20
> On 2016=E5=B9=B403=E6=9C=8810=E6=97=A5 05:35, Eduardo Valentin wrote:
> > This changes the driver to use the devm_ version
> > of thermal_zone_of_sensor_register and cleans
> > up the  local points and unregister calls.
> >=20
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Alexandre Courbot <gnurou@gmail.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-tegra@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> >  drivers/thermal/tegra_soctherm.c | 31 +++++++++----------------------
> >  1 file changed, 9 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_s=
octherm.c
> > index 74ea576..0018ccd 100644
> > --- a/drivers/thermal/tegra_soctherm.c
> > +++ b/drivers/thermal/tegra_soctherm.c
> > @@ -168,7 +168,7 @@ struct tegra_soctherm {
> >  	struct clk *clock_soctherm;
> >  	void __iomem *regs;
> > =20
> > -	struct thermal_zone_device *thermctl_tzs[4];
> > +#define ZONE_NUMBER		4
> >  };
> > =20
> >  struct tsensor_shared_calibration {
> > @@ -342,7 +342,7 @@ static const struct thermctl_zone_desc t124_thermct=
l_temp_zones[] =3D {
> >  static int tegra_soctherm_probe(struct platform_device *pdev)
> >  {
> >  	struct tegra_soctherm *tegra;
> > -	struct thermal_zone_device *tz;
> > +	struct thermal_zone_device *z;
> >  	struct tsensor_shared_calibration shared_calib;
> >  	struct resource *res;
> >  	unsigned int i;
> > @@ -408,36 +408,29 @@ static int tegra_soctherm_probe(struct platform_d=
evice *pdev)
> > =20
> >  	/* Initialize thermctl sensors */
> > =20
> > -	for (i =3D 0; i < ARRAY_SIZE(tegra->thermctl_tzs); ++i) {
> > +	for (i =3D 0; i < ZONE_NUMBER; ++i) {
> >  		struct tegra_thermctl_zone *zone =3D
> >  			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
> >  		if (!zone) {
> >  			err =3D -ENOMEM;
> > -			goto unregister_tzs;
> > +			goto disable_clocks;
> >  		}
> > =20
> >  		zone->reg =3D tegra->regs + t124_thermctl_temp_zones[i].offset;
> >  		zone->shift =3D t124_thermctl_temp_zones[i].shift;
> > =20
> > -		tz =3D thermal_zone_of_sensor_register(&pdev->dev, i, zone,
> > -						     &tegra_of_thermal_ops);
> > -		if (IS_ERR(tz)) {
> > -			err =3D PTR_ERR(tz);
> > +		z =3D devm_thermal_zone_of_sensor_register(&pdev->dev, i, zone,
>=20
> I prefer to still use "tz", it seems this line isn't over 80 characters, =
or we
> can add newline.


Yeah,


>=20
> > +							 &tegra_of_thermal_ops);

CHECK: Alignment should match open parenthesis
#423: FILE: drivers/thermal/tegra_soctherm.c:423:
+		tz =3D devm_thermal_zone_of_sensor_register(&pdev->dev, i, zone,
+							 &tegra_of_thermal_ops);

and if you align it, then, you get the warning:
WARNING: line over 80 characters
#423: FILE: drivers/thermal/tegra_soctherm.c:423:
+							  &tegra_of_thermal_ops);

And I did not want to add either of the above to the driver.=20

But if you prefer tz over z, we can keep the first (check) then.

What do you prefer?





--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW5yoUAAoJEMLUO4d9pOJWaHkIAJuNjRDD8szeiQYLKqZint/c
cxUOhuHdIALaINV0dNPJICwQ3BBwiSne4kOCDV4kRtzkWMfE/kxCVvxpzO3DEa7q
RfIz78/A4mtE8BuMQ3NRK/NjwQb9co7GcC6ClDUg2mm/O1uADv6F1TAyGOkByFME
KiOEoatGfKMODBeICVl4sdW1RjA2RE8QZn1jvXLw/yxz2GVbTyLm6JzOwA8Mqbxi
x/9UiQ45IemEYQ2C7orzdeZE41cGrD1yBkVeQ2b6NkLApUn3/ZEJAT048UihAbto
2F3w4PUzZ8Hc216ZEOgjj6cQk0nUZrGmlGaP/Is8iqkjzDfKwlhB4sHF0YOjcrM=
=ZPKv
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--


--===============3707097250566611804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3707097250566611804==--
