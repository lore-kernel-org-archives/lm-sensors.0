From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 14 Aug 2006 12:37:19 +0000
Subject: [lm-sensors] [PATCH 2/2 RESEND 2] hwmon: add vt1211
Message-Id: <20060814143719.c2b61ce7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This patch adds documentation for the new vt1211 Super-IO driver.

My review:

> --- linux-2.6.17-rc4-mm1-vanilla/Documentation/hwmon/vt1211	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.17-rc4-mm1/Documentation/hwmon/vt1211	2006-05-17 21:14:36.000000000 +0000
> @@ -0,0 +1,167 @@
> +Kernel driver vt1211
> +==========
> +
> +Supported chips:
> +  * VIA VT1211
> +    Prefix: 'vt1211'
> +    Addresses scanned: none, address read from Super-I/O config space
> +    Datasheet: Provided by VIA upon request and under NDA
> +
> +Authors: Juerg Haefliger <juergh at gmail.com>
> +         Lars Ekman <emil71se at yahoo.com>
> +         Mark D. Studebaker <mdsxyz123 at yahoo.com>

Drop Mark, or add a statement "based on a driver written my Mark..."

> +         
> +Thanks to Joseph Chan and Fiona Gatt from VIA for providing documentation and
> +technical support.
> +
> +
> +Description
> +-----------
> +
> +The VIA VT1211 Super-I/O chip includes complete hardware monitoring
> +capabilities. It monitors 2 dedicated temperature sensor inputs (temp1 and 
> +temp3), 2 dedicated voltages (in5 & in6) and 2 fans. Additionally, the chip 
> +implements 5 universal input channels (UCH1-5) that can be individually 
> +programmed to either monitor a voltage or a temperature.
> +
> +This chip also provides manual and automatic control of fan speeds. The driver
> +supports these features but they haven't been very well tested yet (due to the
> +fact that my EPIA M10000 doesn't have the fans connected to the PWM outputs of
> +the VT1211 :-().
> +
> +The following table shows the relationship between the vt1211 inputs and the 
> +sysfs nodes.
> +
> +Sensor          Voltage Mode   Temp Mode   Default Use (from the datasheet)
> +------          ------------   ---------   --------------------------------
> +Reading 1                      temp3       Intel thermal diode
> +Reading 3                      temp1       internal thermal diode
> +UCH1/Reading2   in0            temp2       NTC type thermistor
> +UCH2            in1            temp4       +2.5V
> +UCH3            in2            temp5       VccP (processor core)
> +UCH4            in3            temp6       +5V
> +UCH5            in4            temp7       +12V
> ++3.3V           in5                        Internal VCC (+3.3V)
> +-12V            in6                        (reserved)
> +
> +Note that even though in6 is implemented in the driver, it is reserved as per
> +the datasheet and doesn't return a meaningful value (always 0). 

I take it as a strong indication that it doesn't exist at all, and I'd
drop it.

> +
> +
> +Voltage Monitoring
> +------------------
> +
> +Voltages are sampled by an 8-bit ADC with a LSB of ~10mV. The supported input
> +range is thus from 0 to 2.60V. Voltage values outside of this range need
> +external scaling resistors. This external scaling needs to be compensated for
> +via compute lines in sensors.conf, like:
> +
> +compute inx @*(1+R1/R2), @/(1+R1/R2)
> +
> +The board level scaling resistors according to VIA's recommendation are as
> +follows. And this is of course totally dependent on the actual board
> +implementation :-) You will have to find documentation for your own
> +motherboard and edit sensors.conf accordingly.
> +
> +                                      Expected
> +Voltage       R1     R2     Divider   Raw Value
> +-----------------------------------------------
> ++2.5V         2K     10K    1.2       2083 mV
> +VccP          ---    ---    1.0       1400 mV (1)
> ++5V           14K    10K    2.4       2083 mV
> ++12V          47K    10K    5.7       2105 mV
> ++3.3V (int)   2K     3.4K   1.588     3300 mV (2)
> ++3.3V (ext)   6.8K   10K    1.68      1964 mV
> +
> +(1) Depending on the CPU (1.4V is for a VIA C3 Nehemiah).
> +(2) R1 and R2 for 3.3V (int) are internal to the VT1211 chip and the driver
> +    performs the scaling and returns the properly scaled voltage value.
> +
> +Each measured voltage has an associated low and high limit which triggers an
> +alarm when crossed.
> +
> +
> +Temperature Monitoring
> +----------------------
> +
> +Temperatures are reported in millidegree Celsius. Each measured temperature
> +has a high limit which triggers an alarm if crossed. There is an associated
> +hysteresis value with each temperature below which the temperature has to drop
> +before the alarm is cleared.
> +
> +All temperature channels except temp1 are external. Temp1 is the VT1211
> +internal thermal diode and the driver does all the scaling for temp1 and 
> +returns the temperature in millidegree Celcius. For the external channels,
> +scaling needs to be performed in user-land via sensors.conf and depending on
> +the boad implementation:
> +
> +compute tempx (@-Offset)/Gain, (@*Gain)+Offset   [for thermal diodes]
> +
> +According to the VIA VT1211 BIOS porting guide, the following values should be
> +used:
> +
> +Diode Type      Offset   Gain
> +----------      ------   ----
> +Intel CPU       88.638   0.9528
> +VIA C3 Ezra     83.869   0.9528
> +VIA C3 Ezra-T   73.869   0.9528

