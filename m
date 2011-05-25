From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 25 May 2011 18:55:36 +0000
Subject: Re: [lm-sensors] [PATCH] MAX6642: Better detection schema
Message-Id: <1306349736.2163.465.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDD40D6.8050101@appeartv.com>
In-Reply-To: <4DDD40D6.8050101@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Per,

On Wed, 2011-05-25 at 13:48 -0400, Per Dal=C3=A9n wrote:
> Made the improvement for the detection schema suggested by Guenter Roeck.
> ---
> Check for non-existing registers, registers 0x04, 0x06 and 0xff, which
> are supported by other Maxim chips. Reading such registers returns the
> previously read value.
>=20
> Signed-off-by: Per Dalen <per.dalen@appeartv.com>
> ---
>=20
> diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
> index 0f9fc40..69c7f9e 100644
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
> +
> +/*
>   * Conversions
>   */
>=20
> @@ -126,14 +134,16 @@ static int max6642_detect(struct i2c_client *client,
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter =3D client->adapter;
> -	u8 reg_config, reg_status, man_id;
> +	u8 reg_config, reg_status, man_id, dummy_reg1, dummy_reg2;
>=20
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>=20
>  	/* identification */
>  	man_id =3D i2c_smbus_read_byte_data(client, MAX6642_REG_R_MAN_ID);
> -	if (man_id !=3D 0x4D)
> +	dummy_reg1 =3D i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_1);
> +	if ((man_id !=3D 0x4D) &&
> +	    (man_id !=3D dummy_reg1))

Please drop all the unnecessary () and the unnecessary line break. Also,
I think the logic is wrong. It should be

	if (man_id !=3D 0x4d || man_id !=3D dummy_reg1)

>  		return -ENODEV;
>=20
>  	/*
> @@ -142,9 +152,13 @@ static int max6642_detect(struct i2c_client *client,
>  	 * zero in the status register.
>  	 */
>  	reg_config =3D i2c_smbus_read_byte_data(client, MAX6642_REG_R_CONFIG);
> +	dummy_reg1 =3D i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_2);
>  	reg_status =3D i2c_smbus_read_byte_data(client, MAX6642_REG_R_STATUS);
> -	if (((reg_config & 0x0f) !=3D 0x00) ||
> -	    ((reg_status & 0x2b) !=3D 0x00))
> +	dummy_reg2 =3D i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_3);
> +	if ((reg_config & 0x0f) !=3D 0x00 ||
> +	    (reg_status & 0x2b) !=3D 0x00 ||
> +	    reg_config !=3D dummy_reg1 ||
> +	    reg_status !=3D dummy_reg2)

Please remove unnecessary line breaks.

I think it is better to read all dummy registers right after reading
man_id. This way we know for sure that the MAX6642 will return 0x4d when
reading those registers, and you can check each of the registers against
man_id in the first if statement above.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
