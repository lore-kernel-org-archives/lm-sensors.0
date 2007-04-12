From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Apr 2007 13:32:25 +0000
Subject: Re: [lm-sensors] [PATCH 2/2 RESEND] hwmon: documentation for new
Message-Id: <20070412153225.55345301@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220947s7e16453j4a5a7eb5eee77f1b@mail.gmail.com>
In-Reply-To: <191fb4ca0703220947s7e16453j4a5a7eb5eee77f1b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 22 Mar 2007 09:47:29 -0700, Juerg Haefliger wrote:
> Applied changes based on Hans de Goede's review.
> 
> ---
> This patch adds documentation for the new SMSC DME1737 driver.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>
> diff -uprN -X linux-2.6.21-rc1/Documentation/dontdiff -x drivers -x include linux-2.6.21-rc1.orig/Documentation/hwmon/dme1737 linux-2.6.21-rc1/Documentation/hwmon/dme1737
> --- linux-2.6.21-rc1.orig/Documentation/hwmon/dme1737	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.21-rc1/Documentation/hwmon/dme1737	2007-03-20 08:09:17.000000000 -0700
> @@ -0,0 +1,230 @@
> +Kernel driver dme1737
> +==========> +
> +Supported chips:
> +  * SMSC DME1737, Asus A8000
> +    Prefix: 'dme1737'
> +    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
> +    Datasheet: Provided by SMSC upon request and under NDA
> +
> +Authors:
> +    Juerg Haefliger <juergh@gmail.com>
> +
> +
> +Module Parameters
> +-----------------
> +
> +* force_start: bool	Enables the monitoring of voltage, fan and temp inputs
> +			and PWM output control functions. Using this parameter
> +			shouldn't be required since the BIOS usually takes care
> +			of this.
> +
> +Note that there is no need to use this parameter if the driver loads without
> +complaining. The driver will says so if it is necessary.

will say

> +
> +
> +Description
> +-----------
> +
> +This driver implements support for the hardware monitoring capabilities of the
> +SMSC DME1737 and Asus A8000 (which are the same) Super-I/O chips. This chip
> +features monitoring of 3 temp sensors (2 remote diodes and 1 internal),
> +7 voltages (6 external and 1 internal) and 6 fan speeds. Additionally, the
> +chip implements 5 PWM outputs for controlling fan speeds both manually and
> +automatically.
> +
> +
> +Voltage Monitoring
> +------------------
> +
> +The voltage inputs are sampled with 12-bit resolution and have internal
> +scaling resistors. The values returned by the driver therefore reflect true
> +millivolts and don't need scaling. The voltage inputs are mapped as follows
> +(the last column indicates the input ranges):
> +
> +	in0: +5VTR	(+5V standby)		0V - 6.64V
> +	in1: Vccp	(processor core)	0V - 3V
> +	in2: VCC	(internal +3.3V)	0V - 4.38V
> +	in3: +5V				0V - 6.64V
> +	in4: +12V				0V - 16V
> +	in5: VTR	(+3.3V standby)		0V - 4.38V
> +	in6: Vbat	(+3.0V)			0V - 4.38V
> +
> +Each voltage input has associated min and max limits which trigger an alarm
> +when crossed.
> +
> +
> +Temperature Monitoring
> +----------------------
> +
> +Temperatures are measured with 12-bit resolution and reported in millidegree
> +Celsius. The chip also features offsets for all 3 temperature inputs which -
> +when programmed - get added to the input readings. The chip does all the
> +scaling by itself and the driver therefore reports true temperatures that don't
> +need any user-space adjustments. The temperature inputs are mapped as follows
> +(the last column indicates the input ranges):
> +
> +	temp1: Remote diode 1 (3904 type) temperature	-127C - +127C
> +	temp2: DME1737 internal temperature		-127C - +127C
> +	temp3: Remote diode 2 (3904 type) temperature	-127C - +127C
> +
> +Each temperature input has associated min and max limits which trigger an alarm
> +when crossed. Additionally, each temperature input has a fault attribute that
> +returns 1 when a faulty diode or an unconnected input is detected and 0
> +otherwise.
> +
> +
> +Fan Monitoring
> +--------------
> +
> +Fan RPMs are measured with 16-bit resolution. The chip provides inputs for 6
> +fan tachometers. All 6 inputs have an associated min limit which triggers an
> +alarm when crossed. Fan inputs 1-4 provide type attributes that need to be set
> +to the number of edges per fan revolution that the connected tachometer
> +generates. Supported values are 2, 3, 5, and 9. Fan inputs 5-6 only support
> +fans that generate 5 edges per revolution. Fan inputs 5-6 also provide a max

