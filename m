From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Apr 2007 09:28:37 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 RESEND] hwmon: new driver for SMSC
Message-Id: <20070417112837.56a40cc9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220946p1f1e750i4b285111bfc23318@mail.gmail.com>
In-Reply-To: <191fb4ca0703220946p1f1e750i4b285111bfc23318@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Sun, 15 Apr 2007 09:45:56 -0700, Juerg Haefliger wrote:
> > > > > +     /* inform if fan-to-pwm mapping differs from the default */
> > > > > +     if (reg != 0xa4) {
> > > > > +             dev_err(&client->dev, "Unsupported fan to pwm mapping "
> > > > > +                     "(fan1->pwm%d, fan2->pwm%d, fan3->pwm%d, "
> > > > > +                     "fan4->pwm%d). Please report to the driver "
> > > > > +                     "maintainer.\n",
> > > > > +                     (reg & 0x03) + 1, ((reg >> 4) & 0x03) + 1,
> > > > > +                     ((reg >> 8) & 0x03) + 1, ((reg >> 12) & 0x03) + 1);
> > > > > +             return -EFAULT;
> > > > > +     }
> > > >
> > > > Why would this be a problem? I don't see where your driver is assuming
> > > > anything about this mapping. It might be a good thing to report the
> > > > mapping in the logs in any case, for the interested users. Or maybe we
> > > > need a new sysfs file for this...
> > >
> > > It becomes confusing. In case of a non-standard (non 1:1) mapping, one
> > > might manually change pwmX and expect fanX_input to change accordingly
> > > but instead fanY_input changes.
> >
> > Early in the 2.6 cycle, I proposed to rename the pwmN and pwmN_enable
> > files to fanN_pwm and fanN_pwm_enable, respectively, assuming that the
> > manufacturers would wire the fan inputs and outputs in a sensible way.
> > This was a reasonable assumption, given that you need to know the duty
> > cycle (and PWM base frequency) of a 3-wire fan is you want to be able
> > to measure its speed reliably. Unfortunately, the reality is that board
> > manufacturers sometimes wire PWM outputs and tachometer inputs in an
> > unexpected way. So we can't assume anything and my change was quickly
> > reverted.
> >
> > So this issue is really not specific to the DME1737. In fact, you are
> > even lucky that this chip has a register to describe the fan
> > input/output mapping. This means that we can hope that a manufacturer
> > wiring the fans differently will also update the value of this register
> > to reflect their design decision. And if they don't, the user can do it.
> >
> > I don't think this is right to prevent the driver from loading in this
> > case. Just because the mapping might confuse the user (as is the case
> > with every other driver), you prefer to prevent the user from using the
> > driver at all? Not very friendly. This could also incite manufacturers
> > to NOT change the value of this register when they should. Think about
> > the following scenario: a manufacturer has wired the fans in a
> > non-standard way. If they change the configuration register to reflect
> > this, which is the correct thing to do, then their users won't be able
> > to use your driver. But if they don't change the configuration
> > register, their users will be able to use your driver. But they will
> > experience problems with fan speed monitoring as soon as speed control
> > is used. So you're really not pushing the manufacturers in the right
> > direction.
> 
> I see your point. But the config register is not just to tell
> potential users how the chip is wired, it also alters its behavior. If
> the wiring is non-standard and the config register is not updated to
> reflect this, automatic PWM control won't work properly.

Correct.

> My intention was to get feedback so see if there are boards out there
> that implement non-standard wiring and then add proper support if the
> customer base is large enough (whatever that means).

What kind of support would you need to add? I don't see how the driver
cares, only user-space tools do, or am I missing something?

> If the driver
> just loads and prints a warning we'll probably never hear about it
> unless the user starts playing around with automatic fan control and
> notices funny behavior. In that case we'll probably see a bug report.

I fail to see how the current driver behavior helps. I see 3 different
configurations:

1* Standard wiring, configuration register untouched.
The driver loads and works fines (hopefully ;))

2* Non-standard wiring, configuration register untouched.
The driver loads, and presumably won't work fine. This is a BIOS bug,
not much we can do.

3* Non-standard wiring, configuration register adjusted by the BIOS.
The driver refuses to load, while I believe it would work fine.

Ideally we would let configurations 1 and 3 load the driver, but
unfortunately we can't differentiate between 1 and 2, which is why I
believe we should not prevent the driver from loading at all. Unless,
of course, case 3 would need additional care from the driver - I can't
see what, but you tell me.


> > > It'll take me a while to come up with a new patch. I disassembled the
> > > box for noise reduction.
> >
> > OK. It'll probably be too late for 2.6.22 then, but could go into -mm
> > early in the 2.6.23 development cycle.
> 
> What's the deadline for 2.6.22?

The moment Linus releases 2.6.21. You never can tell for sure, but it
will probably be around April 23rd.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
