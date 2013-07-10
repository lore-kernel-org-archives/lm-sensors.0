From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 10 Jul 2013 17:14:23 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] ARM: dt: t114 dalmore: add dt entry for nct1008
Message-Id: <20130710171422.GC15665@dhcp-172-17-186-34.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6743369816305225940=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1373455798-2944-1-git-send-email-wni@nvidia.com>
 <1373455798-2944-3-git-send-email-wni@nvidia.com>
In-Reply-To: <1373455798-2944-3-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--===============6743369816305225940==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2013 at 07:29:58PM +0800, Wei Ni wrote:
> Enable thermal sensor nct1008 for t114 dalmore.

Nit: "Tegra114 Dalmore"

> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
[...]
> +		nct1008: nct1008 {
> +			compatible = "onnn,nct1008";
> +			reg = <0x4c>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
> +		};

The "nct1008:" label isn't needed here either.

Thierry

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR3ZZuAAoJEN0jrNd/PrOh8YgP/Rf4Laut/ArWOVHytrwPkR8d
t0CBBLY36I4/LkbB1VUuonXBgkdT9ty5lNdlBCknJd+6kkFQcd5ROHOrPIMudCh3
/mIENzDfzY9FicPbPscV6/SLBS+0+4WNah3dXM+loXznd1I4dWL7aTPzP8hZd3Qo
qCNntLogPhIuCy0dGSO5y94j2i/pRv8Jps4SSH35QonrMzERUQh6WRyo+Xdfm8bf
M7FugL/zLj4+tX4dAE3Fu8MCSFDOq9LX4CKa3f2GABrQu2v7ENYEQNJT9YnnZ85y
vaiNwAY6Y6va0H4+Pu9XePRuOoaM++rzX87pFsuGnLiuW2CndGK/IfyPRnXDZLl2
DV3xVOSQGmkPpGBAnzCNQrasMmHiBXEx+8lESt6ykAIWdMTiWWrJhqAG7FwLhdF1
zQ+AyDR2GkX3kjLXgKOU/qv/GvueTsro8bdCDP4B5Cwav2dM1iLT4R4SIcEiI9EJ
dttdBvviUyYMptg9owqjnelr4C/sBrKO/8sfxvxt0fDWtIXut0f6XmK3zToqcMyV
mQN/5q5ZpM8q4mzRcGuLEt2u6M6tNY3cj8NS/E6cDpKGXiU0YhTynm5eM2tUkDXJ
pL6bORW627J+PnL7nyjZcc5IBcQRph54f/CIauB9W3cP00J5l0WVu6CC0C/HigrW
ICWsJwsHhTcbH4vkLAlF
=88wX
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--


--===============6743369816305225940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6743369816305225940==--