Odd, in sensors.conf we have a different fomula, supposedly for Intel
CPUs: offset 65, gain 0.9686. It presumably comes from an older BIOS
porting guide? Might be worth documenting.

Not a word on thermistor-based measurements?

> +
> +
> +Fan Speed Control
> +-----------------
> +
> +The VT1211 provides 2 programmable PWM outputs to control the speeds of 2 fans
> +. Writing a 2 to any of the two pwm[1..2]_enable sysfs nodes will put the PWM

Move the dot at the end of previous line.

[1..2] is usually written [1-2] in the rest of our documentation.

> +controller in automatic mode. Note that there is only a single controller that
> +controls both PWM outputs but each PWM output can be individually enabled and
> +disabled. The possible operating modes for the 2 PWM outputs are as follows:
> +
> +pwm1_enable   pwm2_enable   |   pwm1        pwm2
> +----------------------------------------------------
> +0             0             |   off         off
> +0             1             |   off         manual
> +1             0             |   manual      off
> +1             1             |   manual      manual
> +2             0             |   automatic   off
> +0             2             |   off         automatic
> +2             2             |   automatic   automatic

This table doesn't help much IMHO. What is really important to say is
that you can't mix manual and automatic modes.


> +
> +Each PWM has 4 associated distinctiv output duty-cycles: full, high, low and

That would be distinctive or (better I think) distinct.

> +off. Full and off are internally hard-wired to 255 (100%) and 0 (0%), 
> +respectively. High and low can be programmed via 
> +pwm[1..2]_auto_point[2..3]_pwm. Each PWM output can be associated with a
> +different thermal input but - and here's the weird part - only one set of
> +thermal thresholds exist that control both PWMs output duty cycles (??). The 

Why these question marks?

> +thermal thresholds are accessible via pwm[1..2]_auto_point[1..4]_temp. Note
> +that even though there are 2 sets of 4 auto points each, they map to the same
> +registers in the VT1211. So programming one set is sufficient.
> +
> +PWM Auto Point              PWM Output Duty-Cycle
> +-------------------------------------------------
> +pwm[1..2]_auto_point1_pwm   full speed dc (255)
> +pwm[1..2]_auto_point2_pwm   high speed dc
> +pwm[1..2]_auto_point3_pwm   low speed dc
> +pwm[1..2]_auto_point4_pwm   off dc (0)

"dc" is an unfortunate abbreviation for duty cycle. People could read it
as "direct current", which is the other fan speed control method. Pretty
confusing.

> +
> +Temp Auto Point              Thermal Threshold
> +-------------------------------------------------
> +pwm[1..2]_auto_point1_temp   full speed temp
> +pwm[1..2]_auto_point2_temp   high speed temp
> +pwm[1..2]_auto_point3_temp   low speed temp
> +pwm[1..2]_auto_point4_temp   off temp
> +
> +Long story short, the controller inmplements the following algorithm to set the

Typo: implements.

> +PWM output duty-cycle based on the input temperature:
> +
> +                          Output Duty-Cycle
> +Thermal Threshold   (Rising Temp)   (Falling Temp)
> +--------------------------------------------------
> +                    full speed dc   full speed dc
> +full speed temp
> +                    high speed dc   full speed dc
> +high speed temp
> +                    low speed dc    high speed dc
> +low speed temp
> +                    off dc          low speed dc
> +off temp
> +                    off dc          off dc

Very good doc, well done.

-- 
Jean Delvare

