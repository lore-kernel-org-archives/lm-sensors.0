From: Vojtech Pavlik <vojtech@suse.cz>
Date: Wed, 17 Dec 2014 10:21:26 +0000
Subject: [lm-sensors] Collection of config files
Message-Id: <20141217102126.GA20562@suse.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I'm posting my collection of config files that I've created for a number
of machines I'm running. They may or may not be useful.

-- 
Vojtech Pavlik
Director SUSE Labs

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors3-ASUS-K8N-E-Deluxe.conf"

chip "it8712-*" 

    label in0 "Vcore" 
    set in0_min 1.1 * 0.95 
    set in0_max 1.5 * 1.05 

    ignore in1 

    label in2 "+3.3V" 
    set in2_min 3.3 * 0.95 
    set in2_max 3.3 * 1.05 

    label in3 "+5V" 
    compute in3 @*1.68,@/1.68
    set in3_min 5.0 * 0.95 
    set in3_max 5.0 * 1.05 

    label in4 "+12V" 
    compute in4 @*4,@/4
    set in4_min 12 * 0.95 
    set in4_max 12 * 1.05 

    ignore in5 
    ignore in6 
    ignore in7 

    label in8 "Vbat" 

    label temp1       "CPU Temp" 
    label temp2       "MB Temp" 
    ignore temp3 

    label fan1 "CPU Fan"
    set fan1_min 0 
    label fan2 "Sys Fan"
    set fan2_min 0 

    ignore intrusion0

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors3-ASUS-P9D-I.conf"

chip "acpitz-virtual-*"
ignore temp1
ignore temp2

chip "nct6779-*"

label  in0   "Vcore"
set in0_min	1.7 * 0.95
set in0_max	1.7 * 1.05
label  in1   "+12V"
compute  in1  @*12,@/12
set in1_min  12   * 0.95
set in1_max  12   * 1.05
label  in2   "AVCC"
ignore in2
set in2_min   3.3 * 0.95
set in2_max   3.3 * 1.05
label  in3   "+3.3V"
set in3_min   3.3 * 0.95
set in3_max   3.3 * 1.05
label  in4   "+5V"
compute  in4  @*5,@/5
set in4_min   5   * 0.95
set in4_max   5   * 1.05
ignore in5
ignore in6
label  in7   "3Vsb"
set in7_min   3.3 * 0.95
set in7_max   3.3 * 1.05
label  in8   "Vbat"
set in8_min   3.00
set in8_max   3.60
label  in9   "Vtt"
set in9_min   0.89
set in9_max   1.74
ignore in10
ignore in11
label  in12  "Vddq"
set in12_min   1.5 * 0.95
set in12_max   1.5 * 1.05
ignore in13
ignore in14
label  fan1   "Rear Fan"
ignore fan1
label  fan2   "CPU Fan"
set fan2_min	1000
label  fan3   "Front Fan 1"
ignore fan3
label  fan4   "Front Fan 2"
ignore fan4
label  fan5   "Front Fan 3"
ignore fan5
label  temp1  "MB Temp"
set temp1_max       70
set temp1_max_hyst  40
label  temp2  "CPU Temp"
ignore temp3
ignore temp4
ignore temp5
ignore temp6
ignore temp7
ignore temp8
ignore temp9
ignore temp10

ignore intrusion0 
ignore intrusion1
ignore beep_enable

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors3-Fujitsu-Scenic-E600.conf"

# module fschmd

chip "fscher-*"

# Temperature
    label temp1       "CPU Temp"
    label temp2       "MB Temp"
    ignore temp3

    label fan1        "PS Fan"
    label fan2        "CPU Fan"
    ignore fan3

# Voltage
    label in0         "+12V"
    label in1         "+5V"
    label in2         "Vbat"

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors3-GA-Z87MX-D3H.conf"

chip "acpitz-virtual-0"
#    ignore temp1 # stays always at 27.8 degrees C
#    ignore temp2 # stays always at 29.8 degrees C


