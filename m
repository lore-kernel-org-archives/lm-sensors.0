From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 26 May 2011 04:09:28 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of MAX6642
Message-Id: <20110526040928.GA27381@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Per,

On Wed, May 25, 2011 at 12:56:01PM -0400, Per Dal=E9n wrote:
> This patch adds detection of MAX6642 to sensors-detect.
>=20
> Signed-off-by: Per Dalen <per.dalen@appeartv.com>
> ---
>=20
> --- prog/detect/sensors-detect  (revision 5975)
> +++ prog/detect/sensors-detect  (working copy)
> @@ -848,6 +848,11 @@
>                 i2c_addrs =3D> [0x2c, 0x2e, 0x2f],
>                 i2c_detect =3D> sub { max6639_detect(@_); },
>         }, {
> +               name =3D> "Maxim MAX6642",
> +               driver =3D> "max6642",
> +               i2c_addrs =3D> [0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e,
> 0x4f],
> +               i2c_detect =3D> sub { max6642_detect(@_); },
> +       }, {
>                 name =3D> "Maxim MAX6655/MAX6656",
>                 driver =3D> "max6655",
>                 i2c_addrs =3D> [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
> @@ -5779,6 +5784,36 @@
>         return 6;
>  }
>=20
> +# Chip to detect: MAX6642
> +# Registers used:
> +#   0x02: Status register
> +#   0x03: Configuration register
> +#   0xfe: Manufacturer ID
> +#   0x04,0x06,0xff: No registers
> +# We use the 0x04,0x06 and 0xff addresses (unused) to improve the
> reliability.
> +# These are not real registers and will always return the last returned
> value.
> +# This isn't documented.
> +sub max6642_detect
> +{
> +       my ($file, $addr) =3D @_;
> +       my ($man_id, $conf, $status);
> +
> +       $man_id =3D i2c_smbus_read_byte_data($file, 0xfe, NO_CACHE);

You might want to more the check for $man_id =3D 0x4d to here,=20
to avoid reading the other registers if you don't have to.

> +       return if i2c_smbus_read_byte_data($file, 0x04, NO_CACHE) !> $man=
_id;

I think it would be better to read the other non-existing registers here,=20
because if those are real registers they are more unlikely to return 0x4d
than to return the same value as the status and configuration registers.

Something like

	$man_id =3D i2c_smbus_read_byte_data($file, 0xfe, NO_CACHE);
	return unless $man_id =3D 0x4d;  # Maxim
	return if i2c_smbus_read_byte_data($file, 0xff, NO_CACHE) !=3D $man_id;
	return if i2c_smbus_read_byte_data($file, 0x04, NO_CACHE) !=3D $man_id;
	return if i2c_smbus_read_byte_data($file, 0x06, NO_CACHE) !=3D $man_id;

	...

Thanks,
Guenter

> +       $status =3D i2c_smbus_read_byte_data($file, 0x02, NO_CACHE);
> +       return if i2c_smbus_read_byte_data($file, 0x06, NO_CACHE) !> $sta=
tus;
> +       $conf =3D i2c_smbus_read_byte_data($file, 0x03, NO_CACHE);
> +       return if i2c_smbus_read_byte_data($file, 0xff, NO_CACHE) !=3D $c=
onf;
> +
> +       return unless $man_id =3D 0x4d;  # Maxim
> +       # Bit 5, 3, 1 and 0 should be zero
> +       return unless ($status & 0x2b) =3D 0x00;
> +       # The 4 lower bits should be zero
> +       return unless ($conf & 0x0f) =3D 0x00;
> +
> +       return 6;
> +}
> +
>  sub max6655_detect
>  {
>         my ($file, $addr) =3D @_;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
