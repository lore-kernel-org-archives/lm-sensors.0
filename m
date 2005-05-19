From: filip.tsachev@gmail.com (Filip Tsachev)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: hi about lm_sensors issue
Message-Id: <ea9ff50b0503190638516ee6ca@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea9ff50b050315215248daf6e5@mail.gmail.com>
In-Reply-To: <ea9ff50b050315215248daf6e5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

actually this are last results which are very good at last, just tell
me about vid, Stdby and -5 and -12V pls. will be highly appreciated

[root@localhost etc]# sensors -s
[root@localhost etc]# sensors
it8712-isa-0290
Adapter: ISA adapter
VCore 1:   +1.68 V  (min =  +1.62 V, max =  +1.79 V)
Vram:      +2.61 V  (min =  +2.46 V, max =  +2.74 V)
+3.3V:     +3.31 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.02 V  (min =  +4.74 V, max =  +5.25 V)
+12V:     +11.84 V  (min = +11.39 V, max = +12.61 V)
Vagp:      +1.52 V  (min =  +1.42 V, max =  +1.57 V)
-5V:       -8.03 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
Stdby:     +5.54 V  (min =  +4.74 V, max =  +5.25 V)   ALARM
VBat:      +4.08 V
fan1:     2518 RPM  (min = 2481 RPM, div = 8)
CPU Temp:    +55?C  (low  =   +50?C, high =   +60?C)   sensor = thermistor
M/B Temp:    +41?C  (low  =   +40?C, high =   +50?C)   sensor = thermistor
vid:       +1.60 V


-- 
Regards,
Filip Tsachev

Technical Department
www.infodesign.bg
F-Secure Business Partner
