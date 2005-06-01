From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 01 Jun 2005 17:01:57 +0000
Subject: [lm-sensors] PATCH i2c: adm9240 driver doc
Message-Id: <429DCDD0.5040801@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <rhsq915s84h66e4ncuam104kfsdhf1onc9@4ax.com>
In-Reply-To: <rhsq915s84h66e4ncuam104kfsdhf1onc9@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello.

Please avoid using tabs in document if possible.

> ---
>  adm9240 |  214 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 214 insertions(+)
> 
> diff -X dontdiff -Nrup linux-2.6.12-rc5-mm1/Documentation/i2c/chips/adm9240 linux-2.6.12-rc5-mm1a/Documentation/i2c/chips/adm9240
> --- linux-2.6.12-rc5-mm1/Documentation/i2c/chips/adm9240	1970-01-01 10:00:00.000000000 +1000
> +++ linux-2.6.12-rc5-mm1a/Documentation/i2c/chips/adm9240	2005-06-01 18:27:51.000000000 +1000
> @@ -0,0 +1,214 @@
> +Kernel driver adm9240
> +==========> +
> +Supported chips:
> +  * Analog Devices ADM9240'
> +    Prefix `adm9240'

Please  Prefix: 'adm9240' with same quotes

> +    Addresses scanned: I2C 0x2c - 0x2f
> +    Datasheet: Publicly available at the Analog Devices website
> +	       http://www.analog.com/

Please put url to PDF

> +
> +  * Dallas Semiconductor DS1780
> +    Prefix `ds1780'

same

> +    Addresses scanned: I2C 0x2c - 0x2f
> +    Datasheet: Publicly available at the Dallas Semiconductor (Maxim) website
> +	       http://www.maxim-ic.com

same
> +

