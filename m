From: filip.tsachev@gmail.com (Filip Tsachev)
Date: Mon, 13 Feb 2006 14:07:22 +0000
Subject: [lm-sensors] lm-sensors Digest, Vol 10, Issue 23
Message-Id: <ea9ff50b0602130607t4d74b6cem@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have a brand new Fedora 5 rawhide box with lm_sensors-2.9.1-6.1, sensors
output is not normal,

VCore 1:   +1.60 V  (min =  +1.42 V, max =  +1.57 V)   ALARM
VCore 2:   +2.61 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
+3.3V:     +6.50 V  (min =  +3.14 V, max =  +3.46 V)   ALARM
I know how to fix 3.3V (example from conf)

+5V:       +4.22 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
?? No idea here (Fortron PSU)

+12V:     +11.78 V  (min = +11.39 V, max = +12.61 V)
-12V:     -15.70 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -8.03 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
Stdby:     +4.54 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
??

VBat:      +4.08 V
??

fan1:     2481 RPM  (min =    0 RPM, div = 8)

M/B Temp:    +34 C  (low  =   +15??C, high =   +40??C)   sensor = thermistor
CPU Temp:    +26 C  (low  =   +15??C, high =   +45??C)   sensor = thermistor
Temp3:       -76 C  (low  =   +15??C, high =   +45??C)   sensor = diode

CPU is around 45C, MB - 40..only estimated and taking in account bios
reading,  but for sure it's not 26 and 34 or vice versa.

Rudolf checked my bios was so helpful, it was ok back then

Dec 11 16:43:12 ruik    temp2 might have offset of +23
Dec 11 16:43:22 ruik    but I dont know if this code is uded
Dec 11 16:43:24 ruik    used
Dec 11 16:43:31 ruik    temp3 and temp1 has no offset
Dec 11 16:43:45 ruik    question is what is correct confuguration for
Dec 11 16:43:52 ruik    the thermal x diode settings
Dec 11 16:44:00 ruik    the chip at boot said 0x0
Dec 11 16:44:06 ruik    so all thermistors
Dec 11 16:44:26 ruik    but may agree with you that you should switch temp3
Dec 11 16:44:28 ruik    to diode

but when I changed the CPU to a mobile barton from a desktop TB Athlon the
reading had gone wild again... and considering the new box I have - brand
new sensors.conf file and our discussion regarding the bios... what could be
done?


I have a hardware sensors applet for gnome panel and right now it's quite
useless, just for 12V line I can use it...

Temperature readings is most important to me, please any idea would be
really appreciated.

Cheers,
Filip
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060213/97682846/attachment.html
