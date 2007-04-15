From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 15 Apr 2007 16:45:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 RESEND] hwmon: new driver for SMSC
Message-Id: <191fb4ca0704150945p783a55aby9da59d5427d78df7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220946p1f1e750i4b285111bfc23318@mail.gmail.com>
In-Reply-To: <191fb4ca0703220946p1f1e750i4b285111bfc23318@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,


> > > Do we really need a new battery reading every 30 seconds? I think I'd
> > > go for a much larger interval to not draw too much power from the
> > > battery.
> >
> > How large? 5min?
>
> Yes, 5 minutes sounds OK. You'll tell us after how long you had to
> replace the battery ;)

You'll know when I submit a patch to rip the feature out or increase
the value :-)


> > > > +     /* inform if fan-to-pwm mapping differs from the default */
> > > > +     if (reg != 0xa4) {
> > > > +             dev_err(&client->dev, "Unsupported fan to pwm mapping "
> > > > +                     "(fan1->pwm%d, fan2->pwm%d, fan3->pwm%d, "
> > > > +                     "fan4->pwm%d). Please report to the driver "
> > > > +                     "maintainer.\n",
> > > > +                     (reg & 0x03) + 1, ((reg >> 4) & 0x03) + 1,
> > > > +                     ((reg >> 8) & 0x03) + 1, ((reg >> 12) & 0x03) + 1);
> > > > +             return -EFAULT;
> > > > +     }
> > >
> > > Why would this be a problem? I don't see where your driver is assuming
> > > anything about this mapping. It might be a good thing to report the
> > > mapping in the logs in any case, for the interested users. Or maybe we
> > > need a new sysfs file for this...
> >
> > It becomes confusing. In case of a non-standard (non 1:1) mapping, one
> > might manually change pwmX and expect fanX_input to change accordingly
> > but instead fanY_input changes.
>
> Early in the 2.6 cycle, I proposed to rename the pwmN and pwmN_enable
> files to fanN_pwm and fanN_pwm_enable, respectively, assuming that the
> manufacturers would wire the fan inputs and outputs in a sensible way.
> This was a reasonable assumption, given that you need to know the duty
> cycle (and PWM base frequency) of a 3-wire fan is you want to be able
> to measure its speed reliably. Unfortunately, the reality is that board
> manufacturers sometimes wire PWM outputs and tachometer inputs in an
> unexpected way. So we can't assume anything and my change was quickly
> reverted.
>
> So this issue is really not specific to the DME1737. In fact, you are
> even lucky that this chip has a register to describe the fan
> input/output mapping. This means that we can hope that a manufacturer
> wiring the fans differently will also update the value of this register
> to reflect their design decision. And if they don't, the user can do it.
>
> I don't think this is right to prevent the driver from loading in this
> case. Just because the mapping might confuse the user (as is the case
> with every other driver), you prefer to prevent the user from using the
> driver at all? Not very friendly. This could also incite manufacturers
> to NOT change the value of this register when they should. Think about
> the following scenario: a manufacturer has wired the fans in a
> non-standard way. If they change the configuration register to reflect
> this, which is the correct thing to do, then their users won't be able
> to use your driver. But if they don't change the configuration
> register, their users will be able to use your driver. But they will
> experience problems with fan speed monitoring as soon as speed control
> is used. So you're really not pushing the manufacturers in the right
> direction.

I see your point. But the config register is not just to tell
potential users how the chip is wired, it also alters its behavior. If
the wiring is non-standard and the config register is not updated to
reflect this, automatic PWM control won't work properly.
My intention was to get feedback so see if there are boards out there
that implement non-standard wiring and then add proper support if the
customer base is large enough (whatever that means). If the driver
just loads and prints a warning we'll probably never hear about it
unless the user starts playing around with automatic fan control and
notices funny behavior. In that case we'll probably see a bug report.


> > > > +       If you say yes here you get support for the hardware monitoring
> > > > +       and fan control features of the SMSC DME1737 and ASUS A8000
> > > > +       Super-I/O chips.
> > >
> > > As far as I know, the SMSC SCH5027D is compatible as well. At least it
> > > is listed as such on our Devices wiki page.
> >
> > I wouldn't know. Shall I add it blindly?
>
> We didn't add it in sensors-detect yet. See:
> http://www.lm-sensors.org/ticket/2197
> Given that it has the same IDs as the DME1737, I can only assume it
> will be fully compliant. But I don't really know either.
>
> So you can leave the text as is, or add SMSC SCH5027D, or add "and
> other compatible SMSC chips". We can always adjust this later as we
> learn more, anyway.

OK. I'll go with the "compatible chips" option.


> > It'll take me a while to come up with a new patch. I disassembled the
> > box for noise reduction.
>
> OK. It'll probably be too late for 2.6.22 then, but could go into -mm
> early in the 2.6.23 development cycle.

What's the deadline for 2.6.22?

...juerg


> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