I don't like this term "edges per revolution". It looks incorrect to
me. The datasheet says that "five edges" correspond to "two pulses". I
suspect that the 5th edge is needed to make sure we measured a full
rotation of the fan (between 1st edge and 5th edge), but a standard
2-pulse-per-revolution (PPR) fan certainly only generates _4_ edges per
revolution. (If not, someone really needs to explain to me where the
mysterious 5th one comes from!)

An easy test would be, change the value from 5 to 3, how does the
reported fan speed change? I suspect it will be multiplied by exactly
2, not 5/3.

The lm85 driver exports this value in PPR, and even though this isn't
in our standard, I'd rather have the dme1737 driver do the same. 3
edges would be 1 PPR, 5 edges would be 2 PPR and 9 edges would be 4
PPR. I'm puzzled by the 2 edges option - how could a fan emit 1/2 PPR?
Another mystery someone needs to explain to me.

> +attribute that needs to be set to the maximum attainable RPM (fan at 100% duty-
> +cycle) of the input. The chip adjusts the sampling rate based on this value.
> +
> +
> +PWM Output Control
> +------------------
> +
> +This chip features 5 PWM outputs. PWM outputs 1-3 are associated with fan
> +inputs 1-3 and PWM outputs 5-6 are associated with fan inputs 5-6. PWM outputs
> +1-3 can be configured to operate either in manual or automatic mode by setting
> +the appropriate enable attribute accordingly. PWM outputs 5-6 can only operate
> +in manual mode, their enable attributes are therefore read-only. When set to
> +manual mode, the fan speed is set by writing the duty-cycle value to the
> +appropriate PWM attribute. In automatic mode, the PWM attribute returns the
> +current duty-cycle as set by the fan controller in the chip. All PWM outputs
> +support the setting of the output frequency via the freq attribute.
> +
> +In automatic mode, the chip supports the setting of the PWM ramp rate which
> +defines how fast the PWM output is adjusting to changes of the associated
> +temperature input. Associating PWM outputs to temperature inputs is done via
> +the auto_channels_temp attributes. Each PWM output has 2 distinct output
> +duty-cycles: full and low. Full is internally hard-wired to 255 (100%) and low
> +can be programmed via the auto_point1_pwm attribute. The thermal thresholds are
> +programmed via auto_point[1-2]_temp, auto_point1_temp_hyst and
> +auto_point2_crit, respectively:
> +
> +	pwm[1-3]_auto_point2_pwm		full-speed duty-cycle
> +	pwm[1-3]_auto_point1_pwm		low-speed duty-cycle
> +
> +	temp[1-3]_auto_point2_temp_crit		full-speed temp (all outputs)
> +	temp[1-3]_auto_point2_temp		full-speed temp
> +	temp[1-3]_auto_point1_temp		low-speed temp
> +	temp[1-3]_auto_point1_temp_hyst		off temp
> +
> +The chip adjusts the output duty-cycle linearly in the range of auto_point1_pwm
> +to auto_point2_pwm if the temperature of the associated input is between
> +auto_point1_temp and auto_point2_temp. The fan is turned off if the temperature
> +drops below the auto_point1_temp_hyst value. If any of the temperatures rise
> +above the auto_point2_temp_crit value, all PWM outputs are set to 100% duty-
> +cycle. Following is another representation of how the chip sets the output
> +duty-cycle based on the temperature of the associated thermal input:
> +
> +			Duty-Cycle	Duty-Cycle
> +	Temperature	Rising Temp	Falling Temp
> +	-----------	-----------	------------
> +	full-speed	full-speed	full-speed
> +
> +			< linearly adjusted duty-cycle >
> +
> +	low-speed	low-speed	low-speed
> +	off temp	off		low-speed
> +			off		off
> +
> +
> +Sysfs Attributes
> +----------------
> +
> +Following is a list of all sysfs attributes that the driver provides, their
> +permissions and a short description:
> +
> +Name				Perm	Description
> +----				----	-----------
> +cpu0_vid			RO	CPU core reference voltage in
> +					millivolts.
> +vrm				RW	Voltage regulator module version
> +					number.
> +
> +in[0-6]_input			RO	Measured voltage in millivolts.
> +in[0-6]_min			RW	Low limit for voltage input.
> +in[0-6]_max			RW	High limit for voltage input.
> +in[0-6]_alarm			RO	Voltage input alarm. Returns 1 if
> +					voltage input is or went outside the
> +					associated min-max range, 0 otherwise.
> +
> +temp[1-3]_input			RO	Measured temperature in millidegree
> +					Celsius.
> +temp[1-3]_min			RW	Low limit for temp input.
> +temp[1-3]_max			RW	High limit for temp input.
> +temp[1-3]_offset		RW	Offset for temp input. This value will
> +					be added by the chip to the measured
> +					temperature.
> +temp[1-3]_alarm			RO	Alarm for temp input. Returns 1 if temp
> +					input is or went outside the associated
> +					min-max range, 0 otherwise.
> +temp[1-3]_fault			RO	Temp input fault. Returns 1 if the chip
> +					detects a faulty thermal diode or an
> +					unconnected temp input, 0 otherwise.
> +temp[1-3]_auto_point[1-2]_temp	RW	Auto PWM temp points. Auto_point1 is
> +					the low-speed temperature. Auto_point2
> +					is the full-speed temperature.
> +temp[1-3]_auto_point1_temp_hyst	RW	Auto PWM temp hyst point. This is the

