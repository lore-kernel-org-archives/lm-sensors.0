From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Nov 2011 20:29:57 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] hwmon: (lm63) Add support for
Message-Id: <20111121212957.5524ebed@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321894365-24285-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1321894365-24285-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 21 Nov 2011 08:52:45 -0800, Guenter Roeck wrote:
> LM96163 is an enhanced version of LM63 with improved PWM resolution. Add chip
> detection code as well as support for improved PWM resolution if the chip is
> configured to use it.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/lm63 |    8 ++++++++
>  drivers/hwmon/Kconfig    |    4 ++--
>  drivers/hwmon/lm63.c     |   41 ++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 46 insertions(+), 7 deletions(-)
> (...)
> @@ -605,6 +619,23 @@ static void lm63_init_client(struct i2c_client *client)
>  	if (data->pwm1_freq = 0)
>  		data->pwm1_freq = 1;
>  
> +	/*
> +	 * For LM96163, check if high resolution PWM is enabled.
> +	 * Also, check if unsigned temperature format is enabled
> +	 * and display a warning message if it is.
> +	 */
> +	if (data->kind = lm96163) {
> +		u8 config_enhanced
> +		  = i2c_smbus_read_byte_data(client,
> +					     LM96163_REG_CONFIG_ENHANCED);
> +		if ((config_enhanced & 0x10)
> +		    && !(data->config_fan & 0x08) && data->pwm1_freq = 8)
> +			data->pwm_highres = true;
> +		if (config_enhanced & 0x08)
> +			dev_warn(&client->dev,
> +				 "Unsigned format for High and Crit setpoints enabled but not supported by driver");

Line too long and missing trailing newline. I fixed both, and queued
the patch for kernel 3.3, thank you. Care to update wiki/Devices?

> +	}
> +
>  	/* Show some debug info about the LM63 configuration */
>  	dev_dbg(&client->dev, "Alert/tach pin configured for %s\n",
>  		(data->config & 0x04) ? "tachometer input" :


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
