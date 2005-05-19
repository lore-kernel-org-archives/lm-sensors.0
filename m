From: adobriyan@mail.ru (Alexey Dobriyan)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH 2.6] I2C: New chip driver: sis5595
Message-Id: <200502011420.17466.adobriyan@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050125220945.GA23560@bode.aurel32.net>
In-Reply-To: <20050125220945.GA23560@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Tue, 1 Feb 2005 11:11:35 +0100, Aurelien Jarno wrote:

> Please find below the new version of the patch against kernel
> 2.6.11-rc2-mm2 to add the sis5595 driver (sensor part).

> --- linux-2.6.11-rc2-mm2.orig/drivers/i2c/chips/sis5595.c
> +++ linux-2.6.11-rc2-mm2/drivers/i2c/chips/sis5595.c

> +struct sis5595_data {

> +	char valid;		/* !=0 if following fields are valid */

> +};

> +static struct sis5595_data *sis5595_update_device(struct device *dev)
> +{

> +	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
> +	    (jiffies < data->last_updated) || !data->valid) {

		[snip reading some values]

> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}

> +}

Maybe you should call sis5595_update_device() in initialization finction and
get rid of "value" field. It's sole purpose to fill "struct sis5595" when it's
known that "last_updated" field contains crap.

> +			dev_err(&s_bridge->dev, "sis5595.ko: Error: Looked for SIS5595 but found unsupported device %.4X\n", *i);

> +		dev_err(&s_bridge->dev, "sis5595.ko: base address not set - upgrade BIOS or use force_addr=0xaddr\n");

".ko" isn't needed. "Error: " in the first line too.

	Alexey
