From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 09 Jul 2013 06:21:14 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] ARM: dt: t30 cardhu: add dt entry for lm90
Message-Id: <20130709062112.GC17499@mithrandir>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8340010009876485204=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1372928979-26938-1-git-send-email-wni@nvidia.com>
 <1372928979-26938-2-git-send-email-wni@nvidia.com>
 <51D70483.70203@wwwdotorg.org>
 <51DA6BD4.1040300@nvidia.com>
 <20130708095024.041a6d57@endymion.delvare>
 <51DA8805.50709@nvidia.com>
 <20130708131421.GB21638@roeck-us.net>
In-Reply-To: <20130708131421.GB21638-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>


--===============8340010009876485204==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2013 at 06:14:21AM -0700, Guenter Roeck wrote:
> On Mon, Jul 08, 2013 at 05:36:05PM +0800, Wei Ni wrote:
> > On 07/08/2013 03:50 PM, Jean Delvare wrote:
> > > On Mon, 8 Jul 2013 15:35:48 +0800, Wei Ni wrote:
> > >> On 07/06/2013 01:38 AM, Stephen Warren wrote:
> > >>> On 07/04/2013 03:09 AM, Wei Ni wrote:
> > >>>> Enable thermal sensor lm90 for t30 cardhu.
> > >>>
> > >>>> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot=
/dts/tegra30-cardhu.dtsi
> > >>>
> > >>>> +		nct1008: nct1008 {
> > >>>> +			compatible =3D "lm90,nct1008";
> > >>>
> > >>> "lm90" isn't a valid vendor prefix. I believe the value you want is
> > >>> "onnn,nct1008". Same comment for patch 2/2.
> > >>
> > >> The lm90 doesn't support device tree very well.
> > >=20
> > > I doubt it, but if this is the case, then please fix it, instead of
> > > working the problem around in a different place.
> > >=20
> > >> In the DT, we need to
> > >> named as "lm90" so that the lm90 driver can be loaded,
> > >=20
> > > Not that I am an expert with regards to DT, but this doesn't make any
> > > sense to me. AFAIK DT is about devices, not which drivers handle them.
> > >=20
> > >> and we also need
> > >> to add "nct1008" to indicate this is the nct1008 device, so that the
> > >> lm90 driver can be loaded with the right i2c_device_id->driver_data.
> > >>
> > >> I set the " compatible =3D "lm90,nct1008" ", this is the simplest wa=
y, and
> > >> we doesn't need to change the lm90.c.
> > >=20
> > > There's no problem with changing the lm90 driver, if this is the right
> > > thing to do.
> >=20
> > Ok, I will add DT support in the lm90.c in my next version patch.
> >=20
> Only if you can show that it is necessary.

It should work out of the box. As a matter of fact the same chip is used
on Tamonten and the DTS files use "onnn,nct1008". That used to work. If
it no longer does then that's a regression.

Thierry

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR26vYAAoJEN0jrNd/PrOhBNcQAKUK+WDAajZI67RkQCwNvvfM
+y03JcPHwiL9GTvvO+hchy7xMw6oBnEQy+Lbpz8GWvGhipVg4oW6x8ms2Dwb6B9f
D1MWJvuFsKzTDN67RcKgjURKuqQcaO4sIqfFWyplJN/inykWbnuzns6rHJ4THEXb
U9iLJbU25fV6LVn2wDUO6lpSW5GnAUlHHwk2wvFmvUO9eUWP/3V7pv2y38ZzbH66
WUh5+O07+/0sbmTlGlAlhZYE3HJ4pMhqXGIfcqi50xJREmbwkHTw+4jvM5Qo+wec
tFoLTyn6mpSPJmLLFdmL0P+BsnRkFQHY6HOwsdjl7uyTBeDWsO39pFTZRPQ9wHrR
COD0cia8PYun3c/eBFD5MM7pxLpulXa3fvaSR2su3LXNfinC6NuE91Mv2mpffpg2
3Z6/iAYS8iC2RTGNLOgJsHAAUkq+fe37TxzaT/jJvcNnwgYqRyzAmE7fcFRlrpDp
jA2yR/b2kpiHJiefGEKNNIFiG98ViQcdsZ0Zp2LitnqKDeR3501vCfLalRxdx0Iz
ajOUAABA3H8Skqu4atVM85ktVmAlE52RXowE0gMSxFu/6fezPxkmcdvxo/lMV2EV
B2Pl+ynSmAIkZdA/Fv4FJgwaMD7kpVCmCThBSYKpVeBq0xkx1b7ooXDszATmJSK2
2LyYRhPWUaRVX74AQkgo
=wXln
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--


--===============8340010009876485204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8340010009876485204==--
