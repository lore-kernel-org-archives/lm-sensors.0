From: Mark Brown <broonie@kernel.org>
Date: Thu, 08 Aug 2013 13:08:40 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Add power control
Message-Id: <20130808130840.GC6427@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0948594880330685746=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
 <20130808110136.GA6427@sirena.org.uk>
 <52038035.7030803@roeck-us.net>
In-Reply-To: <52038035.7030803-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org


--===============0948594880330685746==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dUQ3G7okZyz11iOi"
Content-Disposition: inline


--dUQ3G7okZyz11iOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2013 at 04:25:41AM -0700, Guenter Roeck wrote:
> On 08/08/2013 04:01 AM, Mark Brown wrote:

> >That said if you *are* going to do this you should request the
> >regulator using devm_regulator_get_optional(), this is intended to
> >support things that don't need regulators (though that's not the case
> >here).

> The lm90 driver works perfectly fine without regulator.

I'd be most surprised if the device worked without power, if the driver
fails to get and enable a regulator for it then that's not great
(especially if it does so silently).

Note that the regulator API is written to stub itself out if not
enabled, the code should be able to assume that it's there.

--dUQ3G7okZyz11iOi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIbBAEBAgAGBQJSA5hVAAoJELSic+t+oim9t0gP92irDevC9fvT52swMQvNruRs
ogXmFlGn4wuUsZPa81UK5wCmj8eWjV5sCqxeO3l2xlyBlA5UDzfmWQAjMEuJzTSg
T0yOaXZq2vDUwvEuhpBfvvd1f3dDAAoSlIL/QN9uYfwLKSQCKMT/Ls4nG/3rmj5K
jfumdG2JtSy8c1KHW4L6MHYcE5n/88Dzkb8WcSKS0cKYbAT1uCBSC/7PCg/5O/IT
PhPTBzOo/DeUpk8RjBF+59mmkIHzytgR6c8WbVwtvg0wMnhfMv6O7Mhv5RaekWcA
2SfYGdhGKBzHjz9a4Tw8pUhpO9jy2RzEW6PkbfI7vnHw7Fa7Lh9/ZU/pcu4JYcUW
YZH+9vO7IAqJllQuxrKRI7rq51ukav0SKtgYfb/2Jqn3eEFSO4o6hStSR5NNQvhJ
cA5GAdXQ5FIxgHLK7Ze7ijEmZHvW2WKcdGdtaPbkvCUjyzK8yhiMZin/sB3Yh1H3
8MwoFBZqEvyUMmDVuB7QpHya9F/pQlAFYg9UcnUBt38+jSipBUn2i5mdEB/IbwHi
GbMVeWTVMKExQlfaL+wcSIf0ZeT9heoWQT7gC/ARrYWkOS//u4BcKcB7BKm2UiAO
r+iAQFGPjGQJOL7N8NPYRrvUta4Ing+GIFNjQ00m+sIRWlb/sucXAmPGT25Gw4jQ
uOf2FdHbtv3oBXJEA9M=
=j9PC
-----END PGP SIGNATURE-----

--dUQ3G7okZyz11iOi--


--===============0948594880330685746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0948594880330685746==--
