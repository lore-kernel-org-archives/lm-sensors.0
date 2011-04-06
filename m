From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 03:02:20 +0000
Subject: Re: [lm-sensors] [PATCH] Make all it87 drivers SMP safe.
Message-Id: <20110406030220.GB22535@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302038697-28985-1-git-send-email-natg@google.com>
 <20110405223814.GA21350@ericsson.com>
 <BANLkTimQDVYe53K-M173iQtmkHzKg6Djyg@mail.gmail.com>
 <20110406000528.GB21350@ericsson.com>
 <BANLkTi==zj3PoNuqf2=THaHzevvHHsuh=w@mail.gmail.com>
 <20110406004312.GA21882@ericsson.com>
 <BANLkTinSAOxNkjxMGewfPUc0-bjf9MesGA@mail.gmail.com>
In-Reply-To: <BANLkTinSAOxNkjxMGewfPUc0-bjf9MesGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Natarajan Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

On Tue, Apr 05, 2011 at 10:50:47PM -0400, Natarajan Gurumoorthy wrote:
> Guenter,
>       Thank you for spotting the fact the everything goes south if you
> disable "watchdog". I am working on a solution. Looks like the ideal
> place to store it87_io_lock.c will be drivers/misc and the IT87_LOCK
> config will be placed before the MISC_DEVICES entry in
> drivers/misc/Kconfig file. This will be similar to the
> SENSORS_LIS3LV02D entry in that Kconfig file.
> 
Almost, only afaik that is only used inside the misc directory, or at least
has some other components there. I don't really know how to handle this
situation correctly, except you could of course write a mfd driver to handle
the generic parts.

>       Now going back to the partitioning do I send this change out as
> a multi patch set consisting of 4 parts something as below:
> 
> patch 0 has a description
> 
> patch 1 has only the lock and related files
>         drivers/misc/Kconfig
>         drivers/misc/Makefile
>         include/linux/it87_lock.h
>         drivers/misc/it87_lock.c
> 
> patch 2 has drivers/watchdog changes
>         drivers/watchdog/Kconfig
>         drivers/watchdog/it8712f_wdt.c
>         drivers/watchdog/it87_wdt.c
> 
> patch 3 has drives/hwmon changes
>         drivers/hwmon/Kconfig
>         drivers/hwmon/it87.c
> 
Something like that. I have some doubts about using drivers/misc,
but I guess you'll get feedback on that after you submit the patch set.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
