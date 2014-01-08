From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Wed, 08 Jan 2014 12:20:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Fix SENSORS_TMP102 dependencies to eliminate build errors
Message-Id: <52CD4286.7080205@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4573535714451364403=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20140108080557.3439ec23@endymion.delvare>
In-Reply-To: <20140108080557.3439ec23@endymion.delvare>
To: Jean Delvare <khali@linux-fr.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, LM Sensors <lm-sensors@lm-sensors.org>, linux-pm@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Guenter Roeck <linux@roeck-us.net>

--===============4573535714451364403==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="spM41cQEGqLnWsmiSlmq63kNQQcOJmUp4"

--spM41cQEGqLnWsmiSlmq63kNQQcOJmUp4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08-01-2014 03:05, Jean Delvare wrote:
> Similar to what was done for the lm75 driver.
>=20
> Add depends on THERMAL since that is what provides the
> register/unregister functions above, but only if THERMAL_OF was
> selected as this is an optional feature of the driver.
>=20
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/hwmon/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>=20
> --- linux-3.13-rc7.orig/drivers/hwmon/Kconfig	2014-01-08 08:00:58.58307=
2658 +0100
> +++ linux-3.13-rc7/drivers/hwmon/Kconfig	2014-01-08 08:01:36.928977997 =
+0100
> @@ -1285,6 +1285,7 @@ config SENSORS_THMC50
>  config SENSORS_TMP102
>  	tristate "Texas Instruments TMP102"
>  	depends on I2C
> +	depends on THERMAL || !THERMAL_OF
>  	help
>  	  If you say yes here you get support for Texas Instruments TMP102
>  	  sensor chips.
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--spM41cQEGqLnWsmiSlmq63kNQQcOJmUp4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLNQqUACgkQCXcVR3XQvP0oogEAsY3m+U4S7bHPW4NVi5CxPorC
LoFIvLhtTYffnB7BIUoA/32UzMHJrrAZXyzGybl2WwY+a4n7N5dwtCKezJhRD4TQ
=DcRQ
-----END PGP SIGNATURE-----

--spM41cQEGqLnWsmiSlmq63kNQQcOJmUp4--


--===============4573535714451364403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4573535714451364403==--
