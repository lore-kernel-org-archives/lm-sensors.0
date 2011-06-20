From: Jay Alexander Fleming <tito.nehru.naser@gmail.com>
Date: Mon, 20 Jun 2011 22:07:27 +0000
Subject: [lm-sensors] w83627ehf driver on AsRock 870 Extreme3 mobo with
Message-Id: <BANLkTinDvOYz1-KZtDmF9Bdmvn5xYVHrvA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi all,

Here is my report.

I use w83627ehf driver compiled from kernel tree (2.6.39-gentoo-r1).


# modprobe w83627ehf
# dmesg|tail

 [16562.925302] <3>ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
................
 [16562.925303] <3>ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
................
 [16562.925304] <3>ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
................
 [16562.925306]
 [17380.277397] i2c i2c-4: sendbytes: NAK bailout.
 [17380.363084] [drm:radeon_dvi_detect] *ERROR* DVI-I-1: probed a
monitor but no|invalid EDID
 [17390.373045] i2c i2c-4: sendbytes: NAK bailout.
 [18437.620983] xml-purge[27556]: segfault at 0 ip 0000000000400a2a sp
00007fff13a71860 error 4 in xml-purge[400000+1000]
 [24658.366912] i2c i2c-4: sendbytes: NAK bailout.
 [30731.174173] w83627ehf: Found NCT6775F chip at 0x290

Driver was loaded without problem.

Here is sensors command output (i don't write anything in sensors3.conf):

# sensors
radeon-pci-0400
Adapter: PCI adapter
temp1:        +59.0°C

k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +27.1°C  (high = +70.0°C)

nct6775-isa-0290
Adapter: ISA adapter
Vcore:        +1.07 V  (min =  +0.00 V, max =  +1.74 V)
in1:          +1.89 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
AVCC:         +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
+3.3V:        +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:          +0.07 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:          +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in6:          +0.07 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
3VSB:         +3.46 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
Vbat:         +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
fan1:           0 RPM  (min =    0 RPM, div = 128)
fan2:        3308 RPM  (min =    0 RPM, div = 8)  ALARM
fan3:           0 RPM  (min =    0 RPM, div = 128)
SYSTIN:       +37.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor
= thermistor
CPUTIN:       +36.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
AUXTIN:      +127.5°C  (high = +73.0°C, hyst = +73.0°C)  ALARM  sensor
= thermistor
cpu0_vid:    +0.400 V


I will try to experiment with settings from "Winbond W83627EHF
configuration for ASRock AM2NF3-VSTA" <
http://www.lm-sensors.org/wiki/Configurations/ASRock/AM2NF3-VSTA >

Thank you all
-- 
Jay A. Fleming

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
