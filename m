From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 06 Feb 2010 07:49:07 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon: add driver for ADT7411 voltage &
Message-Id: <20100206084907.237555f4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1265142758-10457-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1265142758-10457-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wolfram,

On Sat, 6 Feb 2010 00:49:43 +0100, Wolfram Sang wrote:
> > I don't quite get why adt7411_read_vdd() is responsible for updating
> > data->next_update, while it doesn't make use of its value.
> > data->next_update is only used by adt7411_show_input() so it would make
> > more sense to set it there too. It would be more flexible, as you could
> > decide that the cache (the lifetime of which is controlled by
> > data->next_update) includes both the value of vdd and the value of
> > ref_is_vdd. This would avoid reading vdd when you don't need it, and
> > guarantee that you never use uninitialized values.
> 
> I had the idea that reading vdd via sysfs should also update the cache. Trying
> to do this and reorganizing the code to solve some chicken-and-egg-problem
> regarding the cache, it seems I stumbled over my own feet.
> 
> I implemented it according to your suggestions and it looks cleaner, in deed. I
> just had to drop the idea that reading vdd from sysfs also updates the cache,
> as I would now need another lock for it which I think is not worth the trouble.

You can have reading vdd from sysfs also update the cache, but then you
should also read data->ref_is_vdd at the same time. If the user is
going to always read all the values at once then this is the most
efficient approach.

> > (...)
> > Calling the above function should invalidate the cache. At least
> > changing adc_ref_vdd makes the cached value data->adc_ref_vdd wrong,
> > and presumably the other settings may also affect the value of
> > data->vdd_cached. As I don't expect the user to change the settings
> > frequently, there's probably no point in trying to be smart.
> 
> I hate this driver, it makes me look pretty stupid :/

Naah ;) Stupid developers are the ones who let me review their driver
code and then refuse to fix the problems I have found. As long as your
driver ends up upstream, you're doing the right thing!

> I already made a V3 and will probably send it on Monday after some testing with
> the hardware.

OK, thanks. Remember that you can also do preliminary testing using
i2c-stub + a dump of the chip.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