chip "it8728-*"

    label in0 "Vtt"		# Unused
    ignore in0 			# BIOS reports a reasonable voltage >1V, but
				# this reading shows random values
				# between 0V-1V, so something is wrong

    label in1 "+3.3V"		# looks correct
    set in1_min 3.3 * 0.95
    set in1_max 3.3 * 1.05
    compute in1 @*1.649,@/1.649	# multiplier fits with other GA mainboards

    label in2 "+12V"		# verified
    set in2_min 12 * 0.95
    set in2_max 12 * 1.05
    compute in2 @*6,@/6

    label in3 "+5V"		# verified
    set in3_min 5 * 0.95
    set in3_max 5 * 1.05
    compute in3 @*2.5,@/2.5

    label in4 "Vaxg"		# Unused on Haswell, reports 0V
    ignore in4			# BIOS also reports 0V

    label in5 "Vcore"		# Input to Haswell CPU VR (1.8V nominal)
    set in5_min 1.8 * 0.95
    set in5_max 1.8 * 1.05

    label in6 "Vdram"		# probably correct (1.5V nominal)
    set in6_min 1.5 * 0.95
    set in6_max 1.5 * 1.05
     
    label in7 "+3Vsb"		# defined by datasheet
    set in7_min 3.3 * 0.95
    set in7_max 3.3 * 1.05

    label in8 "Vbat"		# defined by datasheet

### fan

    label fan1 "CPU1 fan"

    label fan2 "Sys1 fan"

    label fan3 "Sys2 fan"

    label fan4 "Sys3 fan"

    label fan5 "CPU2 fan"	# called CPU OPT fan

### temperatures

    label temp1 "System temp"
    set temp1_min 10
    set temp1_max 60

    label temp2 "PCH temp"   
    set temp2_min 10
    set temp2_max 60

    label temp3 "CPU temp"	# offset needed probably because of PECI reporting 
    set temp3_min 10		# a safe margin insteas of raw temperature
    set temp3_max 85
    compute temp3 @+12,@-12

    ignore intrusion0

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors3-Intel-D2500CC.conf"

chip "w83627uhg-*"

    label in0 "Vcore"		# 0.91-1.21V VID range
    set in0_min 0.85
    set in0_max 1.25

    label in1 "+3.3V"
    set in1_min  3.3 * 0.95
    set in1_max  3.3 * 1.05
    compute in1 @*3.2,@/3.2

    label in2 "AVcc"
    set in2_min  5.0 * 0.95
    set in2_max  5.0 * 1.05
    ignore in2			# Tied to +5VSB anyway

    label in3 "+5V"
    set in3_min  5.0 * 0.95
    set in3_max  5.0 * 1.05

    label in4 "+12V"
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05
    compute in4 @*12,@/12

    label in5 "Vdimm"
    set in5_min  1.5 * 0.95
    set in5_max  1.5 * 1.05

    label in7 "+5Vsb"
    set in7_min  5.0 * 0.95
    set in7_max  5.0 * 1.05

    label in8 "Vbat"
    set in8_min  3.0
    set in8_max  3.6

    label temp1 "CPU temp"
    set temp1_max 90
    set temp1_max_hyst 75

    label temp2 "MB temp"
    set temp2_max 45
    set temp2_max_hyst 30

    label fan1 "Sys fan"
    set fan1_min 300

    ignore fan2			# Unused

    label intrusion0 "Intrusion"
    ignore intrusion0		# Untested

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors3-Intel-D945GSEJT.conf"

chip "coretemp-isa-*"
    compute temp2 @+25,@-25	# Wrong Tj offset

