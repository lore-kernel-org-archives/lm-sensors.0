From: DB <Freddog_de@yahoo.co.uk>
Date: Wed, 18 Feb 2009 21:58:26 +0000
Subject: Re: [lm-sensors] [Bulk] Re: [Bulk] Re:  Cannot make ver 3.0.3
Message-Id: <499C8482.4080706@yahoo.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <499C1D1F.8060207@yahoo.co.uk>
In-Reply-To: <499C1D1F.8060207@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

DB wrote:
> Jean Delvare wrote:
>> <snip>
> Ooooooops!!!!! ;-)) That makes a difference! Now all I need to do is 
> get the "right" voltages on the right pins!
>
> [root@Fedora-Blue Dave]# sensors
> <snip>

> Dave
>
Hi Jean

And if I copy the values for the it87, it makes even MORE difference!!!!

*BUT *there appears to be something strange (to my untutored eye) with 
the -12V in Sensors, giving an alarm for a value which appears to me to 
be in-range....

Any thoughts????

Thanks

Dave

***From /etc/sensors3.conf

chip "it87-*" "it8712-*"

# The values below have been tested on Asus CUSI, CUM motherboards.

# Voltage monitors as advised in the It8705 data sheet

label in0 "VCore 1"
label in1 "VCore 2"
label in2 "+3.3V"
label in3 "+5V"
label in4 "+12V"
label in5 "-12V"
label in6 "-5V"
label in7 "Stdby"
label in8 "VBat"

# Incubus Saturnus reports that the IT87 chip on Asus A7V8X-X seems
# to report the VCORE voltage approximately 0.05V higher than the board's
# BIOS does. Although it doesn't make much sense physically, uncommenting
# the next line should bring the readings in line with the BIOS' ones in
# this case.
compute in0 -0.05+@ , @+0.05

# If 3.3V reads around 1.65V, uncomment the following line:
# compute in2 2*@ , @/2

compute in3 ((6.8/10)+1)*@ , @/((6.8/10)+1)
# A number of Gigabyte boards (GA-8IPE1000Pro, GA-8KNXP, GA-7N400-L) use
# a different resistor combination for +5V:
# compute in3 ((10/10)+1)*@ , @/((10/10)+1)

compute in4 ((30/10) +1)*@ , @/((30/10) +1)
# For this family of chips the negative voltage equation is different from
# the lm78. The chip uses two external resistor for scaling but one is
# tied to a positive reference voltage. See ITE8705/12 datasheet (SIS950
# data sheet is wrong)
# Vs = (1 + Rin/Rf) * Vin - (Rin/Rf) * Vref.
# Vref = 4.096 volts, Vin is voltage measured, Vs is actual voltage.

# The next two are negative voltages (-12 and -5).
# The following formulas must be used. Unfortunately the datasheet
# does not give recommendations for Rin, Rf, but we can back into
# them based on a nominal +2V input to the chip, together with a 4.096V 
Vref.
# Formula:
# actual V = (Vmeasured * (1 + Rin/Rf)) - (Vref * (Rin/Rf))
# For -12V input use Rin/Rf = 6.68
# For -5V input use Rin/Rf = 3.33
# Then you can convert the forumula to a standard form like:
# compute in5 (7.67 * @) - 27.36 , (@ + 27.36) / 7.67
# compute in6 (4.33 * @) - 13.64 , (@ + 13.64) / 4.33


# Elite Group K7S5A board
#
compute in5 -(36/10)*@, -@/(36/10)
compute in6 -(56/10)*@, -@/(56/10)
#
compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)

set in0_min 1.5 * 0.95
set in0_max 1.5 * 1.05
set in1_min 2.4
set in1_max 2.6
set in2_min 3.3 * 0.95
set in2_max 3.3 * 1.05
set in3_min 5.0 * 0.95
set in3_max 5.0 * 1.05
set in4_min 12 * 0.95
set in4_max 12 * 1.05
set in5_max -12 * 0.95
set in5_min -12 * 1.05
set in6_max -5 * 0.95
set in6_min -5 * 1.05
set in7_min 5 * 0.95
set in7_max 5 * 1.05
#the chip does not support in8 min/max

# Temperature
#
# Important - if your temperature readings are completely whacky
# you probably need to change the sensor type.
# Adujst and uncomment the appropriate lines below.
#
# 2 = thermistor; 3 = thermal diode; 0 = unused
# set temp1_type 3
# set temp2_type 3
# set temp3_type 3
# If a given sensor isn't used, you will probably want to ignore it
# (see ignore statement right below).

ignore temp1
label temp1 "Temp 1"
set temp1_max 40
set temp1_min 15
label temp2 "M/B Temp"
set temp2_max 45
set temp2_min 15
label temp3 "CPU Temp"
set temp3_max 45
set temp3_min 15


[root@Fedora-Blue Dave]# sensors
it87-isa-0290
Adapter: ISA adapter
VCore 1: +1.68 V (min = +1.42 V, max = +1.58 V) ALARM
VCore 2: +2.46 V (min = +2.40 V, max = +2.61 V)
+3.3V: +3.33 V (min = +3.14 V, max = +3.47 V)
+5V: +4.92 V (min = +4.76 V, max = +5.24 V)
+12V: +12.10 V (min = +11.39 V, max = +12.61 V)
-12V: -12.38 V (min = -12.61 V, max = -11.40 V) ALARM
-5V: -6.36 V (min = -5.29 V, max = -4.75 V) ALARM
Stdby: +5.05 V (min = +4.76 V, max = +5.24 V)
VBat: +3.42 V
fan1: 2410 RPM (min = 0 RPM, div = 8)
fan2: 3183 RPM (min = 0 RPM, div = 8)
fan3: 0 RPM (min = 0 RPM, div = 2)
M/B Temp: +27.0?C (low = +15.0?C, high = +45.0?C) sensor = transistor
CPU Temp: +49.0?C (low = +15.0?C, high = +45.0?C) sensor = transistor



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
