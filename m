From: kestas <kestas@alfa.lema.mii.lt>
Date: Sun, 22 Nov 2009 16:17:41 +0000
Subject: [lm-sensors] sch5017 on tyan s2925e
Message-Id: <200911221817.41365.kestas@alfa.lema.mii.lt>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Tyan s2925e board with SMSC SCH5017 chip, recognised as DME1737 by sensors,.

kernel 2.6.30
sensors-detect revision 5569 (2008-12-15 09:36:09 +0100)
sensors version 2.10.8 with libsensors version 2.10.8.

There are 5 PWM fan connectors on board and one fan tachometer connector.

All installed five fans are with PWM, PS fan tachometer output connected to 
fan tachometer input connector on board.

Sensors found only following:

dme1737-i2c-0-2e
Adapter: SMBus nForce2 adapter at 2d00
Vdimm:     +1.79 V  (min =  +0.00 V, max =  +6.64 V)
Vcore:     +1.20 V  (min =  +0.00 V, max =  +2.99 V)
V3.3:      +3.36 V  (min =  +0.00 V, max =  +4.38 V)
V5:        +5.15 V  (min =  +0.00 V, max =  +6.64 V)
V12:      +12.29 V  (min =  +0.00 V, max = +15.94 V)
V3.3stby:  +3.35 V  (min =  +0.00 V, max =  +4.38 V)
Vbat:      +3.13 V  (min =  +0.00 V, max =  +4.38 V)
SATA T:      +45 C  (low  =  -127 C, high =  +127 C)
CPU T:       +38 C  (low  =  -127 C, high =  +127 C)
MC55 T:      +54 C  (low  =  -127 C, high =  +127 C)
CPU_Fan:  2330 RPM  (min =    0 RPM)
Fan2:     1304 RPM  (min =    0 RPM)
Fan3:     1401 RPM  (min =    0 RPM)
Fan4:     1170 RPM  (min =    0 RPM)
CPU_PWM:   128      (enable = 2, freq =  25000 Hz)
Fan2_PWM:  128      (enable = 2, freq =  25000 Hz)
Fan3_PWM:  128      (enable = 2, freq =  25000 Hz)
cpu0_vid: +1.550 V  (VRM Version 2.5)

dme1737-i2c-1-2e
Adapter: SMBus nForce2 adapter at 2e00
Vdimm:     +1.79 V  (min =  +0.00 V, max =  +6.64 V)
Vcore:     +1.20 V  (min =  +0.00 V, max =  +2.99 V)
V3.3:      +3.36 V  (min =  +0.00 V, max =  +4.38 V)
V5:        +5.15 V  (min =  +0.00 V, max =  +6.64 V)
V12:      +12.29 V  (min =  +0.00 V, max = +15.94 V)
V3.3stby:  +3.35 V  (min =  +0.00 V, max =  +4.38 V)
Vbat:      +3.13 V  (min =  +0.00 V, max =  +4.38 V)
SATA T:      +45 C  (low  =  -127 C, high =  +127 C)
CPU T:       +38 C  (low  =  -127 C, high =  +127 C)
MC55 T:      +54 C  (low  =  -127 C, high =  +127 C)
CPU_Fan:  2329 RPM  (min =    0 RPM)
Fan2:     1304 RPM  (min =    0 RPM)
Fan3:     1400 RPM  (min =    0 RPM)
Fan4:     1170 RPM  (min =    0 RPM)
CPU_PWM:   128      (enable = 2, freq =  25000 Hz)
Fan2_PWM:  128      (enable = 2, freq =  25000 Hz)
Fan3_PWM:  128      (enable = 2, freq =  25000 Hz)
cpu0_vid: +1.550 V  (VRM Version 2.5)

Maybe it is possible to modify dme1737, I can do testing.

Kestas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
