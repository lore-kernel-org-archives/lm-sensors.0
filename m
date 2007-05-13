From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 13 May 2007 08:45:59 +0000
Subject: Re: [lm-sensors] [PATCH 2/2 RESEND] hwmon: documentation for new
Message-Id: <20070513104559.492dfd37@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220947s7e16453j4a5a7eb5eee77f1b@mail.gmail.com>
In-Reply-To: <191fb4ca0703220947s7e16453j4a5a7eb5eee77f1b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Mon, 7 May 2007 14:26:28 -0700, Juerg Haefliger wrote:
> This patch adds documentation for the new SMSC DME1737 driver.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

> diff -uprN -X linux-2.6.21-mm1/Documentation/dontdiff -x drivers -x include linux-2.6.21-mm1.orig/Documentation/hwmon/dme1737 linux-2.6.21-mm1/Documentation/hwmon/dme1737
> --- linux-2.6.21-mm1.orig/Documentation/hwmon/dme1737	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.21-mm1/Documentation/hwmon/dme1737	2007-05-07 12:21:14.000000000 -0700
> @@ -0,0 +1,250 @@
> +Kernel driver dme1737
> +==========> +
> +Supported chips:
> +  * SMSC DME1737 and compatibles, Asus A8000

Confusing (as mentioned in the other part of the review already.)

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
> +complaining. The driver will say so if it is necessary.
> +
> +
> +Description
> +-----------
> +
> +This driver implements support for the hardware monitoring capabilities of the
> +SMSC DME1737 and Asus A8000 (which are the same) Super-I/O chips. This chip
> +features monitoring of 3 temp sensors temp[1-3] (2 remote diodes and 1
> +internal), 7 voltages in[0-6] (6 external and 1 internal) and 6 fan speeds
> +fan[1-6]. Additionally, the chip implements 5 PWM outputs pwm[1-3,5-6] for
> +controlling fan speeds both manually and automatically.
> +
> +Fan[3-6] and pwm[3,5-6] are optional features and their availability is
> +dependent on the configuration of the chip. The driver will detect which
> +features are present during initialization and create the sysfs attributes
> +accordingly.
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
> +to the number of pulses per fan revolution that the connected tachometer
> +generates. Supported values are 1, 2, and 3. Fan inputs 5-6 only support fans

1, 2 or 4

> +that generate 2 pulses per revolution. Fan inputs 5-6 also provide a max
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
> +temperature zones. The chip features 3 zones whose assignments to temperature
> +inputs is static and determined during initialization. These assignments can
> +be retrieved via the zone[1-3]_auto_channels_temp attributes. Each PWM output
> +is assigned to one (or hottest of multiple) temperature zone(s) through the 
> +pwm[1-3]_auto_channels_temp attributes. Each PWM output has 3 distinct output

I think this is named pwm[1-3]_auto_channels_zone in the latest version
of the driver?

> +duty-cycles: full, low, and off. Full is internally hard-wired to 255 (100%)
> +and low and off can be programmed via the pwm[1-3]_auto_point[1-2]_pwm

Inconsistent with the list below which includes
pwm[1-3]_auto_point3_pwm.

> +attributes. The thermal thresholds of the zones are programmed via
> +zone[1-3]_auto_point[1-4]_temp:
> +
> +	pwm[1-3]_auto_point3_pwm	full-speed duty-cycle (255, i.e., 100%)
> +	pwm[1-3]_auto_point2_pwm	low-speed duty-cycle
> +	pwm[1-3]_auto_point1_pwm	off duty-cycle
> +
> +	zone[1-3]_auto_point4_temp	full-speed temp (all outputs)
> +	zone[1-3]_auto_point3_temp	full-speed temp
> +	zone[1-3]_auto_point2_temp	low-speed temp
> +	zone[1-3]_auto_point1_temp	off temp
> +
> +The chip adjusts the output duty-cycle linearly in the range of auto_point2_pwm
> +to auto_point3_pwm if the temperature of the associated zone is between
> +auto_point2_temp and auto_point3_temp. If the temperature drops below the
> +auto_point1_temp value, the output duty-cycle is set to the auto_point1_pwm
> +value which only supports two values: 0 or auto_point2_pwm. That means that the
> +fan either turns completely off or keeps spinning with the low-speed
> +duty-cycle. If any of the temperatures rise above the auto_point4_temp value,
> +all PWM outputs are set to 100% duty-cycle.
> +
> +Following is another representation of how the chip sets the output duty-cycle
> +based on the temperature of the associated thermal zone:
> +
> +			Duty-Cycle	Duty-Cycle
> +	Temperature	Rising Temp	Falling Temp
> +	-----------	-----------	------------
> +	full-speed	full-speed	full-speed
> +
> +			< linearly adjusted duty-cycle >
> +
> +	low-speed	low-speed	low-speed
> +			off		low-speed
> +	off temp	off		off
> +			off		off

