From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Nov 2005 21:52:04 +0000
Subject: [lm-sensors] Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-Id: <20051115215226.4e6494e0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4378960F.8030800@varma-el.com>
In-Reply-To: <4378960F.8030800@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Volkov <avolkov@varma-el.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, "Mark A. Greer" <mgreer@mvista.com>

Hi Andrey,

> Possible too late to include in 2.6.15,
> but better later then never :).

You must be kidding. It might be too late for 2.6._16_. Reviewing takes
time, reworking afterwards takes time, then you get some testing in -mm
and it takes time again.

> Comments?

Sure, although I don't really have the time right now for a complete
review. And I'd rather not review the code if it finally isn't used.

First, a question. Can't you merge the M41T85 support into the m41t00
driver?

Mark, care to comment on that possibility, and/or on the code itself?

> +config SENSORS_M41T85
> +	tristate "ST M41T85 RTC chip"
> +	depends on I2C

I would pretty much likt it named RTC_M41T85 or RTC_M41T85_I2C instead.
It's not a sensor in any way. And it must depend on EXPERIMENTAL to
start with.

> +config SENSORS_M41T85_SQW_FRQ_ENABLE
> +	depends on SENSORS_M41T85
> +	bool "Square Wave Output"

What a mess. Please just have a sysfs file for that, it's more flexible
and less intrusive.

> +/*
> + * drivers/i2c/chips/m41t85.c
> + *

Redundant, you know where the file is if you found it.

> + * HISTORY:
> + *	 2005-10-12	Created
> + */

History doesn't belong to the source code.

> +/*
> + * This i2c client/driver wedges between the drivers/char/genrtc.c RTC
> + * interface and the SMBus interface of the i2c subsystem.
> + * It would be more efficient to use i2c msgs/i2c_transfer directly but, as
> + * recommened in .../Documentation/i2c/writing-clients section
> + * "Sending and receiving", using SMBus level communication is preferred.
> + */

The i2c_transfer interface wouldn't exist if nobody was ever supposed
to use it. Using the SMBus compatible interface makes it possible to
use your chip in conjunction with more I2C or SMBus masters. But maybe
you just need a specific driver for a specific case, and you just don't
care about the other cases. In that case, go with i2c_transfer for
smaller and faster code.

Also, use <file:Documentation/...> for referencing document files.

> +#define	M41T85_DRV_NAME		"m41t85"

Please define m41t85_driver.name directly, and use references to it
where needed. This avoids duplicating string constants.

> +static void
> +m41t85_set_tlet(ulong arg)
> +{
> +	struct rtc_time	tm;
> +	ulong	nowtime = *(ulong *)arg;

What's the idea behind this cast?

> +	strncpy(client->name, M41T85_DRV_NAME, I2C_NAME_SIZE);

Please use strlcpy instead.

> +static void __exit
> +m41t85_exit(void)
> +{
> +	i2c_del_driver(&m41t85_driver);
> +	return;
> +}

Drop this "return" statement, it is useless.

Thanks,
-- 
Jean Delvare
