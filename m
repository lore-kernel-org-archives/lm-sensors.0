From: dcstar@acslink.net.au (David Clayton)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Sample sensors.conf for GigaByte GA-7VM400M
Message-Id: <1106019864.3649.3.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This seems to work well for my m/b, (which uses the VIA KM400 chipset).

-- 
Regards, David.

David Clayton, e-mail: dcstar@acslink.net.au
Melbourne, Victoria, Australia.

Dilbert's words of wisdom #18: Never argue with an idiot. They drag you
down to their level then beat you with experience.
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
# The following operators are valid: + - * / ( ) ^ `
# ^ is e**x and ` is ln(x) (valid in library version 2.0.0 /
# lm_sensors 2.8.0 or higher)
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
# Also, one should set vrm prior to using vid in any formula.
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
# BEEPS
# -----
# Some chips support alarms with beep warnings. When an alarm is triggered
# you can be warned by a beeping signal through your computer speaker. It
# is possible to enable beeps for all alarms on a chip using the following 
# line:
#
# 	set beep_enable 1
#
# or disable them using:
#
# 	set beep_enable 0
#
##########################################################################
#### Here begins the real configuration file

chip "it87-*"

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
    ignore in5
    ignore in6
    ignore in8

    set in0_min 1.5 * 0.95
    set in0_max 1.7 * 1.05
    set in1_min 1.2
    set in1_max 1.3
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.95
    set in4_max 12 * 1.10
    set in5_max -12 * 0.95
    set in5_min -12 * 1.05
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    #the chip does not support in8 min/max

    # vid is not monitored by IT8705F
    # and is not supported by driver at this time
    ignore  vid

# Incubus Saturnus reports that the IT87 chip on Asus A7V8X-X seems
# to report the VCORE voltage approximately 0.05V higher than the board's
# BIOS does. Although it doesn't make much sense physically, uncommenting
# the next line should bring the readings in line with the BIOS' ones in
# this case.
# compute in0 -0.05+@ , @+0.05

# If 3.3V reads 2X too high (Soyo Dragon and Asus A7V8X-X, for example),
# comment out following line.
#   compute in2   2*@ , @/2
#
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
# For this family of chips the negative voltage equation is different from
# the lm78.  The chip uses two external resistor for scaling but one is
# tied to a positive reference voltage.  See ITE8705/12 datasheet (SIS950
# data sheet is wrong)
# Vs = (1 + Rin/Rf) * Vin - (Rin/Rf) * Vref.
# Vref = 4.096 volts, Vin is voltage measured, Vs is actual voltage.

# The next two are negative voltages (-12 and -5).
# The following formulas must be used. Unfortunately the datasheet
# does not give recommendations for Rin, Rf, but we can back into
# them based on a nominal +2V input to the chip, together with a 4.096V Vref.
# Formula:
#    actual V = (Vmeasured * (1 + Rin/Rf)) - (Vref * (Rin/Rf))
#    For -12V input use Rin/Rf = 6.68
#    For -5V input use Rin/Rf = 3.33
# Then you can convert the forumula to a standard form like:
    compute in5 (7.67 * @) - 27.36  ,  (@ + 27.36) / 7.67
    compute in6 (4.33 * @) - 13.64  ,  (@ + 13.64) / 4.33
#
# this much simpler version is reported to work for a
# Elite Group K7S5A board
#
#   compute in5 -(36/10)*@, -@/(36/10)
#   compute in6 -(56/10)*@, -@/(56/10)
#
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# Temperature
#
# Important - if your temperature readings are completely whacky
# you probably need to change the sensor type.
# Adujst and uncomment the appropriate lines below.
# The old method (modprobe it87 temp_type=0xXX) is no longer supported.
#
# 2 = thermistor; 3 = thermal diode; 0 = unused
#   set sensor1 3
#   set sensor2 3
#   set sensor3 3
# If a given sensor isn't used, you will probably want to ignore it
# (see ignore statement right below).

    label temp1       "Power/Aux"
    set   temp1_over  70
    set   temp1_low   15
    label temp2       "M/B"
    set   temp2_over  60
    set   temp2_low   15
#   ignore temp3
    label temp3       "CPU"
    set   temp3_over  80
    set   temp3_low   15

# The A7V8X-X has temperatures inverted, and needs a conversion for
# CPU temp. Thanks to Preben Randhol for the formula.
#   label temp1       "CPU Temp"
#   label temp2       "M/B Temp"
#   compute temp1     (-15.096+1.4893*@), (@+15.096)/1.4893

# The A7V600 also has temperatures inverted, and needs a different
# conversion for CPU temp. Thanks to Dariusz Jaszkowski for the formula.
#   label temp1       "CPU Temp"
#   label temp2       "M/B Temp"
#   compute temp1     (@+128)/3, (3*@-128)

# Fans
    label fan1        "CPU Fan"
    set fan1_min 3000
    ignore fan2
    set fan2_min 3000
    ignore fan3
    set fan3_min 3000
