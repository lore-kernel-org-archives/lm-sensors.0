From: wixorpeek@gmail.com (wixor)
Date: Sat, 02 Dec 2006 14:01:44 +0000
Subject: [lm-sensors] Sensors swapped?
Message-Id: <c43b2e150612020601q21af0d58ge49af3874867be61@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all, I get the following sensors output:

wixor: ~: sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
             +54 C

it8712-isa-0290
Adapter: ISA adapter
VCore 1:   +1.41 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:   +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
+3.3V:     +3.28 V  (min =  +0.00 V, max =  +4.08 V)
+5V:       +5.08 V  (min =  +0.00 V, max =  +6.85 V)
+12V:     +12.10 V  (min =  +0.00 V, max = +16.32 V)
-12V:      -4.17 V  (min = -27.36 V, max =  +3.93 V)
-5V:      -13.64 V  (min = -13.64 V, max =  +4.03 V)   ALARM
Stdby:     +4.92 V  (min =  +0.00 V, max =  +6.85 V)
VBat:      +3.09 V
fan1:     2596 RPM  (min =  811 RPM, div = 8)
fan2:        0 RPM  (min =    0 RPM, div = 8)
fan3:     6250 RPM  (min =    0 RPM, div = 8)
M/B Temp:    +52 C  (low  =    -1 C, high =  +127 C)   sensor = thermistor
CPU Temp:    +40 C  (low  =    -1 C, high =  +127 C)   sensor = thermistor
Temp3:       +30 C  (low  =    -1 C, high =  +127 C)   sensor = thermistor

Now have a look at -12V and -5V sensors - their values don't match
their labels. Are they hardware-swapped on mainboard or is it software
error? Using debian packages and self-compiled kernel 2.6.19 on amd64,
A8N-E ASUS mainboard, nforce4 chipset

Please Cc me, as I'm not in the list. Thanks for responses.
--
wixor

