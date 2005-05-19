From: wik@blueyonder.co.uk (Rik Ryall)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: Asus P4C800-E Deluxe/Winbond W83627THF issue
Message-Id: <200502022021.06992.wik@blueyonder.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hiya,
	I'm something of a noob to Linux (only two years...) so please bear with 
me. :-)

I'm running Suse 9.2 Pro with a 2.6.8 kernel (2.6.8-24.11-smp to be precise) 
and whilst I've made /some/ progress with getting sensors to work, I seem to 
be getting less positive results than I did on my previous 2.4-based build.

I'm getting it to see the sensor and it's giving some interesting figures 
despite tweaking and twiddling sensors.conf until I've gone cross-eyed.

I /think/ that CPU temp figure is a tad low and suspect it to be the mobo 
temp.

I've tried issuing the "force_w83627thf:" parm when loading the module, 
however, I'm unsure of the array parms that should follow.

Also, despite setting the vid parm to 9.0, 9.1 and 10.0, I still can't get rid 
of the error...

Am I being overly thick?

Many thanks,

Rik.


poochzilla:/etc # sensors
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +0.82 V  (min =  +0.96 V, max =  +0.96 V)
+12V:     +12.10 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +3.33 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.99 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)
V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +0.00 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 5273 RPM, div = 32)
CPU Fan:     0 RPM  (min =   -1 RPM, div = 2)
fan3:     1430 RPM  (min =   -1 RPM, div = 8)
M/B Temp:   +125?C  (high =    +0?C, hyst =    +0?C)   sensor = PII/Celeron 
diode
CPU Temp:  +26.0?C  (high =   +80?C, hyst =   +75?C)   sensor = PII/Celeron 
diode
temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor
ERROR: Can't get VID data!
alarms:
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512


