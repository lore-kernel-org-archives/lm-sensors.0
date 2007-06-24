From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 10:19:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add SCH5317 to smsc47b397 driver
Message-Id: <20070624121956.51bfb856@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706201541s2416f573o74e8a34fab258d3a@mail.gmail.com>
In-Reply-To: <191fb4ca0706201541s2416f573o74e8a34fab258d3a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Wed, 20 Jun 2007 15:41:33 -0700, Juerg Haefliger wrote:
> This patch adds the SMSC SCH5317 chip (device ID 0x85) as a supported
> device to the smsc47b397 driver.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Patch is functionally correct, just one thing...

> diff -uprN -X linux-2.6.21.1/Documentation/dontdiff linux-2.6.21.1.orig/Documentation/hwmon/smsc47b397 linux-2.6.21.1/Documentation/hwmon/smsc47b397
> --- linux-2.6.21.1.orig/Documentation/hwmon/smsc47b397	2007-04-27 14:49:26.000000000 -0700
> +++ linux-2.6.21.1/Documentation/hwmon/smsc47b397	2007-06-20 11:01:52.000000000 -0700
> @@ -4,6 +4,7 @@ Kernel driver smsc47b397
>  Supported chips:
>    * SMSC LPC47B397-NC
>    * SMSC SCH5307-NS
> +  * SMSC SCH5317
>      Prefix: 'smsc47b397'
>      Addresses scanned: none, address read from Super I/O config space
>      Datasheet: In this file
> @@ -18,8 +19,8 @@ The following specification describes th
>  provided by Craig Kelly (In-Store Broadcast Network) and edited/corrected
>  by Mark M. Hoffman <mhoffman@lightlink.com>.
>  
> -[1] And SMSC SCH5307-NS, which has a different device ID but is otherwise
> -compatible.
> +[1] And SMSC SCH5307-NS and SCH5317, which have different device IDs but are
> +otherwise compatible.
>  
>  * * * * *
>  
> @@ -131,7 +132,7 @@ OUT	DX,AL
>  The registers of interest for identifying the SIO on the dc7100 are Device ID
>  (0x20) and Device Rev  (0x21).
>  
> -The Device ID will read 0x6F (for SCH5307-NS, 0x81)
> +The Device ID will read 0x6F (0x81 for SCH5307-NS, and 0x85 for SCH5317)
>  The Device Rev currently reads 0x01
>  
>  Obtaining the HWM Base Address.
> diff -uprN -X linux-2.6.21.1/Documentation/dontdiff linux-2.6.21.1.orig/drivers/hwmon/smsc47b397.c linux-2.6.21.1/drivers/hwmon/smsc47b397.c
> --- linux-2.6.21.1.orig/drivers/hwmon/smsc47b397.c	2007-04-27 14:49:26.000000000 -0700
> +++ linux-2.6.21.1/drivers/hwmon/smsc47b397.c	2007-06-20 11:02:49.000000000 -0700
> @@ -309,7 +309,7 @@ static int __init smsc47b397_find(unsign
>  	superio_enter();
>  	id = superio_inb(SUPERIO_REG_DEVID);
>  
> -	if ((id != 0x6f) && (id != 0x81)) {
> +	if ((id != 0x6f) && (id != 0x81) && (id != 0x85)) {
>  		superio_exit();
>  		return -ENODEV;
>  	}
> @@ -322,7 +322,8 @@ static int __init smsc47b397_find(unsign
>  
>  	printk(KERN_INFO "smsc47b397: found SMSC %s "
>  		"(base address 0x%04x, revision %u)\n",
> -		id = 0x81 ? "SCH5307-NS" : "LPC47B397-NC", *addr, rev);
> +		id = 0x81 ? "SCH5307-NS" : id = 0x85 ? "SCH5317" : 
> +	       "LPC47B397-NC", *addr, rev);

Coding style issues here: trailing white space, and last line is aligned
differently than the previous ones. Please make it consistent. Also,
there was some fuzz applying this part. I suspect that the patch was
generated against a 2.6.21 kernel tree. You should generate your
patches against 2.6.22-rc5 or later to make sure they apply cleanly
when Mark picks them.

>  
>  	superio_exit();
>  	return 0;

Can we also have a sensors-detect patch?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
