From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: [PATCH-2.5] Fix w83781d sensor to use Milli-Volt for in_* in sysfs
Message-Id: <20030407215443.GA4386@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1049750163.4174.35.camel@nosferatu.lan>
In-Reply-To: <1049750163.4174.35.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com

On Mon, Apr 07, 2003 at 11:16:03PM +0200, Martin Schlemmer wrote:
> --- drivers/i2c/chips/w83781d.c.orig	2003-04-07 22:53:37.000000000 +0200
> +++ drivers/i2c/chips/w83781d.c	2003-04-07 22:53:34.000000000 +0200
> @@ -364,7 +364,7 @@
>  	 \
>  	w83781d_update_client(client); \
>  	 \
> -	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
> +	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \

Hm, this patch looks backwards, is it?

Also, just as a side note, can you make your patches so that they can be
applied with "patch -p1" instead of "patch -p0" which your current ones
are?  My tools treat -p1 patches much better :)

thanks,

greg k-h
