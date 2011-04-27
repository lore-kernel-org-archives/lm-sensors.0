From: Russell Jones <rjones@eggycrew.com>
Date: Wed, 27 Apr 2011 16:03:43 +0000
Subject: [lm-sensors] w83627hf temp1/2/3 questions
Message-Id: <4DB83E5F.8070701@eggycrew.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

I am attempting to figure out what temp1, 2, and 3 in the following 
output is actually showing:

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
              +31 C
Core1 Temp:
              +37 C

k8temp-pci-00cb
Adapter: PCI adapter
Core0 Temp:
              +28 C
Core1 Temp:
              +33 C

w83627hf-isa-0c00
Adapter: ISA adapter
VCore 1:   +2.00 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:   +2.10 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:     +3.34 V  (min =  +2.82 V, max =  +3.79 V)
+5V:       +5.03 V  (min =  +4.09 V, max =  +0.30 V)       ALARM
+12V:      +5.78 V  (min = +12.28 V, max =  +5.78 V)       ALARM
-12V:      -6.77 V  (min =  -0.19 V, max = -12.69 V)       ALARM
-5V:       -3.94 V  (min =  +3.44 V, max =  -1.88 V)       ALARM
V5SB:      +5.62 V  (min =  +5.75 V, max =  +4.89 V)       ALARM
VBat:      +2.88 V  (min =  +2.86 V, max =  +3.04 V)
fan1:        0 RPM  (min = 5000 RPM, div = 2)              ALARM
fan2:        0 RPM  (min = 2689 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 5487 RPM, div = 2)              ALARM
temp1:       +23 C  (high =  +103 C, hyst =   -53 C)   sensor = thermistor
temp2:     +21.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
temp3:     +27.5 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
vid:      +0.000 V  (VRM Version 2.4)
alarms:
beep_enable:
           Sound alarm enabled



I have tried going through the documentation for this hardware monitor 
chip for what is actually being monitored with no luck 
(http://www.itox.com/pages/support/wdt/W83627HF.pdf)

I am attempting to find the ambient/chassis temperature, and was hoping 
one of these three temps would be it. Any ideas?



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
