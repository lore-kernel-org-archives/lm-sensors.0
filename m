From: Mark Brown <broonie@kernel.org>
Date: Thu, 12 Sep 2013 11:51:06 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/3] hwmon: (lm90) Add power control
Message-Id: <20130912115106.GM29403@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2447112231033971304=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1378985061-28547-1-git-send-email-wni@nvidia.com>
 <1378985061-28547-2-git-send-email-wni@nvidia.com>
In-Reply-To: <1378985061-28547-2-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--===============2447112231033971304==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LAThOmUcSmfEsnm5"
Content-Disposition: inline


--LAThOmUcSmfEsnm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2013 at 07:24:19PM +0800, Wei Ni wrote:

> +#include <linux/delay.h>

You don't need this any more, otherwise

Reviewed-by: Mark Brown <broonie@linaro.org>

--LAThOmUcSmfEsnm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMaqnAAoJELSic+t+oim9nmoQAIfb7z1IwpTynk3KqYsa52vo
M1uKfF6uSoyVR4xc/9zRnr1ZtqXMGv/JElBDbSjTP2qmCq6cTh8yh/mIhcRjv9PB
h8k0ZVVAxfZKGnzps+1FY/DdJn6uKVeb7IN1fk9EdfzkZXjj4V5ATMoDhZKyLREb
is6fO6vs7hkei4sUwzYZuXuTkTEujnvFSVx/cxBYiHyuiRYtAezsCOpy2xvqmkey
MC60Tx4cugHZt5ok3vcaW5n7Y4MAiPJ+yaS/jE9v7b9owABfERNK/+Uz2yItsOF7
Z+rcbbpUXi5iN6rxxGcoV0HYnSiuqXpCheS4mY8xLJooHBf72XYyb/CMYgj2/0Pt
kc+k1B/x5MWWJlOz2FfhzksoBlpbouF1Romri6YPJTsOyOIaNWMTf6t86oVXuD0o
85CB+ZHiDt6A/Ob9pCkr3QSRQFT1powQ8bl3/E+kaNM3I9WmgvurT4Y8/noFN0Jm
KcwJM5kwvwdm8EMy1z36mt99X6B8eIC4KY6875zPcr2YRjMvzMeF6pdKfYckWhp8
NN/g5Wnan09bm8h+AigGIQOeFMcEe2emA/Ncy+WNiDmfjv51UF5fxeofhklCbi86
4akVdzn954GMuIldhHpJ75RgI57RiWXdkcRjAazTrjYNfS8QRkgrhuKevYJUtvhI
rDnodfnlnVX28n46Bpqr
=lJNd
-----END PGP SIGNATURE-----

--LAThOmUcSmfEsnm5--


--===============2447112231033971304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2447112231033971304==--
