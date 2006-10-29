From: christian.mahr.ulm@arcor.de (Christian Mahr)
Date: Sun, 29 Oct 2006 22:50:04 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG
Message-Id: <200610292350.05124.christian.mahr.ulm@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4536788E.8010504@fibertel.com.ar>
In-Reply-To: <4536788E.8010504@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,
as you wished - reply goes also to <lm-sensors at lm-sensors.org>.
Please see my answers/notes below.
Maybe other owners of P5B Deluxe WiFi are interested what sensor readings really do mean for this board - or maybe somebody can give me a hint on what they found out already?
Thanks
	Christian



Am Sonntag, 29. Oktober 2006 21:33 schrieb David Hubbard:
> Hi Christian,
>
> Please include lm-sensors at lm-sensors.org in your reply so this will
> benefit others and get archived on the LM-sensors list.
>
> On 10/29/06, Christian Mahr <christian.mahr.ulm at arcor.de> wrote:
> > Hi David,
> >
> > Thanks again for the driver. So far I can judge - it works!
>
> That's good.
>
> > I am still studying the result.
> >
> > Still guessing how the chip is used on the Motherboard - do you have any
> > documentation on the chip itself to support my guessing?
> >
> > Some of my ovservations so far:
> >
> > 1. Fans
> >
> >  I can observe the 3 fans connect to my board (did not chek the rest).
> > Anyhow the sequence is quite different to the numbering on the mother
> > board.
>
> That is normal.
>
> > I adapted /etc/sensors.conf so I can see the 3 fans properly:
>
> Good. Every motherboard may be different. That's the purpose of
> /etc/sensors.conf.
>
> > fan1: 948 RPM (min = 803 RPM, div = 16) also named CHA_Fan1
> >
> > fan4: 1004 RPM (min = 811 RPM, div = 16) named CHA_Fan2
> >
> > fan5: 819 RPM (min = 602 RPM, div = 16) named CHA_Fan3
> >
> > (I do not use the cpu fan, chasis only)
>
> So, are you saying the CPU fans are not connected?
>
Sorry, I should have explained. The CPU-Fan connector on the P5BDeluxe Wifi is a 4-pin, but my CPU-Fan itself has only 3 pins. As I tried to use the marked 3 pins(the 3-pin connector still fits into the 4 pin) I could not control the speed via the Bios (this is probably the purpose of the 4th pin on a 4 pin connector?) --> it stayed on a somewhat noisy speed.
So I decided to use one of the 3-pin-CHA1_FAN-connector (all other Fan connectors do have 3 pins) for the CPU-fan and tried this one instead --> it works. All calm cool and quiet now.

> > The fans (mine are quite slow) need half a minute to settle. During this
> > time the "div" (which I did not set) seems to vary.
>
> Yes. The div is automatically set. While it is settling, the div may
> have incorrect values and your fans will read incorrect values (0, if
> they are running slowly).

This is pretty neat as the Bios apparently cannot handle this correctly. If the speed is below, say, 700 rpm or so, the Bios (when the "FAN page" is opened) becomes very slow and behaves strange sometimes.
Is this a "auto-div" function of the chip or the driver?
Does this mean you do not need to set it in the sensors.conf ? This should be mentioned later specifically in the comments in sensors.conf, isn?t it?

>
> > 2. Voltages
> >
> > I have no clear idea what I do measure on which input. Here some
> > documentation could help. f.e. on the voltage ratio between measured and
> > reasl +5V seems to be a factor of 3.16
> >
> >
> >
> > Current output is:
> >
> >
> >
> > w83627ehf-isa-0290
> >
> > Adapter: ISA adapter
> >
> > VCore: +1.17 V (min = +0.00 V, max = +1.74 V)
> >
> > +12V: +12.04 V (min = +10.82 V, max = +13.20 V)
> >
> > AVCC: +3.23 V (min = +3.14 V, max = +3.47 V)
> >
> > 3VCC: +3.23 V (min = +3.14 V, max = +3.47 V)
> >
> > in4: +1.46 V (min = +1.29 V, max = +1.58 V)
> >
> > in5: +1.58 V (min = +1.42 V, max = +1.74 V)
> >
> > +5V: +5.07 V (min = +4.75 V, max = +5.24 V)
> >
> > VSB: +3.23 V (min = +3.14 V, max = +3.47 V)
> >
> > VBAT: +3.18 V (min = +3.14 V, max = +3.47 V)
> >

reference reading in /sys/..../in*input	just right now:
1168
1824
3232
3232
1456
1584
1400
3232
3184

versus "sensors interpretation" (some seconds later)
VCore:     +1.16 V  		this seems smewhat low as BIOS says 1.296
+12V:     +12.04 V		this seems smewhat high as BIOS says 11,985
AVCC:      +3.23 V 		matches the bios readin of 3.216 Volts
3VCC:      +3.22 V  
in4:       +1.45 V 		
in5:       +1.58 V  
+5V:       +5.07 V 		Bios says 5.068, but here I adjusted the ratio for a fit.
VSB:       +3.23 V  
VBAT:      +3.18 V  
So Bios shows only 4 voltages out of the 8 sensors that are available!

