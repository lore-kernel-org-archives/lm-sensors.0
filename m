From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 16 Aug 2005 00:14:01 +0000
Subject: [lm-sensors] Re: [PATCH 4/5] add i2c_probe_device and
Message-Id: <20050816001413.50b9c6be.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050815175106.GA24959@litech.org>
	<20050815175438.GE24959@litech.org>
In-Reply-To: <20050815175438.GE24959@litech.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nathan Lutchansky <lutchann@litech.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>

Hi Nathan,

> These functions can be used for special-purpose adapters, such as
> those on TV tuner cards, where we generally know in advance what
> devices are attached.  This is important in cases where the adapter
> does not support probing or when probing is potentially dangerous to
> the connected devices.

Do you know of any adapter actually not supporting the SMBus Quick
command (which we use for probing)?

> --- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/i2c-core.c
> +++ linux-2.6.13-rc6+gregkh/drivers/i2c/i2c-core.c
> @@ -671,6 +671,75 @@ int i2c_control(struct i2c_client *clien
>  }
>  
>  /* ----------------------------------------------------
> + * direct add/remove functions to avoid probing
> + * ----------------------------------------------------
> + */
> +
> +int i2c_probe_device(struct i2c_adapter *adapter, int driver_id,
> +		     int addr, int kind)
> +{
> +	struct list_head   *item;
> +	struct i2c_driver  *driver = NULL;
> +
> +	/* There's no way to probe addresses on this adapter... */
> +	if (kind < 0 && !i2c_check_functionality(adapter,I2C_FUNC_SMBUS_QUICK))
> +		return -EINVAL;

Coding style please: one space after the comma. 

> +
> +	down(&core_lists);
> +	list_for_each(item,&drivers) {

Ditto.

> +		driver = list_entry(item, struct i2c_driver, list);
> +		if (driver->id = driver_id)
> +			break;
> +	}
> +	up(&core_lists);
> +	if (!item)
> +		return -ENOENT;
> +
> +	/* Already in use? */
> +	if (i2c_check_addr(adapter, addr))
> +		return -EBUSY;
> +
> +	/* Make sure there is something at this address, unless forced */
> +	if (kind < 0) {
> +		if (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
> +				   I2C_SMBUS_QUICK, NULL) < 0)
> +			return -ENODEV;
> +
> +		/* prevent 24RF08 corruption */
> +		if ((addr & ~0x0f) = 0x50)
> +			i2c_smbus_xfer(adapter, addr, 0, 0, 0,
> +				       I2C_SMBUS_QUICK, NULL);
> +	}
> +
> +	return driver->detect_client(adapter, addr, kind);
> +}

You are duplicating a part of i2c_probe_address() here. Why don't you
simply call it?

This part of the code is very sensible because of the 24RF08 corruption
issue. I have plans to change the probing method, e.g. by using SMBus
Receive Byte instead of SMBus Quick for the 0x50-0x5F address range.
Thus I would really appreciate if this code would not be duplicated.

Thanks,
-- 
Jean Delvare
