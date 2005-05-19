From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: adm1026 driver port for kernel 2.6.X
Message-Id: <20041025175150.GA17745@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041018210758.GB14960@penguincomputing.com>
In-Reply-To: <20041018210758.GB14960@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 21, 2004 at 11:29:59PM +0200, Jean Delvare wrote:

Thanks again for the input!

<snip>

> > In the board I have access to(Arima HDAMA), the DAC is only used as
> > one of two possible means to drive the speed-controlled fans. 
> > Essentially it doesn't look any different to the end user than the PWM
> > output.  I've chosen to expose it as the set of sysfs files:
> > 
> > pwm2
> > pwm2_enable
> > pwm2_auto_pwm_min
> > 
> > And allow the user to choose which "pwm" drives the fans, as only one
> > is allowed control at a time.  In line with this decision, I intend to
> > keep the visible value for the DAC (pwm2) on the same scale as pwm1
> > (0-255).
> 
> That's an interesting approach, although different from what I did for
> the lm87 driver.
> 
> One possible issue is that we support monitoring chips, not
> motherboards. What if the DAC is used for something different on another
> motherboard? This probably has yet to be seen though.

True.  If an example is found where the DAC is used for something other
than driving fans, then this would need to be changed.  The consequences
of providing a "fan" interface to something completely different might be
a bit ugly.

> I have no strong objection to "faking" the DAC as a PWM output if it
> makes everybody happy. This will have to be clearly documented in the
> source code and/or the extra doc files though.

I have to confess to wondering if there is any real reason to include support
for driving the fans via both the PWM and DAC.  I did so because support was 
already implemented in the 2.4.X kernel driver, and I decided to "fake" the
DAC as a PWM output because I could not see any significant difference between
the 2 interfaces.  The driving equations are a bit different:


PWM_min = 6.67 * PWM_min_bit_value, PWM_min_bit_value in {0-15}

                                  T_actual - T_min
PWM = PWM_min + (100 - PWM_min) * ----------------
                                         20

vs.

DAC_min = 16 * DAC_min_bit_value, DAC_min_bit_value in {0-15}

                                  T_actual - T_min
DAC = DAC_min + (240 - DAC_min) * ----------------
                                         20

And you can see that the DAC output increases linearly up to 240 rather than
its full scale of 255.  Per the spec, however, once the temperature increases
past tempN_auto_point1_temp, DAC jumps to its maximum value (255 => 2.5 volts).

Also note that the automatic PWM equation produces output in the range {0-100},
corresponding to % of the PWM duty cycle.

Aside from the possibility that some fans might behave in a more desireable
manner when driven by the DAC instead of the PWM output, I see no real reason to
provide both sets of interfaces to the user.

Unfortunately then, I'm not sure that there is ANY reason to include support
for the DAC in the driver.  If all the DAC is used for on known boards is to 
essentially duplicate the function of the PWM, then what does providing
a driver interface for it gain the end-user, aside from probable confusion
over which fan-control mechanism to use?  Sure, I could leave in the 
"analog_out" device files and remove the ability to enable the DAC as the
driving output for fan control, but then we have what is a basicly useless
device file littering the sysfs interface.

> BTW, how are pwm1 and pwm2 (aka DAC) linked? if pwm1 and pwm2 correspond
> to the same output, shouldn't they be a single pwm file?

You can have one or the other, but not both.  And since all PWM/DAC-controlled 
fans are driven by no more than one output at a time, providing access to
both seems even less useful.

But I see your point.  If we keep the DAC output as well as the PWM output
in the interface, there really is no reason to provide separate pwm1_* and
pwm2_* entries, since only one can operate at a time.  Then we would need to 
replace

pwm[1-2]_enable, {0,1,2}

with a single file such as:

pwm_enable, {0,1,2,3,4}

where:

0 -> no fan control, fans set @ full speed
1 -> manual PWM fan control
2 -> manual DAC fan control
3 -> automatic PWM fan control
4 -> automatic DAC fan control

> > (2) pwmN_auto_pwm_min values initialize at their maximum value of 15.
> 
> Should be scaled so that this max value matches the max pwm value
> (around 250).

Ugh.  Is this really a good idea?  Is scaling pwnN_auto_pwm_min so that it
matches pwmN worth:

(A)  Obscuring the actual granularity of pwmN_auto_pwm_min
(B)  Introducing "best fit" functions/macros to scale {0-255} => {0-15}.

Especially since the PWM := PWM(PWM_min) equation actually just generates
values in the {0-100} range.  Which granularity level should we respect?
{0-255}? {0-100}? {0-15}?

Is pwmN_auto_pwm_min using a different scale than pwmN any more confusing
when compared to the effect that the "invisible" granularity a 
pwmN_auto_pwm_min scaled {0-255} or {0-100} will have?

Moreover, if we are to keep the DAC as a 2nd "PWM" output, then shouldn't its
pwmN_auto_pwm_min scale {0-240}, rather than {0-255}?

> > I just decided that a pwm structure would help keep things tidy
> > variable- wise and enforce the association of pwmN with pwmN_enable
> > and pwmN_auto_pwm_min, making the code more easily parseable for other
> > people besides myself.
> > 
> > Is there any reason *not* to do this?
> 
> No, I was simply curious.

I may be lazy, but I like things tidy.  ;)

> > > >	device_create_file(&new_client->dev, &dev_attr_temp1_therm);
> > > >	device_create_file(&new_client->dev, &dev_attr_temp2_therm);
> > > >	device_create_file(&new_client->dev, &dev_attr_temp3_therm);

<snip>

> Agreed that it doesn't fit well in the auto-pwm logic.
> 
> I think I would simply call these entries temp[123]_crit. It's common
> that chips do take actions when critical limits are crossed.

Will do.  Thanks for the suggestion.

Justin Thiessen
---------------
jthiessen@penguincomputing.com

