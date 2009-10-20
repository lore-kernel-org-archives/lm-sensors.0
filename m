From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Tue, 20 Oct 2009 14:26:28 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Clean up detect functions
Message-Id: <4ADDC894.7070807@geomatys.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091006201323.0ab6d745@hyperion.delvare>
In-Reply-To: <20091006201323.0ab6d745@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare a =E9crit :
> As kind is now hard-coded to -1, there is room for code clean-ups.

Acked-by: Corentin LABBE <corentin.labbe@geomatys.fr>

>=20
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> CC: Corentin Labbe <corentin.labbe@geomatys.fr>
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> Cc: Juerg Haefliger <juergh@gmail.com>
> Cc: Riku Voipio <riku.vipio@iki.fi>
> Cc: Hans J. Koch <hjk@linutronix.de>
> Cc: Rudolf Marek <r.marek@assembler.cz>
> ---
>  drivers/hwmon/adm1029.c    |   57 +++++++++++----------------------------
>=20
> --- linux-2.6.32-rc3.orig/drivers/hwmon/adm1029.c	2009-10-06 10:33:15.000=
000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/adm1029.c	2009-10-06 12:53:55.00000000=
0 +0200
> @@ -301,59 +301,36 @@ static int adm1029_detect(struct i2c_cli
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter =3D client->adapter;
> +	u8 man_id, chip_id, temp_devices_installed, nb_fan_support;
> =20
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
> =20
> -	/* Now we do the detection and identification. A negative kind
> -	 * means that the driver was loaded with no force parameter
> -	 * (default), so we must both detect and identify the chip
> -	 * (actually there is only one possible kind of chip for now, adm1029).
> -	 * A zero kind means that the driver was loaded with the force
> -	 * parameter, the detection step shall be skipped. A positive kind
> -	 * means that the driver was loaded with the force parameter and a
> -	 * given kind of chip is requested, so both the detection and the
> -	 * identification steps are skipped. */
> -
> -	/* Default to an adm1029 if forced */
> -	if (kind =3D 0)
> -		kind =3D adm1029;
> -
>  	/* ADM1029 doesn't have CHIP ID, check just MAN ID
>  	 * For better detection we check also ADM1029_TEMP_DEVICES_INSTALLED,
>  	 * ADM1029_REG_NB_FAN_SUPPORT and compare it with possible values
>  	 * documented
>  	 */
> =20
> -	if (kind <=3D 0) {	/* identification */
> -		u8 man_id, chip_id, temp_devices_installed, nb_fan_support;
> -
> -		man_id =3D i2c_smbus_read_byte_data(client, ADM1029_REG_MAN_ID);
> -		chip_id =3D i2c_smbus_read_byte_data(client, ADM1029_REG_CHIP_ID);
> -		temp_devices_installed =3D i2c_smbus_read_byte_data(client,
> +	man_id =3D i2c_smbus_read_byte_data(client, ADM1029_REG_MAN_ID);
> +	chip_id =3D i2c_smbus_read_byte_data(client, ADM1029_REG_CHIP_ID);
> +	temp_devices_installed =3D i2c_smbus_read_byte_data(client,
>  					ADM1029_REG_TEMP_DEVICES_INSTALLED);
> -		nb_fan_support =3D i2c_smbus_read_byte_data(client,
> +	nb_fan_support =3D i2c_smbus_read_byte_data(client,
>  						ADM1029_REG_NB_FAN_SUPPORT);
> -		/* 0x41 is Analog Devices */
> -		if (man_id =3D 0x41 && (temp_devices_installed & 0xf9) =3D 0x01
> -		    && nb_fan_support =3D 0x03) {
> -			if ((chip_id & 0xF0) =3D 0x00) {
> -				kind =3D adm1029;
> -			} else {
> -				/* There are no "official" CHIP ID, so actually
> -				 * we use Major/Minor revision for that */
> -				printk(KERN_INFO
> -				       "adm1029: Unknown major revision %x, "
> -				       "please let us know\n", chip_id);
> -			}
> -		}
> -
> -		if (kind <=3D 0) {	/* identification failed */
> -			pr_debug("adm1029: Unsupported chip (man_id=3D0x%02X, "
> -				 "chip_id=3D0x%02X)\n", man_id, chip_id);
> -			return -ENODEV;
> -		}
> +	/* 0x41 is Analog Devices */
> +	if (man_id !=3D 0x41 || (temp_devices_installed & 0xf9) !=3D 0x01
> +	    || nb_fan_support !=3D 0x03)
> +		return -ENODEV;
> +
> +	if ((chip_id & 0xF0) !=3D 0x00) {
> +		/* There are no "official" CHIP ID, so actually
> +		 * we use Major/Minor revision for that */
> +		pr_info("adm1029: Unknown major revision %x, "
> +			"please let us know\n", chip_id);
> +		return -ENODEV;
>  	}
> +
>  	strlcpy(info->type, "adm1029", I2C_NAME_SIZE);
> =20
>  	return 0;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
