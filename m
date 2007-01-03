From: dvogel@intercarve.net (Drew Vogel)
Date: Wed, 03 Jan 2007 21:16:33 +0000
Subject: [lm-sensors] Bad readouts on ASUS M2V VIA VT8237A
Message-Id: <459C1D31.4010903@intercarve.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I ran sensors-detect, accepting all of the defaults (because they seemed
correct, not because I was clueless) but the readouts I get from
`sensors` are obviously off. Here is the output:



# sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
             +30?C
Core1 Temp:
             +37?C

it8712-isa-0d00
Adapter: ISA adapter
VCore 1:   +1.31 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:   +4.08 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
+3.3V:     +3.31 V  (min =  +0.00 V, max =  +4.08 V)
+5V:       +4.89 V  (min =  +0.00 V, max =  +6.85 V)
+12V:     +11.90 V  (min =  +0.00 V, max = +16.32 V)
-12V:      +3.93 V  (min = -27.36 V, max =  +3.93 V)   ALARM
-5V:       +4.03 V  (min = -13.64 V, max =  +4.03 V)   ALARM
Stdby:     +6.85 V  (min =  +0.00 V, max =  +6.85 V)   ALARM
VBat:      +3.31 V
fan1:     35526 RPM  (min =    0 RPM, div = 2)
fan2:        0 RPM  (min =    0 RPM, div = 2)
fan3:        0 RPM  (min =    0 RPM, div = 2)
M/B Temp:    +36?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
CPU Temp:    +42?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
Temp3:      +128?C  (low  =    -1?C, high =  +127?C)   sensor = disabled



k8temp-pci-00c3 should be my NVidia 7600GT card and those seem correct.
On it8712-isa-0d00 the +voltage readings seem perfect but the -12V and
-5V voltages read out as positive values. AFAIK, this is impossible,
because the system wouldn't be stable enough for me to run the sensors
program (must less install the operating system in the first place). The
fan1 (CPU fan) reading is clearly wrong because at 35k RPM it should be
melting the plastic housing.

The system is slightly unstable, but not consistently so. It is an
Athlon64 X2 system running Debian AMD64 (sid). All of my compatibility
problems are with closed-source software (e.g. Sun's 64bit JRE 1.5
segfaults) and usually running in a 32bit chroot (e.g. the video game
Savage with the close-source NVidia drivers, but Sun's 32bit JRE 1.5.0
runs fine). I thought that I ruled out heat problems, but I suspect
maybe the 42C CPU temp reading may be too low (due to the other suspect
readings) because I've ruled out everything but heat and a bad CPU (ran
memtest86+ for 20 passes, no errors).

How can I tell if my sensors are bad or if I just need to put a compute
line in my sensors.conf?

Drew Vogel








