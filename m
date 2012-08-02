From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 02 Aug 2012 13:57:07 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Driver for Nuvoton NCT6775F, NCT6776F, and NCT6779D
Message-Id: <20120802155707.5037a59f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1343403814-26461-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1343403814-26461-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 27 Jul 2012 08:43:34 -0700, Guenter Roeck wrote:
> This driver will replace the w83627ehf driver for NCT6775F and NCT6776F,
> and provides support for NCT6779D.

Wow, what a huge driver. 1000 lines larger than the largest hwmon
drivers we had so far.

This is actually too much for a complete review from me. For today I'll
only comment on the documentation file and driver integration. I'll
review the code itself another day, possibly in several parts.

This is already the 4th submission of this driver, and it did not
receive any review so far. This is certainly related to the size of the
driver. It would probably have helped to first submit a minimal version
of the driver, and then add more features (in particular automatic fan
speed control support) later.

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v4:
> - Fix "temp" array size (reported by smatch)
> - Fix whitespace errors reported by "git am" (but not by checkpatch).
> - Order register definition data by chip type
> - Improve parameter alignment
> 
> v3:
> - Variables pwm_temp, REG_TEMP_MON, and NCT6775_REG_TEMP_MON are not used,
>   drop it.
> 
> v2:
> - superio region access protection
> - Add support for pwmX_step_enable attribute
> - Improved documentation
> 
>  Documentation/hwmon/nct6775 |  187 +++
>  drivers/hwmon/Kconfig       |   13 +
>  drivers/hwmon/Makefile      |    1 +
>  drivers/hwmon/nct6775.c     | 3887 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 4088 insertions(+)
>  create mode 100644 Documentation/hwmon/nct6775
>  create mode 100644 drivers/hwmon/nct6775.c
> 
> diff --git a/Documentation/hwmon/nct6775 b/Documentation/hwmon/nct6775
> new file mode 100644
> index 0000000..09139a6
> --- /dev/null
> +++ b/Documentation/hwmon/nct6775
> @@ -0,0 +1,187 @@
> +Note
> +==
> +
> +This driver supercedes the NCT6775F and NCT6776F support in the W83627EHF
> +driver.

Spelling: supersedes. I'd write "w83627ehf driver" in lower-case. I'd
also move this note at the end of the following section, as it is
really only a note and not an intrinsic property.

> +
> +Kernel driver NCT6775
> +===========
Remove two "=" for alignment.

> +
> +Supported chips:
> +  * Nuvoton NCT6775F/W83667HG-I
> +    Prefix: 'nct6775'
> +    Addresses scanned: ISA address retrieved from Super I/O registers
> +    Datasheet: Available from Nuvoton upon request
> +  * Nuvoton NCT6776F
> +    Prefix: 'nct6776'
> +    Addresses scanned: ISA address retrieved from Super I/O registers
> +    Datasheet: Available from Nuvoton upon request
> +  * Nuvoton NCT6779D
> +    Prefix: 'nct6779'
> +    Addresses scanned: ISA address retrieved from Super I/O registers
> +    Datasheet: Available from Nuvoton upon request
> +
> +Authors:
> +        Guenter Roeck <linux@roeck-us.net>
> +
> +Description
> +-----------
> +
> +This driver implements support for the Nuvoton NCT6775F, NCT6776F, and NCT6779D
> +super I/O chips. We will refer to them collectively as Nuvoton chips.

You don't actually refer to them collectively anywhere in the document.

> +
> +The chips implement up to 8 temperature sensors depending on the chip type and

The comment at the beginning of the driver suggests up to 9 temperature
sensors, and the code itself appears to support up to 10.

> +configuration. Temperatures used to control fan speed are reported separately.
> +There are 4 to 5 fan rotation speed sensors, 8 to 15 analog voltage sensors,
> +one VID, alarms with beep warnings (control unimplemented), and some automatic
> +fan regulation strategies (plus manual fan control mode).
> +
> +The temperature sensor sources on all chips are configurable. temp4 and higher
> +attributes are only reported if its temperature source differs from the
> +temperature sources of the already reported temperature sensors.
> +The configured source for each of the temperature sensors is provided
> +in tempX_label.
> +
> +Temperatures are measured in degrees Celsius and measurement resolution is
> +either 1 degC or 0.5 degC, depending on the temperature source and
> +configuration. An alarm is triggered when the temperature gets higher than
> +the high limit; it stays on until the temperature falls below the hysteresis
> +value. Alarms are only supported for temp1, temp2, and temp3.

The code seems to support them on temp4, temp5 and temp6 too?

> +
> +Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
> +triggered if the rotation speed has dropped below a programmable limit. Fan
> +readings can be divided by a programmable divider (1, 2, 4, 8, 16, 32, 64 or
> +128) to give the readings more range or accuracy.

This sentence does only seem to apply to the NCT6775F.

> The driver sets the most
> +suitable fan divisor itself.

Please explain when and how it decides.

