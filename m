From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 10 Aug 2012 18:45:07 +0000
Subject: Re: [lm-sensors] [patch] hwmon: (f71882fg) Signedness bug in f71882fg_init()
Message-Id: <20120810184507.GC4625@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120810092435.GC26875@elgon.mountain>
In-Reply-To: <20120810092435.GC26875@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Fri, Aug 10, 2012 at 12:24:37PM +0300, Dan Carpenter wrote:
> "address" stores and unsigned short on success but a negative on failure
> so it needs to be an int.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch merged into the original patch introducing the problem.

Thanks,
Guenter

> ---
> Applies to linux-next.  This was introduced in 1f7f944 "hwmon:
> (f71882fg) Fix build warning".
> 
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index b6304eb..853f544 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -2662,7 +2662,7 @@ exit_device_put:
>  static int __init f71882fg_init(void)
>  {
>  	int err = -ENODEV;
> -	unsigned short address;
> +	int address;
>  	struct f71882fg_sio_data sio_data;
>  
>  	memset(&sio_data, 0, sizeof(sio_data));
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