You could spell hysteresis in full here, to make it clearer.

> +					temperature below which the associated
> +					PWM output is set to 0% duty-cycle.
> +temp[1-3]_auto_point2_temp_crit	RW	Auto PWM temp crit point. This is the

And critical in full as well.

> +					temperature above which ALL PWM outputs
> +					are set to 100% duty-cycle.
> +
> +fan[1-6]_input			RO	Measured fan speed in RPM. 
> +fan[1-6]_min			RW	Low limit for fan input.
> +fan[1-6]_alarm			RO	Alarm for fan input. Returns 1 if fan
> +					input is or went below the associated
> +					min value, 0 otherwise.
> +fan[1-4]_type			RW	Type of attached fan. Expressed in
> +					number of edges per revolution that the
> +					fan generates. Supported values are 2,
> +					3, 5, and 9.
> +fan[5-6]_max			RW	Max attainable RPM at 100% duty-cycle.
> +					Required for chip to adjust the
> +					sampling rate accordingly.
> +
> +pmw[1-3,5-6]			RW	Duty-cycle of PWM output. Supported
> +					values are 0-255 (0%-100%). Only
> +					writeable if the associated PWM is in
> +					manual mode.
> +pwm[1-3]_enable			RW	Enable of PWM outputs 1-3. Supported
> +					values are:
> +						-1: turned off (output @ 0%)
> +						 0: turned off (output @ 100%)
> +						 1: manual mode
> +						 2: automatic mode
> +pwm[5-6]_enable			RO	Enable of PWM outputs 5-6. Always
> +					returns 1 since these 2 outputs are
> +					hard-wired to manual mode.

Note that other drivers do not create the file in this case. It is
assumed that PWM is always manual if pwmN exists and pwmN_enable
doesn't.

> +pmw[1-3,5-6]_freq		RW	Frequency of PWM output. Supported
> +					values are in the range 11Hz-30000Hz
> +					(default is 25000Hz).
> +pmw[1-3]_ramp_rate		RW	Ramp rate of PWM output. Determines how
> +					fast the PWM duty-cycle will change
> +					when the PWM is in automatic mode.
> +					Expressed in ms per PWM step size.

s/step size/step/

> +					Supported values are in the range
> +					0ms-206ms (default is 0, which means
> +					the duty-cycle changes instantly).
> +pwm[1-3]_auto_channels_temp	RW	PWM output to temp input mapping.
> +					Supported values are:
> +						1: temp1
> +						2: temp2
> +						4: temp3
> +						6: highest of temp[2-3]
> +						7: highest of temp[1-3]

Might be good mentioning that it's a bitfield, in case the reader
doesn't notice.

> +pwm[1-3]_auto_point[1-2]_pwm	RW	Auto PWM pwm points. Auto_point1 is the
> +					low-speed duty-cycle. Auto_point2 is
> +					the full-speed duty-cycle (which is
> +					hard-wired to 255, i.e., 100% duty-
> +					cycle).
> diff -uprN -X linux-2.6.21-rc1/Documentation/dontdiff -x drivers -x include linux-2.6.21-rc1.orig/MAINTAINERS linux-2.6.21-rc1/MAINTAINERS
> --- linux-2.6.21-rc1.orig/MAINTAINERS	2007-02-20 20:32:30.000000000 -0800
> +++ linux-2.6.21-rc1/MAINTAINERS	2007-02-22 14:27:07.000000000 -0800
> @@ -1156,6 +1156,12 @@ M:	tori@unhappy.mine.nu
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  
> +DME1737 HARDWARE MONITOR DRIVER
> +P:	Juerg Haefliger
> +M:	juergh@gmail.com
> +L:	lm-sensors@lm-sensors.org
> +S:	Maintained
> +
>  DOCBOOK FOR DOCUMENTATION
>  P:	Randy Dunlap
>  M:	rdunlap@xenotime.net


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
