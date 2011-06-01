From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 01 Jun 2011 15:38:09 +0000
Subject: Re: [lm-sensors] MAX6642 chip detection and other stuff
Message-Id: <20110601153809.GA2593@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110528045113.GA8833@ericsson.com>
In-Reply-To: <20110528045113.GA8833@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Per,

On Wed, Jun 01, 2011 at 02:44:19AM -0400, Per Dal=E9n wrote:
> Hi Guenter and Jean,
>=20
> Sorry for the delay. Much stuff at work...
> Here's (Jean's ;) patch.
>=20
> BR
> Per
>=20
[ ... ]

> Improve the detection of MAX6642 by reading non exciting registers (0x04,=
 0x06 and 0xff). The value of those registers should be the same as the las=
t valid resister read.

> Signed-off-by: Per Dalen <per.dalen@appeartv.com>
> ---
> diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
> index 0f9fc40..4fb0564 100644
> --- a/drivers/hwmon/max6642.c
> +++ b/drivers/hwmon/max6642.c
> @@ -136,6 +136,12 @@ static int max6642_detect(struct i2c_client *client,
>  	if (man_id !=3D 0x4D)
>  		return -ENODEV;
> =20
> +	/* sanity check */
> +	if (i2c_smbus_read_byte_data(client, 0x04) !=3D 0x4D
> +	    || i2c_smbus_read_byte_data(client, 0x06) !=3D 0x4D
> +	    || i2c_smbus_read_byte_data(client, 0xff) !=3D 0x4D)
> +		return -ENODEV;
> +
>  	/*
>  	 * We read the config and status register, the 4 lower bits in the
>  	 * config register should be zero and bit 5, 3, 1 and 0 should be

Looks good, only the second part of my suggested changes got lost.

        reg_config =3D i2c_smbus_read_byte_data(client, MAX6642_REG_R_CONFI=
G);
+       if ((reg_config & 0x0f) !=3D 0x00)
+               return -ENODEV;
+
+       /* in between, another round of sanity checks */
+       if (i2c_smbus_read_byte_data(client, 0x04) !=3D reg_config
+	    || i2c_smbus_read_byte_data(client, 0x06) !=3D reg_config
+	    || i2c_smbus_read_byte_data(client, 0xff) !=3D reg_config)
+               return -ENODEV;
+

Please add those, and we should be ready to go.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
