From: Aleksej Serdjukov <deletesoftware@yandex.ru>
Date: Wed, 06 Apr 2011 17:38:56 +0000
Subject: [lm-sensors] testing "w83627ehf" and "k10temp" on ASRock E350M1
Message-Id: <4D9CA530.9030100@yandex.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi.

I've got this computer with ASRock E350M1, and have no idea what the 
temperatures should actually be.

This is on Debian 6.0:
Linux 2.6.32-5-amd64 #1 SMP Mon Mar 7 21:35:22 UTC 2011 x86_64 GNU/Linux


IIRC, UEFI Setup was showing about 52°C on the motherboard or chipset, 
and 49-52 on the CPU.

About a week ago I've installed the "w83627ehf" from 
<http://roeck-us.net/linux/drivers/w83627ehf/>, and saw that those 
temperatures don't go over 53 or 54°C. So I changed the UEFI setting 
more and more for slower fan speed (today it was 6). So the speed was 
about 4000, while the full speed is about 4900 and 9 is a hundred or a 
couple of hundred less. Temperatures didn't go over 54 (or maybe 55) °C. 
Idle CPU (at 800MHz thanks to Cool'n'Quiet) went down to 46°C more and more.

Today, however, while the CPU was not loaded much, the fan appeared to 
be full speed again (at least according to the sensors applet).

But the new sensors-detect was also mentioning "k10temp" (and the old 
one in Debian didn't work), so today I installed a new k10temp, and it 
showed 60°C for something.

Now I have set the fan speed to full in UEFI, and here is what "sensors" 
shows:


nct6775-isa-0290
Adapter: ISA adapter
Vcore:       +1.08 V  (min =  +0.00 V, max =  +1.74 V)
in1:         +1.03 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
AVCC:        +3.33 V  (min =  +2.98 V, max =  +3.63 V)
+3.3V:       +3.33 V  (min =  +2.98 V, max =  +3.63 V)
in4:         +1.39 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in5:         +1.86 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in6:         +1.66 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
3VSB:        +3.44 V  (min =  +2.98 V, max =  +3.63 V)
Vbat:        +3.39 V  (min =  +2.70 V, max =  +3.30 V)   ALARM
fan1:          0 RPM  (min =    0 RPM, div = 128)
fan2:       4963 RPM  (min =    0 RPM, div = 8)  ALARM
fan3:          0 RPM  (min =    0 RPM, div = 128)
fan4:          0 RPM  (div = 128)
SYSTIN:      +51.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = 
thermistor
CPUTIN:      +45.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
AUXTIN:       -9.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
cpu0_vid:   +0.000 V

k10temp-pci-00c3
Adapter: PCI adapter
temp1:       +58.0°C  (high = +70.0°C, crit = +75.0°C)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
