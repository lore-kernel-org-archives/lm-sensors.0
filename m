From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Mar 2011 09:12:27 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <20110317101227.63f7018b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110302185718.3c0e06dc@endymion.delvare>
In-Reply-To: <20110302185718.3c0e06dc@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 17 Mar 2011 08:24:42 +0100, Eibach, Dirk wrote:
> > LDD3 doesn't say anything about setting TASK_RUNNING after 
> > schedule_timeout(), and looking at other drivers, most don't 
> > do it, so I am reasonably certain that we don't have to care.
> > 
> > OTOH, I believe that TASK_INTERRUPTIBLE is not appropriate 
> > here. A received signal would shorten the wait time, meaning 
> > that the driver would no longer wait for the maximum time and 
> > may thus return an error.
> > TASK_UNINTERRUPTIBLE is what we want here, I think, and as a 
> > matter of fact this is what the abituguru driver is doing. 
> > TASK_INTERRUPTIBLE would only be acceptable if the control 
> > loop was time-based rather than count-based.
> > 
> > The missing set_current_state() in the original driver is a 
> > genuine bug, so I'll merge the fix directly in the patch 
> > which adds the driver.
> > Thanks for noticing and reporting.
> > 
> > For reference, here is the change I applied:
> > 
> > --- linux-2.6.38.orig/drivers/hwmon/ads1015.c	2011-03-16 
> > 16:49:29.000000000 +0100
> > +++ linux-2.6.38/drivers/hwmon/ads1015.c	2011-03-16 
> > 16:45:04.000000000 +0100
> > @@ -98,6 +98,7 @@ static int ads1015_read_value(struct i2c
> >  	if (res < 0)
> >  		goto err_unlock;
> >  	for (k = 0; k < 5; ++k) {
> > +		set_current_state(TASK_UNINTERRUPTIBLE);
> >  		schedule_timeout(msecs_to_jiffies(1));
> >  		res = ads1015_read_reg(client, ADS1015_CONFIG);
> >  		if (res < 0)
> > 
> > If anyone has a problem with this, please speak up.
> 
> In "hwmon: (ads1015) Make gain and datarate configurable" I did
> 
> -		schedule_timeout(msecs_to_jiffies(1));
> +		msleep(k ? 1 : conversion_time_ms);
> 
> which should solve this.

Well, I don't want to commit a patch with a known bug, as it makes
bisecting more difficult. Your patch ("hwmon: (ads1015) Make gain and
datarate configurable") adds a feature, it shouldn't silently fix a bug
too.

If you prefer, I can change the original code to:

	for (k = 0; k < 5; ++k) {
		msleep(1);
		res = ads1015_read_reg(client, ADS1015_CONFIG);

Just let me know.

> Jean, will you merge
> hwmon-Add-support-for-Texas-Instruments-ADS1015.patch
> hwmon-ads1015-Drop-dynamic-attribute-group.patch
> hwmon-ads1015-Add-MAINTAINERS-entry.patch

Already in my tree and ready to be sent to Linus (modulo the possible
change discussed above.)

> hwmon-ads1015-Add-devicetree-documentation.patch

I thought we agreed that this should be merged by whoever is
responsible for this part of the kernel tree, i.e. not me? Also, last
time I looked, this was still work in progress.

> hwmon-ads1015-Make-gain-and-datarate-configurable.patch
> 
> Grant recently gave his ACK.

I'll try to find some time to review this one today. But it may be too
late for kernel 2.6.39.

> Emiliano can then rebase his work on top of those.

Fine with me.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
