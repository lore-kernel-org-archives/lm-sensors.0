From: "Stijn Devriendt (sdevrien)" <sdevrien@cisco.com>
Date: Tue, 26 Jul 2011 15:40:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Make SA56004 detection more
Message-Id: <6E4D2678AC543844917CA081C9D6B33F05076061@XMB-AMS-103.cisco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110724203615.04e42d86@endymion.delvare>
In-Reply-To: <20110724203615.04e42d86@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: zondag 24 juli 2011 20:36
> To: LM Sensors
> Cc: Stijn Devriendt (sdevrien); Guenter Roeck
> Subject: [PATCH] hwmon: (lm90) Make SA56004 detection more robust
> 
> With a device ID register value of 0, the SA56004 detection is rather
> weak. Check several other register too to confirm the detection, as we
> do for other supported devices.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Stijn Devriendt <sdevrien@cisco.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lm90.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> --- linux-3.0-rc6.orig/drivers/hwmon/lm90.c	2011-07-07
> 13:35:10.000000000 +0200
> +++ linux-3.0-rc6/drivers/hwmon/lm90.c	2011-07-07
14:26:10.000000000
> +0200
> @@ -1283,8 +1283,19 @@ static int lm90_detect(struct i2c_client
>  			}
>  		}
>  	} else
> -	if (man_id = 0xA1) { /*  NXP Semiconductor/Philips */
> -		if (chip_id = 0x00 && address >= 0x48 && address <0x4F) {
> +	if (address >= 0x48 && address <= 0x4F
> +	 && man_id = 0xA1) { /*  NXP Semiconductor/Philips */
> +		int reg_config2;
> +
> +		reg_config2 = i2c_smbus_read_byte_data(new_client,
> +						LM90_REG_R_CONFIG2);
> +		if (reg_config2 < 0)
> +			return -ENODEV;
> +
> +		if (chip_id = 0x00
> +		 && (reg_config1 & 0x2A) = 0x00
> +		 && (reg_config2 & 0xFE) = 0x00
> +		 && reg_convrate <= 0x09) {
>  			name = "sa56004";
>  		}
>  	}
> 
> 
> --
> Jean Delvare

Acked-by: Stijn Devriendt <sdevrien@cisco.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
