From: lnieroda@MI.Uni-Koeln.DE (Lech Nieroda)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: sis 746FX + 963L, winbond w83697hf - new drivers required
Message-Id: <3EB7BA60.7080404@thales.mi.uni-koeln.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo!

I've noticed your comment in the "New Drivers" section concerning the 
new SiS chipsets and possible test support. If you should consider 
developing these drivers, I'd like to assist with testing them on my board.
My efforts to get the current drivers to work have failed, I hope the 
following info will help you:

Specs of my board:
Model: ASRock K7S8X
Chipset: SiS 746FX (NB) and 963L (SB)
	 Winbond W83697HF Super I/O controller

lm_sensors version:
2.7.0 with a 2.4.20 kernel (patched to i2c-2.7.0)

Output of dmesg concering the sensors:
-- snip --
i2c-sis5595.o version 2.7.0 (20021208)
i2c-sis5595.o: SIS5595 bus detected and initialized
i2c-dev.o: Registered 'SMBus SIS5595 adapter at 0137' as minor 1
-- snap --

Here is the relevant output of sensors-detect (the rest of the checks 
has failed):

-- snip --
  BIOS vendor (ACPI): AMI
  System vendor (DMI): American Megatrends Inc.
  BIOS version (DMI): P1.20
  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-sis5595' for device 00:02.0: Silicon Integrated Systems 
SIS5595
Probe succesfully concluded.
[...]
Next adapter: SMBus SIS5595 adapter at 0137 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): y
Can't open /dev/i2c[-/]1

  Some chips are also accessible through the ISA bus. ISA probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan the ISA bus? (YES/no): y
[...]
Probing for `Winbond W83697HF'
   Trying address 0x0290... Success!
     (confidence 8, driver `w83781d')
Probing for `Silicon Integrated Systems SIS5595'
   Trying general detect... Success!
     (confidence 9, driver `sis5595')
[...]
Driver `w83781d' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `Winbond W83697HF' (confidence: 8)

Driver `sis5595' (should be inserted):
   Detects correctly:
   * ISA bus, undetermined address (Busdriver `i2c-isa')
     Chip `Silicon Integrated Systems SIS5595' (confidence: 9)
-- snap --

Here is the output of isadump:

-- snip --
linux:/scratch/lm-sensors/lm_sensors-2.7.0/prog # ./dump/isadump 0x295 0x296
   WARNING! Running this program can cause system crashes, data loss and 
worse!
   I will probe address register 0x0295 and data register 0x0296.
   You have five seconds to reconsider and press CTRL-C!

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 71 04 d3 b7 c2 c2 c3 3b f0 ef ff 00 00 d1 e0 e3
30: ba cc a8 d8 b2 31 15 40 2c 3c 7f e1 e1 ad 00 00
40: 01 c3 0e 00 00 00 00 5f 2d 02 01 44 41 95 00 a3
50: ff ff 00 ff ff ff 00 00 60 70 ff ff 19 01 ff 05
60: 71 04 d3 b7 c2 c2 c3 3b f0 ef ff 00 00 d1 e0 e3
70: ba cc a8 d8 b2 31 15 40 2c 3c 7f e1 e1 ad 00 00
80: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 71 04 d3 b7 c2 c2 c3 3b f0 ef ff 00 00 d1 e0 e3
b0: ba cc a8 d8 b2 31 15 40 2c 3c 7f e1 e1 ad 00 00
c0: 01 00 00 00 00 00 00 5f 2d 02 01 44 41 95 00 a3
d0: ff ff 00 ff ff ff 00 00 60 70 ff ff 19 01 ff 05
e0: 71 04 d3 b7 c2 c2 c3 3b f0 ef ff 00 00 d1 e0 e3
f0: ba cc a8 d8 b2 31 15 40 2c 3c 7f e1 e1 ad 00 00
-- snap --

Output of sensors (with i2c-core sis5595 w83781d i2c-isa i2c-sis5595 
i2c-dev i2c-proc inserted) :

-- snip --
w83697hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm

sis5595-isa-8008
Adapter: ISA adapter
Algorithm: ISA algorithm
in0:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
in1:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
in2:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
in3:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
fan1:        0 RPM  (min =    0 RPM, div = 8)          ALARM
fan2:        0 RPM  (min =    0 RPM, div = 8)          ALARM
temp:     +51.2?C   (limit = +51?C, hysteresis = +51?C) ALARM
alarms:   Board temperature input (usually LM75 chips) ALARM
-- snap --

Greetings,
Lech Nieroda

