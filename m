From: Mark Brown <broonie@kernel.org>
Date: Fri, 09 Aug 2013 10:56:44 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Add power control
Message-Id: <20130809105644.GW6427@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8319042920264116730=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
 <20130808110136.GA6427@sirena.org.uk>
 <520498F3.8030101@nvidia.com>
In-Reply-To: <520498F3.8030101-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>


--===============8319042920264116730==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hjiPcpt6rcFNGbLy"
Content-Disposition: inline


--hjiPcpt6rcFNGbLy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2013 at 03:23:31PM +0800, Wei Ni wrote:
> On 08/08/2013 07:01 PM, Mark Brown wrote:

> > You shouldn't just be ignoring errors here, though there are deployment
> > difficulties with making sure a stub regulator is provided.  These
> > should be getting easier after the next merge window, the stubs will be
> > being tweaked slightly to have an "assume it's there" option even when

> Oh, really, could you show me the patch, I wish to take a look :)

No patch quite yet - the basic idea is that for plain regulator_get()
you'll only ever get -EPROBE_DEFER as an error, not -ENODEV.  If the
regulator is missing in the DT we assume it's there and provide a dummy
if the DT doesn't hook it up.  If the consumer genuinely wants to see if
a supply might not be wired up it should use regulator_get_optional()
which is in -next at the minute.

--hjiPcpt6rcFNGbLy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSBMrpAAoJELSic+t+oim92agP/j5azvH/+9+pcUjPegcAHB1d
XX79RjQpQnEbtskZxH8tOM10KgWcQqCEzMu+D4L+jCGH592DA398AJl4miVmOAHt
f3BmcJrmIYH+1HUN6dQGzT2yCZqvJqHuvn3qoTff1j+Lfoo2Izr91befX66UoLG2
5+zZkK2iCo8RjOl5koMfNTH5yPt4RNff9iZNCnG1YFTO0U6Z9Kel3orLRBlAvBW1
dffaatc3qKyy8ZZ3O/dpd/nIu5UXo2rASoEaar5atL0mK6iQQ7VqhAnI8HsHphbV
WzmB3K+AoRxGblewawUVz/GZeHEUpxcgxOeFIXnbsOhs/fZrct0NIKre7LEhmUmm
6UJOK7TriFNtKTK3dF6hM68SAUJbiENpQo35vYaOZoiARcE06PIRg69v0wQj83zg
POMZOidZgp9fzI1FisYnTWB+dCFQnSlCJWLQMqrOqFoUjUTUGcSp7vRR8tMUhtL7
50f2dHPnhNKAEWHRRjCAr8c6wnYh4V2H/dFA5k72xHgbKxIMSgScZSTzaAMbsgJ1
77o0cT69HMh3H8scRKrfKhBXCn4UzNKZJwR3uoQHzqQIa4FLXrNAooL62PoTgxgq
U+WjToAlslBAFjQ/QQs83y3bpo27rYfXXEDFgEkv2LHzh6W2ANa5agsXvT5WVtSe
vypsdOjWv8lEByE1RrQ5
=lQYp
-----END PGP SIGNATURE-----

--hjiPcpt6rcFNGbLy--


--===============8319042920264116730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8319042920264116730==--
