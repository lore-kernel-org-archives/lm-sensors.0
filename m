From: Luc Pauwels <Luc.Pauwels@xalasys.com>
Date: Sun, 06 Jan 2013 00:34:55 +0000
Subject: [lm-sensors] Configuration file for Asus P8Z77-V PRO motherboard
Message-Id: <1357432495.17524.33.camel@zenith.xalasys.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-ERsSVkOyrBvG4rHI8sez"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--=-ERsSVkOyrBvG4rHI8sez
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi All,

Attached to this mail is my configuration file for my Asus P8Z77-V PRO
motherboard.  This sensors.conf file is to be used in combination with
the nct6775 standalone driver by Guenter Roeck.

Some of the settings may still require some further tweaking, but the
overall output of the sensors command on my system looks pretty
reasonable now...

Grtz,
Luc

--=-ERsSVkOyrBvG4rHI8sez
Content-Disposition: attachment; filename="sensors.conf"
Content-Type: text/plain; name="sensors.conf"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

# Configuration file for an ASUS P8Z77-V PRO motherboard
# (using the Nuvoton NCT6779D standalone driver by Guenter Roeck)
#
# Author: Luc Pauwels
#

chip "nct6779-*"

     label  in0   "Vcore Voltage"
     label  in1   "  +12 Voltage"
     label  in2   " AVCC Voltage"
     label  in3   " +3.3 Voltage"
     label  in4   "   +5 Voltage"
     ignore in5
     ignore in6
     label  in7   " 3VSB Voltage"
     label  in8   " VBAT Voltage"
     label  in9   "  VTT Voltage"
     ignore in10
     ignore in11
     ignore in12
     ignore in13
     ignore in14
     label  fan1   "CHASSIS1 FAN Speed"
     label  fan2   "CPU FAN Speed"
     label  fan3   "CHASSIS2 FAN Speed"
     label  fan4   "CHASSIS3 FAN Speed"
     label  fan5   "CHASSIS4 FAN Speed"
     label  temp1  "MB Temperature"
     label  temp2  "CPU Temperature"
     ignore temp3
     ignore temp4
     ignore temp5
     ignore temp6
     ignore temp7
     ignore temp8
     ignore temp9
     ignore temp10
     ignore cpu0_vid
 
     compute  in1  @ * (96/8), @ / (96/8)
     compute  in4  @ * (40/8), @ / (40/8)

     set in1_min  12   * 0.95
     set in1_max  12   * 1.05
     set in2_min   3.3 * 0.95
     set in2_max   3.3 * 1.05
     set in3_min   3.3 * 0.95
     set in3_max   3.3 * 1.05
     set in4_min   5   * 0.95
     set in4_max   5   * 1.05
     set in7_min   3.3 * 0.95
     set in7_max   3.3 * 1.05
     set in8_min   3.06
     set in8_max   3.53
     set in9_min   0.89
     set in9_max   1.74
     set temp1_max       70
     set temp1_max_hyst  40
     set temp2_max       80
     set temp2_max_hyst  75

--=-ERsSVkOyrBvG4rHI8sez
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-ERsSVkOyrBvG4rHI8sez--

