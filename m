From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Mar 2010 09:29:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: f71882fg: properly acquire I/O
Message-Id: <20100324102942.215ee413@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269353535-23134-1-git-send-email-me@mortis.eu>
In-Reply-To: <1269353535-23134-1-git-send-email-me@mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Hans de Goede <hdegoede@redhat.com>, Jonathan Cameron <jic23@cam.ac.uk>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, 23 Mar 2010 15:12:15 +0100, Giel van Schijndel wrote:
> Acquire the I/O region for the Super I/O chip while we're working on it.
> 
> Further alter the way multiple Super I/O addresses are probed for chips
> such that errors in the probing process are passed on from the module
> initialisation function.
> 
> Some code cleanup: properly using, previously defined, functions rather
> than duplicating their code.
> (...)

On top of Hans' comments, to which I agree:

>  static u16 f71882fg_read_temp(struct f71882fg_data *data, int nr)
> @@ -2184,6 +2178,13 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
>  	int err = -ENODEV;
>  	u16 devid;
>  
> +	/* Don't step on other driver's I/O space by accident */
> +	if (!request_region(sioaddr, 2, DRVNAME)) {
> +		printk(KERN_ERR DRVNAME ": I/O address 0x%04x already in use\n",
> +				(int)sioaddr);
> +		return -EIO;

This is the wrong error code. This isn't an I/O error. You want -EBUSY.

> +	}
> +
>  	superio_enter(sioaddr);
>  
>  	devid = superio_inw(sioaddr, SIO_REG_MANID);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
