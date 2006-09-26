From: lwhite@nrw.ca (Len J. White)
Date: Tue, 26 Sep 2006 20:32:39 +0000
Subject: [lm-sensors] ADT7475
Message-Id: <45198E67.2000500@nrw.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060902193444.a259efdb.khali@linux-fr.org>
In-Reply-To: <20060902193444.a259efdb.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guys,

I have a ADT7475 on my board as well, I don't have much driver 
experience but I am making some headway...

Going from this message:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-September/017552.html

I have since been able to get the CPU temperature working...

adt7463-i2c-1-2e
Adapter: SMBus nForce2 adapter at 1c40
V1.5:      +0.000 V  (min =  +1.42 V, max =  +1.58 V)
VCore:     +0.000 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
V3.3:      +3.360 V  (min =  +3.13 V, max =  +3.47 V)
V5:       +0.000 V  (min =  +4.74 V, max =  +5.26 V)
V12:      +0.000 V  (min = +11.38 V, max = +12.62 V)
CPU_Fan:      0 RPM  (min = 4000 RPM)                     ALARM
fan2:         0 RPM  (min =    0 RPM)
fan3:         0 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)
CPU:      +32.25 C  (low  =   +10 C, high =   +50 C)     ALARM FAULT
Board:     +0.00 C  (low  =   +10 C, high =   +35 C)     ALARM
Remote:    +0.00 C  (low  =   +10 C, high =   +35 C)     ALARM FAULT
CPU_PWM:     0
Fan2_PWM:    0
Fan3_PWM:    0
vid:      +0.000 V  (VRM Version 2.4)


Change this below from register 0x25 to 0x77, 0x25 is the 8bit 
resolution and 0x77 is the 10bit..

#define LM85_REG_TEMP(nr)               (0x77 + (nr))


This gives the correct CPU temperature (verified by bios)  


