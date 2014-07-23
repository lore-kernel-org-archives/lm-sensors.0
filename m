From: =?UTF-8?Q?=C3=89ric_Le_Bras?= <eric.lebras@gmail.com>
Date: Wed, 23 Jul 2014 09:08:14 +0000
Subject: [lm-sensors] Sensors configuration for Intel D201GLY2 motherboard
Message-Id: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is the configuration I made for the Intel D201GLY2 motherboard. I used
BIOS values read from my system and on the Internet to find voltages labels
and scaling factors.

Only the configurations specific to the board and not found in
sensors3.conf for w83627dhg have been kept.

# libsensors configuration file
# -----------------------------
#
# Configuration file for Intel D201GLY2 motherboard
# Hardware monitor subsystem controlled by Winbond W83627DHG-B I/O
controller.
# Created using information from BIOS and board documentation.

chip "w83627dhg-*"

    label in1 "+12.0V"
    label in6 "+1.5V"

# in4 and in5 report values, oviously one of the two is for the +5V, however
# none of them is reported by the BIOS.
    ignore in4
    ignore in5

    compute in1 @*(55/8),@/(55/8)

    set in1_min 12.0 * 0.90
    set in1_max 12.0 * 1.10
    set in6_min  1.5 * 0.90
    set in6_max  1.5 * 1.10

    label fan1 "Chassis fan"
    label fan2 "CPU fan"

# By default the D201GLY2 has a passive heatsink. If the optional active
# heatsink is present, then one of the following lines is to be commented
out
# (very likely fan2, though not tried).
    ignore fan2
    ignore fan3
    ignore fan4

    label temp1 "Sys temp"
    label temp2 "unknown"
    label temp3 "unknown"

    ignore intrusion0


-- 
Eric Le Bras
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
