From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Mar 2011 10:20:29 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <20110317112029.7b08479f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110302185718.3c0e06dc@endymion.delvare>
In-Reply-To: <20110302185718.3c0e06dc@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 17 Mar 2011 10:41:41 +0100, Eibach, Dirk wrote:
> > From: Jean Delvare [mailto:khali@linux-fr.org] 
> > Sent: Thursday, March 17, 2011 10:12 AM
> > To: Eibach, Dirk
> > Cc: Emiliano Carnati; Guenter Roeck; lm-sensors@lm-sensors.org
> > Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for 
> > Texas Instruments ADS1015
> > 
> > On Thu, 17 Mar 2011 08:24:42 +0100, Eibach, Dirk wrote:
> > > In "hwmon: (ads1015) Make gain and datarate configurable" I did
> > > 
> > > -		schedule_timeout(msecs_to_jiffies(1));
> > > +		msleep(k ? 1 : conversion_time_ms);
> > > 
> > > which should solve this.
> > 
> > Well, I don't want to commit a patch with a known bug, as it 
> > makes bisecting more difficult. Your patch ("hwmon: (ads1015) 
> > Make gain and datarate configurable") adds a feature, it 
> > shouldn't silently fix a bug too.
> > 
> > If you prefer, I can change the original code to:
> > 
> > 	for (k = 0; k < 5; ++k) {
> > 		msleep(1);
> > 		res = ads1015_read_reg(client, ADS1015_CONFIG);
> > 
> > Just let me know.
> 
> I like msleep because it is more readable.
> set_current_state(TASK_UNINTERRUPTIBLE) has some kind of voodoo-flavour
> ;)

OK, changed.

> > > Jean, will you merge
> > > hwmon-Add-support-for-Texas-Instruments-ADS1015.patch
> > > hwmon-ads1015-Drop-dynamic-attribute-group.patch
> > > hwmon-ads1015-Add-MAINTAINERS-entry.patch
> > 
> > Already in my tree and ready to be sent to Linus (modulo the 
> > possible change discussed above.)
> > 
> > > hwmon-ads1015-Add-devicetree-documentation.patch
> > 
> > I thought we agreed that this should be merged by whoever is 
> > responsible for this part of the kernel tree, i.e. not me? 
> > Also, last time I looked, this was still work in progress.
> 
> I hoped review by the devicetree-discuss folks would be sufficient.

I don't really care, I just don't want to step on anyone's toes, nor
give the feeling that we're sneaking things in. I'll ask Grant how we
should proceed.

> > > hwmon-ads1015-Make-gain-and-datarate-configurable.patch
> > > 
> > > Grant recently gave his ACK.
> > 
> > I'll try to find some time to review this one today. But it 
> > may be too late for kernel 2.6.39.
> 
> A pity. I hoped we could get in the final configuration in the first
> shot.

Only code which is in linux-next days before the merge window opens, is
guaranteed to go in.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
