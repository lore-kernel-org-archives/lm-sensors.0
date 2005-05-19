From: klein.hans@gmx.net (Hans-Joachim Klein)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: Motherboard Biostar MK7VB
Message-Id: <1041063578.6469.13.camel@linux>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I just installed lm_sensors 2.7.0 on my syste, (kernel: 2.4.18):

cat /proc/pci|grep VIA
Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 2).
PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev
0).
ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev
34).
IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
USB Controller: VIA Technologies, Inc. UHCI USB (rev 16).
USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 16).
Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
48).
Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 32).

BIOS output:
CPU-Temp	+27,1?C
CPU-Fan		4500 RPM
Vcore		1,68 V
VccSRAM		3,33 V
+3,3 V		3,35 V
+5 V		5,22 V
+12 V	       12,48 V

Sensors output:
via686a-isa-6000
Adapter: ISA adapter
Algorithm: ISA algorithm
CPU core:  +1.61 V  (min =  +1.79 V, max =  +2.18 V)   ALARM
+2.5V:     +0.23 V  (min =  +2.24 V, max =  +2.74 V)   ALARM
I/O:       +3.27 V  (min =  +2.95 V, max =  +3.62 V)
+5V:       +5.09 V  (min =  +4.47 V, max =  +5.49 V)
+12V:     +12.16 V  (min = +10.79 V, max = +13.18 V)
CPU Fan:  4530 RPM  (min = 3000 RPM, div = 2)
P/S Fan:     0 RPM  (min = 3000 RPM, div = 2)
SYS Temp:  +27.1?C  (limit =  +60?C, hysteresis =  +50?C)
CPU Temp: +146.2?C  (limit =  +60?C, hysteresis =  +50?C) ALARM
SBr Temp:  +23.9?C  (limit =  +60?C, hysteresis =  +50?C)

I did no changes to /etc/sensors.conf so far.

Output after changes to /etc/sensors.conf
via686a-isa-6000
Adapter: ISA adapter
Algorithm: ISA algorithm
CPU core:  +1.61 V  (min =  +1.98 V, max =  +2.49 V)   ALARM ???
I/O:       +3.27 V  (min =  +2.95 V, max =  +3.62 V)
+5V:       +5.09 V  (min =  +4.47 V, max =  +5.49 V)
+12V:     +12.16 V  (min = +10.79 V, max = +13.18 V)
CPU Fan:  4623 RPM  (min = 3994 RPM, div = 2)
P/S Fan:     0 RPM  (min = 3000 RPM, div = 2)
CPU Temp:  +37.8?C  (limit =  +45?C, hysteresis =  +40?C)

