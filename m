From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: [PATCH 2.6] I2C: Prevent buffer overflow on SMBus block read in
Message-Id: <20050125224258.GA18228@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050125230348.294aa0b9.khali@linux-fr.org>
In-Reply-To: <20050125230348.294aa0b9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>

On Tue, Jan 25, 2005 at 11:03:48PM +0100, Jean Delvare wrote:
> Hi Greg, Linus, all,
> 
> I just hit a buffer overflow while playing around with i2cdump and
> i2c-viapro through i2c-dev. This is caused by a missing length check on
> a buffer operation when doing a SMBus block read in the i2c-viapro
> driver. The problem was already known and had been fixed upon report by
> Sergey Vlasov back in August 2003 in lm_sensors (2.4 kernel version of
> the driver) but for some reason it was never ported to the 2.6 kernel
> version.
> 
> I am not a security expert but I would guess that such a buffer overflow
> could possibly be used to run arbitrary code in kernel space from user
> space through i2c-dev. The severity obviously depends on the permisions
> set on the i2c device files in /dev. Maybe it wouldn't be a bad idea to
> push this patch upstream rather sooner than later.

Hm, all distros leave the i2c-dev /dev nodes writable only by root, so
this isn't that "big" of an issue.  I also thought I had caught all of
this previously, when Sergey did the 2.4 patches. 

> --- linux-2.6.11-rc1-bk8/drivers/i2c/busses/i2c-viapro.c.orig	2005-01-21 20:05:05.000000000 +0100
> +++ linux-2.6.11-rc1-bk8/drivers/i2c/busses/i2c-viapro.c	2005-01-25 21:45:01.000000000 +0100
> @@ -233,8 +233,8 @@
>  			len = data->block[0];
>  			if (len < 0)
>  				len = 0;
> -			if (len > 32)
> -				len = 32;
> +			if (len > I2C_SMBUS_BLOCK_MAX)
> +				len = I2C_SMBUS_BLOCK_MAX;
>  			outb_p(len, SMBHSTDAT0);
>  			i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
>  			for (i = 1; i <= len; i++)
> @@ -268,6 +268,8 @@
>  		break;
>  	case VT596_BLOCK_DATA:
>  		data->block[0] = inb_p(SMBHSTDAT0);
> +		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
> +			data->block[0] = I2C_SMBUS_BLOCK_MAX;

But data->block[0] just came from the hardware, right?  Not from a user.
Now if we have broken hardware, then we might have a problem here, but
otherwise I don't see it as a security issue right now.

thanks,

greg k-h
