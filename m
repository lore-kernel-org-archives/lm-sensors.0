From: Glen <journeay@gmail.com>
Date: Fri, 13 Aug 2010 03:27:06 +0000
Subject: [lm-sensors] Config file for Gigabyte MA785GM-US2H
Message-Id: <1281670026.2676.3.camel@honcho>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-RRTlkM1uXL6dIxqp5juP"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--=-RRTlkM1uXL6dIxqp5juP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Here's a config file I worked up for the Gigabyte MA758GM-US2H.  It's
based off of one taken from your web site. This is NOT confirmed by
examination of the MB, just by observed readings.

Yours,

Glen Journeay



--=-RRTlkM1uXL6dIxqp5juP
Content-Disposition: attachment; filename="sensors-Gigabyte MA785GM-US2H.conf"
Content-Type: text/plain; name="sensors-Gigabyte MA785GM-US2H.conf"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

# lm_sensors configuration file for the Gigabyte MA785GM-US2H motherboard
# 8-12-2010 G. Journeay <journeay@gmail.com>
# Comments welcome!

chip "it8718-*"

### Voltages

   label  in0  "Vcore"
   label  in1  "Vram"    # "DDR2" in BIOS
   label  in2  "+3.3V"
   label  in3  "+5V"     # Not in BIOS
   ignore in4
   ignore in5
   ignore in6
   label  in7  "+12V"
   label  in8  "Vbat"    # Not in BIOS

   # Vcore, Vram, +3.3V and Vbat are connected directly, so no compute
   # line is needed for these. For +5V the chip is configured to use
   # internal scaling. For +12V the default resistors seem to have been
   # used.
   compute  in0  @ * (  3/10+1), @ / (  3/10+1)
   compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
   compute  in7  @ * ( 45/10+1), @ / ( 45/10+1)

   # The BIOS won't set any limit for voltages.

   set in0_min 1.48 * 0.95
   set in0_max 1.48 * 1.05
   set in1_min 1.8 * 0.95
   set in1_max 1.8 * 1.05
   set in2_min 3.3 * 0.95
   set in2_max 3.3 * 1.05
   set in3_min   5 * 0.95
   set in3_max   5 * 1.05
   set in7_min  12 * 0.95
   set in7_max  12 * 1.05

### Temperatures

   label  temp1  "CPU Temp"
   label  temp3  "NBr Temp"
   label  temp2  "MB Temp"

   set temp1_min 0
   set temp1_max 60
   set temp2_min 0
   set temp3_max 50
   set temp3_min 0
   set temp3_max 50

### Fans

   label  fan1  "CPU Fan"
   label  fan2  "SYS Fan"
   ignore fan3
   label  fan4  "NB Fan"  

   # Adjust for your own fans
   set fan1_min 1000
   set fan4_min 1000

--=-RRTlkM1uXL6dIxqp5juP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-RRTlkM1uXL6dIxqp5juP--