I couldn't figure out how the calculation for the CPU core works!
With best regards
Hans-J. Klein
Germany
-------------- next part --------------
# Sensors configuration file used by 'libsensors'
#------------------------------------------------
#
##########################################################################
#                                                                        #
#    PLEASE READ THIS HELPFUL HINT!!!                                    #
#                                                                        #
#       The 'set' lines (generally for min and max values)               #
#       do not take effect until you run 'sensors -s' as root !!!        #
#       We suggest you put 'sensors -s' in a /etc/rc.d/... file          #
#       to be run at boot time after the modules are inserted !!!        #
#                                                                        #
##########################################################################
#
#
# OVERVIEW
# --------
# This configuration file will be used by all userspace applications
# linked to libsensors. It is NOT used by the lm_sensors drivers directly.
#
# This config file consists of two parts: the heavily commented LM78
# example, and the real parts. Search for '####' if you want to skip
# to the real stuff.
#
# Hash marks introduce comments, which continue until the end of a line
#
# Identifiers consisting of only digits and letters can be used
# unquoted; other identifiers must be quoted. Escape characters within
# quotes operate like those in C.
#
#
# CHIP LINES
# ----------
# A 'chip' line specifies what the following 'label', 'compute', 'set' and
# 'ignore' lines refer to. In this case, until the
# next 'chip' line, everything refers to all lm78, lm78-j and lm79
# chips. Other examples are *-isa-* for everything on the ISA bus, and
# lm78-j-i2c-*-4e for all lm78-j chips on address 0x4e of any I2C bus.
#
# If more chip statements match a specific chip, they are all considered.
# Later lines overrule earlier lines, so if you set the in0 label for
# lm78-* to "This", and later on the in0 label for lm78-isa-* to "That",
# "That" is used for LM78 chips on the ISA bus, and "This" for LM78
# chips on a non-ISA bus.
#
#	chip "lm78-*" "lm78-j-*" "lm79-*"
#
#
# FEATURE NAMES
# -------------
# Feature names are used in 'label', 'compute', 'set', and 'ignore' lines.
# Example feature names are 'in0', 'temp2', 'in3_min', and 'temp3_over'.
# These features are defined for each chip in lib/chips.c.
#
# Undefined features will be silently ignored in 'label' and 'compute' lines.
# Undefined features in 'set' lines will result in 'Unknonw feature name'
# when running 'sensors -s'.
#
# Unfortunately, feature names starting with a number must be in
# double quotes or you get 'parse error, expecting 'NAME''.
#
# If you have trouble, verify the features in lib/chips.c!!!
#
#
# LABEL LINES
# -----------
# A label line describes what a certain feature stands for on your
# mainboard. Programs can retrieve these names and display them.
# If no label is specified for a certain feature, the default name
# (ie. 'fan1' for fan1) is used.
#
# If you specify a label for in1, this label is also used for in1_min and
# in1_max, unless they have their own labels declared. There are several
# of these logical groups.
#
# These are as advised in the LM78 and LM79 data sheets, and used on most
# boards we have seen.
#
#  	label in0 "VCore 1"
#  	label in1 "VCore 2"
#  	label in2 "+3.3V"
#  	label in3 "+5V"
#  	label in4 "+12V"
#  	label in5 "-12V"
#  	label in6 "-5V"
#
#
# COMPUTE LINES
# -------------
# A compute line describes how to scale a certain feature. There are
# two expressions in it: the first describes how the /proc value must
# be translated to a user value, the second how a user value must be
# translated to a /proc value. '@' is the value to operate on. You may
# refer to other readable features (like '2 * vid').
#
# Like for the label statement, there are logical groups here. They are
# sometimes a bit different, though. For example, fan1_div is in the
# logical label group of fan1 (it gets the same label if none is declared
# for it), but it is not in the compute group of fan1 (as it uses a
# completely different system of values).
#
#
# VOLTAGE COMPUTATION DETAILS
# ---------------------------
# Most voltage sensors in sensor chips have a range of 0 to 4.096 Volts.
# This is generally sufficient for the 3.3 and CPU (2.5V, for example)
# supply voltages, so the sensor chip reading is the actual voltage.
#
# Other supply voltages must be scaled with an external resistor network.
# The chip driver generally reports the 'raw' value 0 - 4.09 V, and the
# userspace application must convert this raw value to an actual voltage.
# The 'compute' lines provide this facility.
#
# Unfortunately the resistor values vary among motherboard types.
# Therefore you may have to adjust the computations in this file
# to match your motherboard.
#
# For positive voltages (in3, in4), two resistors are used, with the following
# formula (R1,R2: resistor values, Vs: read voltage, Vin: pin voltage)
#	R1 = R2 * (Vs/Vin - 1)
# For negative voltages (in5, in6) two resistors are used, with the following
# formula (Rin,Rf: resistor values, Vs: read voltage, Vin: pin voltage)
#	Rin = (Vs * Rf) / Vin
#
# Note: Some chips use a different formula, see it87 section for example.
#
# Here are the official LM78 and LM79 data sheet values.
# 	      Vs     R1,Rin   R2,Rf    Vin
# 	in3   +5.0      6.8    10     +2.98
# 	in4  +12.0     30      10     +3.00
# 	in5  -12.0    240      60     +3.00
# 	in6   -5.0    100      60     +3.00
#
# These would lead to these declarations:
# 	compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
# 	compute in4 ((30/10)+1)*@  ,  @/((30/10)+1)
# 	compute in5 -(240/60)*@    ,  -@/(240/60)
# 	compute in6 -(100/60)*@    ,  -@/(100/60)
#
# On almost any mainboard we have seen, the Winbond compute values lead to
# much better results, though.
#
# 	      Vs     R1,Rin   R2,Rf    Vin
# 	in4  +12.0     28      10     +3.00
# 	in5  -12.0    210      60.4   +3.00
# 	in6   -5.0     90.9    60.4   +3.00
#
# These leads to these declarations:
#  	compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
#  	compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
#  	compute in5 -(210/60.4)*@  ,  -@/(210/60.4)
#  	compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)
#
#
# SET LINES
# ---------
# Set statements set things like limits. Complete expressions can be
# used. Not everything can sensibly be set: setting 'in0', for example,
# is impossible! These settings are put through the compute translations;
# so if we specify '12.8' for in6, '3.2' will actually be written!
#
# Important note: In the 'sensors' program, these only take effect
# after running 'sensors -s'!!!
#
# Here are some examples:
#
#	set in0_max vid*1.05
#	set in0_min vid*0.95
#	set temp1_over 40
#	set temp1_hyst 37
#
# Think of tempx_over as 'alarm set' and tempx_hyst as 'alarm clear'
# thresholds. In most cases the 'over' value should be higher than
# the 'hyst' value by several degrees.
#
#
# IGNORE LINES
# ------------
# Ignore statements tell certain features are not wanted. User programs can
# still read them if they really want, though; this is just an advisory
# marking. 'in0' would also invalidate 'in0_max' and 'in0_min'.
# 'ignore' does not disable anything in the actual sensor chip; it
# simply advises the user program to not access that data.
#
#	ignore in0
#
#
# STATEMENT ORDER
# ---------------
# Statements can go in any order, EXCEPT that some statements depend
# on others. Dependencies could be either in the library or the driver.
# A 'compute' statement must go before a 'set' statement
# for the same feature or else the 'set' won't be computed correctly.
# This is a library dependency.
# A 'set fan1_div' statement must go before a 'set fan1_min' statement,
# because the driver uses the divisor in calculating the minimum.
#
#
# BUS LINES
# ---------
# There is one other feature: the 'bus' statement. An example is below.
#
#	bus "i2c-0" "SMBus PIIX4 adapter at e800" "Non-I2C SMBus adapter"
#
# If we refer from now on to 'i2c-0' in 'chip' lines, this will run-time
# be matched to this bus. So even if the PIIX4 is called 'i2c-5' at that
# moment, because five other adapters were detected first, 'i2c-0' in
# the config file would always only match this physical bus. In the above
# config file, this feature is not needed; but the next lines would
# only affect the LM75 chips on the PIIX4 adapter:
#
#	chip "lm75-i2c-0-*"
#
# You should really use the output of /proc/bus/chips to generate bus lines,
# because one mistyped characted will inhibit the match. Wildcards are not
# yet supported; spaces at the end are ignored, though.
#
#
##########################################################################
#### Here begins the real configuration file

