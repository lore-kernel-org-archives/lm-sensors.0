From: no tellin <no.tellin@gmail.com>
Date: Wed, 10 Nov 2010 16:15:53 +0000
Subject: [lm-sensors] lmsensors config file for BioStar F-Force 550
Message-Id: <AANLkTik7-uYqG2M23y0VvS1uZ5iOQLkyHvV=RM=7faWX@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This is a lm sensors motherboard specific configuration file I created
for a Biostar T-Force 550 PC.

As per guidance from the lm-sensors wiki: Configuration page, I'm
posting ithere.

As created and installed:

/etc/sensors.d/biostar_t-force-550.conf
# libsensors configuration file
# -----------------------------
#
# This is a custom configuration file for the Biostar T-Force 550.
# This custom configuration file should be located in /etc/sensors.d. This
# approach makes further updates much easier.
#
# Custom configuration files for specific mainboards can be found at
# http://www.lm-sensors.org/wiki/Configurations

# READ THE MAN PAGE DOCUMENTATION OF 'sensors.conf' FOR MORE
# COMPLETE INFORMATION. ie:

# man sensors.conf

# Regarding the Biostar t-Force 550 motherboard: This motherboard supports
# both manual overclocking by individual settings and preconfigured
# overclocking using predefined sets of overclock settings.

chip "it8716-*"

# All labels set to match Biostar T-Force 550 BIOS displayed labels. See
# the 'PC Health' screen in the BIOS.

# Voltage settings

    label in0 "  Vcore"
    label in1 "Chipset"
    label in2 " +3.3 V"
    label in3 "   +5 V"
    label in4 "  +12 V"
    label in5 "    DDR"
    label in6 "     HT"
    label in7 "   5VSB"
    label in8 "   Vbat"

    compute in3 ((6.8/10)+1)*@ , @/((6.8/10)+1)
    compute in4 ((30/10)+1)*@ , @/((30/10)+1)
    compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)

# Other than +3.3, +5.0 and +12.0 voltages (here set plus/minus 10%), the
# indicated min/max voltages are as per the Biostar T-Force 550 manual.
# These min/max ranges represent the min/max settings available in the
# BIOS. HT (in6) min/max unknown and not available from the manual.

    set in0_min   0.80
    set in0_max   2.31
    set in1_min   1.51
    set in1_max   1.76
    set in2_min   3.3 * 0.90
    set in2_max   3.3 * 1.10
    set in3_min   5.0 * 0.90
    set in3_max   5.0 * 1.10
    set in4_min  12.0 * 0.90
    set in4_max  12.0 * 1.10
    set in5_min   1.80
    set in5_max   2.20
    set in7_min   5.0 * 0.90
    set in7_max   5.0 * 1.10

# Fan settings

    label fan1 "CPU fan"
    label fan2 "Sys fan"
    label fan3 " NB fan"

# Biostar T-Force 550 can allow 0 rpm for the CPU fan when in SMART
# fan control mode. Set as applicable for your system.
#
# The Biostart T-Force 550 is based upon the nVidia nforce 550
# chipset and comes with active (fan based) cooling. There is no
# temperature based fan speed control for this fan. The installed
# NB fan therefore always runs at ~6250 RPM. As this is a hot
# chipset, you probably always want to be warned when it's fan
# slows or stops. Set your kernel and userland programs accordingly.

#    set fan1_min 1000
    set fan1_min 0
    set fan2_min 1000
    set fan3_min 5600

# Temperature sensor settings

    label temp1 "Temp 1"
    label temp2 "M/B Tmp"
    label temp3 "CPU Tmp"

# BioStar T-Force 550 doesn't use 'temp1'.

    ignore temp1

# Only set tempX_type if you have PC Health [disabled]
# in your BIOS. Generally, the kernel {lmsensors} will
# correctly detect individual temperature sensor type and
# set values accordingly.

#    set temp1_type 2
#    set temp2_type 2
#    set temp3_type 3

# Set your temparature max values. Warning: If your values here
# are set higher than the values set in your BIOS, then you may
# shutdown at a lower temperature than you think. It's probably
# best to assume that shutdown will occur at the lowest setting
# whenever the value here and the BIOS are discrepant.

# The other possibility is that a value set here will always
# override the BIOS. You may or may not want that behavior.

# Biostar T-Force 550 BIOS sets a shutdown temperature only for
# the CPU temperature sensor 'temp3'.

#    set temp1_max      50
#    set temp1_max_hyst 45
#    set temp2_max      50
#    set temp2_max_hyst 45
#    set temp3_max      70
#    set temp3_max_hyst 65

# READ THE MAN PAGE DOCUMENTATION OF 'sensors.conf' FOR MORE
# COMPLETE INFORMATION. ie:

# man sensors.conf


This is a sample of the results of this lm sensors configuration file
on a system with no overclock settings enabled:

it8716-isa-0290
Adapter: ISA adapter
  Vcore:     +1.34 V  (min =3D  +0.80 V, max =3D  +2.30 V)
Chipset:     +1.52 V  (min =3D  +1.50 V, max =3D  +1.76 V)
 +3.3 V:     +3.23 V  (min =3D  +2.98 V, max =3D  +3.63 V)
   +5 V:     +4.87 V  (min =3D  +4.49 V, max =3D  +5.51 V)
  +12 V:    +11.90 V  (min =3D +10.82 V, max =3D +13.18 V)
    DDR:     +1.90 V  (min =3D  +1.81 V, max =3D  +2.21 V)
     HT:     +1.23 V  (min =3D  +0.00 V, max =3D  +4.08 V)
   5VSB:     +4.70 V  (min =3D  +4.49 V, max =3D  +5.51 V)
   Vbat:     +3.02 V
CPU fan:    2008 RPM  (min =3D    0 RPM)
Sys fan:    1599 RPM  (min =3D 1000 RPM)
 NB fan:    6308 RPM  (min =3D 5578 RPM)
M/B Tmp:     +36.0=B0C  (low  =3D +127.0=B0C, high =3D +67.0=B0C)  sensor =
=3D thermistor
CPU Tmp:     +35.0=B0C  (low  =3D +127.0=B0C, high =3D +67.0=B0C)  sensor =
=3D thermal diode
cpu0_vid:   +1.550 V

Note that 'cpu0_vid', while it appears to be valid here, is not
displayed in the BIOS.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
