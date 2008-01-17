From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Jan 2008 11:35:19 +0000
Subject: Re: [lm-sensors] hwmon: (vt8231) Add individual alarm files
Message-Id: <20080117123519.2c815fba@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106154602.3f81ae40@hyperion.delvare>
In-Reply-To: <20080106154602.3f81ae40@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

On Thu, 17 Jan 2008 00:05:28 -0000, Roger Lucas wrote:
> Sorry for the slow reply - I have finally had a chance to test your
> changes on the most recent 2.6.24-rc8 kernel.
> 
> I have checked all the voltage, fan and temperature alarms and
> they work as expected.  I only have one temperature sensor on my
> motherboard so I was not able to test the alarms for temperatures 2
> through 6, but the code looks correct so I would be very surprised
> if they did not work properly.

OK, thanks for testing. Mark, can you please apply my patch to your
testing tree?

> My mail address is changing soon so I have a patch below to correct
> my e-mail addresses in the source code.  I have a special address for
> the vt8231 kernel development so that I can filter the spam on it more
> aggressively - it does seem to get heavily harvested...
> (...)
> Signed-off-by: Roger Lucas <vt8231@hiddenengine.co.uk>
> 
> --- linux-2.6.24-rc8-orig/drivers/hwmon/vt8231.c        2008-01-16 22:59:25.000000000 +0000
> +++ linux-2.6.24-rc8/drivers/hwmon/vt8231.c     2008-01-16 23:57:27.000000000 +0000
> @@ -2,7 +2,7 @@
>         vt8231.c - Part of lm_sensors, Linux kernel modules
>                                 for hardware monitoring
> 
> -       Copyright (c) 2005 Roger Lucas <roger@planbit.co.uk>
> +       Copyright (c) 2005 Roger Lucas <vt8231@hiddenengine.co.uk>
>         Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
>                            Aaron M. Marsh <amarsh@sdf.lonestar.org>
> 
> @@ -999,7 +999,7 @@
>         }
>  }
> 
> -MODULE_AUTHOR("Roger Lucas <roger@planbit.co.uk>");
> +MODULE_AUTHOR("Roger Lucas <vt8231@hiddenengine.co.uk>");
>  MODULE_DESCRIPTION("VT8231 sensors");
>  MODULE_LICENSE("GPL");

You probably want to update your address in MAINTAINERS as well.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
