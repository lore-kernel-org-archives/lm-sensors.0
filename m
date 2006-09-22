From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 22 Sep 2006 19:01:22 +0000
Subject: [lm-sensors] [PATCH]: lm-sensors vt1211 updates
Message-Id: <20060922210122.f3fc0f0e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0609220907w416fb35r3533de04d8ee0bd0@mail.gmail.com>
In-Reply-To: <191fb4ca0609220907w416fb35r3533de04d8ee0bd0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> This patch fixes a vt1211 register mapping bug and it syncs the temp
> channel mappings of the 2.4 vt1211 driver with the recently released
> 2.6 driver. It also fixes the register-to-procfs (and
> procfs-to-register) conversions to match the 2.6 driver and updates
> the vt1211 section of sensors.conf accordingly.
> 
> It has been tested on my EPIA M10000 and the outpust of 'sensors' on a
> 2.4 kernel matches the output on a 2.6 kernel using the patched
> sensors.conf file.

Thanks for your work on this. I have a few objections which need to be
discussed and addressed:

> +    set in0_min 3.3 * 0.95
> +    set in0_max 3.3 * 1.05
> +    set in1_min 2.5 * 0.95
> +    set in1_max 2.5 * 1.05
> +# Replace 1.4 with your nominal CPU voltage for in2.
> +    set in2_min 1.4 * 0.97
> +    set in2_max 1.4 * 1.03
> +    set in3_min 5.0 * 0.95
> +    set in3_max 5.0 * 1.05
> +    set in4_min 12.0 * 0.90
> +    set in4_max 12.0 * 1.10
> +    set in5_min 3.3 * 0.95
> +    set in5_max 3.3 * 1.05

We decided some times ago that all "set statements" should be commented
out by default, to prevent trouble when a motherboard uses non-default
wiringq or resistor values. The only exception to this rule is for
internal voltages, because we know they have to be wired and the
scaling is known for sure. So please comment out all set statements,
except for in5.

> +
> +# The temperature calculations are of the form
> +#    compute tempX  (@ - Offset) / Gain, (@ * Gain) + Offset
> +#
> +# The following are the gain and offset values as recommended by VIA
> +#	Diode Type	Gain	Offset
> +#	----------	----	------
> +# 	Intel CPU	0.9528	88.638
> +#			0.9686	65.000	*)
> +#	VIA C3 Ezra	0.9528	83.869
> +#	VIA C3 Ezra-T	0.9528	73.869
> +#
> +# *) These are the values from the previous sensors.conf. I don't know
> +# where they came from or how they got derived.
> +#
> +# The VT1211 internal temperature (temp2) is scaled by the driver
> +# and doesn't need to be adjusted here.
> +
> +    compute temp1  (@ - 73.869) / 0.9528,  (@ * 0.9528) + 73.869
> +
> +# The thermistor calculations are of the form
> +#    compute tempX  1 / (1 / 298.15 - (` Vmax / @ - 1)) / B) - 273.15, \
> +#                   Vmax / (1 + (^ (B / 298.15 - B / (273.15 + @))))
> +#
> +# B is the thermistor beta value, Vmax is the reference voltage, '^' is the
> +# exp() operator and '`' is the ln() operator.
> +# Given B = 3435 and Vmax = 2.2V and assuming that the thermistor forms a
> +# resistor divider with a resistor equal to the thermistor's nominal value at
> +# 25 degrees C, the following compute lines can be used:
> +
> +#    compute temp3  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) - 273.15, \
> +#                   2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
> +#    compute temp4  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) - 273.15, \
> +#                   2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
> +#    compute temp5  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) - 273.15, \
> +#                   2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
> +#    compute temp6  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) - 273.15, \
> +#                   2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
> +#    compute temp7  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) - 273.15, \
> +#                   2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
> +
> +    set temp1_hyst 80
> +    set temp1_over 85
> +    set temp2_hyst 60
> +    set temp2_over 65

same here.