chip "w83627dhg-*"


    label in0 "Vcore"
    set in0_min 0.85
    set in0_max 1.30

    label in1 "+5V"
    compute in1 @*3.2,@/3.2
    set in1_min 5*0.95
    set in1_max 5*1.05

    label in2 "AVcc"	
    set in2_min 3.3*0.95
    set in2_max 3.3*1.05
    ignore in2			# Tied to +3Vsb anyway

    label in3 "+3Vcc"
    set in3_min 3.3*0.95
    set in3_max 3.3*1.05
    ignore in3			# Tied to +3Vsb anyway

    label in4 "+12V"
    compute in4 @*6.6,@/6.6
    set in4_min 12*0.95
    set in4_max 12*1.05

    label in5 "+3.3V"
    compute in5 @*2.8,@/2.8
    set in5_min 3.3*0.95
    set in5_max 3.3*1.05

    label in6 "+5Vsb"
    compute in6 @*3.2,@/3.2
    set in6_min 5*0.95
    set in6_max 5*1.05

    label in7 "+3.3Vsb"
    set in7_min 3.3*0.95
    set in7_max 3.3*1.05

    label in8 "Vbat"
    set in8_min 3.0
    set in8_max 3.6
	
    ignore fan1			# Unused

    label fan2 "System fan"
    set fan2_min 500

    ignore fan3			# Unused
    ignore fan4			# Unused
    ignore fan5			# Unused

    label temp1 "MB temp"
    set temp1_max 45
    set temp1_max_hyst 30

    label temp2 "CPU temp"
    set temp2_max 90
    set temp2_max_hyst 75

    ignore temp3		# Not connected

    ignore cpu0_vid		# Always says 0V

    label intrusion0 "Intrusion"
    ignore intrusion0		# Who connects that?

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors3-Intel-DCP847SKE.conf"

chip "nct6776-*"

    label in0 "Vcore"		# 0.80V @800MHz, 1.0V @1100MHz
    set in1_min 0.75
    set in1_max 1.05

    label in1 "Vdimm"		# 1.5V normal, 1.35V LV-DIMM
    set in1_min  1.5 * 0.95
    set in1_max  1.5 * 1.05

    label in2 "AVcc"		# Analog filtered voltage for
    set in2_min  3.3 * 0.95	# superio sensor
    set in2_max  3.3 * 1.05
    ignore in2			# Tied to +3.3V anyway

    label in3 "+3.3V"
    set in3_min  3.3 * 0.95
    set in3_max  3.3 * 1.05

    label in4 "+5V"
    compute in4 @*5,@/5
    set in4_min  5 * 0.90	# Relaxed limits to 10%
    set in4_max  5 * 1.10	# Voltage above otherwise

    ignore in5			# Unused

    label in6 "+12V"		# Could be swapped with 5V
    compute in6 @*12,@/12
    set in6_min  12 * 0.95
    set in6_max  12 * 1.05

    label in7 "+3Vsb"
    set in7_min  3.3 * 0.95
    set in7_max  3.3 * 1.05

    label in8 "Vbat"		# Lithium battery volatge
    set in8_min  3.0
    set in8_max  3.6

    ignore fan1			# Unused

    label fan2 "CPU fan"
    set fan2_min 1000

    label temp1 "CPU temp"
    set temp1_max 90
    set temp1_max_hyst 75

    ignore temp2		# Unused

    label temp3 "Ambient"	# Inlet air temperature
    set temp3_max 45
    set temp3_max_hyst 30

    ignore temp4		# Unused
    ignore temp5		# Unused
    ignore temp6		# Unused
    ignore temp7		# Unused
    ignore temp8		# Unused
    ignore temp9		# Unused
    ignore temp10		# Unused

    ignore intrusion0		# Untested
    ignore intrusion1		# Untested

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors3-Intel-DN2800MT.conf"

chip "w83627dhg-*"

    label in0 "Vcore"
    set in0_min 0.75 * 0.99
    set in0_max 1.21 * 1.01
   
    label in1 "+12V"
    compute in1 12*@, @/12
    set in1_min 12 * 0.95
    set in1_max 12 * 1.05

    label in2 "AVcc"
    set in3_min 3.3 * 0.95
    set in3_max 3.3 * 1.05
    ignore in2			# Tied to Vcc/3.3V
   
    label in3 "+3.3V"
    set in3_min 3.3 * 0.95
    set in3_max 3.3 * 1.05
   
    label in4 "+5V"
    compute in4 5*@, @/5
    set in4_min 5.0 * 0.95
    set in4_max 5.0 * 1.05
   
    label in5 "Vdimm"
    set in5_min 1.5 * 0.95
    set in5_max 1.5 * 1.05
   
    label in6 "Vpch"
    set in6_min 1.05 * 0.95
    set in6_max 1.05 * 1.05
   
    label in7 "+3Vsb"
    set in7_min 3.3 * 0.95
    set in7_max 3.3 * 1.05

    label in8 "Vbat"
    set in8_min 3.0
    set in8_max 3.6

    label temp1 "MB temp"
    set temp1_max 80
    set temp1_max_hyst 75
   
    ignore temp2		 # Always on 110.5 - unconnected
   
    label temp3 "CPU temp"
    set temp3_max 80
    set temp3_max_hyst 75
   
    label fan1 "PWM fan" 
    set fan1_min 0		# Passive design
    label fan2 "System fan"
    set fan2_min 0		# Passive design
   
    ignore fan3			# Unconnected
    ignore fan4			# Unconnected
    ignore fan5			# Unconnected
   
    ignore cpu0_vid		# Always reports 0
    ignore intrusion0

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors3-PCEngines-ALIX2.conf"

