From: J.Kilb@gmx.de (Juergen Kilb)
Date: Tue, 29 Aug 2006 19:55:11 +0000
Subject: [lm-sensors] ADT7474
Message-Id: <200608292155.12019.J.Kilb@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
it seems that the ADT7475 is compatible with an ADT7463, so i have tried to 
use the lm85 driver. (The ADT7475 is missing the Vid Inputs.)

My first attempd was to force the ADT7463 with

modprobe lm85 force_adt7463:0,0x2e

but this fails with
==FATAL: Error inserting 
lm85 /lib/modules/2.6.16.21-0.13-smp/kernel/drivers/hwmon/lm85.ko): Unknown 
symbol in module, or unknown parameter (see dmesg)
==

After that i have added the verstep to lm85.c

#define LM85_VERSTEP_ADT7475            0x69

and changed inside lm85_detect ...

  } else if( company = LM85_COMPANY_ANALOG_DEV
                    && (verstep = LM85_VERSTEP_ADT7463
                         || verstep = LM85_VERSTEP_ADT7463C
                         || verstep = LM85_VERSTEP_ADT7475) ) {
                        kind = adt7463 ;

now sensors give me the following infos:

snip=======adt7463-i2c-1-2e
Adapter: SMBus nForce2 adapter at 1c40

V1.5:      +0.000 V  (min =  +0.00 V, max =  +3.32 V)
VCore:     +0.000 V  (min =  +0.00 V, max =  +2.99 V)   ALARM
V3.3:      +3.395 V  (min =  +0.00 V, max =  +4.38 V)
V5:       +0.000 V  (min =  +0.00 V, max =  +6.64 V)
V12:      +0.000 V  (min =  +0.00 V, max = +15.94 V)
CPU_Fan:   2019 RPM  (min =    0 RPM)
fan2:      1420 RPM  (min =    0 RPM)
fan3:      1889 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)
CPU Temp:  +0.25?C  (low  =    +1?C, high =    -1?C)     ALARM FAULT
Board Temp:
          +87.00?C  (low  =    +1?C, high =    -1?C)
Remote Temp:
           +0.00?C  (low  =    +1?C, high =    -1?C)     ALARM FAULT
CPU_PWM:     0
Fan2_PWM:    0
Fan3_PWM:    0
vid:      +0.000 V  (VRM Version 2.4)

snap=========
What do you think about this ?

=Juergen

