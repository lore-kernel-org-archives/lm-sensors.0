From: tejerina@chem.northwestern.edu (Baudilio Tejerina)
Date: Thu, 05 Jan 2006 01:03:06 +0000
Subject: [lm-sensors] ERROR: Can't get VID data!
Message-Id: <80665230-2626-423D-AD28-EAE2BF931B1E@chem.northwestern.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,


I've just installed 'lm_sensors' on a dual AMD Opteron 248 on a  
motherboard with AMD 8000 chipset. I am concerned about an error  
message I get when I run 'sensors'. Is this condition OK or, should I  
do anything to fix it?

Here is the output.


[root at argon ~]# sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.54 V  (min =  +0.00 V, max =  +0.00 V)
VCore 2:   +1.54 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +3.38 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.08 V  (min =  +4.76 V, max =  +5.24 V)
+12V:      +4.86 V  (min = +10.82 V, max = +13.19 V)
-12V:      -1.59 V  (min = -13.18 V, max = -10.80 V)
-5V:       -3.79 V  (min =  -5.25 V, max =  -4.75 V)
V5SB:      +5.73 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +2.42 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     7758 RPM  (min = 11065 RPM, div = 2)
fan2:     7500 RPM  (min = 3214 RPM, div = 2)
fan3:     4326 RPM  (min = 2860 RPM, div = 8)
Ambient:     +35?C  (high =   +40?C, hyst =   +37?C)   sensor =  
thermistor
CPU1:      +35.5?C  (high =   +52?C, hyst =   +47?C)   sensor =  
thermistor
CPU2:      +40.5?C  (high =   +52?C, hyst =   +47?C)   sensor =  
thermistor
ERROR: Can't get VID data!
alarms:
beep_enable:
           Sound alarm disabled





