From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 May 2011 19:33:08 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add detection of MAX6642
Message-Id: <20110526213308.2b060a2f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDE1CFF.1020906@appeartv.com>
In-Reply-To: <4DDE1CFF.1020906@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Per,

On Thu, 26 May 2011 11:27:27 +0200, Per Dal=E9n wrote:
> Changed according to the suggestions from Guenter Roeck:
>=20
> * Check the manufacturer ID directly. Fastens the test if it's not a
> Maxim chip.
> * Read the other non-existing registers after the manufacturer ID.

THis is better but I'm not completely happy yet.

> This patch adds detection of MAX6642 to sensors-detect.
>=20
> Signed-off-by: Per Dalen <per.dalen@appeartv.com>
> ---
>=20
> --- prog/detect/sensors-detect	(revision 5975)
> +++ prog/detect/sensors-detect	(working copy)
> @@ -848,6 +848,11 @@
>  		i2c_addrs =3D> [0x2c, 0x2e, 0x2f],
>  		i2c_detect =3D> sub { max6639_detect(@_); },
>  	}, {
> +		name =3D> "Maxim MAX6642",
> +		driver =3D> "max6642",
> +		i2c_addrs =3D> [0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f],

Better written: [0x48..0x4f]

> +		i2c_detect =3D> sub { max6642_detect(@_); },
> +	}, {
>  		name =3D> "Maxim MAX6655/MAX6656",
>  		driver =3D> "max6655",
>  		i2c_addrs =3D> [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
> @@ -5779,6 +5784,36 @@
>  	return 6;
>  }
>=20
> +# Chip to detect: MAX6642
> +# Registers used:
> +#   0x02: Status register
> +#   0x03: Configuration register
> +#   0xfe: Manufacturer ID
> +#   0x04,0x06,0xff: No registers
> +# We use the 0x04,0x06 and 0xff addresses (unused) to improve the

Space after comma please.

> reliability.

Please disable line wrapping in your e-mail client before sending patches.

> +# These are not real registers and will always return the last returned
> value.
> +# This isn't documented.
> +sub max6642_detect
> +{
> +	my ($file, $addr) =3D @_;
> +	my ($man_id, $conf, $status);
> +
> +	$man_id =3D i2c_smbus_read_byte_data($file, 0xfe, NO_CACHE);
> +	return unless $man_id =3D 0x4d;	# Maxim
> +	return if i2c_smbus_read_byte_data($file, 0x04, NO_CACHE) !=3D $man_id;
> +	return if i2c_smbus_read_byte_data($file, 0x06, NO_CACHE) !=3D $man_id;
> +	return if i2c_smbus_read_byte_data($file, 0xff, NO_CACHE) !=3D $man_id;
> +	$status =3D i2c_smbus_read_byte_data($file, 0x02, NO_CACHE);

At this point you should check the unused status bits immediately (so
that you can exit if they don't meet the expectations.) Then you should
read non-registers 0x04, 0x06 and 0xff again. This is the only reliable
way to make sure that there are no registers at these addresses. It is
perfectly possible (though unlikely) that a given chip does have values
0x4d for all of registers 0x04, 0x06, 0xfe and 0xff.

See max6657_detect() for an example.

> +	$conf =3D i2c_smbus_read_byte_data($file, 0x03, NO_CACHE);

NO_CACHE is not needed here, as this register 0x03 does exist. Only use
NO_CACHE when you really need it, it's expensive!

> +
> +	# Bit 5, 3, 1 and 0 should be zero
> +	return unless ($status & 0x2b) =3D 0x00;
> +	# The 4 lower bits should be zero
> +	return unless ($conf & 0x0f) =3D 0x00;
> +
> +	return 6;
> +}
> +
>  sub max6655_detect
>  {
>  	my ($file, $addr) =3D @_;


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
