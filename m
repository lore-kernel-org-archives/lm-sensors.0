From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Mon, 30 Jul 2007 03:23:31 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fscher-bugfix-read-control.patch
Message-Id: <20070730032331.GF31314@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <469F6DC0.8070401@hhs.nl>
In-Reply-To: <469F6DC0.8070401@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-07-19 15:57:20 +0200]:
> Here is a small fscher bugfix for 2.6.23 merging, lifted from my other fscher
> work, as requested by Jean. The current driver has a control sysfs attribute,
> which shows the contents of the control register, but the underlying
> global_control value in the data structure currently never gets filled with
> the actual contents of this register.
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> diff -up linux-2.6.22-rc4/drivers/hwmon/fscher.c.orig linux-2.6.22-rc4/drivers/hwmon/fscher.c
> --- linux-2.6.23-rc0.git1/drivers/hwmon/fscher.c.orig	2007-07-09 13:18:28.000000000 +0200
> +++ linux-2.6.23-rc0.git1/drivers/hwmon/fscher.c	2007-07-09 13:23:52.000000000 +0200
> @@ -441,6 +441,8 @@ static struct fscher_data *fscher_update
>  		data->watchdog[2] = fscher_read_value(client, FSCHER_REG_WDOG_CONTROL);
>  
>  		data->global_event = fscher_read_value(client, FSCHER_REG_EVENT_STATE);
> +		data->global_control = fscher_read_value(client,
> +							FSCHER_REG_CONTROL);
>  
>  		data->last_updated = jiffies;
>  		data->valid = 1;                 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
