From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 15 Mar 2011 22:54:15 +0000
Subject: Re: [lm-sensors] [PATCH resend] sensors: Add support for additional
Message-Id: <20110315225415.GA23844@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110210030757.GA22858@ericsson.com>
In-Reply-To: <20110210030757.GA22858@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, Mar 15, 2011 at 05:50:46PM -0400, Jean Delvare wrote:
> On Tue, 15 Mar 2011 13:17:05 -0700, Guenter Roeck wrote:
> > On Tue, 2011-03-15 at 15:44 -0400, Jean Delvare wrote:
> > > I'd seen this, yes. "emergency" could be shorten to "emerg" (after all
> > > we already shortened "critical" to "crit".) For hysteresis, my plan is
> > > to ensure it's always on the same line as the limit it relates to, so
> > > "hyst" will always be enough.
> > > 
> > Ok, I'll make it "emerg". Or maybe "emrg" to make it fit into four
> > characters ?
> 
> "emrg" is certainly the easiest approach, yes. I just wasn't sure if it
> would be clear enough for the users.
> 
> Note that there are still "lowest" and "highest" which are longer than 4
> chars, and which we won't be able to shorten, so focusing on the
> "emergency" case may not be the best thing to do.
> 
> One thing worth noting is that neither of these 3 long strings are
> relevant for the typical PC user (which I admit is the one I mostly
> care about) so in fact I don't personally care if they break alignment,
> and it is quite possible that the affected users don't care either.
> 
Makes sense, and, yes, at least I don't care that much about alignment.
So I'll stick with "emerg".

> > > (...)
> > > You have interesting I2C bus numbers :p
> >
> > The system has more than 50 virtual (ie multiplexed) and real I2C
> > busses. There are some gaps to keep numbers aligned. I can send you the
> > complete sensors output if you like ... must be the best monitored
> > system in the world.
> 
> I'm very happy to see that apparently the i2c core is able to cope
> nicely with this amount of devices :)
> 
> > > > (...)
> > > > jc42-i2c-100-1a
> > > > Adapter: SMBus I801 adapter at 5080
> > > > temp1:        +26.2 C  (low  =  +0.0 C, high =  +0.0 C)  ALARM (MAX, CRIT)
> > > 
> > > The "MAX" in alarm is inconsistent with the "high" label... We should
> > > use LOW and HIGH for temperature alarms, not MIN and MAX.
> > > 
> > Fine with me. No backwards compatibility concerns ?
> 
> No. Limit-specific alarm flags are relatively recent, and most often
> not available on PC mainboard monitoring devices, so the impact of the
> change is low.
> 
Ok.

> > > (...)
> > > I think you're missing one space here, as an ALARM on the temp1 line
> > > would have 2 spaces before ALARM.
> > > 
> > That is because the "crit" temperature has three digits.
> 
> Ah, yes, the very point you were making; sorry for being distracted.
> 
> > > > in2:          +0.00 V                                    ALARM
> > > > fan1:             N/A
> > > > temp1:        +34.0 C  (high = +97.0 C, crit = +107.0 C)
> > > > power1:        0.00 nW  
> 
> Apparently our unit selection algorithm picks the smallest unit if
> value is 0? Wouldn't it make more sense to pick the base unit instead
> (W in this case)?
> 
I'll add
	if (abs_value = 0) {
                *prefixstr = "";
                return;
        }
to the beginning of scale_value(). Seems to be the easiest fix.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
