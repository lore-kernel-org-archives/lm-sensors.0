From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Aug 2010 15:26:16 +0000
Subject: Re: [lm-sensors] [PATCH] Trivial changes to pacify the checkpatch.
Message-Id: <20100827172616.49d908fa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1282919942-4087-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1282919942-4087-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 27 Aug 2010 20:09:02 +0530, Shubhrajyoti D wrote:
> Some trivial changes to pacify the checkpatch.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/hwmon/lm75.c |   45 ++++++++++++++++++++++++---------------------
>  1 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index d579290..3e8a1f9 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -1,22 +1,22 @@
>  /*
> -    lm75.c - Part of lm_sensors, Linux kernel modules for hardware
> -             monitoring
> -    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
> -
> -    This program is free software; you can redistribute it and/or modify
> -    it under the terms of the GNU General Public License as published by
> -    the Free Software Foundation; either version 2 of the License, or
> -    (at your option) any later version.
> -
> -    This program is distributed in the hope that it will be useful,
> -    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -    GNU General Public License for more details.
> -
> -    You should have received a copy of the GNU General Public License
> -    along with this program; if not, write to the Free Software
> -    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> -*/
> + * lm75.c - Part of lm_sensors, Linux kernel modules for hardware
> + *	 monitoring
> + * Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
>  
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -339,9 +339,11 @@ static struct i2c_driver lm75_driver = {
>  
>  /* register access */
>  
> -/* All registers are word-sized, except for the configuration register.
> -   LM75 uses a high-byte first convention, which is exactly opposite to
> -   the SMBus standard. */
> +/*
> + * All registers are word-sized, except for the configuration register.
> + * LM75 uses a high-byte first convention, which is exactly opposite to
> + * the SMBus standard.
> + */
>  static int lm75_read_value(struct i2c_client *client, u8 reg)
>  {
>  	int value;

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