This is only true if pwm[1-3]_auto_point1_pwm is set to 0, right?

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
> +
> +zone[1-3]_auto_channels_temp	RO	Temperature zone to temperature input
> +					mapping. This attribute is a bitfield
> +					and supports the following values:
> +						1: temp1
> +						2: temp2
> +						4: temp3
> +zone[1-3]_auto_point[1-4]_temp	RW	Auto PWM temp points. Auto_point1 is
> +					the off temp, auto_point2 is the low-
> +					speed temp, auto_point3 is the full-
> +					speed temp and auto_point4 is the temp
> +					at which all PWM outputs are set to
> +					full-speed (100% duty-cycle).
> +
> +fan[1-6]_input			RO	Measured fan speed in RPM. 
> +fan[1-6]_min			RW	Low limit for fan input.
> +fan[1-6]_alarm			RO	Alarm for fan input. Returns 1 if fan
> +					input is or went below the associated
> +					min value, 0 otherwise.
> +fan[1-4]_type			RW	Type of attached fan. Expressed in
> +					number of pulses per revolution that
> +					the fan generates. Supported values are
> +					1, 2, and 3.
> +fan[5-6]_max			RW	Max attainable RPM at 100% duty-cycle.
> +					Required for chip to adjust the
> +					sampling rate accordingly.
> +
> +pmw[1-3,5-6]			RO/RW	Duty-cycle of PWM output. Supported
> +					values are 0-255 (0%-100%). Only
> +					writeable if the associated PWM is in
> +					manual mode.
> +pwm[1-3]_enable			RW	Enable of PWM outputs 1-3. Supported
> +					values are:
> +						 0: turned off (output @ 100%)
> +						 1: manual mode
> +						 2: automatic mode
> +pwm[5-6]_enable			RO	Enable of PWM outputs 5-6. Always
> +					returns 1 since these 2 outputs are
> +					hard-wired to manual mode.
> +pmw[1-3,5-6]_freq		RW	Frequency of PWM output. Supported
> +					values are in the range 11Hz-30000Hz
> +					(default is 25000Hz).
> +pmw[1-3]_ramp_rate		RW	Ramp rate of PWM output. Determines how
> +					fast the PWM duty-cycle will change
> +					when the PWM is in automatic mode.
> +					Expressed in ms per PWM step. Supported
> +					values are in the range 0ms-206ms
> +					(default is 0, which means the duty-
> +					cycle changes instantly).
> +pwm[1-3]_auto_channels_zone	RW	PWM output to temperature zone mapping.
> +					This attribute is a bitfield and
> +					supports the following values:
> +						1: zone1
> +						2: zone2
> +						4: zone3
> +						6: highest of zone[2-3]
> +						7: highest of zone[1-3]
> +pwm[1-3]_auto_point[1-2]_pwm	RW	Auto PWM pwm points. Auto_point1 is the
> +					off duty-cycle and auto_point2 is the
> +					low-speed duty-cycle.
> +pwm[1-3]_auto_point3_pwm	RO	Auto PWM pwm point. Auto_point3 is the
> +					full-speed duty-cycle which is hard-
> +					wired to 255 (100% duty-cycle).
> diff -uprN -X linux-2.6.21-mm1/Documentation/dontdiff -x drivers -x include linux-2.6.21-mm1.orig/MAINTAINERS linux-2.6.21-mm1/MAINTAINERS
> --- linux-2.6.21-mm1.orig/MAINTAINERS	2007-05-07 12:16:20.000000000 -0700
> +++ linux-2.6.21-mm1/MAINTAINERS	2007-05-07 12:25:53.000000000 -0700
> @@ -1249,6 +1249,12 @@ M:	christopher.leech@intel.com
>  L:	linux-kernel@vger.kernel.org
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
