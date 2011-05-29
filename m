From: Arseny Klimovsky <arseny.klimovsky@gmail.com>
Date: Sun, 29 May 2011 13:47:18 +0000
Subject: Re: [lm-sensors] Testing results for Nuvoton W83677HG-I
Message-Id: <4DE24E66.40604@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DD783EB.5010606@gmail.com>
In-Reply-To: <4DD783EB.5010606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Guenter Roeck пишет:
> Hi Arseny,
>
> On Sat, May 21, 2011 at 05:20:43AM -0400, Arseny Klimovsky wrote:
>> Hello list,
>>
>> I've tested a driver at http://www.roeck-us.net/linux/drivers/w83627ehf/
>> with my motherboard Intel DH67BL.
>>
>> I'm not sure what exactly should be tested, I'm most interested in fan
>> speeds.
>> They are correct, values are practically the same like in BIOS.
>> On my board fan1 is rear fan, fan2 is CPU fan and fan3 is front fan.
>>
> Fan speed is the most interesting at this point, since I could not test
> that myself.
>
> Thanks a lot for the feedback!
>
> Guenter
With this driver I created a configuration for my board. It can be added 
to wiki, but I have some questions:
1. Multiplier for +12V is strange (11), but it gets exactly correct 
results (12.14V switching to 12.23V and back). Can this be correct?
2. Statement "ignore temp5" does not take effect. I see line about "PECI 
Agent 1"

The sensors output with the config:

nct6775-isa-0290
Adapter: ISA adapter
Vcore: +1.06 V (min = +0.60 V, max = +1.60 V)
+12V: +12.14 V (min = +11.09 V, max = +12.94 V)
AVCC: +3.41 V (min = +2.98 V, max = +3.63 V)
+3.3V: +3.41 V (min = +2.98 V, max = +3.63 V)
+5V: +5.04 V (min = +4.60 V, max = +5.40 V)
MemV: +1.56 V (min = +0.40 V, max = +2.00 V)
PCHV: +1.06 V (min = +0.60 V, max = +1.60 V)
3VSB: +3.39 V (min = +2.98 V, max = +3.63 V)
Vbat: +3.28 V (min = +2.70 V, max = +3.30 V)
Rear fan: 727 RPM (min = 251 RPM, div = 32)
CPU fan: 917 RPM (min = 251 RPM, div = 32)
Front fan: 740 RPM (min = 251 RPM, div = 32)
VR temp: +35.0°C (high = +90.0°C, hyst = +75.0°C) sensor = diode
CPU temp: +35.5°C (high = +93.0°C, hyst = +75.0°C) sensor = diode
Memory DIMM temp: +34.5°C (high = +90.0°C, hyst = +75.0°C) sensor = diode
PCH temp: +47.0°C
PECI Agent 1: +0.0°C (high = +80.0°C, hyst = +75.0°C)

The configuration:

# Created for board DH67BL using information from Inte Desktop Utilities 
and BIOS
# "FRONT" and "REAR" fan labels correspond to the motherboard
# headers, but not necessarily the actual fan locations.

chip "nct6775-isa-0290"

# Fans
label fan1 "Rear fan"
set fan1_min 250 # From IDU

label fan2 "CPU fan"
set fan2_min 250 # From IDU

label fan3 "Front fan"
set fan3_min 250 # From IDU

# There is no fan4 on the board
ignore fan4

# Voltages

# Processor Vcc
label in0 "Vcore"
set in0_min 0.6 # From IDU
set in0_max 1.6 # From IDU

# This should be "12 Volts", but computations are strange
label in1 "+12V"
compute in1 11*@, @/11
set in1_min 11.1 # From IDU
set in1_max 12.9 # From IDU

# AVCC(?) - Not shown in BIOS or IDU
label in2 "AVCC"
set in2_min 3.0 # same as +3.3V
set in2_max 3.6 # same as +3.3V

# +3.3 Volts
label in3 "+3.3V"
set in3_min 3.0 # from IDU
set in3_max 3.6 # from IDU

# +5 Volts
label in4 "+5V"
compute in4 5*@, @/5
set in4_min 4.6 # from IDU
set in4_max 5.4 # from IDU

# Memory Vcc ("SDRAM Vcc" in IDU)
label in5 "MemV"
compute in5 1.5*@, @/1.5
set in5_min 0.4 # from IDU
set in5_max 2.0 # from IDU

# PCH Vcc
label in6 "PCHV"
set in6_min 0.6 # from IDU
set in6_max 1.6 # from IDU

# +3.3 Volt Standby
label in7 "3VSB"
set in7_min 3.0 # from IDU
set in7_max 3.6 # from IDU

# VBAT(?) - Not shown in BIOS or IDU
label in8 "Vbat"

# It shows +2.050 V, seems to be not used
ignore cpu0_vid

# Temperatures

# Labeled as "SYSTIN"
# Guess!
label temp1 "VR temp"
set temp1_max 90 # From IDU
set temp1_max_hyst 75
# Labeled as "CPUTIN"
label temp2 "CPU temp"
set temp2_max 93 # From IDU
set temp2_max_hyst 75
# Labeled as "PECI Agent 0"
# Guess!
label temp3 "Memory DIMM temp"
set temp3_max 90 # From IDU
set temp3_max_hyst 75
# Labeled as "PCH_CHIP_TEMP"
label temp4 "PCH temp"

# Labeled as "PECI Agent 1"
# Not used
ignore temp5

-- 
Arseny Klimovsky



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
