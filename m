From: filip.tsachev@gmail.com (Filip Tsachev)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: hi about lm_sensors issue
Message-Id: <ea9ff50b050319063114b7d3f6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea9ff50b050315215248daf6e5@mail.gmail.com>
In-Reply-To: <ea9ff50b050315215248daf6e5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for making the settings so clear to me. I just need something more:

[root@localhost etc]# sensors -s
[root@localhost etc]# sensors
it8712-isa-0290
Adapter: ISA adapter
VCore 1:   +1.70 V  (min =  +1.62 V, max =  +1.79 V)   ALARM
Vram:      +2.61 V  (min =  +2.46 V, max =  +2.74 V)   ALARM
+3.3V:     +3.31 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.99 V  (min =  +4.74 V, max =  +5.25 V)   ALARM
+12V:     +11.97 V  (min = +11.39 V, max = +12.61 V)
Vagp:      +1.50 V  (min =  +1.57 V, max =  +1.42 V)   ALARM
-5V:       -8.10 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
Stdby:     +5.54 V  (min =  +4.74 V, max =  +5.25 V)   ALARM
VBat:      +4.08 V
fan1:     2518 RPM  (min = 2481 RPM, div = 8)
CPU Temp:    +47?C  (low  =   +15?C, high =   +60?C)   sensor = thermistor
M/B Temp:    +45?C  (low  =   +15?C, high =   +50?C)   sensor = thermistor
vid:       +1.60 V

what to do with that vid? I commented out and I didn't understand you how to 
>You can also comment out the "ignore  vid" line, and use vid to set
>in0_min/max.

CPU should be even more like 54 degrees C at least because I verify
with Gigabyte Easy tune for windows and BIOS and if you happen to have
seen a program SpeedFan for windows it needed +15 for CPU and + 8 for
MB to match Gigabyte tool, but here it seems different value.

and Vcore1 seems to be inside the interval but still shows ALARM
and Vram is not good too , both should not trigger an ALARM? pls help
me out here
-- 
Regards,
Filip Tsachev

Technical Department
www.infodesign.bg
F-Secure Business Partner
