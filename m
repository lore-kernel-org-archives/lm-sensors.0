From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 Aug 2012 14:42:39 +0000
Subject: Re: [lm-sensors] NULL dereference BUG in sch56xx_init()
Message-Id: <20120809144239.GA6604@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120809125526.GA11926@localhost>
In-Reply-To: <20120809125526.GA11926@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, Aug 09, 2012 at 08:55:26PM +0800, Fengguang Wu wrote:
> Hi Guenter,
> 
> This commit triggered an oops which can be fixed by the attached diff.
> Should it be folded into the original one (preferable for me), or be
> resent as a standalone patch?
> 
I folded it into the original commit.

Thanks a lot for the test and feedback!

Guenter

[ ... ]

> diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
> index 69abbf7..d00b30a 100644
> --- a/drivers/hwmon/sch56xx-common.c
> +++ b/drivers/hwmon/sch56xx-common.c
> @@ -554,7 +554,7 @@ exit:
>  	return err;
>  }
>  
> -static int __init sch56xx_device_add(unsigned short address, const char *name)
> +static int __init sch56xx_device_add(int address, const char *name)
>  {
>  	struct resource res = {
>  		.start	= address,
> @@ -594,7 +594,7 @@ exit_device_put:
>  
>  static int __init sch56xx_init(void)
>  {
> -	unsigned short address;
> +	int address;
>  	const char *name = NULL;
>  
>  	address = sch56xx_find(0x4e, &name);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
