From: "Hans J. Koch" <hjk@linutronix.de>
Date: Tue, 06 Oct 2009 18:27:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Clean up detect functions
Message-Id: <20091006182734.GD3632@local>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091006201323.0ab6d745@hyperion.delvare>
In-Reply-To: <20091006201323.0ab6d745@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 06, 2009 at 08:13:23PM +0200, Jean Delvare wrote:
> As kind is now hard-coded to -1, there is room for code clean-ups.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

For the max6650 and lm93 part:
Reviewed-by: Hans J. Koch <hjk@linutronix.de>
Acked-by: Hans J. Koch <hjk@linutronix.de>

Thanks,
Hans

> CC: Corentin Labbe <corentin.labbe@geomatys.fr>
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> Cc: Juerg Haefliger <juergh@gmail.com>
> Cc: Riku Voipio <riku.vipio@iki.fi>
> Cc: Hans J. Koch <hjk@linutronix.de>
> Cc: Rudolf Marek <r.marek@assembler.cz>
> ---
>  drivers/hwmon/adm1026.c    |   47 +++++++++++++-------------------
>  drivers/hwmon/adm1029.c    |   57 +++++++++++----------------------------
>  drivers/hwmon/adm1031.c    |   26 ++++-------------
>  drivers/hwmon/adm9240.c    |   61 +++++++++++++++--------------------------
>  drivers/hwmon/ads7828.c    |   22 ++++++---------
>  drivers/hwmon/adt7462.c    |   27 +++++++-----------
>  drivers/hwmon/adt7470.c    |   27 +++++++-----------
>  drivers/hwmon/adt7473.c    |   27 +++++++-----------
>  drivers/hwmon/adt7475.c    |   14 ++++-----
>  drivers/hwmon/asb100.c     |   55 ++++++++++++-------------------------
>  drivers/hwmon/dme1737.c    |   32 +++++++---------------
>  drivers/hwmon/ds1621.c     |   22 ++++++---------
>  drivers/hwmon/f75375s.c    |   31 ++++++---------------
>  drivers/hwmon/fschmd.c     |   53 ++++++++++++++++--------------------
>  drivers/hwmon/gl518sm.c    |   29 ++++---------------
>  drivers/hwmon/gl520sm.c    |   12 +++-----
>  drivers/hwmon/lm63.c       |   50 +++++++++++++++-------------------
>  drivers/hwmon/lm75.c       |   54 +++++++++++++++++--------------------
>  drivers/hwmon/lm78.c       |   60 ++++++++++++++---------------------------
>  drivers/hwmon/lm87.c       |   41 ++++++++++++----------------
>  drivers/hwmon/lm92.c       |   29 ++++++-------------
>  drivers/hwmon/lm93.c       |   32 +++++++---------------
>  drivers/hwmon/lm95241.c    |   48 ++++++---------------------------
>  drivers/hwmon/max1619.c    |   64 +++++++++++++-------------------------------
>  drivers/hwmon/max6650.c    |   20 +------------
>  drivers/hwmon/smsc47m192.c |   28 ++++++++-----------
>  drivers/hwmon/thmc50.c     |   31 +++++----------------
>  drivers/hwmon/w83793.c     |   53 ++++++++++++------------------------
>  drivers/hwmon/w83l786ng.c  |   58 ++++++++++++---------------------------
>  29 files changed, 394 insertions(+), 716 deletions(-)
> 
> --- linux-2.6.32-rc3.orig/drivers/hwmon/adm1026.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/adm1026.c	2009-10-06 12:53:55.000000000 +0200
> @@ -1672,35 +1672,26 @@ static int adm1026_detect(struct i2c_cli
>  		i2c_adapter_id(client->adapter), client->addr,
>  		company, verstep);
>  
> -	/* If auto-detecting, Determine the chip type. */
> -	if (kind <= 0) {
> -		dev_dbg(&adapter->dev, "Autodetecting device at %d,0x%02x "
> -			"...\n", i2c_adapter_id(adapter), address);
> -		if (company = ADM1026_COMPANY_ANALOG_DEV
> -		    && verstep = ADM1026_VERSTEP_ADM1026) {
> -			kind = adm1026;
> -		} else if (company = ADM1026_COMPANY_ANALOG_DEV
> -			&& (verstep & 0xf0) = ADM1026_VERSTEP_GENERIC) {
> -			dev_err(&adapter->dev, "Unrecognized stepping "
> -				"0x%02x. Defaulting to ADM1026.\n", verstep);
> -			kind = adm1026;
> -		} else if ((verstep & 0xf0) = ADM1026_VERSTEP_GENERIC) {
> -			dev_err(&adapter->dev, "Found version/stepping "
> -				"0x%02x. Assuming generic ADM1026.\n",
> -				verstep);
> -			kind = any_chip;
> -		} else {
> -			dev_dbg(&adapter->dev, "Autodetection failed\n");
> -			/* Not an ADM1026 ... */
> -			if (kind = 0) { /* User used force=x,y */
> -				dev_err(&adapter->dev, "Generic ADM1026 not "
> -					"found at %d,0x%02x.  Try "
> -					"force_adm1026.\n",
> -					i2c_adapter_id(adapter), address);
> -			}
> -			return -ENODEV;
> -		}
> +	/* Determine the chip type. */
> +	dev_dbg(&adapter->dev, "Autodetecting device at %d,0x%02x...\n",
> +		i2c_adapter_id(adapter), address);
> +	if (company = ADM1026_COMPANY_ANALOG_DEV
> +	    && verstep = ADM1026_VERSTEP_ADM1026) {
> +		/* Analog Devices ADM1026 */
> +	} else if (company = ADM1026_COMPANY_ANALOG_DEV
> +		&& (verstep & 0xf0) = ADM1026_VERSTEP_GENERIC) {
> +		dev_err(&adapter->dev, "Unrecognized stepping "
> +			"0x%02x. Defaulting to ADM1026.\n", verstep);
> +	} else if ((verstep & 0xf0) = ADM1026_VERSTEP_GENERIC) {
> +		dev_err(&adapter->dev, "Found version/stepping "
> +			"0x%02x. Assuming generic ADM1026.\n",
> +			verstep);
> +	} else {
> +		dev_dbg(&adapter->dev, "Autodetection failed\n");
> +		/* Not an ADM1026... */
> +		return -ENODEV;
>  	}
> +
>  	strlcpy(info->type, "adm1026", I2C_NAME_SIZE);
>  
>  	return 0;
> --- linux-2.6.32-rc3.orig/drivers/hwmon/adm1029.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/adm1029.c	2009-10-06 12:53:55.000000000 +0200
> @@ -301,59 +301,36 @@ static int adm1029_detect(struct i2c_cli
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> +	u8 man_id, chip_id, temp_devices_installed, nb_fan_support;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
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
> -	if (kind = 0)
> -		kind = adm1029;
> -
>  	/* ADM1029 doesn't have CHIP ID, check just MAN ID
>  	 * For better detection we check also ADM1029_TEMP_DEVICES_INSTALLED,
>  	 * ADM1029_REG_NB_FAN_SUPPORT and compare it with possible values
>  	 * documented
>  	 */
>  
> -	if (kind <= 0) {	/* identification */
> -		u8 man_id, chip_id, temp_devices_installed, nb_fan_support;
> -
> -		man_id = i2c_smbus_read_byte_data(client, ADM1029_REG_MAN_ID);
> -		chip_id = i2c_smbus_read_byte_data(client, ADM1029_REG_CHIP_ID);
> -		temp_devices_installed = i2c_smbus_read_byte_data(client,
> +	man_id = i2c_smbus_read_byte_data(client, ADM1029_REG_MAN_ID);
> +	chip_id = i2c_smbus_read_byte_data(client, ADM1029_REG_CHIP_ID);
> +	temp_devices_installed = i2c_smbus_read_byte_data(client,
>  					ADM1029_REG_TEMP_DEVICES_INSTALLED);
> -		nb_fan_support = i2c_smbus_read_byte_data(client,
> +	nb_fan_support = i2c_smbus_read_byte_data(client,
>  						ADM1029_REG_NB_FAN_SUPPORT);
> -		/* 0x41 is Analog Devices */
> -		if (man_id = 0x41 && (temp_devices_installed & 0xf9) = 0x01
> -		    && nb_fan_support = 0x03) {
> -			if ((chip_id & 0xF0) = 0x00) {
> -				kind = adm1029;
> -			} else {
> -				/* There are no "official" CHIP ID, so actually
> -				 * we use Major/Minor revision for that */
> -				printk(KERN_INFO
> -				       "adm1029: Unknown major revision %x, "
> -				       "please let us know\n", chip_id);
> -			}
> -		}
> -
> -		if (kind <= 0) {	/* identification failed */
> -			pr_debug("adm1029: Unsupported chip (man_id=0x%02X, "
> -				 "chip_id=0x%02X)\n", man_id, chip_id);
> -			return -ENODEV;
> -		}
> +	/* 0x41 is Analog Devices */
> +	if (man_id != 0x41 || (temp_devices_installed & 0xf9) != 0x01
> +	    || nb_fan_support != 0x03)
> +		return -ENODEV;
> +
> +	if ((chip_id & 0xF0) != 0x00) {
> +		/* There are no "official" CHIP ID, so actually
> +		 * we use Major/Minor revision for that */
> +		pr_info("adm1029: Unknown major revision %x, "
> +			"please let us know\n", chip_id);
> +		return -ENODEV;
>  	}
> +
>  	strlcpy(info->type, "adm1029", I2C_NAME_SIZE);
>  
>  	return 0;
> --- linux-2.6.32-rc3.orig/drivers/hwmon/adm1031.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/adm1031.c	2009-10-06 12:53:55.000000000 +0200
> @@ -817,31 +817,19 @@ static int adm1031_detect(struct i2c_cli
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> -	const char *name = "";
> +	const char *name;
> +	int id, co;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	if (kind < 0) {
> -		int id, co;
> -		id = i2c_smbus_read_byte_data(client, 0x3d);
> -		co = i2c_smbus_read_byte_data(client, 0x3e);
> +	id = i2c_smbus_read_byte_data(client, 0x3d);
> +	co = i2c_smbus_read_byte_data(client, 0x3e);
>  
> -		if (!((id = 0x31 || id = 0x30) && co = 0x41))
> -			return -ENODEV;
> -		kind = (id = 0x30) ? adm1030 : adm1031;
> -	}
> -
> -	if (kind <= 0)
> -		kind = adm1031;
> +	if (!((id = 0x31 || id = 0x30) && co = 0x41))
> +		return -ENODEV;
> +	name = (id = 0x30) ? "adm1030" : "adm1031";
>  
> -	/* Given the detected chip type, set the chip name and the
> -	 * auto fan control helper table. */
> -	if (kind = adm1030) {
> -		name = "adm1030";
> -	} else if (kind = adm1031) {
> -		name = "adm1031";
> -	}
>  	strlcpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
> --- linux-2.6.32-rc3.orig/drivers/hwmon/adm9240.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/adm9240.c	2009-10-06 12:53:55.000000000 +0200
> @@ -556,51 +556,34 @@ static int adm9240_detect(struct i2c_cli
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	if (kind = 0) {
> -		kind = adm9240;
> -	}
> -
> -	if (kind < 0) {
> -
> -		/* verify chip: reg address should match i2c address */
> -		if (i2c_smbus_read_byte_data(new_client, ADM9240_REG_I2C_ADDR)
> -				!= address) {
> -			dev_err(&adapter->dev, "detect fail: address match, "
> -					"0x%02x\n", address);
> -			return -ENODEV;
> -		}
> -
> -		/* check known chip manufacturer */
> -		man_id = i2c_smbus_read_byte_data(new_client,
> -				ADM9240_REG_MAN_ID);
> -		if (man_id = 0x23) {
> -			kind = adm9240;
> -		} else if (man_id = 0xda) {
> -			kind = ds1780;
> -		} else if (man_id = 0x01) {
> -			kind = lm81;
> -		} else {
> -			dev_err(&adapter->dev, "detect fail: unknown manuf, "
> -					"0x%02x\n", man_id);
> -			return -ENODEV;
> -		}
> -
> -		/* successful detect, print chip info */
> -		die_rev = i2c_smbus_read_byte_data(new_client,
> -				ADM9240_REG_DIE_REV);
> -		dev_info(&adapter->dev, "found %s revision %u\n",
> -				man_id = 0x23 ? "ADM9240" :
> -				man_id = 0xda ? "DS1780" : "LM81", die_rev);
> +	/* verify chip: reg address should match i2c address */
> +	if (i2c_smbus_read_byte_data(new_client, ADM9240_REG_I2C_ADDR)
> +			!= address) {
> +		dev_err(&adapter->dev, "detect fail: address match, 0x%02x\n",
> +			address);
> +		return -ENODEV;
>  	}
>  
> -	/* either forced or detected chip kind */
> -	if (kind = adm9240) {
> +	/* check known chip manufacturer */
> +	man_id = i2c_smbus_read_byte_data(new_client, ADM9240_REG_MAN_ID);
> +	if (man_id = 0x23) {
>  		name = "adm9240";
> -	} else if (kind = ds1780) {
> +	} else if (man_id = 0xda) {
>  		name = "ds1780";
> -	} else if (kind = lm81) {
> +	} else if (man_id = 0x01) {
>  		name = "lm81";
> +	} else {
> +		dev_err(&adapter->dev, "detect fail: unknown manuf, 0x%02x\n",
> +			man_id);
> +		return -ENODEV;
>  	}
> +
> +	/* successful detect, print chip info */
> +	die_rev = i2c_smbus_read_byte_data(new_client, ADM9240_REG_DIE_REV);
> +	dev_info(&adapter->dev, "found %s revision %u\n",
> +		 man_id = 0x23 ? "ADM9240" :
> +		 man_id = 0xda ? "DS1780" : "LM81", die_rev);
> +
>  	strlcpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
> --- linux-2.6.32-rc3.orig/drivers/hwmon/ads7828.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/ads7828.c	2009-10-06 12:53:55.000000000 +0200
> @@ -191,6 +191,7 @@ static int ads7828_detect(struct i2c_cli
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> +	int ch;
>  
>  	/* Check we have a valid client */
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_WORD_DATA))
> @@ -202,20 +203,17 @@ static int ads7828_detect(struct i2c_cli
>  	- Read from the 8 channel addresses
>  	- Check the top 4 bits of each result are not set (12 data bits)
>  	*/
> -	if (kind < 0) {
> -		int ch;
> -		for (ch = 0; ch < ADS7828_NCH; ch++) {
> -			u16 in_data;
> -			u8 cmd = channel_cmd_byte(ch);
> -			in_data = ads7828_read_value(client, cmd);
> -			if (in_data & 0xF000) {
> -				printk(KERN_DEBUG
> -				"%s : Doesn't look like an ads7828 device\n",
> -				__func__);
> -				return -ENODEV;
> -			}
> +	for (ch = 0; ch < ADS7828_NCH; ch++) {
> +		u16 in_data;
> +		u8 cmd = channel_cmd_byte(ch);
> +		in_data = ads7828_read_value(client, cmd);
> +		if (in_data & 0xF000) {
> +			pr_debug("%s : Doesn't look like an ads7828 device\n",
> +				 __func__);
> +			return -ENODEV;
>  		}
>  	}
> +
>  	strlcpy(info->type, "ads7828", I2C_NAME_SIZE);
>  
>  	return 0;
> --- linux-2.6.32-rc3.orig/drivers/hwmon/adt7462.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/adt7462.c	2009-10-06 12:53:55.000000000 +0200
> @@ -1906,27 +1906,22 @@ static int adt7462_detect(struct i2c_cli
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> +	int vendor, device, revision;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	if (kind <= 0) {
> -		int vendor, device, revision;
> +	vendor = i2c_smbus_read_byte_data(client, ADT7462_REG_VENDOR);
> +	if (vendor != ADT7462_VENDOR)
> +		return -ENODEV;
> +
> +	device = i2c_smbus_read_byte_data(client, ADT7462_REG_DEVICE);
> +	if (device != ADT7462_DEVICE)
> +		return -ENODEV;
>  
> -		vendor = i2c_smbus_read_byte_data(client, ADT7462_REG_VENDOR);
> -		if (vendor != ADT7462_VENDOR)
> -			return -ENODEV;
> -
> -		device = i2c_smbus_read_byte_data(client, ADT7462_REG_DEVICE);
> -		if (device != ADT7462_DEVICE)
> -			return -ENODEV;
> -
> -		revision = i2c_smbus_read_byte_data(client,
> -						    ADT7462_REG_REVISION);
> -		if (revision != ADT7462_REVISION)
> -			return -ENODEV;
> -	} else
> -		dev_dbg(&adapter->dev, "detection forced\n");
> +	revision = i2c_smbus_read_byte_data(client, ADT7462_REG_REVISION);
> +	if (revision != ADT7462_REVISION)
> +		return -ENODEV;
>  
>  	strlcpy(info->type, "adt7462", I2C_NAME_SIZE);
>  
> --- linux-2.6.32-rc3.orig/drivers/hwmon/adt7470.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/adt7470.c	2009-10-06 12:53:55.000000000 +0200
> @@ -1229,27 +1229,22 @@ static int adt7470_detect(struct i2c_cli
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> +	int vendor, device, revision;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	if (kind <= 0) {
> -		int vendor, device, revision;
> +	vendor = i2c_smbus_read_byte_data(client, ADT7470_REG_VENDOR);
> +	if (vendor != ADT7470_VENDOR)
> +		return -ENODEV;
> +
> +	device = i2c_smbus_read_byte_data(client, ADT7470_REG_DEVICE);
> +	if (device != ADT7470_DEVICE)
> +		return -ENODEV;
>  
> -		vendor = i2c_smbus_read_byte_data(client, ADT7470_REG_VENDOR);
> -		if (vendor != ADT7470_VENDOR)
> -			return -ENODEV;
> -
> -		device = i2c_smbus_read_byte_data(client, ADT7470_REG_DEVICE);
> -		if (device != ADT7470_DEVICE)
> -			return -ENODEV;
> -
> -		revision = i2c_smbus_read_byte_data(client,
> -						    ADT7470_REG_REVISION);
> -		if (revision != ADT7470_REVISION)
> -			return -ENODEV;
> -	} else
> -		dev_dbg(&adapter->dev, "detection forced\n");
> +	revision = i2c_smbus_read_byte_data(client, ADT7470_REG_REVISION);
> +	if (revision != ADT7470_REVISION)
> +		return -ENODEV;
>  
>  	strlcpy(info->type, "adt7470", I2C_NAME_SIZE);
>  
> --- linux-2.6.32-rc3.orig/drivers/hwmon/adt7473.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/adt7473.c	2009-10-06 12:53:55.000000000 +0200
> @@ -1090,27 +1090,22 @@ static int adt7473_detect(struct i2c_cli
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> +	int vendor, device, revision;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	if (kind <= 0) {
> -		int vendor, device, revision;
> +	vendor = i2c_smbus_read_byte_data(client, ADT7473_REG_VENDOR);
> +	if (vendor != ADT7473_VENDOR)
> +		return -ENODEV;
> +
> +	device = i2c_smbus_read_byte_data(client, ADT7473_REG_DEVICE);
> +	if (device != ADT7473_DEVICE)
> +		return -ENODEV;
>  
> -		vendor = i2c_smbus_read_byte_data(client, ADT7473_REG_VENDOR);
> -		if (vendor != ADT7473_VENDOR)
> -			return -ENODEV;
> -
> -		device = i2c_smbus_read_byte_data(client, ADT7473_REG_DEVICE);
> -		if (device != ADT7473_DEVICE)
> -			return -ENODEV;
> -
> -		revision = i2c_smbus_read_byte_data(client,
> -						    ADT7473_REG_REVISION);
> -		if (revision != ADT7473_REV_68 && revision != ADT7473_REV_69)
> -			return -ENODEV;
> -	} else
> -		dev_dbg(&adapter->dev, "detection forced\n");
> +	revision = i2c_smbus_read_byte_data(client, ADT7473_REG_REVISION);
> +	if (revision != ADT7473_REV_68 && revision != ADT7473_REV_69)
> +		return -ENODEV;
>  
>  	strlcpy(info->type, "adt7473", I2C_NAME_SIZE);
>  
> --- linux-2.6.32-rc3.orig/drivers/hwmon/adt7475.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/adt7475.c	2009-10-06 12:53:55.000000000 +0200
> @@ -975,14 +975,12 @@ static int adt7475_detect(struct i2c_cli
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	if (kind <= 0) {
> -		if (adt7475_read(REG_VENDID) != 0x41 ||
> -		    adt7475_read(REG_DEVID) != 0x75) {
> -			dev_err(&adapter->dev,
> -				"Couldn't detect a adt7475 part at 0x%02x\n",
> -				(unsigned int)client->addr);
> -			return -ENODEV;
> -		}
> +	if (adt7475_read(REG_VENDID) != 0x41 ||
> +	    adt7475_read(REG_DEVID) != 0x75) {
> +		dev_err(&adapter->dev,
> +			"Couldn't detect a adt7475 part at 0x%02x\n",
> +			(unsigned int)client->addr);
> +		return -ENODEV;
>  	}
>  
>  	strlcpy(info->type, adt7475_id[0].name, I2C_NAME_SIZE);
> --- linux-2.6.32-rc3.orig/drivers/hwmon/asb100.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/asb100.c	2009-10-06 12:53:55.000000000 +0200
> @@ -701,6 +701,7 @@ static int asb100_detect(struct i2c_clie
>  			 struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> +	int val1, val2;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
>  		pr_debug("asb100.o: detect failed, "
> @@ -708,50 +709,30 @@ static int asb100_detect(struct i2c_clie
>  		return -ENODEV;
>  	}
>  
> -	/* The chip may be stuck in some other bank than bank 0. This may
> -	   make reading other information impossible. Specify a force=... or
> -	   force_*=... parameter, and the chip will be reset to the right
> -	   bank. */
> -	if (kind < 0) {
> -
> -		int val1 = i2c_smbus_read_byte_data(client, ASB100_REG_BANK);
> -		int val2 = i2c_smbus_read_byte_data(client, ASB100_REG_CHIPMAN);
> -
> -		/* If we're in bank 0 */
> -		if ((!(val1 & 0x07)) &&
> -				/* Check for ASB100 ID (low byte) */
> -				(((!(val1 & 0x80)) && (val2 != 0x94)) ||
> -				/* Check for ASB100 ID (high byte ) */
> -				((val1 & 0x80) && (val2 != 0x06)))) {
> -			pr_debug("asb100.o: detect failed, "
> -					"bad chip id 0x%02x!\n", val2);
> -			return -ENODEV;
> -		}
> +	val1 = i2c_smbus_read_byte_data(client, ASB100_REG_BANK);
> +	val2 = i2c_smbus_read_byte_data(client, ASB100_REG_CHIPMAN);
>  
> -	} /* kind < 0 */
> +	/* If we're in bank 0 */
> +	if ((!(val1 & 0x07)) &&
> +			/* Check for ASB100 ID (low byte) */
> +			(((!(val1 & 0x80)) && (val2 != 0x94)) ||
> +			/* Check for ASB100 ID (high byte ) */
> +			((val1 & 0x80) && (val2 != 0x06)))) {
> +		pr_debug("asb100: detect failed, bad chip id 0x%02x!\n", val2);
> +		return -ENODEV;
> +	}
>  
> -	/* We have either had a force parameter, or we have already detected
> -	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
> +	/* Put it now into bank 0 and Vendor ID High Byte */
>  	i2c_smbus_write_byte_data(client, ASB100_REG_BANK,
>  		(i2c_smbus_read_byte_data(client, ASB100_REG_BANK) & 0x78)
>  		| 0x80);
>  
>  	/* Determine the chip type. */
> -	if (kind <= 0) {
> -		int val1 = i2c_smbus_read_byte_data(client, ASB100_REG_WCHIPID);
> -		int val2 = i2c_smbus_read_byte_data(client, ASB100_REG_CHIPMAN);
> -
> -		if ((val1 = 0x31) && (val2 = 0x06))
> -			kind = asb100;
> -		else {
> -			if (kind = 0)
> -				dev_warn(&adapter->dev, "ignoring "
> -					"'force' parameter for unknown chip "
> -					"at adapter %d, address 0x%02x.\n",
> -					i2c_adapter_id(adapter), client->addr);
> -			return -ENODEV;
> -		}
> -	}
> +	val1 = i2c_smbus_read_byte_data(client, ASB100_REG_WCHIPID);
> +	val2 = i2c_smbus_read_byte_data(client, ASB100_REG_CHIPMAN);
> +
> +	if (val1 != 0x31 || val2 != 0x06)
> +		return -ENODEV;
>  
>  	strlcpy(info->type, "asb100", I2C_NAME_SIZE);
>  
> --- linux-2.6.32-rc3.orig/drivers/hwmon/dme1737.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/dme1737.c	2009-10-06 12:53:55.000000000 +0200
> @@ -2201,33 +2201,23 @@ static int dme1737_i2c_detect(struct i2c
>  		return -ENODEV;
>  	}
>  
> -	/* A negative kind means that the driver was loaded with no force
> -	 * parameter (default), so we must identify the chip. */
> -	if (kind < 0) {
> -		company = i2c_smbus_read_byte_data(client, DME1737_REG_COMPANY);
> -		verstep = i2c_smbus_read_byte_data(client, DME1737_REG_VERSTEP);
> +	company = i2c_smbus_read_byte_data(client, DME1737_REG_COMPANY);
> +	verstep = i2c_smbus_read_byte_data(client, DME1737_REG_VERSTEP);
>  
> -		if (company = DME1737_COMPANY_SMSC &&
> -		    (verstep & DME1737_VERSTEP_MASK) = DME1737_VERSTEP) {
> -			kind = dme1737;
> -		} else if (company = DME1737_COMPANY_SMSC &&
> -			   verstep = SCH5027_VERSTEP) {
> -			kind = sch5027;
> -		} else {
> -			return -ENODEV;
> -		}
> -	}
> -
> -	if (kind = sch5027) {
> +	if (company = DME1737_COMPANY_SMSC &&
> +	    verstep = SCH5027_VERSTEP) {
>  		name = "sch5027";
> -	} else {
> -		kind = dme1737;
> +
> +	} else if (company = DME1737_COMPANY_SMSC &&
> +		   (verstep & DME1737_VERSTEP_MASK) = DME1737_VERSTEP) {
>  		name = "dme1737";
> +	} else {
> +		return -ENODEV;
>  	}
>  
>  	dev_info(dev, "Found a %s chip at 0x%02x (rev 0x%02x).\n",
> -		 kind = sch5027 ? "SCH5027" : "DME1737", client->addr,
> -		 verstep);
> +		 verstep = SCH5027_VERSTEP ? "SCH5027" : "DME1737",
> +		 client->addr, verstep);
>  	strlcpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
> --- linux-2.6.32-rc3.orig/drivers/hwmon/ds1621.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/ds1621.c	2009-10-06 12:53:55.000000000 +0200
> @@ -237,20 +237,16 @@ static int ds1621_detect(struct i2c_clie
>  		return -ENODEV;
>  
>  	/* Now, we do the remaining detection. It is lousy. */
> -	if (kind < 0) {
> -		/* The NVB bit should be low if no EEPROM write has been 
> -		   requested during the latest 10ms, which is highly 
> -		   improbable in our case. */
> -		conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
> -		if (conf < 0 || conf & DS1621_REG_CONFIG_NVB)
> +	/* The NVB bit should be low if no EEPROM write has been  requested
> +	   during the latest 10ms, which is highly improbable in our case. */
> +	conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
> +	if (conf < 0 || conf & DS1621_REG_CONFIG_NVB)
> +		return -ENODEV;
> +	/* The 7 lowest bits of a temperature should always be 0. */
> +	for (i = 0; i < ARRAY_SIZE(DS1621_REG_TEMP); i++) {
> +		temp = i2c_smbus_read_word_data(client, DS1621_REG_TEMP[i]);
> +		if (temp < 0 || (temp & 0x7f00))
>  			return -ENODEV;
> -		/* The 7 lowest bits of a temperature should always be 0. */
> -		for (i = 0; i < ARRAY_SIZE(DS1621_REG_TEMP); i++) {
> -			temp = i2c_smbus_read_word_data(client,
> -							DS1621_REG_TEMP[i]);
> -			if (temp < 0 || (temp & 0x7f00))
> -				return -ENODEV;
> -		}
>  	}
>  
>  	strlcpy(info->type, "ds1621", I2C_NAME_SIZE);
> --- linux-2.6.32-rc3.orig/drivers/hwmon/f75375s.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/f75375s.c	2009-10-06 12:53:55.000000000 +0200
> @@ -681,30 +681,19 @@ static int f75375_detect(struct i2c_clie
>  			 struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> -	u8 version = 0;
> -	const char *name = "";
> +	u8 vendid, chipid, version;
> +	const char *name;
>  
> -	if (kind < 0) {
> -		u16 vendid = f75375_read16(client, F75375_REG_VENDOR);
> -		u16 chipid = f75375_read16(client, F75375_CHIP_ID);
> -		version = f75375_read8(client, F75375_REG_VERSION);
> -		if (chipid = 0x0306 && vendid = 0x1934) {
> -			kind = f75375;
> -		} else if (chipid = 0x0204 && vendid = 0x1934) {
> -			kind = f75373;
> -		} else {
> -			dev_err(&adapter->dev,
> -				"failed,%02X,%02X,%02X\n",
> -				chipid, version, vendid);
> -			return -ENODEV;
> -		}
> -	}
> -
> -	if (kind = f75375) {
> +	vendid = f75375_read16(client, F75375_REG_VENDOR);
> +	chipid = f75375_read16(client, F75375_CHIP_ID);
> +	if (chipid = 0x0306 && vendid = 0x1934)
>  		name = "f75375";
> -	} else if (kind = f75373) {
> +	else if (chipid = 0x0204 && vendid = 0x1934)
>  		name = "f75373";
> -	}
> +	else
> +		return -ENODEV;
> +
> +	version = f75375_read8(client, F75375_REG_VERSION);
>  	dev_info(&adapter->dev, "found %s version: %02X\n", name, version);
>  	strlcpy(info->type, name, I2C_NAME_SIZE);
>  
> --- linux-2.6.32-rc3.orig/drivers/hwmon/fschmd.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/fschmd.c	2009-10-06 12:57:25.000000000 +0200
> @@ -1000,43 +1000,38 @@ static void fschmd_dmi_decode(const stru
>  	}
>  }
>  
> -static int fschmd_detect(struct i2c_client *client, int kind,
> +static int fschmd_detect(struct i2c_client *client, int _kind,
>  			 struct i2c_board_info *info)
>  {
> +	enum chips kind;
>  	struct i2c_adapter *adapter = client->adapter;
> +	char id[4];
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
>  	/* Detect & Identify the chip */
> -	if (kind <= 0) {
> -		char id[4];
> -
> -		id[0] = i2c_smbus_read_byte_data(client,
> -				FSCHMD_REG_IDENT_0);
> -		id[1] = i2c_smbus_read_byte_data(client,
> -				FSCHMD_REG_IDENT_1);
> -		id[2] = i2c_smbus_read_byte_data(client,
> -				FSCHMD_REG_IDENT_2);
> -		id[3] = '\0';
> -
> -		if (!strcmp(id, "PEG"))
> -			kind = fscpos;
> -		else if (!strcmp(id, "HER"))
> -			kind = fscher;
> -		else if (!strcmp(id, "SCY"))
> -			kind = fscscy;
> -		else if (!strcmp(id, "HRC"))
> -			kind = fschrc;
> -		else if (!strcmp(id, "HMD"))
> -			kind = fschmd;
> -		else if (!strcmp(id, "HDS"))
> -			kind = fschds;
> -		else if (!strcmp(id, "SYL"))
> -			kind = fscsyl;
> -		else
> -			return -ENODEV;
> -	}
> +	id[0] = i2c_smbus_read_byte_data(client, FSCHMD_REG_IDENT_0);
> +	id[1] = i2c_smbus_read_byte_data(client, FSCHMD_REG_IDENT_1);
> +	id[2] = i2c_smbus_read_byte_data(client, FSCHMD_REG_IDENT_2);
> +	id[3] = '\0';
> +
> +	if (!strcmp(id, "PEG"))
> +		kind = fscpos;
> +	else if (!strcmp(id, "HER"))
> +		kind = fscher;
> +	else if (!strcmp(id, "SCY"))
> +		kind = fscscy;
> +	else if (!strcmp(id, "HRC"))
> +		kind = fschrc;
> +	else if (!strcmp(id, "HMD"))
> +		kind = fschmd;
> +	else if (!strcmp(id, "HDS"))
> +		kind = fschds;
> +	else if (!strcmp(id, "SYL"))
> +		kind = fscsyl;
> +	else
> +		return -ENODEV;
>  
>  	strlcpy(info->type, fschmd_id[kind - 1].name, I2C_NAME_SIZE);
>  
> --- linux-2.6.32-rc3.orig/drivers/hwmon/gl518sm.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/gl518sm.c	2009-10-06 12:53:55.000000000 +0200
> @@ -488,36 +488,21 @@ static int gl518_detect(struct i2c_clien
>  			struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> -	int i;
> +	int rev;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>  				     I2C_FUNC_SMBUS_WORD_DATA))
>  		return -ENODEV;
>  
>  	/* Now, we do the remaining detection. */
> -
> -	if (kind < 0) {
> -		if ((gl518_read_value(client, GL518_REG_CHIP_ID) != 0x80)
> -		 || (gl518_read_value(client, GL518_REG_CONF) & 0x80))
> -			return -ENODEV;
> -	}
> +	if ((gl518_read_value(client, GL518_REG_CHIP_ID) != 0x80)
> +	 || (gl518_read_value(client, GL518_REG_CONF) & 0x80))
> +		return -ENODEV;
>  
>  	/* Determine the chip type. */
> -	if (kind <= 0) {
> -		i = gl518_read_value(client, GL518_REG_REVISION);
> -		if (i = 0x00) {
> -			kind = gl518sm_r00;
> -		} else if (i = 0x80) {
> -			kind = gl518sm_r80;
> -		} else {
> -			if (kind <= 0)
> -				dev_info(&adapter->dev,
> -				    "Ignoring 'force' parameter for unknown "
> -				    "chip at adapter %d, address 0x%02x\n",
> -				    i2c_adapter_id(adapter), client->addr);
> -			return -ENODEV;
> -		}
> -	}
> +	rev = gl518_read_value(client, GL518_REG_REVISION);
> +	if (rev != 0x00 && rev != 0x80)
> +		return -ENODEV;
>  
>  	strlcpy(info->type, "gl518sm", I2C_NAME_SIZE);
>  
> --- linux-2.6.32-rc3.orig/drivers/hwmon/gl520sm.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/gl520sm.c	2009-10-06 12:53:55.000000000 +0200
> @@ -691,13 +691,11 @@ static int gl520_detect(struct i2c_clien
>  		return -ENODEV;
>  
>  	/* Determine the chip type. */
> -	if (kind < 0) {
> -		if ((gl520_read_value(client, GL520_REG_CHIP_ID) != 0x20) ||
> -		    ((gl520_read_value(client, GL520_REG_REVISION) & 0x7f) != 0x00) ||
> -		    ((gl520_read_value(client, GL520_REG_CONF) & 0x80) != 0x00)) {
> -			dev_dbg(&client->dev, "Unknown chip type, skipping\n");
> -			return -ENODEV;
> -		}
> +	if ((gl520_read_value(client, GL520_REG_CHIP_ID) != 0x20) ||
> +	    ((gl520_read_value(client, GL520_REG_REVISION) & 0x7f) != 0x00) ||
> +	    ((gl520_read_value(client, GL520_REG_CONF) & 0x80) != 0x00)) {
> +		dev_dbg(&client->dev, "Unknown chip type, skipping\n");
> +		return -ENODEV;
>  	}
>  
>  	strlcpy(info->type, "gl520sm", I2C_NAME_SIZE);
> --- linux-2.6.32-rc3.orig/drivers/hwmon/lm63.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/lm63.c	2009-10-06 12:53:55.000000000 +0200
> @@ -427,40 +427,34 @@ static int lm63_detect(struct i2c_client
>  		       struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = new_client->adapter;
> +	u8 man_id, chip_id, reg_config1, reg_config2;
> +	u8 reg_alert_status, reg_alert_mask;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	if (kind < 0) { /* must identify */
> -		u8 man_id, chip_id, reg_config1, reg_config2;
> -		u8 reg_alert_status, reg_alert_mask;
> +	man_id = i2c_smbus_read_byte_data(new_client, LM63_REG_MAN_ID);
> +	chip_id = i2c_smbus_read_byte_data(new_client, LM63_REG_CHIP_ID);
>  
> -		man_id = i2c_smbus_read_byte_data(new_client,
> -			 LM63_REG_MAN_ID);
> -		chip_id = i2c_smbus_read_byte_data(new_client,
> -			  LM63_REG_CHIP_ID);
> -		reg_config1 = i2c_smbus_read_byte_data(new_client,
> -			      LM63_REG_CONFIG1);
> -		reg_config2 = i2c_smbus_read_byte_data(new_client,
> -			      LM63_REG_CONFIG2);
> -		reg_alert_status = i2c_smbus_read_byte_data(new_client,
> -				   LM63_REG_ALERT_STATUS);
> -		reg_alert_mask = i2c_smbus_read_byte_data(new_client,
> -				 LM63_REG_ALERT_MASK);
> +	reg_config1 = i2c_smbus_read_byte_data(new_client,
> +		      LM63_REG_CONFIG1);
> +	reg_config2 = i2c_smbus_read_byte_data(new_client,
> +		      LM63_REG_CONFIG2);
> +	reg_alert_status = i2c_smbus_read_byte_data(new_client,
> +			   LM63_REG_ALERT_STATUS);
> +	reg_alert_mask = i2c_smbus_read_byte_data(new_client,
> +			 LM63_REG_ALERT_MASK);
>  
> -		if (man_id = 0x01 /* National Semiconductor */
> -		 && chip_id = 0x41 /* LM63 */
> -		 && (reg_config1 & 0x18) = 0x00
> -		 && (reg_config2 & 0xF8) = 0x00
> -		 && (reg_alert_status & 0x20) = 0x00
> -		 && (reg_alert_mask & 0xA4) = 0xA4) {
> -			kind = lm63;
> -		} else { /* failed */
> -			dev_dbg(&adapter->dev, "Unsupported chip "
> -				"(man_id=0x%02X, chip_id=0x%02X).\n",
> -				man_id, chip_id);
> -			return -ENODEV;
> -		}
> +	if (man_id != 0x01 /* National Semiconductor */
> +	 || chip_id != 0x41 /* LM63 */
> +	 || (reg_config1 & 0x18) != 0x00
> +	 || (reg_config2 & 0xF8) != 0x00
> +	 || (reg_alert_status & 0x20) != 0x00
> +	 || (reg_alert_mask & 0xA4) != 0xA4) {
> +		dev_dbg(&adapter->dev,
> +			"Unsupported chip (man_id=0x%02X, chip_id=0x%02X)\n",
> +			man_id, chip_id);
> +		return -ENODEV;
>  	}
>  
>  	strlcpy(info->type, "lm63", I2C_NAME_SIZE);
> --- linux-2.6.32-rc3.orig/drivers/hwmon/lm75.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/lm75.c	2009-10-06 12:53:55.000000000 +0200
> @@ -239,6 +239,7 @@ static int lm75_detect(struct i2c_client
>  {
>  	struct i2c_adapter *adapter = new_client->adapter;
>  	int i;
> +	int cur, conf, hyst, os;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>  				     I2C_FUNC_SMBUS_WORD_DATA))
> @@ -251,40 +252,35 @@ static int lm75_detect(struct i2c_client
>  	   The cycling+unused addresses combination is not tested,
>  	   since it would significantly slow the detection down and would
>  	   hardly add any value. */
> -	if (kind < 0) {
> -		int cur, conf, hyst, os;
>  
> -		/* Unused addresses */
> -		cur = i2c_smbus_read_word_data(new_client, 0);
> -		conf = i2c_smbus_read_byte_data(new_client, 1);
> -		hyst = i2c_smbus_read_word_data(new_client, 2);
> -		if (i2c_smbus_read_word_data(new_client, 4) != hyst
> -		 || i2c_smbus_read_word_data(new_client, 5) != hyst
> -		 || i2c_smbus_read_word_data(new_client, 6) != hyst
> -		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
> -			return -ENODEV;
> -		os = i2c_smbus_read_word_data(new_client, 3);
> -		if (i2c_smbus_read_word_data(new_client, 4) != os
> -		 || i2c_smbus_read_word_data(new_client, 5) != os
> -		 || i2c_smbus_read_word_data(new_client, 6) != os
> -		 || i2c_smbus_read_word_data(new_client, 7) != os)
> -			return -ENODEV;
> +	/* Unused addresses */
> +	cur = i2c_smbus_read_word_data(new_client, 0);
> +	conf = i2c_smbus_read_byte_data(new_client, 1);
> +	hyst = i2c_smbus_read_word_data(new_client, 2);
> +	if (i2c_smbus_read_word_data(new_client, 4) != hyst
> +	 || i2c_smbus_read_word_data(new_client, 5) != hyst
> +	 || i2c_smbus_read_word_data(new_client, 6) != hyst
> +	 || i2c_smbus_read_word_data(new_client, 7) != hyst)
> +		return -ENODEV;
> +	os = i2c_smbus_read_word_data(new_client, 3);
> +	if (i2c_smbus_read_word_data(new_client, 4) != os
> +	 || i2c_smbus_read_word_data(new_client, 5) != os
> +	 || i2c_smbus_read_word_data(new_client, 6) != os
> +	 || i2c_smbus_read_word_data(new_client, 7) != os)
> +		return -ENODEV;
>  
> -		/* Unused bits */
> -		if (conf & 0xe0)
> -			return -ENODEV;
> +	/* Unused bits */
> +	if (conf & 0xe0)
> +		return -ENODEV;
>  
> -		/* Addresses cycling */
> -		for (i = 8; i < 0xff; i += 8)
> -			if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
> -			 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
> -			 || i2c_smbus_read_word_data(new_client, i + 3) != os)
> -				return -ENODEV;
> +	/* Addresses cycling */
> +	for (i = 8; i < 0xff; i += 8) {
> +		if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
> +		 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
> +		 || i2c_smbus_read_word_data(new_client, i + 3) != os)
> +			return -ENODEV;
>  	}
>  
> -	/* NOTE: we treat "force=..." and "force_lm75=..." the same.
> -	 * Only new-style driver binding distinguishes chip types.
> -	 */
>  	strlcpy(info->type, "lm75", I2C_NAME_SIZE);
>  
>  	return 0;
> --- linux-2.6.32-rc3.orig/drivers/hwmon/lm78.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/lm78.c	2009-10-06 12:53:55.000000000 +0200
> @@ -576,52 +576,34 @@ static int lm78_i2c_detect(struct i2c_cl
>  	if (isa)
>  		mutex_lock(&isa->update_lock);
>  
> -	if (kind < 0) {
> -		if ((i2c_smbus_read_byte_data(client, LM78_REG_CONFIG) & 0x80)
> -		 || i2c_smbus_read_byte_data(client, LM78_REG_I2C_ADDR)
> -		    != address)
> -			goto err_nodev;
> -
> -		/* Explicitly prevent the misdetection of Winbond chips */
> -		i = i2c_smbus_read_byte_data(client, 0x4f);
> -		if (i = 0xa3 || i = 0x5c)
> -			goto err_nodev;
> -	}
> +	if ((i2c_smbus_read_byte_data(client, LM78_REG_CONFIG) & 0x80)
> +	 || i2c_smbus_read_byte_data(client, LM78_REG_I2C_ADDR) != address)
> +		goto err_nodev;
> +
> +	/* Explicitly prevent the misdetection of Winbond chips */
> +	i = i2c_smbus_read_byte_data(client, 0x4f);
> +	if (i = 0xa3 || i = 0x5c)
> +		goto err_nodev;
>  
>  	/* Determine the chip type. */
> -	if (kind <= 0) {
> -		i = i2c_smbus_read_byte_data(client, LM78_REG_CHIPID);
> -		if (i = 0x00 || i = 0x20	/* LM78 */
> -		 || i = 0x40)			/* LM78-J */
> -			kind = lm78;
> -		else if ((i & 0xfe) = 0xc0)
> -			kind = lm79;
> -		else {
> -			if (kind = 0)
> -				dev_warn(&adapter->dev, "Ignoring 'force' "
> -					"parameter for unknown chip at "
> -					"adapter %d, address 0x%02x\n",
> -					i2c_adapter_id(adapter), address);
> -			goto err_nodev;
> -		}
> -
> -		if (lm78_alias_detect(client, i)) {
> -			dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
> -				"be the same as ISA device\n", address);
> -			goto err_nodev;
> -		}
> +	i = i2c_smbus_read_byte_data(client, LM78_REG_CHIPID);
> +	if (i = 0x00 || i = 0x20	/* LM78 */
> +	 || i = 0x40)			/* LM78-J */
> +		client_name = "lm78";
> +	else if ((i & 0xfe) = 0xc0)
> +		client_name = "lm79";
> +	else
> +		goto err_nodev;
> +
> +	if (lm78_alias_detect(client, i)) {
> +		dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
> +			"be the same as ISA device\n", address);
> +		goto err_nodev;
>  	}
>  
>  	if (isa)
>  		mutex_unlock(&isa->update_lock);
>  
> -	switch (kind) {
> -	case lm79:
> -		client_name = "lm79";
> -		break;
> -	default:
> -		client_name = "lm78";
> -	}
>  	strlcpy(info->type, client_name, I2C_NAME_SIZE);
>  
>  	return 0;
> --- linux-2.6.32-rc3.orig/drivers/hwmon/lm87.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/lm87.c	2009-10-06 12:53:55.000000000 +0200
> @@ -666,37 +666,32 @@ static int lm87_detect(struct i2c_client
>  		       struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = new_client->adapter;
> -	static const char *names[] = { "lm87", "adm1024" };
> +	const char *name;
> +	u8 cid, rev;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	/* Default to an LM87 if forced */
> -	if (kind = 0)
> -		kind = lm87;
> +	if (lm87_read_value(new_client, LM87_REG_CONFIG) & 0x80)
> +		return -ENODEV;
>  
>  	/* Now, we do the remaining detection. */
> -	if (kind < 0) {
> -		u8 cid = lm87_read_value(new_client, LM87_REG_COMPANY_ID);
> -		u8 rev = lm87_read_value(new_client, LM87_REG_REVISION);
> -
> -		if (cid = 0x02			/* National Semiconductor */
> -		 && (rev >= 0x01 && rev <= 0x08))
> -			kind = lm87;
> -		else if (cid = 0x41		/* Analog Devices */
> -		      && (rev & 0xf0) = 0x10)
> -			kind = adm1024;
> -
> -		if (kind < 0
> -		 || (lm87_read_value(new_client, LM87_REG_CONFIG) & 0x80)) {
> -			dev_dbg(&adapter->dev,
> -				"LM87 detection failed at 0x%02x.\n",
> -				new_client->addr);
> -			return -ENODEV;
> -		}
> +	cid = lm87_read_value(new_client, LM87_REG_COMPANY_ID);
> +	rev = lm87_read_value(new_client, LM87_REG_REVISION);
> +
> +	if (cid = 0x02			/* National Semiconductor */
> +	 && (rev >= 0x01 && rev <= 0x08))
> +		name = "lm87";
> +	else if (cid = 0x41		/* Analog Devices */
> +	      && (rev & 0xf0) = 0x10)
> +		name = "adm1024";
> +	else {
> +		dev_dbg(&adapter->dev, "LM87 detection failed at 0x%02x\n",
> +			new_client->addr);
> +		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, names[kind - 1], I2C_NAME_SIZE);
> +	strlcpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> --- linux-2.6.32-rc3.orig/drivers/hwmon/lm92.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/lm92.c	2009-10-06 12:53:55.000000000 +0200
> @@ -323,31 +323,22 @@ static int lm92_detect(struct i2c_client
>  		       struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = new_client->adapter;
> +	u8 config;
> +	u16 man_id;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
>  					    | I2C_FUNC_SMBUS_WORD_DATA))
>  		return -ENODEV;
>  
> -	/* A negative kind means that the driver was loaded with no force
> -	   parameter (default), so we must identify the chip. */
> -	if (kind < 0) {
> -		u8 config = i2c_smbus_read_byte_data(new_client,
> -			     LM92_REG_CONFIG);
> -		u16 man_id = i2c_smbus_read_word_data(new_client,
> -			     LM92_REG_MAN_ID);
> +	config = i2c_smbus_read_byte_data(new_client, LM92_REG_CONFIG);
> +	man_id = i2c_smbus_read_word_data(new_client, LM92_REG_MAN_ID);
>  
> -		if ((config & 0xe0) = 0x00
> -		 && man_id = 0x0180) {
> -			pr_info("lm92: Found National Semiconductor LM92 chip\n");
> -	 		kind = lm92;
> -		} else
> -		if (max6635_check(new_client)) {
> -			pr_info("lm92: Found Maxim MAX6635 chip\n");
> -			kind = lm92; /* No separate prefix */
> -		}
> -		else
> -			return -ENODEV;
> -	}
> +	if ((config & 0xe0) = 0x00 && man_id = 0x0180)
> +		pr_info("lm92: Found National Semiconductor LM92 chip\n");
> +	else if (max6635_check(new_client))
> +		pr_info("lm92: Found Maxim MAX6635 chip\n");
> +	else
> +		return -ENODEV;
>  
>  	strlcpy(info->type, "lm92", I2C_NAME_SIZE);
>  
> --- linux-2.6.32-rc3.orig/drivers/hwmon/lm93.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/lm93.c	2009-10-06 12:53:55.000000000 +0200
> @@ -2505,34 +2505,24 @@ static int lm93_detect(struct i2c_client
>  		       struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> +	int mfr, ver;
>  
>  	if (!i2c_check_functionality(adapter, LM93_SMBUS_FUNC_MIN))
>  		return -ENODEV;
>  
>  	/* detection */
> -	if (kind < 0) {
> -		int mfr = lm93_read_byte(client, LM93_REG_MFR_ID);
> -
> -		if (mfr != 0x01) {
> -			dev_dbg(&adapter->dev,"detect failed, "
> -				"bad manufacturer id 0x%02x!\n", mfr);
> -			return -ENODEV;
> -		}
> +	mfr = lm93_read_byte(client, LM93_REG_MFR_ID);
> +	if (mfr != 0x01) {
> +		dev_dbg(&adapter->dev,
> +			"detect failed, bad manufacturer id 0x%02x!\n", mfr);
> +		return -ENODEV;
>  	}
>  
> -	if (kind <= 0) {
> -		int ver = lm93_read_byte(client, LM93_REG_VER);
> -
> -		if ((ver = LM93_MFR_ID) || (ver = LM93_MFR_ID_PROTOTYPE)) {
> -			kind = lm93;
> -		} else {
> -			dev_dbg(&adapter->dev,"detect failed, "
> -				"bad version id 0x%02x!\n", ver);
> -			if (kind = 0)
> -				dev_dbg(&adapter->dev,
> -					"(ignored 'force' parameter)\n");
> -			return -ENODEV;
> -		}
> +	ver = lm93_read_byte(client, LM93_REG_VER);
> +	if (ver != LM93_MFR_ID && ver != LM93_MFR_ID_PROTOTYPE) {
> +		dev_dbg(&adapter->dev,
> +			"detect failed, bad version id 0x%02x!\n", ver);
> +		return -ENODEV;
>  	}
>  
>  	strlcpy(info->type, "lm93", I2C_NAME_SIZE);
> --- linux-2.6.32-rc3.orig/drivers/hwmon/lm95241.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/lm95241.c	2009-10-06 12:53:55.000000000 +0200
> @@ -315,51 +315,23 @@ static int lm95241_detect(struct i2c_cli
>  {
>  	struct i2c_adapter *adapter = new_client->adapter;
>  	int address = new_client->addr;
> -	const char *name = "";
> +	const char *name;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	/*
> -	 * Now we do the remaining detection. A negative kind means that
> -	 * the driver was loaded with no force parameter (default), so we
> -	 * must both detect and identify the chip. A zero kind means that
> -	 * the driver was loaded with the force parameter, the detection
> -	 * step shall be skipped. A positive kind means that the driver
> -	 * was loaded with the force parameter and a given kind of chip is
> -	 * requested, so both the detection and the identification steps
> -	 * are skipped.
> -	 */
> -	if (kind < 0) {	/* detection */
> -		if ((i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
> -		     != MANUFACTURER_ID)
> -		|| (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
> -		    < DEFAULT_REVISION)) {
> -			dev_dbg(&adapter->dev,
> -				"LM95241 detection failed at 0x%02x.\n",
> -				address);
> -			return -ENODEV;
> -		}
> -	}
> -
> -	if (kind <= 0) { /* identification */
> -		if ((i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
> -		     = MANUFACTURER_ID)
> -		&& (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
> -		    >= DEFAULT_REVISION)) {
> -
> -			kind = lm95241;
> -
> -			if (kind <= 0) { /* identification failed */
> -				dev_info(&adapter->dev, "Unsupported chip\n");
> -				return -ENODEV;
> -			}
> -		}
> +	if ((i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
> +	     = MANUFACTURER_ID)
> +	 && (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
> +	     >= DEFAULT_REVISION)) {
> +		name = "lm95241";
> +	} else {
> +		dev_dbg(&adapter->dev, "LM95241 detection failed at 0x%02x\n",
> +			address);
> +		return -ENODEV;
>  	}
>  
>  	/* Fill the i2c board info */
> -	if (kind = lm95241)
> -		name = "lm95241";
>  	strlcpy(info->type, name, I2C_NAME_SIZE);
>  	return 0;
>  }
> --- linux-2.6.32-rc3.orig/drivers/hwmon/max1619.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/max1619.c	2009-10-06 12:53:55.000000000 +0200
> @@ -226,58 +226,34 @@ static const struct attribute_group max1
>   */
>  
>  /* Return 0 if detection is successful, -ENODEV otherwise */
> -static int max1619_detect(struct i2c_client *new_client, int kind,
> +static int max1619_detect(struct i2c_client *client, int kind,
>  			  struct i2c_board_info *info)
>  {
> -	struct i2c_adapter *adapter = new_client->adapter;
> -	u8 reg_config=0, reg_convrate=0, reg_status=0;
> +	struct i2c_adapter *adapter = client->adapter;
> +	u8 reg_config, reg_convrate, reg_status, man_id, chip_id;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	/*
> -	 * Now we do the remaining detection. A negative kind means that
> -	 * the driver was loaded with no force parameter (default), so we
> -	 * must both detect and identify the chip. A zero kind means that
> -	 * the driver was loaded with the force parameter, the detection
> -	 * step shall be skipped. A positive kind means that the driver
> -	 * was loaded with the force parameter and a given kind of chip is
> -	 * requested, so both the detection and the identification steps
> -	 * are skipped.
> -	 */
> -	if (kind < 0) { /* detection */
> -		reg_config = i2c_smbus_read_byte_data(new_client,
> -			      MAX1619_REG_R_CONFIG);
> -		reg_convrate = i2c_smbus_read_byte_data(new_client,
> -			       MAX1619_REG_R_CONVRATE);
> -		reg_status = i2c_smbus_read_byte_data(new_client,
> -				MAX1619_REG_R_STATUS);
> -		if ((reg_config & 0x03) != 0x00
> -		 || reg_convrate > 0x07 || (reg_status & 0x61 ) !=0x00) {
> -			dev_dbg(&adapter->dev,
> -				"MAX1619 detection failed at 0x%02x.\n",
> -				new_client->addr);
> -			return -ENODEV;
> -		}
> +	/* detection */
> +	reg_config = i2c_smbus_read_byte_data(client, MAX1619_REG_R_CONFIG);
> +	reg_convrate = i2c_smbus_read_byte_data(client, MAX1619_REG_R_CONVRATE);
> +	reg_status = i2c_smbus_read_byte_data(client, MAX1619_REG_R_STATUS);
> +	if ((reg_config & 0x03) != 0x00
> +	 || reg_convrate > 0x07 || (reg_status & 0x61) != 0x00) {
> +		dev_dbg(&adapter->dev, "MAX1619 detection failed at 0x%02x\n",
> +			client->addr);
> +		return -ENODEV;
>  	}
>  
> -	if (kind <= 0) { /* identification */
> -		u8 man_id, chip_id;
> -	
> -		man_id = i2c_smbus_read_byte_data(new_client,
> -			 MAX1619_REG_R_MAN_ID);
> -		chip_id = i2c_smbus_read_byte_data(new_client,
> -			  MAX1619_REG_R_CHIP_ID);
> -		
> -		if ((man_id = 0x4D) && (chip_id = 0x04))
> -			kind = max1619;
> -
> -		if (kind <= 0) { /* identification failed */
> -			dev_info(&adapter->dev,
> -			    "Unsupported chip (man_id=0x%02X, "
> -			    "chip_id=0x%02X).\n", man_id, chip_id);
> -			return -ENODEV;
> -		}
> +	/* identification */
> +	man_id = i2c_smbus_read_byte_data(client, MAX1619_REG_R_MAN_ID);
> +	chip_id = i2c_smbus_read_byte_data(client, MAX1619_REG_R_CHIP_ID);
> +	if (man_id != 0x4D || chip_id != 0x04) {
> +		dev_info(&adapter->dev,
> +			 "Unsupported chip (man_id=0x%02X, chip_id=0x%02X).\n",
> +			 man_id, chip_id);
> +		return -ENODEV;
>  	}
>  
>  	strlcpy(info->type, "max1619", I2C_NAME_SIZE);
> --- linux-2.6.32-rc3.orig/drivers/hwmon/max6650.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/max6650.c	2009-10-06 12:53:55.000000000 +0200
> @@ -534,7 +534,7 @@ static int max6650_detect(struct i2c_cli
>  	struct i2c_adapter *adapter = client->adapter;
>  	int address = client->addr;
>  
> -	dev_dbg(&adapter->dev, "max6650_detect called, kind = %d\n", kind);
> +	dev_dbg(&adapter->dev, "max6650_detect called\n");
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
>  		dev_dbg(&adapter->dev, "max6650: I2C bus doesn't support "
> @@ -542,23 +542,7 @@ static int max6650_detect(struct i2c_cli
>  		return -ENODEV;
>  	}
>  
> -	/*
> -	 * Now we do the remaining detection. A negative kind means that
> -	 * the driver was loaded with no force parameter (default), so we
> -	 * must both detect and identify the chip (actually there is only
> -	 * one possible kind of chip for now, max6650). A zero kind means that
> -	 * the driver was loaded with the force parameter, the detection
> -	 * step shall be skipped. A positive kind means that the driver
> -	 * was loaded with the force parameter and a given kind of chip is
> -	 * requested, so both the detection and the identification steps
> -	 * are skipped.
> -	 *
> -	 * Currently I can find no way to distinguish between a MAX6650 and
> -	 * a MAX6651. This driver has only been tried on the former.
> -	 */
> -
> -	if ((kind < 0) &&
> -	   (  (i2c_smbus_read_byte_data(client, MAX6650_REG_CONFIG) & 0xC0)
> +	if (((i2c_smbus_read_byte_data(client, MAX6650_REG_CONFIG) & 0xC0)
>  	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_GPIO_STAT) & 0xE0)
>  	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_ALARM_EN) & 0xE0)
>  	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_ALARM) & 0xE0)
> --- linux-2.6.32-rc3.orig/drivers/hwmon/smsc47m192.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/smsc47m192.c	2009-10-06 12:53:55.000000000 +0200
> @@ -491,24 +491,22 @@ static int smsc47m192_detect(struct i2c_
>  		return -ENODEV;
>  
>  	/* Detection criteria from sensors_detect script */
> -	if (kind < 0) {
> -		if (i2c_smbus_read_byte_data(client,
> +	version = i2c_smbus_read_byte_data(client, SMSC47M192_REG_VERSION);
> +	if (i2c_smbus_read_byte_data(client,
>  				SMSC47M192_REG_COMPANY_ID) = 0x55
> -		 && ((version = i2c_smbus_read_byte_data(client,
> -				SMSC47M192_REG_VERSION)) & 0xf0) = 0x20
> -		 && (i2c_smbus_read_byte_data(client,
> +	 && (version & 0xf0) = 0x20
> +	 && (i2c_smbus_read_byte_data(client,
>  				SMSC47M192_REG_VID) & 0x70) = 0x00
> -		 && (i2c_smbus_read_byte_data(client,
> +	 && (i2c_smbus_read_byte_data(client,
>  				SMSC47M192_REG_VID4) & 0xfe) = 0x80) {
> -			dev_info(&adapter->dev,
> -				 "found SMSC47M192 or compatible, "
> -				 "version 2, stepping A%d\n", version & 0x0f);
> -		} else {
> -			dev_dbg(&adapter->dev,
> -				"SMSC47M192 detection failed at 0x%02x\n",
> -				client->addr);
> -			return -ENODEV;
> -		}
> +		dev_info(&adapter->dev,
> +			 "found SMSC47M192 or compatible, "
> +			 "version 2, stepping A%d\n", version & 0x0f);
> +	} else {
> +		dev_dbg(&adapter->dev,
> +			"SMSC47M192 detection failed at 0x%02x\n",
> +			client->addr);
> +		return -ENODEV;
>  	}
>  
>  	strlcpy(info->type, "smsc47m192", I2C_NAME_SIZE);
> --- linux-2.6.32-rc3.orig/drivers/hwmon/thmc50.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/thmc50.c	2009-10-06 12:53:55.000000000 +0200
> @@ -289,7 +289,6 @@ static int thmc50_detect(struct i2c_clie
>  	unsigned revision;
>  	unsigned config;
>  	struct i2c_adapter *adapter = client->adapter;
> -	int err = 0;
>  	const char *type_name;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> @@ -301,31 +300,13 @@ static int thmc50_detect(struct i2c_clie
>  	pr_debug("thmc50: Probing for THMC50 at 0x%2X on bus %d\n",
>  		 client->addr, i2c_adapter_id(client->adapter));
>  
> -	/* Now, we do the remaining detection. */
>  	company = i2c_smbus_read_byte_data(client, THMC50_REG_COMPANY_ID);
>  	revision = i2c_smbus_read_byte_data(client, THMC50_REG_DIE_CODE);
>  	config = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
> +	if (revision < 0xc0 || (config & 0x10))
> +		return -ENODEV;
>  
> -	if (kind = 0)
> -		kind = thmc50;
> -	else if (kind < 0) {
> -		err = -ENODEV;
> -		if (revision >= 0xc0 && ((config & 0x10) = 0)) {
> -			if (company = 0x49) {
> -				kind = thmc50;
> -				err = 0;
> -			} else if (company = 0x41) {
> -				kind = adm1022;
> -				err = 0;
> -			}
> -		}
> -	}
> -	if (err = -ENODEV) {
> -		pr_debug("thmc50: Detection of THMC50/ADM1022 failed\n");
> -		return err;
> -	}
> -
> -	if (kind = adm1022) {
> +	if (company = 0x41) {
>  		int id = i2c_adapter_id(client->adapter);
>  		int i;
>  
> @@ -340,9 +321,13 @@ static int thmc50_detect(struct i2c_clie
>  							  config);
>  				break;
>  			}
> -	} else {
> +	} else if (company = 0x49) {
>  		type_name = "thmc50";
> +	} else {
> +		pr_debug("thmc50: Detection of THMC50/ADM1022 failed\n");
> +		return -ENODEV;
>  	}
> +
>  	pr_debug("thmc50: Detected %s (version %x, revision %x)\n",
>  		 type_name, (revision >> 4) - 0xc, revision & 0xf);
>  
> --- linux-2.6.32-rc3.orig/drivers/hwmon/w83793.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/w83793.c	2009-10-06 12:53:55.000000000 +0200
> @@ -1164,7 +1164,7 @@ ERROR_SC_0:
>  static int w83793_detect(struct i2c_client *client, int kind,
>  			 struct i2c_board_info *info)
>  {
> -	u8 tmp, bank;
> +	u8 tmp, bank, chip_id;
>  	struct i2c_adapter *adapter = client->adapter;
>  	unsigned short address = client->addr;
>  
> @@ -1174,44 +1174,27 @@ static int w83793_detect(struct i2c_clie
>  
>  	bank = i2c_smbus_read_byte_data(client, W83793_REG_BANKSEL);
>  
> -	if (kind < 0) {
> -		tmp = bank & 0x80 ? 0x5c : 0xa3;
> -		/* Check Winbond vendor ID */
> -		if (tmp != i2c_smbus_read_byte_data(client,
> -							W83793_REG_VENDORID)) {
> -			pr_debug("w83793: Detection failed at check "
> -				 "vendor id\n");
> -			return -ENODEV;
> -		}
> -
> -		/* If Winbond chip, address of chip and W83793_REG_I2C_ADDR
> -		   should match */
> -		if ((bank & 0x07) = 0
> -		 && i2c_smbus_read_byte_data(client, W83793_REG_I2C_ADDR) !> -		    (address << 1)) {
> -			pr_debug("w83793: Detection failed at check "
> -				 "i2c addr\n");
> -			return -ENODEV;
> -		}
> -
> +	tmp = bank & 0x80 ? 0x5c : 0xa3;
> +	/* Check Winbond vendor ID */
> +	if (tmp != i2c_smbus_read_byte_data(client, W83793_REG_VENDORID)) {
> +		pr_debug("w83793: Detection failed at check vendor id\n");
> +		return -ENODEV;
>  	}
>  
> -	/* We have either had a force parameter, or we have already detected the
> -	   Winbond. Determine the chip type now */
> -
> -	if (kind <= 0) {
> -		if (0x7b = i2c_smbus_read_byte_data(client,
> -						     W83793_REG_CHIPID)) {
> -			kind = w83793;
> -		} else {
> -			if (kind = 0)
> -				dev_warn(&adapter->dev, "w83793: Ignoring "
> -					 "'force' parameter for unknown chip "
> -					 "at address 0x%02x\n", address);
> -			return -ENODEV;
> -		}
> +	/* If Winbond chip, address of chip and W83793_REG_I2C_ADDR
> +	   should match */
> +	if ((bank & 0x07) = 0
> +	 && i2c_smbus_read_byte_data(client, W83793_REG_I2C_ADDR) !> +	    (address << 1)) {
> +		pr_debug("w83793: Detection failed at check i2c addr\n");
> +		return -ENODEV;
>  	}
>  
> +	/* Determine the chip type now */
> +	chip_id = i2c_smbus_read_byte_data(client, W83793_REG_CHIPID);
> +	if (chip_id != 0x7b)
> +		return -ENODEV;
> +
>  	strlcpy(info->type, "w83793", I2C_NAME_SIZE);
>  
>  	return 0;
> --- linux-2.6.32-rc3.orig/drivers/hwmon/w83l786ng.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/w83l786ng.c	2009-10-06 12:53:55.000000000 +0200
> @@ -590,53 +590,31 @@ w83l786ng_detect(struct i2c_client *clie
>  		 struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> +	u16 man_id;
> +	u8 chip_id;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
>  		return -ENODEV;
>  	}
>  
> -	/*
> -	 * Now we do the remaining detection. A negative kind means that
> -	 * the driver was loaded with no force parameter (default), so we
> -	 * must both detect and identify the chip (actually there is only
> -	 * one possible kind of chip for now, W83L786NG). A zero kind means
> -	 * that the driver was loaded with the force parameter, the detection
> -	 * step shall be skipped. A positive kind means that the driver
> -	 * was loaded with the force parameter and a given kind of chip is
> -	 * requested, so both the detection and the identification steps
> -	 * are skipped.
> -	 */
> -	if (kind < 0) { /* detection */
> -		if (((w83l786ng_read_value(client,
> -		    W83L786NG_REG_CONFIG) & 0x80) != 0x00)) {
> -			dev_dbg(&adapter->dev,
> -				"W83L786NG detection failed at 0x%02x.\n",
> -				client->addr);
> -			return -ENODEV;
> -		}
> +	/* Detection */
> +	if ((w83l786ng_read_value(client, W83L786NG_REG_CONFIG) & 0x80)) {
> +		dev_dbg(&adapter->dev, "W83L786NG detection failed at 0x%02x\n",
> +			client->addr);
> +		return -ENODEV;
>  	}
>  
> -	if (kind <= 0) { /* identification */
> -		u16 man_id;
> -		u8 chip_id;
> -
> -		man_id = (w83l786ng_read_value(client,
> -		    W83L786NG_REG_MAN_ID1) << 8) +
> -		    w83l786ng_read_value(client, W83L786NG_REG_MAN_ID2);
> -		chip_id = w83l786ng_read_value(client, W83L786NG_REG_CHIP_ID);
> -
> -		if (man_id = 0x5CA3) { /* Winbond */
> -			if (chip_id = 0x80) { /* W83L786NG */
> -				kind = w83l786ng;
> -			}
> -		}
> -
> -		if (kind <= 0) { /* identification failed */
> -			dev_info(&adapter->dev,
> -			    "Unsupported chip (man_id=0x%04X, "
> -			    "chip_id=0x%02X).\n", man_id, chip_id);
> -			return -ENODEV;
> -		}
> +	/* Identification */
> +	man_id = (w83l786ng_read_value(client, W83L786NG_REG_MAN_ID1) << 8) +
> +		 w83l786ng_read_value(client, W83L786NG_REG_MAN_ID2);
> +	chip_id = w83l786ng_read_value(client, W83L786NG_REG_CHIP_ID);
> +
> +	if (man_id != 0x5CA3 ||		/* Winbond */
> +	    chip_id != 0x80) {		/* W83L786NG */
> +		dev_dbg(&adapter->dev,
> +			"Unsupported chip (man_id=0x%04X, chip_id=0x%02X)\n",
> +			man_id, chip_id);
> +		return -ENODEV;
>  	}
>  
>  	strlcpy(info->type, "w83l786ng", I2C_NAME_SIZE);
> 
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
