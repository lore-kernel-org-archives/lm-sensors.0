From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Aug 2012 17:43:39 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Driver for Nuvoton NCT6775F, NCT6776F, and NCT6779D
Message-Id: <20120804174339.GA26203@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1343403814-26461-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1343403814-26461-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 02, 2012 at 03:57:07PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 27 Jul 2012 08:43:34 -0700, Guenter Roeck wrote:
> > This driver will replace the w83627ehf driver for NCT6775F and NCT6776F,
> > and provides support for NCT6779D.
> 
> Wow, what a huge driver. 1000 lines larger than the largest hwmon
> drivers we had so far.
> 
> This is actually too much for a complete review from me. For today I'll
> only comment on the documentation file and driver integration. I'll
> review the code itself another day, possibly in several parts.
> 
> This is already the 4th submission of this driver, and it did not
> receive any review so far. This is certainly related to the size of the
> driver. It would probably have helped to first submit a minimal version
> of the driver, and then add more features (in particular automatic fan
> speed control support) later.
> 

Hi Jean,

thanks a lot for the review and your time.

Yes, I know, it has been growing. I can split it into multiple pieces if you
prefer / if you think it helps (I would also split out NCT6776 and NCT6779
support in that case).

Much of your comments are straightforward, so I won't comment on those. Some of
it was due to cut-and-paste from the w83627ehf documentation, so maybe I should
address it there as well.

> 
> > +
> > +The chips implement up to 8 temperature sensors depending on the chip type and
> 
> The comment at the beginning of the driver suggests up to 9 temperature
> sensors, and the code itself appears to support up to 10.
> 
Yes, that is a bit tricky with those chips, since they have so many registers
and temperature sources. I'll go through the specifications and make sure the
numbers are at least consistent.

> > +Common fan control attributes
> > +-----------------------------
> > +
> > +pwm[1-5]_temp_sel	Temperature source. Value is temperature sensor index.
> > +			For example, select '1' for temp1_input.
> > +pwm[1-5]_weight_temp_sel
> > +			Secondary temperature source. Value is temperature
> > +			sensor index. For example, select '1' for temp1_input.
> > +pwm[1-5]_weight_enable	Set to 1 to enable secondary temperature control.
> > +
> > +If secondary temperature functionality is enabled, it is controlled with the
> > +following attributes.
> > +
> > +pwm[1-5]_weight_duty_step
> > +			Duty step size.
> > +pwm[1-5]_weight_temp_step
> > +			Temperature step size. With each step over
> > +			temp_step_base, the value of weight_duty_step is added
> > +			to the current pwm value.
> > +pwm[1-5]_weight_temp_step_base
> > +			Temperature at which secondary temperature control kicks
> > +			in.
> > +pwm[1-5]_weight_temp_step_tol
> > +			Temperature step tolerance or hysteresis. This is a
> > +			relative value.
> 
> Wow, this is incredibly complex. Took me two reads to understand what
> it is for and a third to understand how I would program the settings.
> The standard interface has a single file for roughly the same:
> pwm[1-*]_auto_channels_temp.
> 
Problem with pwm[1-*]_auto_channels_temp is that it is a non-weighted bit mask.
I could use it for pwm[1-5]_temp_sel.

> Are the above settings really that useful? Do the BIOS out there
> actually make use of these?
> 
Yes, my Intel board configures and enables the weight settings.

/sys/class/hwmon/hwmon1/device/pwm1_weight_duty_step:36
/sys/class/hwmon/hwmon1/device/pwm1_weight_enable:1
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_sel:1
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step:2000
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step_base:70000
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step_tol:1000

This is why I added it in.

> > +Thermal Cruise mode (2)
> > +-----------------------
> > +
> > +If the temperature is in the range defined by:
> > +
> > +pwm[1-5]_target		Target temperature, unit millidegree Celsius
> > +			(range 0 - 127000)
> 
> This looks wrong. The name should reflect the fact that the target is a
> temperature value. As a matter of fact we use fan[1-*]_target when the
> target is a fan speed value.
> 
Ah yes, and worse, the register is overloaded and means the target speed in
speed cruise mode. I'll have to address that. What should I use ?
	pwm[1-5]_target_temp	for thermal cruise mode
	fan[1-*]_target		for speed cruise mode

> > +pwm[1-5]_auto_temp1_hyst
> > +			Hysteresis, unit millidegree Celsius
> > +			Hysteresis value is relative to pwm[1-5]_auto_temp1.
> 
> I don't see these two attributes in the driver, instead I see
> pwm[1-5]_auto_point1_temp and pwm[1-5]_auto_point1_temp_hyst.
> Which I prefer because they are part of the standard interface, while
> the documented ones aren't.
> 
I changed that in the code to follow the ABI and forgot to update Documentation.

