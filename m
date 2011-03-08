From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 08 Mar 2011 18:02:37 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <20110308180237.GA17828@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110302185718.3c0e06dc@endymion.delvare>
In-Reply-To: <20110302185718.3c0e06dc@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Emiliano,

On Tue, Mar 08, 2011 at 12:43:17PM -0500, Emiliano Carnati wrote:
> Sorry to all,
> it's the first time I contribute to the kernel and I've done a bit of 
> confusion...
> 
> First of all, I apologize:  there is no bug in Dirk's code.
> 
> What I've found is that I need to call set_current_state before 
> schedule_timeout,
> otherways the system doesn't wait at all.
> 
> 
> Below there is the patch to patch v4  with the changes pointed by Dirk and 
> Guenter.
> - the {} in the if clause are in kernel style
> - the enum is lowercase and is not initialized
> - the msec variable is always >= 1 (because 128 >> 7 = 1)
> - I've initialized in=0 because otherways I get a compiler warning
> 
> Thaks for your patience
> Emiliano.
> 
> <<<< START >>>>
> diff --git a/Documentation/hwmon/ads1015 b/Documentation/hwmon/ads1015
> index 85ffd77..e12fd1c 100644
> --- a/Documentation/hwmon/ads1015
> +++ b/Documentation/hwmon/ads1015
> @@ -6,6 +6,10 @@ Supported chips:
>      Prefix: 'ads1015'
>      Datasheet: Publicly available at the Texas Instruments website :
>                 http://focus.ti.com/lit/ds/symlink/ads1015.pdf
> +  * Texas Instruments ADS1115
> +    Prefix: 'ads1115'
> +    Datasheet: Publicly available at the Texas Instruments website :
> +               http://focus.ti.com/lit/ds/symlink/ads1115.pdf
> 
>  Authors:
>          Dirk Eibach, Guntermann & Drunck GmbH <eibach <at> gdsys.de>
> @@ -13,9 +17,11 @@ Authors:
>  Description
>  -----------
> 
> -This driver implements support for the Texas Instruments ADS1015.
> +This driver implements support for the Texas Instruments ADS1015 and
> +ADS1115.
> 
> -This device is a 12-bit A-D converter with 4 inputs.
> +ADS1015 is a 12-bit A-D converter with 4 inputs.
> +ADS1115 is a 16-bit A-D converter with 4 inputs.
> 
>  The inputs can be used single ended or in certain differential 
> combinations.
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 9abcc6b..9b3e3e9 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -856,7 +856,7 @@ config SENSORS_ADS1015
>  	depends on I2C
>  	help
>  	  If you say yes here you get support for Texas Instruments ADS1015
> -	  12-bit 4-input ADC device.
> +	  & ADS1115 12/16-bit 4-input ADC devices.
> 
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called ads1015.
> diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
> index 4572024..9a607b0 100644
> --- a/drivers/hwmon/ads1015.c
> +++ b/drivers/hwmon/ads1015.c
> @@ -53,6 +53,12 @@ struct ads1015_data {
>  	struct mutex update_lock; /* mutex protect updates */
>  	struct attribute *attr_table[ADS1015_CONFIG_CHANNELS + 1];
>  	struct attribute_group attr_group;
> +	int   id;
> +};
> +
> +enum ads1015_num_id {
> +	ads1015,
> +	ads1115,
>  };
> 
>  static s32 ads1015_read_reg(struct i2c_client *client, unsigned int reg)
> @@ -78,6 +84,7 @@ static int ads1015_read_value(struct i2c_client *client, 
> unsigned int channel,
>  	unsigned int k;
>  	struct ads1015_data *data = i2c_get_clientdata(client);
>  	int res;
> +	int msec;
> 
>  	mutex_lock(&data->update_lock);
> 
> @@ -89,6 +96,13 @@ static int ads1015_read_value(struct i2c_client *client, 
> unsigned int channel,
>  	pga = (config >> 9) & 0x0007;
>  	fullscale = fullscale_table[pga];
> 
> +	/* for ADS1115, get the conversion time */
> +	if(data->id = ads1115) {
> +		msec = (config >> 5) & 0x0007;
> +		msec = 128 >> msec;
> +	}
> +	else
> +		msec = 1;

Actually, the rule is to either use { } in both branches of an if statement,
or not at all. So here you would use it in both branches, or rewrite it to

+	if(data->id = ads1115)
+		msec = 128 >> ((config >> 5) & 0x0007);
+	else
+		msec = 1;

As mentioned before, with this you end up waiting up to 128 * 5 ms which seems to be
a bit long. However, I wonder if this is necessary in the first place. From the datasheet
it seems to be used for continuous mode only, and it reflects the number of samples
per second. Are you sure you need it, or did you have a problem because set_current_state()
was missing ?

Another question - is it ok to keep the thread state as TASK_INTERRUPTIBLE after
the wait is complete ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
