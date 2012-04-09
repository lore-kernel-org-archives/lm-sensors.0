From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Apr 2012 18:20:36 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (smsc47b397) Fix compiler warning
Message-Id: <20120409202036.164ef2bb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 28 Mar 2012 09:38:25 -0700, Guenter Roeck wrote:
> Some configurations produce the following compiler warning:
> 
> drivers/hwmon/smsc47b397.c: In function 'smsc47b397_init':
> drivers/hwmon/smsc47b397.c:385: warning: 'address' may be used uninitialized in this function
> 
> While this is a false positive, it can easily be fixed by overloading the return
> value from smsc47b397_find with both address and error return code (the address
> is an unsigned short and thus never negative). This also reduces module size by
> a few bytes (64 bytes for x86_64).
> 
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/smsc47b397.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
> index d3b778d..c5f6be4 100644
> --- a/drivers/hwmon/smsc47b397.c
> +++ b/drivers/hwmon/smsc47b397.c
> @@ -343,10 +343,11 @@ exit:
>  	return err;
>  }
>  
> -static int __init smsc47b397_find(unsigned short *addr)
> +static int __init smsc47b397_find(void)
>  {
>  	u8 id, rev;
>  	char *name;
> +	unsigned short addr;
>  
>  	superio_enter();
>  	id = force_id ? force_id : superio_inb(SUPERIO_REG_DEVID);
> @@ -370,14 +371,14 @@ static int __init smsc47b397_find(unsigned short *addr)
>  	rev = superio_inb(SUPERIO_REG_DEVREV);
>  
>  	superio_select(SUPERIO_REG_LD8);
> -	*addr = (superio_inb(SUPERIO_REG_BASE_MSB) << 8)
> +	addr = (superio_inb(SUPERIO_REG_BASE_MSB) << 8)
>  		 |  superio_inb(SUPERIO_REG_BASE_LSB);
>  
>  	pr_info("found SMSC %s (base address 0x%04x, revision %u)\n",
> -		name, *addr, rev);
> +		name, addr, rev);
>  
>  	superio_exit();
> -	return 0;
> +	return addr;
>  }
>  
>  static int __init smsc47b397_init(void)
> @@ -385,9 +386,10 @@ static int __init smsc47b397_init(void)
>  	unsigned short address;
>  	int ret;
>  
> -	ret = smsc47b397_find(&address);
> -	if (ret)
> +	ret = smsc47b397_find();
> +	if (ret < 0)
>  		return ret;
> +	address = ret;
>  
>  	ret = platform_driver_register(&smsc47b397_driver);
>  	if (ret)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
