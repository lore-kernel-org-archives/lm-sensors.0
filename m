From: gabriel.euzet@gmail.com (Gabe)
Date: Fri, 17 Feb 2006 20:41:37 +0000
Subject: [lm-sensors] vt8231 - epia800
Message-Id: <d5dcbca20602171241s2380ccc6x@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Does anyone can tell me how to get the temperature of my system ?

MB : Epia 800 (sensor vt8231)

sensors.conf :
chip "vt8231-*"

    label in1 "+2.5V"
    label in2 "VCore"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "+3.3V"

    label temp1 "CPU Temp"
    label temp2 "M/B Temp"
    compute in1  @ * (1 +   2 / 10),  @ / (1 +   2 / 10)
    compute in3  @ * (1 +  14 / 10),  @ / (1 +  14 / 10)
    compute in4  @ * (1 +  47 / 10),  @ / (1 +  47 / 10)

    set in2_min 1.65 * 0.95
    set in2_max 1.65 * 1.05
    set in3_max 5.0 * 1.05
    set in4_min 12.0 * 0.95
    set in4_max 12.0 * 1.05
    set in5_min 3.3 * 0.95
    set in5_max 3.3 * 1.05

# For VIA EPIA CPU (provided by Roger Lucas):
    compute temp1  (@ - 45) / 0.7809,  (@ * 0.7809) + 45

    compute temp2  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) - 273.15, \
                   2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
    compute temp3  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) - 273.15, \
                   2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))

    set temp1_hyst 60
    set temp1_over 65
    set temp2_hyst 40
    set temp2_over 45

output of sensors :
vt8231-isa-6000
Adapter: ISA adapter
in0:       +2.13 V  (min =  -0.03 V, max =  +2.63 V)
+2.5V:     +2.55 V  (min =  -0.04 V, max =  +3.16 V)
VCore:     +2.07 V  (min =  +1.56 V, max =  +1.72 V)   ALARM
+5V:       +4.03 V  (min =  -0.07 V, max =  +5.23 V)
+12V:     +12.55 V  (min = +11.36 V, max = +12.55 V)
+3.3V:     +3.30 V  (min =  +3.13 V, max =  +3.46 V)
fan1:        0 RPM  (min = 2570 RPM, div = 2)          ALARM
fan2:        0 RPM  (min = 2570 RPM, div = 2)          ALARM
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!
ERROR: Can't get TEMP4 data!
ERROR: Can't get TEMP5 data!
ERROR: Can't get TEMP6 data!
ERROR: Can't get TEMP7 data!

Regards,
Gabe
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060217/0f3d1757/attachment.html
