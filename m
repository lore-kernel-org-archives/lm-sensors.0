From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 25 Sep 2012 06:44:29 +0000
Subject: Re: [lm-sensors] [PATCH] update name
Message-Id: <20120925084429.3bdd645c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1348516134-5226-1-git-send-email-bug-track@fisher-privat.net>
In-Reply-To: <1348516134-5226-1-git-send-email-bug-track@fisher-privat.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 24 Sep 2012 21:48:54 +0200, Oleksij Rempel wrote:
> My name was change after migration
> 
> Signed-off-by: Oleksij Rempel <bug-track@fisher-privat.net>
> ---
>  Documentation/hwmon/max1619 |    2 +-
>  drivers/hwmon/max1619.c     |    4 ++--
>  drivers/hwmon/max6642.c     |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/hwmon/max1619 b/Documentation/hwmon/max1619
> index d6f8d9c..e6d8739 100644
> --- a/Documentation/hwmon/max1619
> +++ b/Documentation/hwmon/max1619
> @@ -9,7 +9,7 @@ Supported chips:
>                 http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
>  
>  Authors:
> -        Alexey Fisher <fishor@mail.ru>,
> +        Oleksij Rempel <bug-track@fisher-privat.net>,
>          Jean Delvare <khali@linux-fr.org>
>  
>  Description
> diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
> index 6c11ec2..445e5d4 100644
> --- a/drivers/hwmon/max1619.c
> +++ b/drivers/hwmon/max1619.c
> @@ -1,7 +1,7 @@
>  /*
>   * max1619.c - Part of lm_sensors, Linux kernel modules for hardware
>   *             monitoring
> - * Copyright (C) 2003-2004 Alexey Fisher <fishor@mail.ru>
> + * Copyright (C) 2003-2004 Oleksij Rempel <bug-track@fisher-privat.net>
>   *                         Jean Delvare <khali@linux-fr.org>
>   *
>   * Based on the lm90 driver. The MAX1619 is a sensor chip made by Maxim.
> @@ -357,7 +357,7 @@ static struct max1619_data *max1619_update_device(struct device *dev)
>  
>  module_i2c_driver(max1619_driver);
>  
> -MODULE_AUTHOR("Alexey Fisher <fishor@mail.ru> and "
> +MODULE_AUTHOR("Oleksij Rempel <bug-track@fisher-privat.net> and "
>  	"Jean Delvare <khali@linux-fr.org>");
>  MODULE_DESCRIPTION("MAX1619 sensor driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
> index bf236c0..223461a 100644
> --- a/drivers/hwmon/max6642.c
> +++ b/drivers/hwmon/max6642.c
> @@ -7,7 +7,7 @@
>   * Derived from:
>   *
>   *  Based on the max1619 driver.
> - *  Copyright (C) 2003-2004 Alexey Fisher <fishor@mail.ru>
> + *  Copyright (C) 2003-2004 Oleksij Rempel <bug-track@fisher-privat.net>
>   *                          Jean Delvare <khali@linux-fr.org>
>   *
>   * The MAX6642 is a sensor chip made by Maxim.

Applied, thanks Oleksij.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
