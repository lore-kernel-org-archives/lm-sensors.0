From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Mar 2013 11:15:16 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: (lm75) Tune resolution and sample time per chip
Message-Id: <20130313121516.294df50d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130312155108.054dd75e@endymion.delvare>
In-Reply-To: <20130312155108.054dd75e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 12 Mar 2013 10:26:51 -0700, Guenter Roeck wrote:
> On Tue, Mar 12, 2013 at 05:34:11PM +0100, Jean Delvare wrote:
> > Indeed. The LM90 case is a little different though, as the update rate
> > has an effect primarily on power consumption, and for extreme values on
> > accuracy if I remember correctly (due to less/no averaging.) While in
> > the LM75 case it has no effect on power consumption but on resolution.
>
> There are always multiple dimensions. Sample time, resolution, accuracy,
> and power consumption all interact with each other. I have been using
> update_interval so far to report/configure it all. "resolution" (or possibly
> tempX_resolution) was suggested as possible additional sysfs attribute
> at some point.
> 
> > Are you suggesting that I should rename lm75_data.sample_time to
> > update_interval, and change it from jiffies to ms, for consistency?
>
> Would be a start.

I slept over it and I don't think I'll do that change. lm90's
update_interval refers to how frequently the chip starts a new
measurement. The chips supported by this driver don't do continuous
sampling, they sleep between measurements. The conversion time is
constant.

lm75's sample_time is for how long the driver can cache the values. I
ensured that it was always larger than the maximum possible conversion
time, but for some of the supported chips this maximum is a lot more
than the typical conversion time. LM75-like chips do continuous
sampling, and we don't know the exact conversion time, so we simply
don't know the update_interval value. All we can do is estimate its
maximum.

So it's not as simple as renaming a variable, changing its unit and
exporting it to sysfs. Some more thinking and care is required, which I
have no time for ATM.

> > That I should add a read-only update_interval to report the update
> > interval to user-space?
> > 
> > That I should make the update_interval attribute writable and change
> > the resolution on the fly accordingly, on a per-chip basis? This
> > would be non-trivial, as each chip have their own conversion times for
> > each supported resolution.
>
> Actually that was the idea, though I did not think about complexity.
> If it is too complex it might not be worth the effort.

For me it's not worth it. I think my patches already represent a
significant improvement to the lm75 driver, it will make readings
faster and more accurate out of the box. I don't want to spend more
time on this, I'd rather spend time reviewing pending patches ;)

Of course if someone else steps up later to work on this, I have no
objection.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
