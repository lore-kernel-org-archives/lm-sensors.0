From: root@onyx.nurealm.net (root)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: spurious erroneous ALARM flag on fan reading and Soyo Dragon Plus
Message-Id: <200409201602.i8KG2k85002561@onyx.nurealm.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I randomly see this sort of thing

 P/S Fan:  1418 RPM  (min = 1250 RPM, div = 4)          ALARM

often followed by this

 P/S Fan:  1418 RPM  (min = 1250 RPM, div = 4)

This is, of course, silly.  Is there something subtle in the alarm code that
it can not compare "1418 < 1250" and determine "false"?  I took a quick
look at the code, but didn't try to decipher all the macros.  Does the chip
generate this alarm signal itself?

Sometimes I see this only once when I first run "sensors" after boot, but
sometimes it seems to happen repeatedly.

This variable speed fan starts very slowly, around 1150 rpm when the computer
is first turned on cold.  I changed the divisor to 8 and the min to 1100.
If the ALARM is generated on the chip, does the chip latch the ALARM state?
and does "sensors" clear the ALARM state after reading the alarm?  Then this
would literally be a real passing ALARM generated during startup when the
P/S fan temperature sensor is cold.

If so a little note about latching ALARM states would be in order.

And still, I'll get this

 P/S Fan:  1480 RPM  (min = 1096 RPM, div = 8)          ALARM

mixed occasionally with this erroneous rpm reading (divide by 2)

 P/S Fan:   740 RPM  (min = 1096 RPM, div = 8)          ALARM

even when the system is warmed up.  The fan is just running at the same
speed, of course.  If there is a hardware problem with the fan signal, there
is still the issue of where the alarm is generated.  Is the alarm, again,
being latched by the chip?

I realize that there is an ambiguity about the fan divisor.  With respect to
the fan divisor chart and explanation on the web site, do the "rpm's" refer
to the "pre-compute" or "post-compute" values with respect to the fan
"compute" equations?  I assume they have to be "pre-compute" because the
hardware doesn't know anything about fan pulses per revolution, but then the
fan divisor chart should say "pulses per minute" and NOT "revolutions per
minute", which would make the numbers in the chart all wrong by a factor of
2 anyway, yes?

I tried changing the fan divisor back to 4, but leaving the minimum at 1100.
Compared to the original configuration, the fan1_min value is lower.  This
works sometimes

 P/S Fan:  1360 RPM  (min = 1102 RPM, div = 4)
 P/S Fan:  1430 RPM  (min = 1102 RPM, div = 4)

but sometimes does this

 P/S Fan:  1480 RPM  (min = 1102 RPM, div = 4)          ALARM
 P/S Fan:    -0 RPM  (min = 1102 RPM, div = 4)          ALARM
 P/S Fan:  1467 RPM  (min = 1102 RPM, div = 4)          ALARM

Using a fan divisor of 16 does not help

 P/S Fan:  1454 RPM  (min = 1110 RPM, div = 16)          ALARM


I have in /etc/sensors.conf

    label fan1  "P/S Fan"
    compute fan1  @ / 2,  @ * 2    # 4 pulse per rev
    set fan1_div 4
    set fan1_min 1100

I'm inferring the factor of two compute equation based upon the fan speed
reported by the BIOS.  I've only made the two readings display the same.  I
haven't measured the actual fan speed or pulse frequency, but the hardware
only knows about the pulse frequency anyway.

This is with RedHat lm_sensors-2.8.7-1, running kernel-2.6.8-1.541 with the
it87 chip on a Soyo "Dragon Plus".  The fan signal is from an Enermax P/S
with a variable speed fan.

I've never seen this "false alarm" on fan2, which is a regular fixed speed
fan on the CPU.


Also, another issue, I always get from "sensors"

 VBat:      +0.00 V

I don't know if this is normal for this board or not.  The BIOS display
always has a correct battery voltage reading.  Maybe some other chip
generates that reading, but that seems unlikely.


Some Soyo Dragon Plus notes.

    compute in5 ((1+(232/56)) * @) - 16.969 ,  (@ + 16.969) / 5.143
    compute in6 ((1+(120/56)) * @) -  8.777 ,  (@ +  8.777) / 3.143

That's in "mixed" form - the second equation is simplified, but the first
equation is a note for myself about the resistor values.  The resistor
values are taken from the ITE Reference Circuit, 8705CG_V02.pdf, and give
correct readings.  Other compute values in the config already match the
Reference Circuit values.

Also for the Soyo Dragon Plus,

    label fan2  "CPU Fan"


A note about the documentation.

I would have found helpful a little more information about the fan divisors
in either the man page or the top of the /etc/sensors.conf.

Perhaps you could simply add the small chart from

 THEORY OF OPERATION - Guide to Fan Divisors
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/fan-divisors

to the top of /etc/sensors.conf, with a link to the web page "for more
info".  You might want to change this to "Pulses per minute" with a note
about "Pulses per revolution", but this would still be helpful as it is.


#
# FAN DIVISOR SETTINGS
# --------------------
#
# Fan Divisor     Minimum RPM     Maximum RPM
# -----------     -----------     -----------
#   1             5314            1350000
#   2             2657             675000         default on most chips
#   4             1328             337500
#   8              664             168750
#  16              332              84375         no support on most chips
#  32              166              42187         "
#  64               83              21093         "
# 128               41              10546         "
#
#
# Pick a divisor so that the nominal RPM is about 50%
# above the minimum. This is a good compromise between
# margin and accuracy. Note that most chips only support
# fan divisors of 1, 2, 4, and 8.
#
# If you have a 0 RPM reading some or all of the time,
# increase the divisor until you get good readings.
#
# For more information, see
#  THEORY OF OPERATION - Guide to Fan Divisors
#  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/fan-divisors
#


Thanks

James Feeney
