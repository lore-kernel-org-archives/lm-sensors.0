From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 30 Aug 2006 16:45:22 +0000
Subject: [lm-sensors] [PATCH 2/2 RESEND 3] hwmon: add vt1211
Message-Id: <20060830184522.0280c0ab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This patch adds documentation for the new vt1211 Super-IO driver.

> +Temperature Monitoring
> +----------------------
> +
> +Temperatures are reported in millidegree Celsius. Each measured temperature
> +has a high limit which triggers an alarm if crossed. There is an associated
> +hysteresis value with each temperature below which the temperature has to drop
> +before the alarm is cleared.

This is actually only true in interrupt mode "0", right?

> +
> +All temperature channels except temp2 are external. Temp2 is the VT1211
> +internal thermal diode and the driver does all the scaling for temp2 and
> +returns the temperature in millidegree Celcius. For the external channels

Celsius

> +temp1 and temp4-temp7, scaling depends on the board implementation and needs

temp3?

> +to be performed in userspace via sensors.conf.
> +
> +Temp1 is an Intel-type thermal diode which requires the following formula to
> +convert between sysfs readings and real temperatures:
> +
> +compute temp1 (@-Offset)/Gain, (@*Gain)+Offset
> +
> +According to the VIA VT1211 BIOS porting guide, the following gain and offset
> +values should be used:
> +
> +Diode Type      Offset   Gain
> +----------      ------   ----
> +Intel CPU       88.638   0.9528
> +                65.000   0.9686   *)
> +VIA C3 Ezra     83.869   0.9528
> +VIA C3 Ezra-T   73.869   0.9528
> +
> +*) This is the formula from the current (2.10.0) sensors.conf file. I don't
> +know where it comes from or how it was derived, it's just listed here for
> +completeness.
> +
> +Temp3-temp7 support NTC thermistors. For these channels, the driver returns the
> +voltages as seen at the individual pins of UCH1-UCH5. The voltage at the pin
> +(Vpin) is formed by a voltage divider made of the thermistor (Rth) and a
> +scaling resistor (Rs):
> +
> +Vpin = 2200 * Rth / (Rs + Rth)   (2200 is the ADC max limit of 2200 mV)
> +
> +The equation for the thermistor is as follows (google it if you want to know
> +more about it):
> +
> +Rth = Ro * exp(B * (1 / T - 1 / To))
> +
> +Mingling the above two equations and assuming Rs = Ro and B = 3435 yields the

and assuming To = 25 degrees C

In other words, assuming Rth = Rs at 25 degrees C...

> +following formula for sensors.conf:
> +
> +compute tempx 1 / (1 / 298.15 - (` (2200 / @ - 1)) / 3435) - 273.15,
> +              2200 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
> +
> +
> +Fan Speed Control
> +-----------------
> +
> +The VT1211 provides 2 programmable PWM outputs to control the speeds of 2 fans.
> +Writing a 2 to any of the two pwm[1-2]_enable sysfs nodes will put the PWM
> +controller in automatic mode. There is only a single controller that controls
> +both PWM outputs but each PWM output can be individually enabled and disabled.
> +
> +Each PWM has 4 associated distinct output duty-cycles: full, high, low and
> +off. Full and off are internally hard-wired to 255 (100%) and 0 (0%),
> +respectively. High and low can be programmed via
> +pwm[1-2]_auto_point[2-3]_pwm. Each PWM output can be associated with a
> +different thermal input but - and here's the weird part - only one set of
> +thermal thresholds exist that controls both PWMs output duty-cycles. The
> +thermal thresholds are accessible via pwm[1-2]_auto_point[1-4]_temp. Note
> +that even though there are 2 sets of 4 auto points each, they map to the same
> +registers in the VT1211 and programming one set is sufficient (actually only 
> +the first set pwm1_auto_point[1-4]_temp is writable, the second set is
> +read-only).
> +
> +PWM Auto Point             PWM Output Duty-Cycle
> +------------------------------------------------
> +pwm[1-2]_auto_point4_pwm   full speed duty-cyle (hard-wired to 255)

cycle

> +pwm[1-2]_auto_point3_pwm   high speed duty-cycle
> +pwm[1-2]_auto_point2_pwm   low speed duty-cycle
> +pwm[1-2]_auto_point1_pwm   off duty-cycle (hard-wired to 0)
> +
> +Temp Auto Point             Thermal Threshold
> +---------------------------------------------
> +pwm[1-2]_auto_point4_temp   full speed temp
> +pwm[1-2]_auto_point3_temp   high speed temp
> +pwm[1-2]_auto_point2_temp   low speed temp
> +pwm[1-2]_auto_point1_temp   off temp
> +
> +Long story short, the controller implements the following algorithm to set the
> +PWM output duty-cycle based on the input temperature:
> +
> +Thermal Threshold             Output Duty-Cycle
> +                    (Rising Temp)           (Falling Temp)
> +----------------------------------------------------------
> +                    full speed duty-cycle   full speed duty-cycle
> +full speed temp
> +                    high speed duty-cycle   full speed duty-cycle
> +high speed temp
> +                    low speed duty-cycle    high speed duty-cycle
> +low speed temp
> +                    off duty-cycle          low speed duty-cycle
> +off temp
> +                    off duty-cycle          off duty-cycle
> diff -uprN -X linux-2.6.18-rc4-mm-vanilla/Documentation/dontdiff -x drivers -x MAINTAINERS -x usr -x dwarf2-defs.h linux-2.6.18-rc4-mm-vanilla/include/linux/utsrelease.h linux-2.6.18-rc4-mm/include/linux/utsrelease.h
> --- linux-2.6.18-rc4-mm-vanilla/include/linux/utsrelease.h	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.18-rc4-mm/include/linux/utsrelease.h	2006-08-16 21:04:49.000000000 -0700
> @@ -0,0 +1 @@
> +#define UTS_RELEASE "2.6.18-rc4-mm1"

This shouldn't have been in this patch either ;)

Thanks,
-- 
Jean Delvare

