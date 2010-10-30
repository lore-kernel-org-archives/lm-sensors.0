From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 30 Oct 2010 08:21:36 +0000
Subject: Re: [lm-sensors] [PATCH 4/6] hwmon: Change mail address of Hans J.
Message-Id: <20101030102136.6a6a3035@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101029221231.GA4331@local>
	<20101029223223.GE4331@local>
In-Reply-To: <20101029223223.GE4331@local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Hans J. Koch" <hjk@hansjkoch.de>
Cc: LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Hans,

On Sat, 30 Oct 2010 00:32:23 +0200, Hans J. Koch wrote:
> My old mail address doesn't exist anymore. This changes all occurrences
> to my new address.

Thanks for letting us know.

> 
> Signed-off-by: Hans J. Koch <hjk@hansjkoch.de>
> ---
>  drivers/hwmon/amc6821.c |    2 +-
>  drivers/hwmon/lm93.c    |    4 ++--
>  drivers/hwmon/max6650.c |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index fa9708c..4033974 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -4,7 +4,7 @@
>  	Copyright (C) 2009 T. Mertelj <tomaz.mertelj@guest.arnes.si>
>  
>  	Based on max6650.c:
> -	Copyright (C) 2007 Hans J. Koch <hjk@linutronix.de>
> +	Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
>  
>  	This program is free software; you can redistribute it and/or modify
>  	it under the terms of the GNU General Public License as published by
> diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
> index 6669255..754e5fb 100644
> --- a/drivers/hwmon/lm93.c
> +++ b/drivers/hwmon/lm93.c
> @@ -20,7 +20,7 @@
>      Adapted to 2.6.20 by Carsten Emde <cbe@osadl.org>
>          Copyright (c) 2006 Carsten Emde, Open Source Automation Development Lab
>  
> -    Modified for mainline integration by Hans J. Koch <hjk@linutronix.de>
> +    Modified for mainline integration by Hans J. Koch <hjk@hansjkoch.de>
>          Copyright (c) 2007 Hans J. Koch, Linutronix GmbH
>  
>      This program is free software; you can redistribute it and/or modify
> @@ -2629,7 +2629,7 @@ static void __exit lm93_exit(void)
>  }
>  
>  MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>, "
> -		"Hans J. Koch <hjk@linutronix.de");
> +		"Hans J. Koch <hjk@hansjkoch.de");

Probably the right time to add the missing ">". I'll do it, consider
this patch applied.

>  MODULE_DESCRIPTION("LM93 driver");
>  MODULE_LICENSE("GPL");
>  
> diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
> index a0160ee..9a11532 100644
> --- a/drivers/hwmon/max6650.c
> +++ b/drivers/hwmon/max6650.c
> @@ -2,7 +2,7 @@
>   * max6650.c - Part of lm_sensors, Linux kernel modules for hardware
>   *             monitoring.
>   *
> - * (C) 2007 by Hans J. Koch <hjk@linutronix.de>
> + * (C) 2007 by Hans J. Koch <hjk@hansjkoch.de>
>   *
>   * based on code written by John Morris <john.morris@spirentcom.com>
>   * Copyright (c) 2003 Spirent Communications


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
