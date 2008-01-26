From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Jan 2008 17:21:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/dme1737: fix Super-IO device ID
Message-Id: <20080126182154.69efe9de@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0801240942h64bd96c1j67554c131c32c01e@mail.gmail.com>
In-Reply-To: <191fb4ca0801240942h64bd96c1j67554c131c32c01e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 26 Jan 2008 08:54:24 -0800, Juerg Haefliger wrote:
> Shoot, sorry about that. Attached  is the correct patch.
> 
> ------
> The dme1737 has a second place where the Super-IO device ID is
> checked. This has been missed by Jean's initial patch that adds
> support for user-controlled Super-IO device ID override. This patch
> fixes this issue.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>
> Index: linux/drivers/hwmon/dme1737.c
> =================================> --- linux.orig/drivers/hwmon/dme1737.c	2008-01-24 09:32:47.000000000 -0800
> +++ linux/drivers/hwmon/dme1737.c	2008-01-24 09:38:59.000000000 -0800
> @@ -2023,7 +2023,7 @@
>  
>  	/* Check device ID
>  	 * The DME1737 can return either 0x78 or 0x77 as its device ID. */
> -	reg = dme1737_sio_inb(sio_cip, 0x20);
> +	reg = force_id ? force_id : dme1737_sio_inb(sio_cip, 0x20);
>  	if (!(reg = 0x77 || reg = 0x78)) {
>  		err = -ENODEV;
>  		goto exit;

Good catch. I had forgotten the hybrid nature of the dme1737 driver.

Acked-by: Jean Delvare <khali@linux-fr.org>

This could also be merged into my original patch. I'll leave it to Mark
how he wants to handle it.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
