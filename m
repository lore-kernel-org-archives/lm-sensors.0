From: frlinux@frlinux.net (FRLinux)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: Asus a7v8x support
Message-Id: <1055785605.5085.4.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I am using Gentoo Linux on an Asus a7v8x motherboard with an Athlon XP
2600+. Been using a vanilla kernel with latest acpi patches and i2c and
lm_sensors (2.7.0) patched against it (using your mkpatch command). All
is fine but the cpu temperature which seems to be 20 degrees upper its
real temperature ... Same problem occurs with 2.4.20 and 2.4.21

Here are the modules i am using : 

w83781d                20368   0  (unused)
i2c-viapro              3984   0  (unused)
i2c-proc                7312   0  [w83781d]
i2c-core               15208   0  [w83781d i2c-viapro i2c-proc]

The sensors.conf is the one provided with your sources. I've included a
sensors.conf that i found on the web concerning the asus motherboards
but it then have a wrong cpu value by nearly 10 degrees lower than the
real value.

I hope i am not disturbing anyone around. Been using your project for
quite some time now and was fine until i switched to a kt400 board (had
a kt133a before hand).

Steph
-- 
Mail sent on Gentoo 1.4rc3 k2420 AMD 2600+
"Piece by Piece, the penguins are taking my sanity apart ..."
http://frlinux.net - frlinux@frlinux.net
http://gentoofr.org - Portail Francais sur Gentoo Linux


-------------- next part --------------
# Sensors configuration file used by 'libsensors'
#------------------------------------------------
chip "w83782d-*" "w83783s-*" "w83627hf-*"
    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "V5SB"
    label in8 "VBat"

compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in0_min vid*0.95
    set in0_max vid*1.05
    set in1_min vid*0.95
    set in1_max vid*1.05
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_min -12 * 0.90
    set in5_max -12 * 1.10
    set in6_min -5 * 0.95
    set in6_max -5 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

# set up sensor types (thermistor is default)
# 1 = PII/Celeron Diode; 2 = 3904 transistor;
# 3435 = thermistor with Beta = 3435
# If temperature changes very little, try 1 or 2.
   set sensor1 2
   set sensor2 2
   set sensor3 2

   set temp1_over 70
   set temp1_hyst 60
   set temp2_over 70
   set temp2_hyst 60
   set temp3_over 70
   set temp3_hyst 60

   ignore alarms
   ignore beep_enable
