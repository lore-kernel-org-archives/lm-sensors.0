From: dcb@pa.net (Douglas Bollinger)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: From Ticket 1972, Gigabyte 7dpxdw+, making it work correctly
Message-Id: <20050504174827.11115a83.dcb@pa.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is from Ticket #1972, Gigabyte 7dpxdw+, making it work correctly

> the lm90 chip, driver, and userspace supports two temperatures.  are you
> saying that only one is reported or only one is correct?  If only one is
> reported check that the other is not set to ignore in /etc/sensors.conf.
> If incorrect you can try adjusting with a compute line in sensors.conf.
> If you need more help follow up by email, ref. your ticket number.
> MDS 5/4/05

Sorry, I should have been more precise.  This is a duallie board, so the
LM90 needs to support TWO external temperatures, instead of the usual one,
along with the usual on-the-chip sensor.  That is what is so special (or
odd) about this board.

Here's a sensor output of what I have so far:

******
doug@ghidorah etc $ sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.52 V  (min =  +1.52 V, max =  +1.68 V)       ALARM
VCore 2:   +1.52 V  (min =  +1.52 V, max =  +1.68 V)       ALARM
+3.3V:     +3.10 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.73 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
+12V:     +11.49 V  (min = +10.82 V, max = +13.19 V)
-12V:     -12.03 V  (min = -13.18 V, max = -10.80 V)
-5V:       -5.05 V  (min =  -5.25 V, max =  -4.75 V)
V5SB:      +5.35 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.20 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min =    0 RPM, div = 2)
fan2:        0 RPM  (min =    0 RPM, div = 2)
fan3:        0 RPM  (min =    0 RPM, div = 2)
temp1:       +30 C  (high =  +127 C)                     sensor = thermistor 
temp2:     +32.0 C  (high =  +127 C, hyst =  +128 C)   sensor = thermistor 
temp3:     +37.5 C  (high =  +127 C, hyst =  +128 C)   sensor = thermistor 
vid:      +1.600 V  (VRM Version 9.0)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

eeprom-i2c-1-53
Adapter: SMBus AMD768 adapter at 50e0
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-1-52
Adapter: SMBus AMD768 adapter at 50e0
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-1-51
Adapter: SMBus AMD768 adapter at 50e0
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-1-50
Adapter: SMBus AMD768 adapter at 50e0
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

lm90-i2c-1-4c
Adapter: SMBus AMD768 adapter at 50e0
M/B Temp:    +49 C  (low  =    +0 C, high =   +70 C)
CPU Temp:  +81.2 C  (low  =  +0.0 C, high = +70.0 C)   ALARM
M/B Crit:    +85 C  (hyst =   +75 C)
CPU Crit:    +85 C  (hyst =   +75 C)

Philips NTSC -i2c-0-61
Adapter: bt878 #0 [sw]

tveeprom-i2c-0-50
Adapter: bt878 #0 [sw]
******

From the w83627hf: the voltage readings are OK, the fan RPM readings are OK
as none of my fans have tach lines and the 3 temp. readings are a mystery.
They have nothing to do with the CPU temps.

Skipping down to the lm90, I assume the M/B Temp is the "on-the-chip"
sensor and the CPU temp is the one external temp reading that works.  If I
stall a CPU fan this reading will rise, so this one is good.  Of course,
it's way too high, but that's the way it shows in the BIOS and that's easy
enough to fix anyway.  

The problem is that the lm90 should have one more external temp for the 2nd
CPU.

The website to this Windows program:

http://mbm.livewiredev.com/

The motherboard list of the above website shows the GA7 DPXDW+ with a
LM90-1 remote and a LM90-2 remote.  Alas, the program is closed source so
it's not much help.  The author also quit supporting this program so I
suppose emailing him and asking how he did it wouldn't be much help either.

-- 
"Rights" is a fictional abstraction.  No one has "Rights", neither machines
nor flesh-and-blood.  Persons... have opportunities, not rights, which they
use or do not use.
		-- Lazarus Long
