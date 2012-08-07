From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Aug 2012 12:36:27 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Driver for Nuvoton NCT6775F, NCT6776F, and  NCT6779D
Message-Id: <20120807143627.63d3d3b3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1343403814-26461-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1343403814-26461-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fast reply as I am short on time...

On Sat, 4 Aug 2012 10:43:39 -0700, Guenter Roeck wrote:
> Yes, I know, it has been growing. I can split it into multiple pieces if you
> prefer / if you think it helps (I would also split out NCT6776 and NCT6779
> support in that case).

Smaller chunks are easier to review, but it is also easier if you don't
have to know what's coming next in order to review every patch. OTOH
the goal is not to force you to write intermediate code just to make
reviewers happy. So I presume there's a balance to be found.

> Much of your comments are straightforward, so I won't comment on those. Some of
> it was due to cut-and-paste from the w83627ehf documentation, so maybe I should
> address it there as well.

I noticed this, yes.

> > > +Thermal Cruise mode (2)
> > > +-----------------------
> > > +
> > > +If the temperature is in the range defined by:
> > > +
> > > +pwm[1-5]_target		Target temperature, unit millidegree Celsius
> > > +			(range 0 - 127000)
> > 
> > This looks wrong. The name should reflect the fact that the target is a
> > temperature value. As a matter of fact we use fan[1-*]_target when the
> > target is a fan speed value.
>
> Ah yes, and worse, the register is overloaded and means the target speed in
> speed cruise mode. I'll have to address that. What should I use ?
> 	pwm[1-5]_target_temp	for thermal cruise mode
> 	fan[1-*]_target		for speed cruise mode

The recurrent problem with naming is that it all depends on what the
chip attaches the attribute to. The same attribute can be attached to a
temperature channel, a fan input or PWM output, depending on the
hardware implementation, so the name that seems better because it is
more generic may not actually always fit.

My first choice for thermal cruise mode would be temp[1-*]_target,
however it turns out that the Nuvoton chips attach the temperature
target to PWM outputs, not temperature channels directly, so it won't
work. Your proposal makes more sense.

Unfortunately these implementation differences between chips make it
very difficult to define a standard sysfs interface for automatic fan
speed control :(

> > > +there are no changes to fan speed. Once the temperature leaves the interval,
> > > +fan speed increases (temp is higher) or decreases if lower than desired,
> > > +using the following steps and times.
> > 
> > The compact wording hurts readability somewhat. What about the more
> > verbose:
> > 
> > "Once the temperature leaves the interval, fan speed increases (if
> > temperature is higher that desired) or decreases (if temperature is
> > lower than desired), using the following steps and times."
> > 
> > "steps and time" is a strange formulation, BTW, I see time settings but
> > no step settings.
>
> Correct, there are no step settings.
> 
> How about that:
> "Once the temperature leaves the interval, fan speed increases (if temperature
> is higher that desired) or decreases (if temperature is lower than desired),
> using the following limits and time intervals."

Looks good.

> > > +
> > > +pwm[1-5]_start_output	fan pwm start value (range 1 - 255), to start fan
> > > +			when the temperature is above defined range.
> > > +pwm[1-5]_stop_output	lowest fan pwm (range 1 - 255) if temperature is below
> > > +			the defined range.
> > > +pwm[1-5]_stop_output_enable
> > > +			Set to 1 to enable pwm[1-5]_stop_output. If disabled
> > > +			(set to 0), the fan will stop if the temperature is
> > > +			below the defined range.
> > 
> > I don't much like the name pwm[1-5]_stop_output, even though I know
> > this is the name found in several datasheets. Using the word "stop" to
> > say that the fan should actually keep spinning is quite confusing. What
> > the value really describes is a minimum PWM output. Maybe pwm[1-5]_floor
> > would be a better name.
> > 
> > Also the "output" part of the names seems redundant.
>
> How about 
> pwm[1-5]_start          fan pwm start value (range 1 - 255), to start fan
>                         when the temperature is above defined range.
> pwm[1-5]_floor          lowest fan pwm (range 1 - 255) if temperature is below
> 			the defined range.
> pwm[1-5]_floor_enable	Set to 1 to enable pwm[1-5]_floor_output.

s/_output//

> 			If disabled (set to 0), the fan will stop if the temperature is
> 			below the defined range.

The problem is that I can actually think of 3 behaviors, not 2:
* If fan speed should be below floor, it is set to floor value.
* If fan speed should be below floor, it is set to 0.
* No special handling for low speed values.

One could argue that the third behavior is better described by not
implementing the pwm[1-*]_floor* attributes at all, but what about
chips which support all behaviors?

> > The step_up_time and step_down_time attributes don't actually seem to
> > affect thermal cruise mode, according to the NCT6775F datasheet. I
> > think it only affects Smart Fan III and/or IV.
>
> Table 8-7 ?

You're right, not sure how I missed that.

> 
> > > +Smart Fan IV mode (5)
> > > +---------------------
> > > +
> > > +The fan is regulated to maintain a target temperature. There are five data
> > 
> > This definition makes it look like thermal cruise mode, while it is
> > different. Smart Fan IV is based on a PWM vs. temperature response
> > curve (or trip points.)
> > 
> Is this better ?
> 
> "This mode offers multiple slopes to control the fan speed. The slopes can be
> controlled by setting the pwm and temperature attributes. When the temperature
> rises, the chip will calculate the DC/PWM output based on the current slope.
> There are up to seven data points depending on the chip type. Subsequent data
> points should be set to higher temperatures and higher pwm values to achieve
> higher fan speeds with increasing temperature. The last data point reflects
> critical temperature mode, in which the fans should run at full speed."

Sounds good, although the notion of slope only applies in interpolation
mode. Without interpolation, it's really only a set of trip points.

> > > +pwm[1-5]_step_enable	Set to 1 to enable fine grain speed control.
> > 
> > The attribute name doesn't match the function. It's about
> > interpolation / smoothing, the attribute name should reflect that. This
> > attribute is also a candidate for standardization.
>
> pwm[1-5]_interpolate ?

Agreed.

> > > +			If disabled, pwm values will increase or decrease to
> > > +			the values configured in the auto_point_pwm attributes.
> > > +			If enabled, pwm values will be interpolated, resulting
> > 
> > I presume temperature values are interpolated too.
> 
> pwm values are interpolated based on the actual temperature. For example, if two
> steps are 
> 	{ pwm = 100, temp = 50 }
> 	{ pwm = 200, temp = 60 }
> and the temperature is 55 degrees C, the pwm value will be set to 150.
> Not sure how to explain that. Any idea ?

Your explanation was actually just fine, I was probably just tired.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
