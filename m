From: cezarym@pf.pl (Cezary Morga)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: w83627hf module
Message-Id: <200407201955.33362.cezarym@pf.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello.
I have installed lm_sensors 2.8.7 from an rpm package (for mandrake 10.0) and 
have problems with configuration.
My motherboard is VIA VT8233A (though instruction for my M/B says it's V266B). 
And when first probing it finds i2c-viapro for this bus but later on finds 
nothing on SMBus Via Pro adapter (only eeprom), on ISA bus it finds Winbond 
W83697HF (w83781d driver) and on Super I/0 it finds Winbond W83697HF Super IO 
Sensors.
Here's the summary :
Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)

Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF Super IO Sensors' (confidence: 9)
My problem is that it tells me to $modprobe w83627hf which outputs :
FATAL: Module w83627hf not found.
And when I try to $modprobe w83781d module is loaded successfuly but
$sensors -s
outputs :
w83697hf-isa-0290: Can't access procfs/sysfs file for writing;
Run as root?
though I'm a root...
What's going on?
-- 
Cezary Morga <cezarym@pf.pl>
GG# 169903 ICQ# 328-700-565
Jabber: thereidos@jabber.aster.pl
	thereidos@jabberpl.org