# Motherboard BIOSTAR MKV7B

chip "via686a-*"

# VIA is very specific about the voltage sensor inputs, and our labels
# reflect what they say.  Unfortunately, they are not at all specific about
# how to convert any of the register values to real units.  Fortunately,
# Jonathan Yew <j.teh@iname.com> and Alex van Kaam <darkside@chello.nl>
# came through with some data for temp conversion and formulae for voltage
# conversion. However, the conversions should be regarded as our best guess-
# YMMV.

# On the Tyan S1598, the 2.5V sensor reads 0 and is not displayed in the BIOS.
# Linas Vepstas <linas@linas.org> reports that this sensor shows nothing of
# interest on the Abit KA7 (Athlon), and is also not displayed in the BIOS.
# Likewise, Johannes Drechsel-Burkhard <jdb@chello.at> reports that this
# sensor is unavailable in the BIOS of his MSI K7T Pro (Thunderbird).  So,
# if you have one of these boards you may want to uncomment the 'ignore 2.5V'
# line below.

    label "2.0V" "CPU core"
    label "2.5V" "+2.5V"
    ignore "2.5V"
    label "3.3V" "I/O"
    label "5.0V" "+5V"
    label "12V" "+12V"

    label fan1  "CPU Fan"
    label fan2  "P/S Fan"

# VIA suggests that temp3 is an internal temp sensor for the 686a.  However,
# on the Tyan S1598 as well as the Abit KA7 (Athalon), the absolute values
# of the readings from that sensor are not valid.  The readings do seem to
# correlate with temp changes, but the conversion factor may be quite
# different from temp1 & temp2 (as noted above, VIA has not provided
# conversion info).  So, you may wish to 'ignore temp3'.

# Johannes Drechsel-Burkhard <jdb@chello.at> notes that on his MSI K7T Pro,
# temp1 is the CPU temp and temp2 is the SYS temp.

    label temp1 "CPU Temp"
    label temp2 "SYS Temp"
    ignore temp2
    label temp3 "SBr Temp"
    ignore temp3

# Set your CPU core limits here.  For the other voltage sensors, the
# built-in defaults should be fine.

    set in0_min 2.0
    set in0_max 2.5

# Set your temp limits here.  Remember, 'tempX_over' is the temp at which an
# alarm is triggered, and 'tempX_hyst' is the temp at which an alarm turns off.
# Setting tempX_hyst to a few degrees below the corresponding tempX_over
# prevents an oscillation between alarm on and off states.  This kind of
# oscillation is known as hyteresis, thus the name.  (You typically get the
# most serious and troublesome hysteresis when a sensor triggers something to
# reduce the temp, thus creating a negative feedback loop.  Even without that,
# we would still get some oscillation when the temp hovers around the limit
# due to noise.)

    set temp1_hyst 40
    set temp1_over 45
    set temp2_hyst 55
    set temp2_over 60
    set temp3_hyst 60
    set temp3_over 65

# You could set your fan limits too, but the defaults should be fine.

    set fan1_min 4000
    #set fan2_min 5000

# For at least one Tyan S1598, the following corrections make the sensors
# readings more in-line with the BIOS readings on boot.  Try these, and
# adjust as necessary.

  #compute "2.0V" 1.02*@ ,  @/1.02
  #compute "3.3V" 1.02*@  ,  @/1.02
  #compute "5.0V" 1.009*@  ,  @/1.009
  #compute "12V" 1.04*@ ,  @/1.04