> Some fans might not be present because they
> +share pins with other functions.
> +
> +Voltage sensors (also known as IN sensors) report their values in millivolts.
> +An alarm is triggered if the voltage has crossed a programmable minimum
> +or maximum limit.
> +
> +The driver supports automatic fan control mode known as Thermal Cruise.
> +In this mode, the chip attempts to keep the measured temperature in a
> +predefined temperature range. If the temperature goes out of range, fan
> +is driven slower/faster to reach the predefined range again.
> +
> +The mode works for fan1-fan5.
> +
> +sysfs attributes
> +----------------
> +
> +name - this is a standard hwmon device entry, it contains the name of
> +       the device (see the prefix in the list of supported devices at
> +       the top of this file)

As this is a completely standard attribute and not even related to fan
speed control, I'm not sure why you list it here.

> +
> +pwm[1-5] - this file stores PWM duty cycle or DC value (fan speed) in range:
> +	   0 (stop) to 255 (full)

0 is lowest speed for the given fan. It will not necessarily stop a
4-pin fan.

> +
> +pwm[1-5]_enable - this file controls mode of fan/temperature control:
> +	* 0 Fan control disabled (fans set to maximum speed)
> +	* 1 Manual mode, write to pwm file any value 0-255 (full speed)

"write to pwm[1-5]" would be clearer. Also the "(full speed)" is a
little confusing and probably not needed, as the meaning of the
pwm[1-5] is already explained above.

> +	* 2 "Thermal Cruise" mode
> +	* 3 "Fan Speed Cruise" mode
> +	* 4 "Smart Fan III" mode (NCT6775F only)
> +	* 5 "Smart Fan IV" mode
> +
> +pwm[1-5]_mode - controls if output is PWM or DC level
> +        * 0 DC output (0 - 12v)

Capital "V", if you really want to mention a voltage value. I wouldn't,
as I doubt the chip itself can output 12 V, being powered with 3.3 V. As
a matter of fact, the DC output voltage scale tops at 3.3 V (NCT6775F
datasheet version 1.7, PDF page 95.) I presume that an amplifier is
needed between the chip's output pin and the fan supply pin in DC
output mode.

> +        * 1 PWM output
> +
> +Common fan control attributes
> +-----------------------------
> +
> +pwm[1-5]_temp_sel	Temperature source. Value is temperature sensor index.
> +			For example, select '1' for temp1_input.
> +pwm[1-5]_weight_temp_sel
> +			Secondary temperature source. Value is temperature
> +			sensor index. For example, select '1' for temp1_input.
> +pwm[1-5]_weight_enable	Set to 1 to enable secondary temperature control.
> +
> +If secondary temperature functionality is enabled, it is controlled with the
> +following attributes.
> +
> +pwm[1-5]_weight_duty_step
> +			Duty step size.
> +pwm[1-5]_weight_temp_step
> +			Temperature step size. With each step over
> +			temp_step_base, the value of weight_duty_step is added
> +			to the current pwm value.
> +pwm[1-5]_weight_temp_step_base
> +			Temperature at which secondary temperature control kicks
> +			in.
> +pwm[1-5]_weight_temp_step_tol
> +			Temperature step tolerance or hysteresis. This is a
> +			relative value.

Wow, this is incredibly complex. Took me two reads to understand what
it is for and a third to understand how I would program the settings.
The standard interface has a single file for roughly the same:
pwm[1-*]_auto_channels_temp.

Are the above settings really that useful? Do the BIOS out there
actually make use of these?

> +
> +

Your spacing between sections is inconsistent, sometimes you have a
single blank line and sometimes you have two.

> +Thermal Cruise mode (2)
> +-----------------------
> +
> +If the temperature is in the range defined by:
> +
> +pwm[1-5]_target		Target temperature, unit millidegree Celsius
> +			(range 0 - 127000)

This looks wrong. The name should reflect the fact that the target is a
temperature value. As a matter of fact we use fan[1-*]_target when the
target is a fan speed value.

> +pwm[1-5]_auto_temp1_hyst
> +			Hysteresis, unit millidegree Celsius
> +			Hysteresis value is relative to pwm[1-5]_auto_temp1.

I don't see these two attributes in the driver, instead I see
pwm[1-5]_auto_point1_temp and pwm[1-5]_auto_point1_temp_hyst.
Which I prefer because they are part of the standard interface, while
the documented ones aren't.

I am still confused by the fact that the datasheet mentions a
temperature target and a tolerance, not a high limit with an
hysteresis. While the concepts are similar, there are implementation
differences. Most notably, tolerance is reported as a relative value to
user-space, while hysteresis must always be reported as an absolute
value. Also, hysteresis typically applies on one side of a given limit,
while tolerance applies on both. Here you cleanly want to expose a
tolerance, exactly as the w83627ehf driver was doing.

> +
> +there are no changes to fan speed. Once the temperature leaves the interval,
> +fan speed increases (temp is higher) or decreases if lower than desired,
> +using the following steps and times.

The compact wording hurts readability somewhat. What about the more
verbose:

