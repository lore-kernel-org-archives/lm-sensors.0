From: Uwe Hermann <uwe@hermann-uwe.de>
Date: Tue, 09 Oct 2007 14:55:11 +0000
Subject: Re: [lm-sensors] hwmon/lm87: Add support for the Analog
Message-Id: <20071009145511.GE13822@greenwood>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1393325433308977160=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============1393325433308977160==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Untested, and I'm not an lm-sensors or kernel expert anyway, but here are
some comments:

On Tue, Oct 09, 2007 at 03:22:22PM +0200, Jean Delvare wrote:
> --- linux-2.6.23-rc9.orig/Documentation/hwmon/lm87	2007-10-09 08:42:48.00=
0000000 +0200
> +++ linux-2.6.23-rc9/Documentation/hwmon/lm87	2007-10-09 11:14:05.0000000=
00 +0200
> @@ -4,8 +4,12 @@ Kernel driver lm87
>  Supported chips:
>    * National Semiconductor LM87
>      Prefix: 'lm87'
> -    Addresses scanned: I2C 0x2c - 0x2f
> +    Addresses scanned: I2C 0x2c - 0x2e

Is this intentional? Was the previous value incorrect?


>      Datasheet: http://www.national.com/pf/LM/LM87.html
> +  * Analog Devices ADM1024
> +    Prefix: 'adm1024'
> +    Addresses scanned: I2C 0x2c - 0x2e
> +    Datasheet: http://www.analog.com/en/prod/0,2877,ADM1024,00.html
[...]
> @@ -686,11 +692,18 @@ static int lm87_detect(struct i2c_adapte
> =20
>  	/* Now, we do the remaining detection. */
>  	if (kind < 0) {
> +		u8 cid =3D lm87_read_value(new_client, LM87_REG_COMPANY_ID);
>  		u8 rev =3D lm87_read_value(new_client, LM87_REG_REVISION);
> =20
> -		if (rev < 0x01 || rev > 0x08
> -		 || (lm87_read_value(new_client, LM87_REG_CONFIG) & 0x80)
> -		 || lm87_read_value(new_client, LM87_REG_COMPANY_ID) !=3D 0x02) {
> +		if (cid =3D=3D 0x02			/* National Semiconductor */
> +		 && (rev >=3D 0x01 && rev <=3D 0x08))
> +			kind =3D lm87;
> +		else if (cid =3D=3D 0x41		/* Analog Devices */

I don't know how this is handled in the rest of the code, but personally I'd
make them #defines, e.g. like this:

#define COMPANY_ID_NATSEMI		0x02
#define COMPANY_ID_ANALOG_DEVICES	0x41

(maybe even in some common header file which other drivers can use, too)

A lot more readable IMO, and you don't need any code comment anymore.


HTH, Uwe.
--=20
http://www.hermann-uwe.de  | http://www.holsham-traders.de
http://www.crazy-hacks.org | http://www.unmaintained-free-software.org

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHC5ZPXdVoV3jWIbQRAjEqAJ9At7jHkjiUHt2expkk+e2fLGMaBACgm3py
0InOeaV376M2E09BBRLuyVk=
=kEvc
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--


--===============1393325433308977160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1393325433308977160==--
