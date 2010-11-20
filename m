From: no tellin <no.tellin@gmail.com>
Date: Sat, 20 Nov 2010 20:41:39 +0000
Subject: [lm-sensors] lm-sensors config file for Asus K8N-DL motherboard
Message-Id: <AANLkTinYEMqSH_PMmVOqV4bn1a9qFoagtVo4AHpG=57H@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

/etc/sensors.d/asus_k8n-dl.conf
# libsensors configuration file
# -----------------------------
#
# This is a custom configuration file for the Asus K8N-DL Opteron motherboard.
# This custom configuration file should be located in /etc/sensors.d. This
# approach makes further updates much easier.
#
# Custom configuration files for specific mainboards can be found at
# http://www.lm-sensors.org/wiki/Configurations

# READ THE MAN PAGE DOCUMENTATION OF 'sensors.conf' FOR MORE
# COMPLETE INFORMATION. ie:

# man sensors.conf

# Regarding the Asus K8N-DL dual socket Opteron motherboard: This motherboard
# supports up to 8 SATA 1.5 drives using a combination of nVidia chipset and
# the Silicon Sys SATA chip.

# Warning: 'sensors-detect' will report the wrong Winbond I2C chip.
Board inspection
# and the official manual both indicate 'w83792d'.

chip "w83792d-*"

# All labels set to match Asus K8N-DL BIOS displayed labels. See
# the 'Fan Speed' and 'Voltage' screens in the BIOS.

# Voltage settings

    label in0 " VCoreA"
    label in1 " VCoreB"
    label in2 " +3.3 V"
    label in3 "+12.0 V"
    label in4 " +1.5 V"
    label in5 " +2.5 V"
    label in6 "   5VCC"
    label in7 "   5VSB"
    label in8 "   Vbat"

    compute in3 ((28/10)+1)*@ , @/((28/10)+1)

# Other than +3.3, +5.0 and +12.0 voltages (here set plus/minus 10%), the
# indicated min/max voltages are as per the Asus K8N-DL manual.
# These min/max ranges represent the min/max settings available in the
# BIOS. in4 is Chipset voltage and ranges from 1.5V to 1.8V in 0.1V
# increments. in5 are both CPUs DDR Voltage and ranges from 2.6V {2.5V
# when not set manually} to 2.9V in 0.1V increments. HT {Hyper Transport
# voltage} is not available through the I2C chip. It is set 'blind' and
# ranges from 1.20V to 1.35V in 0.05V increments.

    set in2_min   3.3 * 0.90
    set in2_max   3.3 * 1.10
    set in3_min  12.0 * 0.90
    set in3_max  12.0 * 1.10
    set in4_min   1.47
    set in4_max   1.83
    set in5_min   2.47
    set in5_max   2.93
    set in6_min   5.0 * 0.90
    set in6_max   5.0 * 1.10
    set in7_min   5.0 * 0.90
    set in7_max   5.0 * 1.10

# Fan settings - There are 6 fans on the motherboard. However, there is no
# 'fan6'. Instead, the internal label for the 6th fan is reported as 'fan7'.
# Who knew?
# Moreover, the fan labels stenciled onto the motherboard don't match what's
# reported in the BIOS. Alas, the labels reported in the BIOS don't match
# how the fans are used. What is reported as 'Front Fan 1' in the BIOS is
# dedicated to cooling the nVidia North Bridge chip. The commented out labels
# are as the BIOS labels the fans. The active labels reflect how the fans are
# used. You're sure to be confused. Trust the active labels.

#   label fan1 " CPU1 fan"
#   label fan2 " CPU2 fan"
#   label fan3 "Frnt1 fan"
#   label fan4 "Frnt2 fan"
    label fan5 "Rear1 fan"
    label fan7 "Rear2 fan"

# Override fan labels for your usage - The Asus K8N-DL uses the Frnt 1
# fan to cool the nVidia chipset.

    label fan1 "   NB fan"
    label fan2 " CPU1 fan"
    label fan3 " CPU2 fan"
    label fan4 "Frnt1 fan"

# Ignore unused fan connectors on the motherboard.

    ignore fan7

# All of the Asus K8N-DL fan connectors require a devisor of 4 except the
# fan dedicated to the North Bridge. That fan requires a divisor of 1.
# Having said that, the NB fan reports 2X revolutions compared to the BIOS.

    compute fan1 @/2,2*@

    set fan1_div 1
    set fan2_div 4
    set fan3_div 4
    set fan4_div 4
    set fan5_div 4
    set fan7_div 4

# Asus K8N-DL can allow 0 rpm for all fans when in SMART
# fan control mode. Set as applicable for your system.
#
# The Asus K8N-DL is based upon an nVidia nforce chipset. This is a hot
# chipset and comes with active (fan based) cooling. There is no
# temperature based fan speed control for this fan. The installed
# NB fan therefore always runs at ~5000 RPM. As this is a hot
# chipset, you probably always want to be warned when it's fan
# slows or stops. Set your kernel and userland programs accordingly.

#   set fan1_min 0
#   set fan2_min 0
#   set fan3_min 0
#   set fan4_min 0
#   set fan5_min 0
#   set fan7_min 0

# Temperature sensor settings

    label temp1 "  Sys tmp"
    label temp2 "CPU A tmp"
    label temp3 "CPU B tmp"

# Only set tempX_type if you have PC Health [disabled]
# in your BIOS. Generally, the kernel {lmsensors} will
# correctly detect individual temperature sensor type and
# set values accordingly.

#    set temp1_type 2
#    set temp2_type 2
#    set temp3_type 3

# Set your temperature max values. Warning: If your values here
# are set higher than the values set in your BIOS, then you may
# shutdown at a lower temperature than you think. It's probably
# best to assume that shutdown will occur at the lowest setting
# whenever the value here and the BIOS are discrepant.

# The other possibility is that a value set here will always
# override the BIOS. You may or may not want that behavior.
# Temperautres listed here come from the example in the manual.
# Max CPU temp is given at 60. All temps Celsius.

     set temp1_max      50
     set temp1_max_hyst 45
#    set temp2_max      55
#    set temp2_max_hyst 50
#    set temp3_max      55
#    set temp3_max_hyst 50

# Set as appropriate for your environment

     set temp2_max      60
     set temp2_max_hyst 55
     set temp3_max      60
     set temp3_max_hyst 55

# READ THE MAN PAGE DOCUMENTATION OF 'sensors.conf' FOR MORE
# COMPLETE INFORMATION. ie:

# man sensors.conf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
