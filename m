From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: [PATCH 2.6] New chip driver: pcf8591
Message-Id: <20040409190532.GA17315@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040328160717.GA32728@pc.aurel32.private>
In-Reply-To: <20040328160717.GA32728@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 28, 2004 at 06:07:17PM +0200, Aurelien Jarno wrote:
> Hi Greg,
> 
> Please find below a patch against kernel 2.6.5-rc2-mm4 to add the pcf8591
> driver (a 8-bit A/D and D/A converter). I have ported it from the 2.4
> version, and it includes some fixes, improvements and simplifications.
> 
> It has been reviewed by Jean Delvare on IRC.
> 
> Please also note that the patch also fixes a missing space in
> drivers/i2c/chips/Kconfig, introduced by the previous patch I sent you
> concerning the pcf8574.

Sorry for the delay, this has now been applied, along with a few
formatting changes, and one bugfix:

> +static ssize_t set_out0_output(struct device *dev, const char *buf, size_t count)
> +{
> +	unsigned int value;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct pcf8591_data *data = i2c_get_clientdata(client);
> +	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255);
> +	{
> +		data->aout = value;
> +		i2c_smbus_write_byte_data(client, data->control, data->aout);
> +	}
> +	return count;
> +}

I fixed that if statement above (you really didn't want that ';' there,
right?

thanks,

greg k-h
