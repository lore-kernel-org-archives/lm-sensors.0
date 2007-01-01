From: jbold@inbox.lv (Jurijs Petrovs)
Date: Mon, 01 Jan 2007 16:57:32 +0000
Subject: [lm-sensors] strange output values from W83627HG chip
Message-Id: <1167670650.45993d7c034f0@www.inbox.lv>
List-Id: <lm-sensors.vger.kernel.org>
References: <1167384671.4594e05f0a0df@www.inbox.lv>
In-Reply-To: <1167384671.4594e05f0a0df@www.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!
First, happy new year to all!

Many thanks for your advice, Rudolf!
I loaded correct driver w83793 and updated lm-sensors. Right after
that I saw correct values from sensor command. As you asked, here is
report  of these values (I just corrected computing formula for
"-12V" sensor and set ignore to unused FANs):

w83793-i2c-0-2f 
Adapter: SMBus I801 adapter at 1100 
VCoreA: +1.23 V (min = +0.92 V, max = +1.49 V) 
VCoreB: +1.23 V (min = +0.92 V, max = +1.49 V) 
Vtt: +1.19 V (min = +1.08 V, max = +1.33 V) 
-12V: -12.81 V (min = -13.14 V, max = -11.57 V) 
P1V5: +1.49 V (min = +1.34 V, max = +1.65 V) 
+3.3V: +3.33 V (min = +2.96 V, max = +3.63 V) 
+12V: +12.19 V (min = +10.75 V, max = +13.25 V) 
+5V: +4.85 V (min = +4.49 V, max = +5.50 V) 
5VSB: +5.02 V (min = +4.49 V, max = +5.50 V) 
VBAT: +3.15 V (min = +2.99 V, max = +3.66 V) 
fan1: 3770 RPM (min = 712 RPM) 
fan2: 3668 RPM (min = 712 RPM) 
fan4: 1230 RPM (min = 712 RPM) 
fan5: 1254 RPM (min = 712 RPM) 
CPU1 Temp: +24.0&deg;C (high = +75.0&deg;C, hyst = +70.0&deg;C) 
CPU2 Temp: +22.0&deg;C (high = +75.0&deg;C, hyst = +70.0&deg;C) 
temp3: +30.5&deg;C (high = +75.0&deg;C, hyst = +70.0&deg;C) 
temp4: -128.0&deg;C (high = +75.0&deg;C, hyst = +70.0&deg;C) 
temp5: +35&deg;C (high = +50&deg;C, hyst = +45&deg;C) 
temp6: +16&deg;C (high = +100&deg;C, hyst = +95&deg;C) 
cpu0_vid: +0.019 V (VRM Version 11.0) 
cpu1_vid: +0.019 V (VRM Version 11.0) 
Very strange that motherboard specification on the original
manufacturer site shows Winbond W83627HG chip. Is it error on site or
my own misunderstanding of docs?

http://www.supermicro.com/products/motherboard/Xeon1333/5000V/X7DVA-E.cfm
[1]

And where I can get _right_ description of temperature sensors for
temp3-temp6 sensors?

Thnaks for help!

Quoting Rudolf Marek :Hi all and happy new year!

I promised holiday, but CDMA works here. ;)

I'm just got new server based on Supermicro X7DVA-E mainboard with
W83627HG chip.

Successfully loaded kernel driver w83627hf (using 2.6.20-rc2 kernel
with
lm-sensors 2.10.0) and noticed that BIOS values of sensors differs
from
lm-sensors output results.

These are values from BIOS:

PECI Agent1: 21 C
PECI Agent2: 18 C
System Temperature 24 C

FAN1: 3708 RPM
FAN2: 3648 RPM
FAN3: N/A
FAN4: 1232 RPM
FAN5: 1260 RPM
FAN6: N/A

Vcore A: 1.228 V
Vcore B: 1.232 V
-12V -12.809 V
P1V5 1.488 V
+3.3V 3.328 V
+12V 12.192 V
5Vsb 5.016 V
5Vdd 4.848 V
P_VTT 1.194 V
V_bat 3.152 V
And these ones I&rsquo;m getting from linux tool
&ldquo;sensors&rdquo;:

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1: +3.36 V (min = +1.34 V, max = +1.49 V) ALARM
VCore 2: +3.41 V (min = +1.34 V, max = +1.49 V) ALARM
+3.3V: +0.91 V (min = +3.14 V, max = +3.47 V) ALARM
+5V: +5.08 V (min = +4.76 V, max = +5.24 V)
+12V: +4.50 V (min = +10.82 V, max = +13.19 V) ALARM
-12V: -6.93 V (min = -13.18 V, max = -10.80 V) ALARM
-5V: -1.98 V (min = -5.25 V, max = -4.75 V) ALARM
V5SB: +5.75 V (min = +4.76 V, max = +5.24 V) ALARM
VBat: +2.14 V (min = +2.40 V, max = +3.60 V) ALARM
Fan1: 0 RPM (min = 3013 RPM, div = 2) ALARM
Fan2: 0 RPM (min = 2657 RPM, div = 2) ALARM
Fan3: 0 RPM (min = 2657 RPM, div = 2) ALARM
Temp1: +29&deg;C (high = +50&deg;C, hyst = +45&deg;C) sensor thermistor
Temp2: +32.5&deg;C (high = +80&deg;C, hyst = +75&deg;C) sensor thermistor
Temp3: +33.0&deg;C (high = +80&deg;C, hyst = +75&deg;C) sensor thermistor
vid: +1.419 V (VRM Version 11.0)
alarms:
beep_enable:
Sound alarm enabled
Very strange values in almost all sensors (voltages, temperature) and
especially in Fan speeds. I could not get any value except zero.
Some ideas what I&rsquo;m doing wrong?

Yes because you have on your board another chip, which is actually
used -
W83793. Just modprobe w83793 driver, and report if it is OK. And
please use the
lm-sensors version 2.10.1 which has support for this chip, the
sensors-detect
from 2.10.1 should find it.

Please report back the output of sensors command, and dont forget to
update your
sensors.conf

Regards
Rudolf
 

Links:
------
[1]
http://www.supermicro.com/products/motherboard/Xeon1333/5000V/X7DVA-E.cfm
[2] mailto:r.marek at assembler.cz
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070101/e26d22c1/attachment.html 
