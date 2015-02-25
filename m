From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 25 Feb 2015 18:30:37 +0000
Subject: Re: [lm-sensors] [PATCH v4 5/8] ARM: dts: Add properties to use pwm-fan device as a cooling device i
Message-Id: <20150225183035.GC2306@developer.amazonguestwifi.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0246946519979015471=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-6-git-send-email-l.majewski@samsung.com>
 <20150224193711.GA353@developer.amazonguestwifi.org>
 <20150225142815.562fe22b@amdc2363>
In-Reply-To: <20150225142815.562fe22b@amdc2363>
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>


--===============0246946519979015471==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 02:28:15PM +0100, Lukasz Majewski wrote:
> Hi Eduardo,
>=20
> > On Wed, Feb 18, 2015 at 11:07:33AM +0100, Lukasz Majewski wrote:
> > > With those bindings it is possible to use pwm-fan device available
> > > in Odroid U3 as a cooling device.
> > >=20
> > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > ---
> > > Changes for v2:
> > > - Rename cooling-pwm-values property to cooling-levels
> > > Changes for v3:
> > > - Change patch's topic to "ARM dts"
> > > - Reduce maximal cooling-level to 230 from 255
> > > Changes for v4:
> > > - None
> > > ---
> > >  arch/arm/boot/dts/exynos4412-odroidu3.dts | 33
> > > ++++++++++++++++++++++++++++++- 1 file changed, 32 insertions(+), 1
> > > deletion(-)
> > >=20
> > > diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > > b/arch/arm/boot/dts/exynos4412-odroidu3.dts index 60bd1e4..3e5df3e
> > > 100644 --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > > +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > > @@ -32,11 +32,42 @@
> > >  		};
> > >  	};
> > > =20
> > > -	pwm-fan {
> > > +	fan0: pwm-fan {
> > >  		compatible =3D "pwm-fan";
> > >  		pwms =3D <&pwm 0 10000 0>;
> > > +		cooling-min-state =3D <0>;
> > > +		cooling-max-state =3D <3>;
> > > +		#cooling-cells =3D <2>;
> > > +		cooling-levels =3D <0 102 170 230>;
> > >  		status =3D "okay";
> > >  	};
> > > +
> > > +	thermal-zones {
> > > +		cpu_thermal: cpu-thermal {
> >=20
> >=20
> > This thermal zone misses the mandatory properties as per=20
> >  Documentation/devicetree/bindings/thermal/thermal.txt
>=20
> Following mandatory properties:
> 		thermal-sensors =3D <&tmu 0>;
> 		polling-delay-passive =3D <0>;
> 		polling-delay =3D <0>;
> 		trips {
>=20
> 		}
>=20
> are defined in exynos4-cpu-thermal.dtsi included by this file.
>=20
> In this patch only device dependent changes are stated.

OK. I missed that.



>=20
> >=20
> > > +			cooling-maps {
> > > +				map0 {
> > > +				     trip =3D <&cpu_alert1>;
> > > +				     cooling-device =3D <&cpu0 7 7>;
> > > +				};
> > > +				map1 {
> > > +				     trip =3D <&cpu_alert2>;
> > > +				     cooling-device =3D <&cpu0 13
> > > 13>;
> > > +				};
> > > +				map2 {
> > > +				     trip =3D <&cpu_alert0>;
> > > +				     cooling-device =3D <&fan0 0 1>;
> > > +				};
> > > +				map3 {
> > > +				     trip =3D <&cpu_alert1>;
> > > +				     cooling-device =3D <&fan0 1 2>;
> > > +				};
> > > +				map4 {
> > > +				     trip =3D <&cpu_alert2>;
> > > +				     cooling-device =3D <&fan0 2 3>;
> > > +				};
> > > +			};
> > > +		};
> > > +	};
> > >  };
> > > =20
> > >  &pwm {
> > > --=20
> > > 2.0.0.rc2
> > >=20
>=20
>=20
>=20
> --=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7hTDAAoJEMLUO4d9pOJW3UgIAJuPitfzUpvx64fKWhzkwJEo
Wqurf/24cFmq4hfTc2XzZWD4m+UgGbKEVlk/4Nh0Sf5HTOgYB5xuXjex1UnwFH4q
vJ04nR/UXHL3utrVOgoHrRKfpzRRqr3NE1XjbgBzv/KQkX5coVfPGZHGn1QEdKoI
GUYU8NxGpAGgnTFDVX4PmrPtj8XEHLdbtr59yaYG1ATH+C/guGZZqPE8xd2RN80H
5ikrFzoX8azLo/o/7l89KeWrASavVTbnwY/zAPqOcULMpnfjwov6yJmDf9jhcFhT
SDq6HYdkQIcZWql6/a/zqtWCT4deAq8dqlOlFYZNoHvgWOmkaYROrS1tGB9pCJ0=
=EDyM
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--


--===============0246946519979015471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0246946519979015471==--
