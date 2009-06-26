From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date: Fri, 26 Jun 2009 09:28:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Message-Id: <1246007760.3067.5.camel@hpdv5.satnam>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A448926.1030701@samsung.com>
In-Reply-To: <4A448926.1030701@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, lm-sensors@lm-sensors.org, suchang.woo@samsung.com, kyungmin.park@samsung.com

On Fri, 2009-06-26 at 17:39 +0900, Minkyu Kang wrote:
> The GP2A002 is a I2C interfaced Sensor for Proximity/Ambient
> This patch adds support the GP2A002 sensor
> 
> Signed-off-by: Minkyu Kang <mk7.kang@samsung.com>
> Signed-off-by: Suchang Woo <suchang.woo@samsung.com>
> ---
>  drivers/hwmon/Kconfig    |    7 +
>  drivers/hwmon/Makefile   |    1 +
>  drivers/hwmon/gp2ap002.c |  471 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/gp2ap002.h |   21 ++
>  4 files changed, 500 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/gp2ap002.c
>  create mode 100644 include/linux/gp2ap002.h
> 

> diff --git a/include/linux/gp2ap002.h b/include/linux/gp2ap002.h
> new file mode 100644
> index 0000000..b6a950b
> --- /dev/null
> +++ b/include/linux/gp2ap002.h
> @@ -0,0 +1,21 @@
> +/*
> + *  Copyright (C) 2009 Samsung Electronics
> + *  Minkyu Kang <mk7.kang@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __GP2AP002_H_
> +#define __GP2AP002_H_
> +
> +struct gp2ap002_platform_data {
> +	int (*get_adc)(void);
> +	void (*power_enable)(int);
> +	int vo_gpio;
> +	int prox_mode;
> +	int enable;
> +};
> +
> +#endif

I am curious what is the use of include/linux/gp2ap002.h, it only have
gp2ap002_platform_data structure which you can keep in your source file
the only file which is using it.

Thanks,
--
JSR


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
