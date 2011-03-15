From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Mar 2011 17:48:36 +0000
Subject: Re: [lm-sensors] [PATCH resend] sensors: Add support for additional
Message-Id: <20110315184836.5b8a5f1f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110210030757.GA22858@ericsson.com>
In-Reply-To: <20110210030757.GA22858@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 15 Mar 2011 10:31:28 -0700, Guenter Roeck wrote:
> On Tue, 2011-03-15 at 12:56 -0400, Jean Delvare wrote:
> > On Tue, 15 Mar 2011 09:23:25 -0700, Guenter Roeck wrote:
> > > Backwards compatibility issue. "max" and "min" were traditionally used
> > > to display "highest" and "lowest", and I did not want to change that.
> > 
> > But the origial code supported max (highest) without min (lowest) just
> > fine, which you code does not.
> > 
> > Quite frankly, I wouldn't bother about backwards compatibility here.
> > For one thing, power sensors are relatively recent, so users probably
> > don't expect things to be carved in stone yet. For another, using "min"
> > and "max" for "lowest" and "highest" was a bad choice in the first
> > place. We have traditionally used "min" and "max" for limits, while
> > what we have here are measurement extremes. Re-using "min" and "max"
> > can only confuse the user. So I would use "lowest" and "highest" to
> > clearly show the difference.
> > 
> Ok, I'll luse "lowest" and "highest". Really makes much more sense.
> 
> > > However, that overlaps with "max" for the new SENSORS_SUBFEATURE_POWER_MAX.
> > > 
> > > I've changed the highest output to to "hmax" to lift the limitation.
> > > Not optimal, since there is still the average max which is also displayed
> > > as "max". Please let me know if you have a better idea.
> > 
> > Instant and average power sensors are supposed to be mutually
> > exclusive, and so are their limits, so I don't see any problem here.
> > 
> Should I use "lowest" and "highest" here as well for consistency ?

Yes, please.

> > > (...)
> > > I am also looking into support for DS1721, DS1631, and DS1731. DS1721 is supported
> > > by the ds1621 driver, though auto-detection does not work if the chip is in "standard"
> > > mode (the driver itself still works, though).
> > 
> > The ds1621 driver shouldn't do device detection in the first place, it
> > is hardly reliable as the devices lack an ID register.
> > 
> > > I am waiting for samples for the other chips.
> > 
> > I have a DS1631 somewhere in a drawer. I asked Maxim for the samples
> > long ago and never got to add support for these. Shame on me. If you
> > work on this, I'll be happy to help with review and testing.
> > 
> Sounds good.
> 
> > > Once I get those, I'll test the driver and update it as/if needed. I don't have an ETA for
> > > that, though.
> > 
> > And all this is on the kernel side and not lm-sensors anyway. So let's
> > get your patch finished, add a few improvements on top of it, and
> > prepare for the release.
> > 
> Mostly kernel, though I wanted to amend sensors-detect if I can for the
> DSxxxx chips. But that should not hold up the new version of lm-sensors.

Indeed, sensors-detect is a moving target anyway (which is the reason
why we make it available for separate download.)

As far as amending it for the DS1621 successors, of course it depends
on how reliably these can be detected, but for now my choice would be
to drop detection of the DS1621 and have all these chips instantiated
explicitly. These chips are not found on PC mainboards, these are only
for embedded systems and overclockers/tweakers, so auto-detection isn't
a must-have.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