>  #    set temp3_hyst 60
>  #    set temp3_over 65
>  #    set temp4_hyst 40
>  #    set temp4_over 45
> +#    set temp5_hyst 40
> +#    set temp5_over 45
> +#    set temp6_hyst 40
> +#    set temp6_over 45
> +#    set temp7_hyst 40
> +#    set temp7_over 45
>  
> -#    set fan1_min 3000
> -#    set fan2_min 3000
> +    set fan1_min 3000
> +    set fan2_min 3000

And here.

> +/* temp1 (i = 1) is an intel thermal diode which is scaled in user space.
> +   temp2 (i = 2) is the internal temp diode so it's scaled in the driver
> +   according to some measurements taken on an EPIA M10000.
> +   temp3-7 are thermistor based so the driver returns the voltage measured at
> +   the pin (range 0V - 2.2V). */
> +#define TEMP_FROM_REG(i, reg)	((i) = 1 ? (reg) * 10 : \
> +				 (i) = 2 ? (reg) < 51 ? 0 : \
> +				 ((reg) - 51) * 10 : \
> +				 ((253 - (reg)) * 220 + 1050) / 2100)
> +/* for 10-bit temp values */
> +#define TEMP_FROM_REG10(i, reg)	((i) = 1 ? (reg) * 10 / 4 : \
> +				 (i) = 2 ? (reg) < 204 ? 0 : \
> +				 ((reg) - 204) * 10 / 4 : \
> +				 ((1012 - (reg)) * 55 + 1050) / 2100)
> +#define TEMP_TO_REG(i, val)	SENSORS_LIMIT( \
> +				 ((i) = 1 ? ((val) + 5) / 10 : \
> +				  (i) = 2 ? ((val) + 5) / 10 + 51 : \
> +				  253 - ((val) * 2100 + 110) / 220), 0, 255)

The problem is that the formulas for i >= 3 assume a magnitude of 3
(LSB = 0.001 mV), while the driver (and libsensors) export a magnitude
value of 1 (LSB = 0.1 degree C). I guess you didn't have the
opportunity to test these inputs on your system? You need to change the
magnitude value in vt1211_temp() (operation = SENSORS_PROC_REAL_INFO),
and then in libsensors.

> +
> +/* in5 (i = 5) is special. It's the internal 3.3V so it's scaled in the
> +   driver according to the VT1211 BIOS porting guide */
> +#define IN_FROM_REG(i, reg)	((reg) < 3 ? 0 : (i) = 5 ? \
> +				 (((reg) - 3) * 15882 + 4790) / 9580 : \
> +				 (((reg) - 3) * 10000 + 4790) / 9580)
> +#define IN_TO_REG(i, val)	(SENSORS_LIMIT((i) = 5 ? \
> +				 ((val) * 9580 + 7941) / 15882 + 3 : \
> +				 ((val) * 9580 + 5000) / 10000 + 3, 0, 255))
>  
>  /********* FAN RPM CONVERSIONS ********/
>  /* But this chip saturates back at 0, not at 255 like all the other chips.
> @@ -270,11 +288,11 @@ static struct i2c_driver vt1211_driver >  #define VT1211_ALARM_FAN1 0x40
>  #define VT1211_ALARM_FAN2 0x80
>  #define VT1211_ALARM_IN4 0x100
> -#define VT1211_ALARM_TEMP2 0x800
> +#define VT1211_ALARM_TEMP3 0x800
>  #define VT1211_ALARM_CHAS 0x1000
> -#define VT1211_ALARM_TEMP3 0x8000
> +#define VT1211_ALARM_TEMP2 0x8000
>  /* duplicates */
> -#define VT1211_ALARM_IN0 VT1211_ALARM_TEMP2
> +#define VT1211_ALARM_IN0 VT1211_ALARM_TEMP3
>  #define VT1211_ALARM_TEMP4 VT1211_ALARM_IN1
>  #define VT1211_ALARM_TEMP5 VT1211_ALARM_IN2
>  #define VT1211_ALARM_TEMP6 VT1211_ALARM_IN3

I am surprised to see temp1 alarm unchanged... I take it that the
original code was not correct? Not necessarily surprising given that
temp1 and temp3 limit registers were swapped.

I'm fine with the rest, so if you're OK I might as well fix the above
by myself, no need to resend a patch.

-- 
Jean Delvare