> I am still confused by the fact that the datasheet mentions a
> temperature target and a tolerance, not a high limit with an
> hysteresis. While the concepts are similar, there are implementation
> differences. Most notably, tolerance is reported as a relative value to
> user-space, while hysteresis must always be reported as an absolute
> value. Also, hysteresis typically applies on one side of a given limit,
> while tolerance applies on both. Here you cleanly want to expose a
> tolerance, exactly as the w83627ehf driver was doing.
> 
I went back and forth about that. Yes, tolerance is much better. I started to
use hyst only because that is the standard attribute. I'll go back to tolerance;
that makes the code simpler anyway.

> > +
> > +there are no changes to fan speed. Once the temperature leaves the interval,
> > +fan speed increases (temp is higher) or decreases if lower than desired,
> > +using the following steps and times.
> 
> The compact wording hurts readability somewhat. What about the more
> verbose:
> 
> "Once the temperature leaves the interval, fan speed increases (if
> temperature is higher that desired) or decreases (if temperature is
> lower than desired), using the following steps and times."
> 
> "steps and time" is a strange formulation, BTW, I see time settings but
> no step settings.
> 
Correct, there are no step settings.

How about that:
"Once the temperature leaves the interval, fan speed increases (if temperature
is higher that desired) or decreases (if temperature is lower than desired),
using the following limits and time intervals."

> > +
> > +pwm[1-5]_start_output	fan pwm start value (range 1 - 255), to start fan
> > +			when the temperature is above defined range.
> > +pwm[1-5]_stop_output	lowest fan pwm (range 1 - 255) if temperature is below
> > +			the defined range.
> > +pwm[1-5]_stop_output_enable
> > +			Set to 1 to enable pwm[1-5]_stop_output. If disabled
> > +			(set to 0), the fan will stop if the temperature is
> > +			below the defined range.
> 
> I don't much like the name pwm[1-5]_stop_output, even though I know
> this is the name found in several datasheets. Using the word "stop" to
> say that the fan should actually keep spinning is quite confusing. What
> the value really describes is a minimum PWM output. Maybe pwm[1-5]_floor
> would be a better name.
> 
> Also the "output" part of the names seems redundant.
> 
How about 
pwm[1-5]_start          fan pwm start value (range 1 - 255), to start fan
                        when the temperature is above defined range.
pwm[1-5]_floor          lowest fan pwm (range 1 - 255) if temperature is below
			the defined range.
pwm[1-5]_floor_enable	Set to 1 to enable pwm[1-5]_floor_output.
			If disabled (set to 0), the fan will stop if the temperature is
			below the defined range.

> These attribute are relatively common, several hwmon drivers already
> implement them. Maybe this would be the right time to come up with
> standard names and add these to Documentation/hwmon/sysfs-interface?
> 
Sure.

> > +pwm[1-5]_step_up_time	milliseconds [ms] before fan speed is increased
> > +pwm[1-5]_step_down_time	milliseconds [ms] before fan speed is decreased
> > +pwm[1-5]_stop_time	how many milliseconds [ms] must elapse to switch
> > +			corresponding fan off (when the temperature was below
> > +			defined range).
> 
> I don't think the [ms] are needed.
> 
> The step_up_time and step_down_time attributes don't actually seem to
> affect thermal cruise mode, according to the NCT6775F datasheet. I
> think it only affects Smart Fan III and/or IV.
> 
Table 8-7 ?

> > +Smart Fan IV mode (5)
> > +---------------------
> > +
> > +The fan is regulated to maintain a target temperature. There are five data
> 
> This definition makes it look like thermal cruise mode, while it is
> different. Smart Fan IV is based on a PWM vs. temperature response
> curve (or trip points.)
> 
Is this better ?

"This mode offers multiple slopes to control the fan speed. The slopes can be
controlled by setting the pwm and temperature attributes. When the temperature
rises, the chip will calculate the DC/PWM output based on the current slope.
There are up to seven data points depending on the chip type. Subsequent data
points should be set to higher temperatures and higher pwm values to achieve
higher fan speeds with increasing temperature. The last data point reflects
critical temperature mode, in which the fans should run at full speed."

> 
> > +pwm[1-5]_step_enable	Set to 1 to enable fine grain speed control.
> 
> The attribute name doesn't match the function. It's about
> interpolation / smoothing, the attribute name should reflect that. This
> attribute is also a candidate for standardization.
> 
pwm[1-5]_interpolate ?

> > +			If disabled, pwm values will increase or decrease to
> > +			the values configured in the auto_point_pwm attributes.
> > +			If enabled, pwm values will be interpolated, resulting
> 
> I presume temperature values are interpolated too.

pwm values are interpolated based on the actual temperature. For example, if two
steps are 
	{ pwm = 100, temp = 50 }
	{ pwm = 200, temp = 60 }
and the temperature is 55 degrees C, the pwm value will be set to 150.
Not sure how to explain that. Any idea ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
