From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 11:51:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm90: Quiet down error messages when
Message-Id: <20071024135109.46047552@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071023225323.GA9467@lixom.net>
In-Reply-To: <20071023225323.GA9467@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Olof,

On Tue, 23 Oct 2007 17:53:23 -0500, Olof Johansson wrote:
> The commit "hwmon/lm90: Add support for the Maxim MAX6680/MAX6681"
> added a number of new addresses to probe for lm90 devices, which for me
> resulted in a bunch of these during boot (26 of them!):
> 
> Register 0xfe read failed (-1)
> Register 0xfe read failed (-1)
> Register 0xfe read failed (-1)
> 
> I.e. one for every failed probe -- 3 busses, 9 addresses.
> 
> No other hwmon driver prints debug info like this, so let's just get
> rid of it.

It's not "debug info", it's reporting an actual read error. It would
actually be good if other drivers would report these errors instead or
ignoring them. Some do, BTW (lm93 at least.)

The question is, how do you manage to get that many errors reported,
when I don't get any when loading the lm90 driver, despite the 6 I2C
buses on my system. When you reach this point in the lm90 driver, it
means that i2c-core successfully probed that there was a device at said
address on the given bus. I have a hard time believing that you have
chips at 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d and 0x4e on 3
different I2C buses on your system.

It sounds like the underlying bus driver is broken and report chips
where they aren't. What are these I2C buses? Their driver(s) needs
fixing.

> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 960df9f..b21ca19 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -470,11 +470,8 @@ static int lm90_read_reg(struct i2c_client* client, u8 reg, u8 *value)
>   	} else
>   		err = i2c_smbus_read_byte_data(client, reg);
>  
> -	if (err < 0) {
> -		dev_warn(&client->dev, "Register %#02x read failed (%d)\n",
> -			 reg, err);
> +	if (err < 0)
>  		return err;
> -	}
>  	*value = err;
>  
>  	return 0;

I'm not taking this, sorry. We _do_ want I/O errors to be reported.

If something needs to be changed here, it's rather the fact that
lm90_read_reg() is used during device probe. Calling
i2c_smbus_read_byte_data() instead would make more sense, and
incidentally wouldn't flood your logs on error (even though, again, the
underlying i2c bus driver is broken, not lm90).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