> +  * National Semiconductor LM81
> +    Prefix `lm81'
same

> +    Addresses scanned: I2C 0x2c - 0x2f
> +    Datasheet: Publicly available at the National Semiconductor website
> +	       http://www.national.com/

same
> +
> +Authors:
> +	Frodo Looijaard <frodol@dds.nl>,
> +	Philip Edelbrock <phil@netroedge.com>
,

> +	Michiel Rook <michiel@grendelproject.nl>
,
> +	Grant Coady <gcoady@gmail.com> with guidance 
> +		from Jean Delvare <khali@linux-fr.org>
> +
> +Interface
> +====
----------

As others has this one

> +The I2C addresses listed above assume BIOS has not changed the 
> +chip MSB 5-bit address.  Each chip reports a unique manufacturer 
> +identification code as well as the chip revision/stepping level.
> +
> +alarms		R	16-bit alarm status
> +aout_output	RW	0..1250mV analog output
> +chassis_clear	W	'echo 1 > chassis_clear' to clear Chassis Intrusion latch
> +cpu0_vid	R	mV VID reading
> +fan1_div	R	2 x fan divider, 1, 2, 4, 8
> +fan1_input	R	2 x fan speed reading in rpm
> +fan1_min	RW	2 x fan minimum speed limit in rpm
> +in0_input	R	6 x scaled voltage inputs [1]
> +in0_max		RW	6 x voltage high limit
> +in0_min		RW	6 x voltage low limit
> +temp1_input	R	chip temperature to 0.5'C resolution
> +temp1_max	WR	chip max temperature alarm point
> +temp1_max_hyst	WR	chip max temperature hysteresis [2]

I think we should describe only non standard stuff this time. Please can you adjust?

> +[1]	Nominal mV: 2500, 2700, 3300, 5000, 12000, 2700
> +
> +[2]	temperature alarm asserted when temperature exceeds maximum value 
> +	and cleared when temperature falls below the hysteresis value
> +
> +
> +Description
> +=====
---------------- (adjust line size yourself :)

> +[From ADM9240] The ADM9240 is a complete system hardware monitor for 
> +microprocessor-based systems, providing measurement and limit comparison 
> +of up to four power supplies and two processor core voltages, plus 
> +temperature, two fan speeds and chassis intrusion.  Measured values can 
> +be read out via an I2C-compatible serial System Management Bus, and values 
> +for limit comparisons can be programmed in over the same serial bus.  The 

Please remove all double spaces '  ' they may be somewhere else too

> +high speed successive approximation ADC allows frequent sampling of all 
> +analog channels to ensure a fast interrupt response to any out-of-limit 
> +measurement.
> +
> +The ADM9240, DS1780 and LM81 are register compatible, the following 
> +details are common to the three chips.  Chip differences are described 
> +after this section.
> +
> +
> +Measurements
> +======

---------------

> +The measurement cycle
> +
> +The adm9240 driver will take a measurement reading no faster than once 
> +each two seconds.  User-space may read sysfs interface faster than the 
> +measurement update rate and will receive cached data from the most 
> +recent measurement.  
> +
> +Temperature
> +-----------
> +On chip temperature is reported as degrees Celsius as 9-bit signed data 
> +with resolution of 0.5 degrees Celsius.  High and low temperature limits 
> +are 8-bit signed data with resolution of one degree Celsius.  The driver 

double dragon :)

> +sets temperature interrupt to default mode so that an alarm is asserted 
> +once the temperature exceeds the high limit, and is cleared when the 
> +temperature falls below the temp1_max_hyst value.
> +
> +Fan Speed
> +---------
> +Two fan tacho inputs are provided, the ADM9240 gates an internal 22.5kHz 
> +clock via a divider to an 8-bit counter.  Fan speed (rpm) is calculated by:
> +
> +rpm = (22500 * 60) / (count * divider)
> +
> +Automatic fan clock divider
> +
> +  * User sets 0 to fan_min limit
> +    - low speed alarm is disabled
> +    - fan clock divider not changed
> +    - auto fan clock adjuster enabled for valid fan speed reading
> +
> +  * User sets fan_min limit too low
> +    - low speed alarm is enabled
> +    - fan clock divider set to max
> +    - fan_min set to register value 254 which corresponds
> +      to 664 rpm on adm9240
> +    - low speed alarm will be asserted if fan speed is
> +      less than minimum measurable speed
> +    - auto fan clock adjuster disabled
> +
> +  * User sets reasonable fan speed
> +    - low speed alarm is enabled
> +    - fan clock divider set to suit fan_min
> +    - auto fan clock adjuster enabled: adjusts fan_min
> +
> +  * User sets unreasonably high low fan speed limit
> +    - resolution of the low speed limit may be reduced
> +    - alarm will be asserted
> +    - auto fan clock adjuster enabled: adjusts fan_min
> +
> +    * fan speed may be displayed as zero until the auto fan clock divider
> +      adjuster brings fan speed clock divider back into chip measurement
> +      range, this will occur within a few measurement cycles.
> +
> +Note: changing the fan clock divider does NOT change the fan speed reading, 
> +it adjusts the internal measurement range so that the 8-bit fan clock 
> +counter does not overflow.  The datasheet rpm values assume two pulses per 
> +fan revolution.  If your fan differs from two pulses per revolution, scale 
> +the fan speed reading in user-space.

We removed this information about pulse/per revolution from other drivers


> +Analog Output
> +-------------
> +An analog output provides a 0 to 1.25 volt signal intended for an external 
> +fan speed amplifier circuit.  The analog output is set to maximum value on 
> +power up or reset.  This doesn't do much on the test Intel SE440BX-2.
> +
> +Voltage Monitor
> +
> +Voltage (IN) measurement is internally scaled:
> +
> +	nr	label		 nominal	maximum	     resolution
> +				   mV		  mV		 mV
> +	0	+2.5V		  2500		 3320		13.0
> +	1	Vccp1		  2700		 3600		14.1 
> +	2	+3.3V		  3300		 4380		17.2
> +	3	+5V		  5000		 6640		26.0
> +	4	+12V		 12000		15940		62.5
> +	5	Vccp2		  2700		 3600		14.1
> +
> +The reading is an unsigned 8-bit value, nominal voltage measurement is 
> +represented by a reading of 192, being 3/4 of the measurement range.
> +
> +An alarm is asserted for any voltage going below or above the set limits.
> +
> +The driver reports and accepts voltage limits scaled to the above table.
> +
> +VID Monitor
> +-----------
> +The chip has five inputs to read the 5-bit VID and reports the mV value 
> +based on detected CPU type.
> +
> +Chassis Intrusion
> +-----------------
> +An alarm is asserted when the CI pin goes active high.  The ADM9240 
> +Datasheet has an example of an external temperature sensor driving 
> +this pin.  On an Intel SE440BX-2 the Chassis Intrusion header is 
> +connected to a normally open switch.
> +
> +The ADM9240 provides an internal open drain on this line, and may output 
> +a 20 ms active low pulse to reset an external Chassis Intrusion latch.
> +
> +Clear the CI latch by writing value 1 to the sysfs chassis_clear file.
> +
> +Alarm flags reported as 16-bit word
> +-----------------------------------
> +	bit	label		comment
> +	------	--------------	--------------------------------------------
> +	 0	+2.5 V_Error	high or low limit exceeded
> +	 1	VCCP_Error	high or low limit exceeded
> +	 2	+3.3 V_Error	high or low limit exceeded
> +	 3	+5 V_Error	high or low limit exceeded
> +	 4	Temp_Error	temperature error
> +	 6	FAN1_Error	fan low limit exceeded
> +	 7	FAN2_Error	fan low limit exceeded
> +	 8	+12 V_Error	high or low limit exceeded
> +	 9	VCCP2_Error	high or low limit exceeded
> +	12	Chassis_Error	CI pin went high
> +
> +Remaining bits are reserved and thus undefined.  It is important to note 
> +that alarm bits may be cleared on read, user-space may latch alarms and 
> +provide the end-user with a method to clear alarm memory.
> +
> +Chip differences
> +========
-----------------

> +ADM9240 has a very fast 320us temperature and voltage measurement cycle 
> +with independent fan speed measurement cycles counting alternating rising 
> +edges of the fan tacho inputs.  Comparisons are described as "exceeds 
> +limit."

I lost context about "Comparisions"

> +DS1780 measurement cycle is about once per second including fan speed.
> +"For the high limits of the voltages, the device is doing a greater than 
> +comparison. For the low limits, however, it is doing a less than or equal 
> +comparison."
> +
> +LM81 measurement cycle is about once per 400ms including fan speed, the 
> +LM81 also has an unsupported 12-bit extended temperature measurement mode.
> +"For voltage input high limits, the device is doing a greater than comparison.
> +For low limits, however, it is doing a less than or equal to comparison."
> +
> +Grant Coady <gcoady@gmail.com> 2005-05-31

We do not have author at the end of file. I think we do not need the date
because the file has date itself.

