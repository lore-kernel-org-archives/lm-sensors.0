From: list0570@paradise.net.nz (Volker Kuhlmann)
Date: Mon, 31 Oct 2005 01:08:10 +0000
Subject: [lm-sensors] PC Chips M810LR sensors.conf
Message-Id: <20051031000720.GG26397@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok this is old stuff, but it's a neat box for home LANs.
These are functional settings for this main moard.
Changes needed from the 

* delete the whole   chip "it87-*" "it8712-*"  section
* forget about it87 module options
* sensors-detect works like a charm
* in0 voltage is 1.5, not 1.7
* no fan3, and fan2 unconnected or no speed info
* no temp3
* temp1 and temp2 labels need to be swapped
* missing temp low and over values added
* all values verified against BIOS hardware monitor
* SUSE 10.0 out of the box, kernel 2.6.13, sensors 2.9.1


# The following is for a PC Chips main board model M810LR, PCB Rev 5.0,
# which uses a IT8705F for monitoring with the SIS630.
# BIOS identifier:  AMI BIOS, ..... -SiS730S-M810LR-H
# Note modprobe it87 no longer has a temp_type option.
# Delete or comment out above it87 sections and uncomment the following.
# This is based on the "Inside Technologies 786LCD which uses either a IT8705F
# or a SIS950 for monitoring with the SIS630".
chip "it87-*"
    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "3.3 Stdby"
    label in6 "-12V"
    label in7 "5 Stdby"
    label in8 "VBat"
   # in0 will depend on your processor VID value, set to voltage specified in
   # bios setup screen   (Does this apply to my board? What's vid?)
    set in0_min 1.5 * 0.95
    set in0_max 1.5 * 1.05
    set in1_min 2.4
    set in1_max 2.6
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_min 3.3 * 0.95
    set in5_max 3.3 * 1.05
    set in6_max -12 * 0.90
    set in6_min -12 * 1.10
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
   # vid not monitored by IT8705F
    ignore  vid
   # computations
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
    compute in6 (1+232/56)*@ - 4.096*232/56, (@ + 4.096*232/56)/(1+232/56)
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
   # Temperature
    label temp1       "Sys Temp"
    set   temp1_over  40
    set   temp1_low   15
    label temp2       "CPU Temp"
    set   temp2_over  45
    set   temp2_low   15
    ignore temp3
   # Fans
    set fan1_min 3000
    set fan2_min 0
    ignore fan3


it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.50 V  (min =  +1.42 V, max =  +1.57 V)
VCore 2:   +2.50 V  (min =  +2.40 V, max =  +2.61 V)
+3.3V:     +3.46 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.11 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +12.48 V  (min = +10.82 V, max = +13.18 V)
3.3 Stdby: +3.39 V  (min =  +3.14 V, max =  +3.47 V)
-12V:     -11.87 V  (min = -13.18 V, max = -10.80 V)
5 Stdby:   +4.95 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.38 V
fan1:     4927 RPM  (min = 2657 RPM, div = 2)
fan2:        0 RPM  (min =    0 RPM, div = 2)
Sys Temp:    +27?C  (low  =   +15?C, high =   +40?C)   sensor = thermistor
CPU Temp:    +38?C  (low  =   +15?C, high =   +45?C)   sensor = thermistor

eeprom-i2c-0-51
Adapter: SMBus SIS630 adapter at 5080
Memory type:            SDR SDRAM DIMM
Memory size (MB):       256


Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.
