From: Aleksej Serdjukov <deletesoftware@yandex.ru>
Date: Thu, 07 Apr 2011 09:11:44 +0000
Subject: Re: [lm-sensors] testing "w83627ehf" and "k10temp" on ASRock E350M1
Message-Id: <4D9D7FD0.8060107@yandex.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D9CA530.9030100@yandex.ru>
In-Reply-To: <4D9CA530.9030100@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

(sorry, the CCs seem to have confused Thunderbird)
On 2011-04-07 11:26, Jean Delvare wrote:
 > Hi Aleksej, Guenter,
 >
 > On Wed, 6 Apr 2011 15:54:56 -0700, Guenter Roeck wrote:
 >> On Wed, Apr 06, 2011 at 01:38:56PM -0400, Aleksej Serdjukov wrote:
 >>> Today, however, while the CPU was not loaded much, the fan appeared to
 >>> be full speed again (at least according to the sensors applet).
 >
 > It's always nice to get user reports, but...

The wiki says the driver "needs testing" (though as of 2011-02-01).  I 
thought that at least AUXTIN being negative was something worth reporting.

 > what is your problem exactly? Do you have an actual question?

My problem is the noise the fan is making at full-on speed. I want it to 
be reasonably quiet, but I don't know why it is following the speed 
chosen (between 1 and 9) and not just trying to keep the chosen CPU 
temperature; and why yesterday it suddenly got to maximum without me 
changing the setting or the non-temp1 temperatures being ordinary.


Since k10temp shown 60-65°C, I set the fan speed to full and posted here.

Also, the only clear statement about temperatures of E-350 I found is 
that the maximum is 90. Reviews talk about 30 or 50. Where should I stop 
with the quietness?


 >>> But the new sensors-detect was also mentioning "k10temp" (and the old
 >>> one in Debian didn't work), so today I installed a new k10temp, and it
 >>> showed 60°C for something.
 >
 > Please note that the internal sensors in AMD CPUs have never need
 > considered accurate. Some models are better than others but it general

So can I ignore it when choosing fan speed? Or see that it doesn't go to 
the 90°C maximum?


 >>> in1:         +1.03 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
 >>
 >> 	Possibly 12V (*12)
 >>
 >>> AVCC:        +3.33 V  (min =  +2.98 V, max =  +3.63 V)
 >>> +3.3V:       +3.33 V  (min =  +2.98 V, max =  +3.63 V)
 >>> in4:         +1.39 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
 >>> in5:         +1.86 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
 >>
 >> No idea what in4/in5 might be.
 >
 > DDR3 runs at +1.8V so in5 could be Vdimm. Best is to check what the
 > BIOS is printing, and compare.

Settings in UEFI:
DRAM : 1.507
+1V  : 1.10
FCH  : 1.10
+1.8V: 1.85



== START COMPARISON #1 =======================
UEFI's H/W pane said:

CPU Temp: 44  (got there from 40 since reboot)
M/B Temp: 44  (got there from 43 since reboot)

Vcore: 1.304 V
+12 V: 12.196 V
+5.00: 4.992 V
+3.30: 3.328 V


sensors after boot:

k10temp-pci-00c3
Adapter: PCI adapter
temp1:       +57.5°C  (high = +70.0°C, crit = +75.0°C)

nct6775-isa-0290
Adapter: ISA adapter
Vcore:       +1.13 V  (min =  +0.00 V, max =  +1.74 V)
in1:         +1.00 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
AVCC:        +3.33 V  (min =  +2.98 V, max =  +3.63 V)
+3.3V:       +3.33 V  (min =  +2.98 V, max =  +3.63 V)
in4:         +1.38 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in5:         +1.86 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in6:         +1.66 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
3VSB:        +3.44 V  (min =  +2.98 V, max =  +3.63 V)
Vbat:        +3.39 V  (min =  +2.70 V, max =  +3.30 V)   ALARM
fan1:          0 RPM  (min =    0 RPM, div = 64)
fan2:       4963 RPM  (min =    0 RPM, div = 8)  ALARM
fan3:          0 RPM  (min =    0 RPM, div = 128)
fan4:          0 RPM  (div = 128)
SYSTIN:      +45.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = 
thermistor
CPUTIN:      +43.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
AUXTIN:       -8.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
cpu0_vid:   +0.000 V

== END #1 =============================



== START COMPARISON #2 =======================

UEFI's H/W Monitor pane said:

VCore: 1.304
+12  : 12.144
+5   : 4.9?2
+3.3 : 3.328


sensors after boot:

k10temp-pci-00c3
Adapter: PCI adapter
temp1:       +63.0°C  (high = +70.0°C, crit = +75.0°C)

nct6775-isa-0290
Adapter: ISA adapter
Vcore:       +1.08 V  (min =  +0.00 V, max =  +1.74 V)
in1:         +1.02 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
AVCC:        +3.33 V  (min =  +2.98 V, max =  +3.63 V)
+3.3V:       +3.33 V  (min =  +2.98 V, max =  +3.63 V)
in4:         +1.39 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in5:         +1.86 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in6:         +1.66 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
3VSB:        +3.44 V  (min =  +2.98 V, max =  +3.63 V)
Vbat:        +3.39 V  (min =  +2.70 V, max =  +3.30 V)   ALARM
fan1:          0 RPM  (min =    0 RPM, div = 32)
fan2:       5113 RPM  (min =    0 RPM, div = 8)  ALARM
fan3:          0 RPM  (min =    0 RPM, div = 128)
fan4:          0 RPM  (div = 128)
SYSTIN:      +53.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = 
thermistor
CPUTIN:      +50.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
AUXTIN:       -9.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
cpu0_vid:   +0.000 V

== END #2 =============================


 >>> in6:         +1.66 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
 >>
 >> 	This one might be 5V (*3)

UEFI: +5.00: 4.992 V

4.992 / 3 = 1.664
1.66 * 3 = 4.98


 >>> SYSTIN:      +51.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM 
sensor =  thermistor
 >>> CPUTIN:      +45.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = 
thermistor
 >
 > These temperatures look reasonable to me. Find out which is the CPU
 > temperature by putting some load on the CPU: the CPU temperature will
 > raise faster and higher. You should also set appropriate limits for
 > temp1 and write them to the chip with "sensors -s".

CPUTIN and temp1 slowly increased (CPUTIN from 44-46 to 48-49, temp1 
from 56 to 67-69).


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
