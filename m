From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 20 Aug 2007 20:51:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Update the sysfs interface
Message-Id: <46C9FEBB.8020700@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070820164444.48e68a63@hyperion.delvare>
In-Reply-To: <20070820164444.48e68a63@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> * Document the name attribute.
> * Document the *_label attributes.
> * Drop "typical usage" lists, they no longer match the reality.
> * Drop non hardware-monitoring related entries.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Looks good to me"
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

> ---
>  Documentation/hwmon/sysfs-interface |   75 +++++++++++++++++++----------------
>  1 file changed, 41 insertions(+), 34 deletions(-)
> 
> --- linux-2.6.23-rc3.orig/Documentation/hwmon/sysfs-interface	2007-08-19 12:04:41.000000000 +0200
> +++ linux-2.6.23-rc3/Documentation/hwmon/sysfs-interface	2007-08-20 16:41:06.000000000 +0200
> @@ -78,8 +78,21 @@ RW	read/write value
>  Read/write values may be read-only for some chips, depending on the
>  hardware implementation.
>  
> -All entries are optional, and should only be created in a given driver
> -if the chip has the feature.
> +All entries (except name) are optional, and should only be created in a
> +given driver if the chip has the feature.
> +
> +
> +********
> +* Name *
> +********
> +
> +name		The chip name.
> +		This should be a short, lowercase string, not containing
> +		spaces nor dashes, representing the chip name. This is
> +		the only mandatory attribute.
> +		I2C devices get this attribute created automatically.
> +		RO
> +
>  
>  ************
>  * Voltages *
> @@ -104,18 +117,17 @@ in[0-*]_input	Voltage input value.
>  		by the chip driver, and must be done by the application.
>  		However, some drivers (notably lm87 and via686a)
>  		do scale, because of internal resistors built into a chip.
> -		These drivers will output the actual voltage.
> -
> -		Typical usage:
> -			in0_*	CPU #1 voltage (not scaled)
> -			in1_*	CPU #2 voltage (not scaled)
> -			in2_*	3.3V nominal (not scaled)
> -			in3_*	5.0V nominal (scaled)
> -			in4_*	12.0V nominal (scaled)
> -			in5_*	-12.0V nominal (scaled)
> -			in6_*	-5.0V nominal (scaled)
> -			in7_*	varies
> -			in8_*	varies
> +		These drivers will output the actual voltage. Rule of
> +		thumb: drivers should report the voltage values at their
> +		pins.
> +
> +in[0-*]_label	Suggested voltage channel label.
> +		Text string
> +		Should only be created if the driver has hints about what
> +		this voltage channel is being used for, and user-space
> +		doesn't. In all other cases, the label is provided by
> +		user-space.
> +		RO
>  
>  cpu[0-*]_vid	CPU core reference voltage.
>  		Unit: millivolt
> @@ -159,6 +171,13 @@ fan[1-*]_target
>  		Only makes sense if the chip supports closed-loop fan speed
>  		control based on the measured fan speed.
>  
> +fan[1-*]_label	Suggested fan channel label.
> +		Text string
> +		Should only be created if the driver has hints about what
> +		this fan channel is being used for, and user-space doesn't.
> +		In all other cases, the label is provided by user-space.
> +		RO
> +
>  Also see the Alarms section for status flags associated with fans.
>  
>  
> @@ -260,18 +279,19 @@ temp[1-*]_crit_hyst
>  		from the critical value.
>  		RW
>  
> -temp[1-4]_offset
> +temp[1-*]_offset
>  		Temperature offset which is added to the temperature reading
>  		by the chip.
>  		Unit: millidegree Celsius
>  		Read/Write value.
>  
> -		If there are multiple temperature sensors, temp1_* is
> -		generally the sensor inside the chip itself,
> -		reported as "motherboard temperature".  temp2_* to
> -		temp4_* are generally sensors external to the chip
> -		itself, for example the thermal diode inside the CPU or
> -		a thermistor nearby.
> +temp[1-*]_label	Suggested temperature channel label.
> +		Text string
> +		Should only be created if the driver has hints about what
> +		this temperature channel is being used for, and user-space
> +		doesn't. In all other cases, the label is provided by
> +		user-space.
> +		RO
>  
>  Some chips measure temperature using external thermistors and an ADC, and
>  report the temperature measurement as a voltage. Converting this voltage
> @@ -391,16 +411,3 @@ beep_mask	Bitmask for beep.
>  		use discouraged for the same reason. Use individual
>  		*_beep files instead.
>  		RW
> -
> -
> -*********
> -* Other *
> -*********
> -
> -eeprom		Raw EEPROM data in binary form.
> -		RO
> -
> -pec		Enable or disable PEC (SMBus only)
> -		0: disable
> -		1: enable
> -		RW
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
