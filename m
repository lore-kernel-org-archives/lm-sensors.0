From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 May 2011 19:39:27 +0000
Subject: Re: [lm-sensors] [PATCH v2] MAX6642: Better detection schema
Message-Id: <20110526213927.297ad09a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDE50E5.5040902@appeartv.com>
In-Reply-To: <4DDE50E5.5040902@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 26 May 2011 15:08:53 +0200, Per Dal=E9n wrote:
> Changed according to the suggestions from Guenter Roeck:
>=20
> * Check the manufacturer ID directly. Fastens the test if it's not a
> Maxim chip.
> * Read the other non-existing registers after the manufacturer ID.
>=20
> ---
> Check for non-existing registers, registers 0x04, 0x06 and 0xff, which
> are supported by other Maxim chips. Reading such registers returns the
> previously read value.
>=20
> Signed-off-by: Per Dalen <per.dalen@appeartv.com>
> ---
>=20
> diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
> index 0f9fc40..565b507 100644
> --- a/drivers/hwmon/max6642.c
> +++ b/drivers/hwmon/max6642.c
> @@ -64,6 +64,14 @@ static const unsigned short normal_i2c[] =3D {
>  #define MAX6642_REG_W_REMOTE_HIGH	0x0D
>=20
>  /*
> + * Registers for detection tests, these registers isn't pressent and
> + * will only show the last valid register read.
> + */
> +#define MAX6642_REG_R_DUMMY_1          0x04
> +#define MAX6642_REG_R_DUMMY_2          0x06
> +#define MAX6642_REG_R_DUMMY_3          0xFF

I don't even think you want defines for these. They don't exist! The
comment would be better placed right before the relevant piece of code.

> +
> +/*
>   * Conversions
>   */
>=20
> @@ -126,7 +134,7 @@ static int max6642_detect(struct i2c_client *client,
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter =3D client->adapter;
> -	u8 reg_config, reg_status, man_id;
> +	u8 reg_config, reg_status, man_id, dummy_reg;
>=20
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
> @@ -136,6 +144,19 @@ static int max6642_detect(struct i2c_client *client,
>  	if (man_id !=3D 0x4D)
>  		return -ENODEV;
>=20
> +	/* sanity check */
> +	dummy_reg =3D i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_1);
> +	if (dummy_reg !=3D 0x4D)
> +		return -ENODEV;
> +
> +	dummy_reg =3D i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_2);
> +	if (dummy_reg !=3D 0x4D)
> +		return -ENODEV;
> +
> +	dummy_reg =3D i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_3);
> +	if (dummy_reg !=3D 0x4D)
> +		return -ENODEV;
> +

Same as for sensors-detect, please do a second round of checks after
reading the config or status register. You may want to move the checks
to a small function to avoid repeating the code.

>  	/*
>  	 * We read the config and status register, the 4 lower bits in the
>  	 * config register should be zero and bit 5, 3, 1 and 0 should be
>=20


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
