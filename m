From: Lee Marriott <leemarriott@sbcglobal.net>
Date: Sat, 09 Apr 2011 00:05:57 +0000
Subject: [lm-sensors] lm-sensors configuration file for BioStar N68S+
Message-Id: <4D9FA2E5.4040508@sbcglobal.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040607030001040001050505"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040607030001040001050505
Content-Type: multipart/alternative;
 boundary="------------020909080909000109010309"


--------------020909080909000109010309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

To whom it may be of interest,

Attached is a lm-sensors configuration file for a BioStar N68S+ 
motherboard. It is the result of several days of head scratching and 
googling, and its results agree with the BIOS output (at least on my 
system using openSUSE 11.4). You are welcome to use as you see fit, but 
of course, there is no guarantee that it will work properly for others.


I hope that it will be of some aid to others.


Lee Marriott,
Retired


--------------020909080909000109010309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    <style type="text/css">p, li { white-space: pre-wrap; }</style>
    <p style="margin: 0px; text-indent: 0px;"><big>To whom it may be of
        interest,<br>
        <br>
      </big></p>
    <p style="margin: 0px; text-indent: 0px;"><big>Attached is a
        lm-sensors configuration file for a BioStar N68S+ motherboard.
        It is the result of several days of head scratching and
        googling, and its results agree with the BIOS output (at least
        on my system using openSUSE 11.4). You are welcome to use as you
        see fit, but of course, there is no guarantee that it will work
        properly for others.<br>
      </big></p>
    <p style="margin: 0px; text-indent: 0px;"><big><br>
        I hope that it will be of some aid to others.<br>
      </big></p>
    <p style="margin: 0px; text-indent: 0px;"><big><br>
        Lee Marriott,<br>
        Retired<br>
      </big></p>
  </body>
</html>

--------------020909080909000109010309--

--------------040607030001040001050505
Content-Type: text/plain;
 name="sensors3.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sensors3.conf"

# libsensors configuration file
# -----------------------------
#
# This is a first attempt at a custom configuration file for the Biostar N68S+.
# This custom configuration file should be located in /etc/sensors3.conf.
#
# Custom configuration files for some specific mainboards can be found at
# http://www.lm-sensors.org/wiki/Configurations

# READ THE MAN PAGE DOCUMENTATION OF 'sensors.conf' FOR MORE
# COMPLETE INFORMATION. ie:

# man sensors.conf

# Regarding the Biostar N68S+ motherboard: This motherboard supports
# both manual overclocking by individual settings and preconfigured
# overclocking using predefined sets of overclock settings.

chip "it8716-*"

# All labels set to match Biostar N68S+ BIOS displayed labels. See
# the 'PC Health' screen in the BIOS.

# Voltage settings

    label in0 "  Vcore"
    label in1 "Chipset"
    ignore in2           # +3.3 V not in BIOS
    label in3 "   +5 V"  # VCC
    label in4 "  +12 V"
    label in5 "    DDR"
    label in6 "     HT"
    label in7 "   5VSB"
    label in8 "   Vbat"

    compute in3 ((6.8/10)+1)*@ , @/((6.8/10)+1)
    compute in4 ((30/10)+1)*@ , @/((30/10)+1)
    compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)

    ignore cpu0_vid

# Other than +3.3, +5.0 and +12.0 voltages (here set plus/minus 10%), the
# indicated min/max voltages are a guess based on present measurements
# and similar to those on my Asus m/b.
# 

    set in0_min   0.80
    set in0_max   1.80
    set in1_min   1.1
    set in1_max   1.76
#    set in2_min   3.3 * 0.90
#    set in2_max   3.3 * 1.10
    set in3_min   5.0 * 0.90
    set in3_max   5.0 * 1.10
    set in4_min  12.0 * 0.90
    set in4_max  12.0 * 1.10
    set in5_min   1.60
    set in5_max   2.20
    set in6_min   0.95
    set in6_max   1.4
    set in7_min   5.0 * 0.90
    set in7_max   5.0 * 1.10

# Fan settings

    label fan1 "CPU fan"
    label fan2 "Sys1fan"
    label fan3 " NB fan"

    # Ignore fans you don't have
   ignore fan3

#
# The Biostart N68S+ is based upon the nVidia GeForce 7025/nForce 630a
# chipset and comes with active (fan based) cooling.

# Biostar N68S+ can allow 0 rpm for the CPU fan when in SMART
# fan control mode. Set min speeds as applicable for your system.

#    set fan1_min 1000
    set fan1_min 0
    set fan2_min 1000
#    set fan3_min 5600

# Temperature sensor settings

    label temp1 "CPU Tmp"
    label temp2 "M/B Tmp"
    label temp3 "NB     "

# BioStar N68S+ BIOS doesn't use 'temp2' and 'temp3'.

    ignore temp2
    ignore temp3

# Only set tempX_type if you have PC Health [disabled]
# in your BIOS???? Generally, the kernel {lmsensors} will
# correctly detect individual temperature sensor type and
# set values accordingly.
# 2 = thermistor; 3 = thermal diode; 0 = unused

#    set temp1_type 2
#    set temp2_type 2
#    set temp3_type 3

# Set your temparature max values. Warning: If your values here
# are set higher than the values set in your BIOS, then you may
# shutdown at a lower temperature than you think. It's probably
# best to assume that shutdown will occur at the lowest setting
# whenever the value here and the BIOS are different.

   set temp1_max  50
   set temp1_min  10
#   set temp2_max  50
#   set temp2_min  10

# The other possibility is that a value set here will always
# override the BIOS. You may or may not want that behavior.


--------------040607030001040001050505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040607030001040001050505--