# module scx200_acb
# module lm90

chip "lm86-*"
   label temp1 "MB Temp"
   label temp2 "CPU Temp"

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors3-Supermicro-X7SPA-HF.conf"

chip "w83627dhg-*"

    label in0 "Vcore"
    set in0_min 0.72
    set in0_max 1.39

    label in1 "Vich"
    set in1_min  1.05 * 0.95
    set in1_max  1.05 * 1.05

    label in2 "AVcc"		# Tied to 3Vcc
    set in2_min  3.3 * 0.95
    set in2_max  3.3 * 1.05
    ignore in2

    label in3 "+3.3V"		# 3Vcc
    set in3_min  3.3 * 0.95
    set in3_max  3.3 * 1.05

    label in4 "Vdimm"
    set in4_min  1.5 * 0.95
    set in4_max  1.5 * 1.05

    label in5 "+5V"
    compute in5 @*4,@/4
    set in5_min  5 * 0.95
    set in5_max  5 * 1.05

    label in6 "+12V"
    compute in6 @*6.625,@/6.625
    set in6_min 12 * 0.95
    set in6_max 12 * 1.05

    label in7 "+3.3Vsb"
    set in7_min  3.3 * 0.95
    set in7_max  3.3 * 1.05

    label in8 "Vbat"
    set in8_min  3.0
    set in8_max  3.6

    label fan1 "CPU fan"
    set fan1_min 0
    label fan2 "Sys fan"
    set fan2_min 0

    ignore fan3
    ignore fan4
    ignore fan5

    label temp1 "MB temp"
    set temp1_max 60
    set temp1_max_hyst 45

    label temp2 "CPU temp"
    set temp2_max 90
    set temp2_max_hyst 75

    label temp3 "Ambient"
    set temp3_max 45
    set temp3_max_hyst 30

    ignore cpu0_vid		# Reads always 0.0V

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors3-Supermicro-X9SRH-7F.conf"

chip "nct6776-*"


    label in0 "Vcore"
    set in0_min 0.55
    set in0_max 1.50

    label in1 "+12V"
    compute in1 @*6.625,@/6.625
    set in1_min 12 * 0.95
    set in1_max 12 * 1.05

    label in2 "AVCC"
    set in2_min  3.3 * 0.95
    set in2_max  3.3 * 1.05
    ignore in2			# Tied to 3Vsb

    label in3 "+3.3V"
    set in3_min  3.3 * 0.95
    set in3_max  3.3 * 1.05

    label in4 "Vdimm"
    set in4_min 1.5 * 0.95
    set in4_max 1.5 * 1.05

    label in5 "+5V"
    compute in5 @*4,@/4
    set in5_min 5 * 0.95
    set in5_max 5 * 1.05

    ignore in6			# Disabled

    label in7 "3Vsb"
    set in7_min  3.3 * 0.95
    set in7_max  3.3 * 1.05

    label in8 "Vbat"
    set in8_min  3.0
    set in8_max  3.6

    ignore fan1
    ignore fan2

    label fan3 "Fan 1"

    label fan4 "Fan 2"

    ignore fan5

    label temp1 "Peripheral temp"
    set temp1_max 60
    set temp1_max_hyst 45
    label temp2 "System temp"
    set temp2_max 60
    set temp2_max_hyst 45
    label temp3 "Ambient"	# Maybe fixed

    ignore temp4
    ignore temp5
    ignore temp6

    ignore cpu0_vid

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--SLDf9lqlvOQaIe6s--