Interestingly enough one can set some more Voltages when performing overclocking (I don?t dare to). 
The manual says, one can set 6 voltages on this board:
	memory voltage[1.80..2.45]
	CPU-Vcore         [1.275..1,7V], 
	FSB-voltage       [1.2 .. 1.45V]
	NB-Vcore	          [1.25..1,55]
	SB-vcore	          [1.5..1,8]
	ICH-voltage      [1.057 and 1,215V]

Since the Bios does not show these (except Vcore), these seem to be "write-only".
Nevertheless it could be that in4 and in5 relate to one of those values?
Maybe somebody on the list knows?


> >
> >
> > So on some voltages I am just guessing....
>
> The voltage scaling is done externally and although the datasheet
> specifies the resistor ratio, it is possible that the motherboard
> manufacturer has wired it differently. The way to check the voltages
> is to look in the BIOS. Can you see all the voltages listed there?
>
see above....
I guess the load situation is Bios is different to having Linux started?

> > 3. Temperatures
> >
> >
> >
> > I can see 2 out of 3 valid temperatures -
> >
> > Sys Temp: +36?C (high = +45?C, hyst = +40?C)
> >
> > CPU Temp: +35.0?C (high = +45.0?C, hyst = +40.0?C)
> >
> > AUX Temp: +119.0?C (high = +80.0?C, hyst = +75.0?C) ALARM
> >
> >
> >
> > The 3rd temperature sensoris obviously not used (says 119 degrees)
> >
> > But I have no real Idea what the 2 sensors are doing.
>
Interestingly enough the "sys" is very close to "CPU" in temperature wheras Bios shows 7 degrees more for the CPU (???).
Question: 
Which CPU sensor is meant here? The Core2Duo has got 2 of them internally (see coretemp driver) - is this a 3rd one?


> The AUX temp may need to be configured correctly. Can you see any
> variation? It may also be that the pin on the chip is not connected to
> anything, and just floating.
>
> > 4. in /sys
> >
> > ther is nothing in /proc/ACPI/fan, but I have observed the new device in
> > /sys/devices/platform/i2c-9191/9191-0290:
> >
> >
> >
> > . fan3_min in1_input in5_alarm in8_min pwm2_target pwm4_tolerance
> >
> > .. fan4_alarm in1_max in5_input name pwm2_tolerance subsystem
> >
> > bus fan4_div in1_min in5_max power pwm3 temp1_alarm
> >
> > driver fan4_input in2_alarm in5_min pwm1 pwm3_enable temp1_input
> >
> > fan1_alarm fan4_min in2_input in6_alarm pwm1_enable pwm3_min_output
> > temp1_max
> >
> > fan1_div fan5_alarm in2_max in6_input pwm1_min_output pwm3_mode
> > temp1_max_hyst
> >
> > fan1_input fan5_div in2_min in6_max pwm1_mode pwm3_stop_time temp2_alarm
> >
> > fan1_min fan5_input in3_alarm in6_min pwm1_stop_time pwm3_target
> > temp2_input
> >
> > fan2_alarm fan5_min in3_input in7_alarm pwm1_target pwm3_tolerance
> > temp2_max
> >
> > fan2_div hwmon:hwmon2 in3_max in7_input pwm1_tolerance pwm4
> > temp2_max_hyst
> >
> > fan2_input in0_alarm in3_min in7_max pwm2 pwm4_enable temp3_alarm
> >
> > fan2_min in0_input in4_alarm in7_min pwm2_enable pwm4_min_output
> > temp3_input
> >
> > fan3_alarm in0_max in4_input in8_alarm pwm2_min_output pwm4_mode
> > temp3_max
> >
> > fan3_div in0_min in4_max in8_input pwm2_mode pwm4_stop_time
> > temp3_max_hyst
> >
> > fan3_input in1_alarm in4_min in8_max pwm2_stop_time pwm4_target uevent
> >
> >
> >
> >
> >
> > and I can get the raw values out of fan* amd in*, which seem to be
> > matching the "sensors" output.
>
> Yes, sensors is just accessing the files in the sysfs.
>
> > My question: how do I operate the "pwm*" ports? Am I right that I can
> > control the fan speed here?
> >
> > How to do? Which values to echo in?
>
> There is documentation in the kernel source under
> linux/documentation/hwmon. Basically, set pwmN_enable to 1 for manual
> control, 2 for automatic "thermal cruise" or "SmartFan 1". In manual
> mode, echo "0" > pwmN stops the fan, and echo "255" > pwmN to run the
> fan at full speed.

Thanks , I should have known to look there
I?ll try.


>
> > If you have a data sheet in pdf of this chip with a "recommended
> > application" or the like - this might help me.
>
> I do have a copy of the datasheet from Winbond, but it is not
> currently available to the public. A "recommended application"? I am
> not sure how to help you there. If the values reported look correct,
> then it would seem the driver is working.
>
> Hope that helps,
> David
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061029/4fb4a583/attachment-0001.html 
