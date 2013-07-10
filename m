From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 10 Jul 2013 17:13:20 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] ARM: dt: t30 cardhu: add dt entry for nct1008
Message-Id: <20130710171319.GB15665@dhcp-172-17-186-34.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0881900693243344488=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1373455798-2944-1-git-send-email-wni@nvidia.com>
 <1373455798-2944-2-git-send-email-wni@nvidia.com>
In-Reply-To: <1373455798-2944-2-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--===============0881900693243344488==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2013 at 07:29:57PM +0800, Wei Ni wrote:
> Enable thermal sensor nct1008 for t30 cardhu.

Nit: "Tegra30 Cardhu"

> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
[...]
>  				};
>  			};
>  		};
> +
> +		nct1008: nct1008 {

I don't think it's very likely that this chip will need to be referenced
by a phandle, in which case the "nct1008:" label can be dropped. Even if
it was used at some point in the future, it's better to add it at that
time.

Thierry

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR3ZYvAAoJEN0jrNd/PrOhbrkP/2e6u1DFpkaI19FxiXu1zh38
Wk1hbEfwC0UA/v2Pmxfo3yVtCpu7vgj8bm3tJ/qUVdLs2r1xmAdbBc7AhfN2qnat
OcX1OnnZ734R9Ob6/Em8hAZOwjnVYbBtzqFLBEkgPGDD84hog6VdltUZX+WzFZtJ
S+mfYgBkxap0/8bYZniPwOVvGyFBvLuKNJRwyGz6mGmjNkmmj672QyCDa/LaIBFr
FvHvhsLtHfkn8re36COyO0ZRKB3/dwZbjkr6ccJcQYSgLuYo5oGaoOHu41O2iqd2
saGIf1nyy5OhVtjINI4pJkk+DeX2mem5ggnYPy8Kg/HoyS68VcpzbCANYMjZwKG/
0cMNw1ckRoWIZ144AaCS8xbt+4SB9L8vNCRQ1gmWRxZVUy/goUNEca1N3W65vNgB
Iva5bMXxShU8nem/W/hiFux7MMmTlo4ymax3R0XpazQF6BObKfqSqqTZK1BkmTsx
R2lsqdTJw9qNHStAHyKxxlWABbdyizC0ErOTvxH4QatVpnYvBT0f1pWZFVslxII6
tY94zV0v7HI/dY3c8C+lpPl7Suz6U0PEjffS0FIB5c511WmHyAMDYtZVs45r/4xI
ODYPQYKRhob0ekv0oeyK3eUu66rWdY96qwSiI9lKI+unXvkXQwfpujWvbPcQsu8z
w8fPMJQBoSFAwdM0wIPh
=e6gy
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--


--===============0881900693243344488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0881900693243344488==--