"Once the temperature leaves the interval, fan speed increases (if
temperature is higher that desired) or decreases (if temperature is
lower than desired), using the following steps and times."

"steps and time" is a strange formulation, BTW, I see time settings but
no step settings.

> +
> +pwm[1-5]_start_output	fan pwm start value (range 1 - 255), to start fan
> +			when the temperature is above defined range.
> +pwm[1-5]_stop_output	lowest fan pwm (range 1 - 255) if temperature is below
> +			the defined range.
> +pwm[1-5]_stop_output_enable
> +			Set to 1 to enable pwm[1-5]_stop_output. If disabled
> +			(set to 0), the fan will stop if the temperature is
> +			below the defined range.

I don't much like the name pwm[1-5]_stop_output, even though I know
this is the name found in several datasheets. Using the word "stop" to
say that the fan should actually keep spinning is quite confusing. What
the value really describes is a minimum PWM output. Maybe pwm[1-5]_floor
would be a better name.

Also the "output" part of the names seems redundant.

These attribute are relatively common, several hwmon drivers already
implement them. Maybe this would be the right time to come up with
standard names and add these to Documentation/hwmon/sysfs-interface?

> +pwm[1-5]_step_up_time	milliseconds [ms] before fan speed is increased
> +pwm[1-5]_step_down_time	milliseconds [ms] before fan speed is decreased
> +pwm[1-5]_stop_time	how many milliseconds [ms] must elapse to switch
> +			corresponding fan off (when the temperature was below
> +			defined range).

I don't think the [ms] are needed.

The step_up_time and step_down_time attributes don't actually seem to
affect thermal cruise mode, according to the NCT6775F datasheet. I
think it only affects Smart Fan III and/or IV.

> +
> +Speed Cruise mode (3)
> +---------------------
> +
> +This modes tries to keep the fan speed constant.
> +Untested; use at your own risk.
> +
> +Smart Fan IV mode (5)
> +---------------------
> +
> +The fan is regulated to maintain a target temperature. There are five data

This definition makes it look like thermal cruise mode, while it is
different. Smart Fan IV is based on a PWM vs. temperature response
curve (or trip points.)

> +points. Subsequent data points should be set to higher temperatures and higher
> +pwm values to achieve higher fan speeds with increasing temperature. The last
> +data point reflects critical temperature mode, in which the fans should run at
> +full speed.
> +
> +pwm[1-5]_auto_point[1-5]_pwm
> +			pwm value to be set if temperature reaches matching
> +			temperature range.

The driver actually exposes up to 7 trip points.

> +pwm[1-5]_auto_point[1-5]_temp
> +			Temperature at which the matching pwm is enabled.

I suggest "over which" instead of "at which", for clarity.

> +pwm[1-5]_step_up_time	milliseconds [ms] before fan speed is increased
> +pwm[1-5]_step_down_time	milliseconds [ms] before fan speed is decreased

Here again, [ms] is redundant.

> +pwm[1-5]_step_enable	Set to 1 to enable fine grain speed control.

The attribute name doesn't match the function. It's about
interpolation / smoothing, the attribute name should reflect that. This
attribute is also a candidate for standardization.

> +			If disabled, pwm values will increase or decrease to
> +			the values configured in the auto_point_pwm attributes.
> +			If enabled, pwm values will be interpolated, resulting

I presume temperature values are interpolated too.

> +			in a more fine-grained fan control, resulting in a more
> +			fine-grained fan control

Duplicate end of sentence.

> +
> +
> +Usage Notes
> +-----------
> +
> +On various ASUS boards with NCT6776F, it appears that CPUTIN is not really
> +connected to anything and floats, or that it is connected to some non-standard
> +temperature measurement device. As a result, the temperature reported on CPUTIN
> +will not reflect a usable value. It often reports unreasonablyy high

Spelling: unreasonably.

> +temperatures, and in some cases the reported temperature declines if the actual
> +temperature increases (similar to the raw PECI temperature value - see PECI
> +specification for details). CPUTIN should therefore be be ignored on ASUS
> +boards. The CPU temperature on ASUS boards is reported from PECI 0.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b0a2e4c..131a7a1 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -844,6 +844,19 @@ config SENSORS_MCP3021
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called mcp3021.
>  
> +config SENSORS_NCT6775
> +	tristate "Nuvoton NCT6775F, NCT6776F, NCT6779D"
> +	depends on !PPC && EXPERIMENTAL
> +	select HWMON_VID
> +	help
> +	  If you say yes here you get support for the hardware monitoring
> +	  functionality of the Nuvoton NCT6775F, NCT6776F, and NCT6779D
> +	  Super-I/O chips. It replaces the w83627ehf driver for NCT6775F
> +	  and NCT6776F.

It isn't clear what "It" refers to in the last sentence.

> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called nct6775.
> +
>  config SENSORS_NTC_THERMISTOR
>  	tristate "NTC thermistor support"
>  	depends on EXPERIMENTAL
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 7aa9811..7856141 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
>  obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
>  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
>  obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
> +obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
>  obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
>  obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
