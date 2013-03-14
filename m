From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 15:16:28 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: (lm75) Tune resolution and sample time per chip
Message-Id: <20130314151627.GB10995@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130312155108.054dd75e@endymion.delvare>
In-Reply-To: <20130312155108.054dd75e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 14, 2013 at 08:28:57AM +0100, Jean Delvare wrote:
> On Wed, 13 Mar 2013 16:16:36 -0700, Guenter Roeck wrote:
> > Key question right now though is what to do with the nct6775 driver ...
> > I would really like to get it off my back. It just seems impossible
> > to get anyone to review it. Not really surprising given its size.
> > On the other side there is real demand for it, to the point that
> > at least archlinux already provides it. I wonder if I should just
> > push it into 3.10 and wait for any fallout. Do you have an opinion ?
> 
> Yes, please push it into 3.10. It's a new driver, so you're not going
> to cause any regression. Worst case, driver doesn't work properly for
> some users, or some feature is broken, this can't really be worse than
> having no driver at all.
> 
Ok, I'll do that.

> And if this ultimately lets us remove support for some chips from the
> w83627ehf driver and make it look sane again, I'm all for it.
> 
Makes sense. This also makes one of the patches I submitted for w83627ehf
unnecessary, as it affects nct6775/nct6776 support.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
