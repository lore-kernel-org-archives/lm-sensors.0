From: george multescu <multescugeorge@yahoo.com>
Date: Fri, 06 Jul 2007 16:44:44 +0000
Subject: [lm-sensors] sensors.config for DFI CFX3200-M2/G infinity
Message-Id: <923890.46463.qm@web90403.mail.mud.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0-2121716226-1183740284=:46463"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--0-2121716226-1183740284=:46463
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Id: 
Content-Disposition: inline

I tinkered a bit and i got a sensors.config file
working satisfactory against=20
the bios.
Motherboard chipset: SB600
Manufacturer: DFI
I2C adapter driver: =A0i2c-piix4
Chipset driver: it87
detected sensor module: it8716-isa-0228
relevant section of sensors.config attatched



      =20
___________________________________________________________________________=
_________
Take the Internet to Go: Yahoo!Go puts the Internet in your pocket: mail, n=
ews, photos & more.=20
http://mobile.yahoo.com/go?refer=3D1GNXIC
--0-2121716226-1183740284=:46463
Content-Type: text/plain; name="DFI CFX3200-M2G.txt"
Content-Description: 2525820448-DFI CFX3200-M2G.txt
Content-Disposition: inline; filename="DFI CFX3200-M2G.txt"

chip "it8716-*"

# Voltages

    label  in0  "VCore" #-->cpu voltage
    label  in1  "VDDR"
    label  in2  "+3.3V"    # VCC3
    label  in3  "+5V"      # VCC
    label  in4  "V_NBr"	   #--> notrh bridge voltage
    label  in5  "+12V"
    ignore in6
    label  in7  "5VSB"     # VCCH
    label  in8  "VBat"

    compute in3  ((6.8/10)+1)*@ , @/((6.8/10)+1)
#   compute in4  ((30/10)+1)*@  , @/((30/10)+1)
    compute in5  ((30/10)+1.02)*@  , @/((30/10)+1.02) #-->not sure about this one, check this value(+12v) against bios
#   compute in5  (1+232/56)*@ - 4.096*232/56 , (@ + 4.096*232/56)/(1+232/56)
#   compute in6  (1+120/56)*@ - 4.096*120/56 , (@ + 4.096*120/56)/(1+120/56)
    compute in7  ((6.8/10)+1)*@ , @/((6.8/10)+1)

# If vid (nominal CPU voltage) isn't correct, hardcode the correct value
# instead.
#    set in0_min  vid * 0.95
#    set in0_max  vid * 1.05
#    set in1_min  1.8 * 0.95
#    set in1_max  1.8 * 1.05
#    set in2_min  3.3 * 0.95
#    set in2_max  3.3 * 1.05
#    set in3_min    5 * 0.95
#    set in3_max    5 * 1.05
     set in4_min   1.18 * 0.95
     set in4_max   1.18 * 1.05
     set in5_max  12 * 1.05
     set in5_min  12 * 0.95
#    set in6_max   -5 * 0.95
#    set in6_min   -5 * 1.05
#    set in7_min    5 * 0.95
#    set in7_max    5 * 1.05
# The chip does not support in8 min/max

# Temperatures

# If you are lucky, the BIOS has set the proper sensor types for you.
# If your temperature readings are completely whacky you probably
# need to change the sensor types. Adujst and uncomment the
# appropriate lines below.
#
# 2 = thermistor; 3 = thermal diode; 0 = unused
#   set sensor1  3
#   set sensor2  3
#   set sensor3  3

# If a given sensor isn't used, you will probably want to ignore it
# as well (see ignore statement right below).
# The CPU sensor can be any of temp1, temp2 or temp3 - it's motherboard
# dependent. Same for the motherboard temperature.

label  temp1  "System Temp"
label  temp2  "CPU Temp"
label  temp3  "ChipsetTemp"

#   set temp1_over  60
#   set temp1_low   10
#   set temp2_over  50
#   set temp2_low   10

# Fans

# The CPU fan can be any of fan1, fan2 or fan3 - it's motherboard
# dependent. Same for the case fan.

label  fan1 "Chipset Fan"
label  fan2 "CPU Fan"
label fan3 "System fan"

#   set fan1_min 2000
#   set fan2_min 2000


--0-2121716226-1183740284=:46463
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--0-2121716226-1183740284=:46463--
