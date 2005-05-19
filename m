From: christy@attglobal.net (Peter Christy)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: feedback
Message-Id: <200212141421.50457.christy@attglobal.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200203231220.g2NCKQD01021@shire.frodo.local>
In-Reply-To: <200203231220.g2NCKQD01021@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Feedback regarding lm_sensors.

(pls forgive me if I've sent this to the wrong address, but this one seemed 
the most appropriate)

I've just installed the latest lm_sensors packages (i2c-2.7.0 and 
lm_sensors-2.7.0) on three machines (from ancient to modern) and think that 
the following feedback may be of general interest.

All the machines are running freshly compiled 2.4.20 kernels, and lm_sensors 
was installed using method (1) (seperate from kernel)

###############################################################################

Starting with the oldest machine first:

Motherboard: 	Asus P5AB
Chipset:		Ali V
Processor:	AMD K6-2-350 (overclocked to 400)
OS:			VectorLinux 3.0 (Slackware-alike)
Sensor chip:	W83781D


Modules loaded:	eeprom
				W8371D
				i2c-proc
				i2c-isa
				i2c-ali15x3
				i2c-core


temp1 appears to be the SYS temp
temp2 appears to be the CPU temp (slightly higher than above)
temp3 appears to be MB/ambient case (?) temp

I had to tweak the suggested w83781d temperature limits to reflect the above 
order....

fan2 appears to be CPU fan (probably depends on which connector fan is 
					      connected to...)

The in2 ("3.3v") readings appear slightly anomolous, reading higher than the 
"VID" voltage, and slightly higher than that reported by the BIOS - enough to 
trigger the alarm. Assuming the BIOS to be right, I have widened the limits 
from 5% to 10% as a stop-gap measure. (The machine has functioned perfectly 
for several years, so I think I can assume its functioning within acceptable 
limits!)

Installation funnies: VectorLinux is based on Slackware (which uses BSD style 
init scripts) but has added a SysV init layer to "aid" compatibility. This 
confused the installation detection which suggested installing a SysV (init.d) 
script as well as suggesting lines to go in rc.local. You need to choose one 
or the other, but not both! I went the rc.local route which worked fine.

Note: It's not enough just to put "sensors -s" in rc.local - you have to put 
the full path, ie /usr/local/bin/sensors -s

###############################################################################

A more recent machine:

Motherboard:	Gigabyte GA-7ZM
Chipset:		VIA KT-133
Processor	AMD Duron 1.2GHz
OS			Slackware 9.0b
Sensor chip:	Via 686a

Modules loaded:	via686a
				eeprom
				i2c-proc
				i2c-isa
				i2c-viapro
				i2c-core

temp1 appears to be CPU temp (highest)
temp2 appears to be SYS temp
temp3 appears to be MB/anbient case (?) temp

The suggested in0 min and max voltages seemed incorrect for this 
mobo/processor combination. I reduced them from 2.0/2.5 to 1.6/2.1 to more 
accurately reflect the proper values.

Sensors is called from rc.local using the full path (/usr/local/bin/sensors 
-s)

This was the least problematic install of the three.

###############################################################################

The most modern (and probably interesting!) machine:

an FIC A360+ laptop (Locally re-badged as a Tiny MediaBook 1000)

Motherboard:	FIC(?)
Chipset:		Via 686 (No specs from FIC, or visible on boot, but its definitely 
			some kind of 686!)
Processor:	Intel Celeron 1GHz
OS:			Slackware 8.1
Sensor chip	686a-isa (?)

Note: To function correctly, this machine *must* have a recent acpi patch 
applied to the kernel!

Modules loaded:	via686a
				i2c-proc
				i2c-isa
				i2c-core

temp1 and temp2 mostly report identical temperatures, so its difficult to 
determine which is the cpu and which is the sys!

Both fans sensors read 0, even though (once the acpi patch is applied) the 
processor fan throttles properly. (There is only one fan)

sensors-detect reported being unable to load the viapro module.

It was necessary to "modprobe via686a force_addr=0xf000" to get the via686 
module to run correctly.

The full path to sensors -s needs to be added to rc.local

This one was definitely the most fiddly of the lot, not helped by the 
unavailability of any significant technical info from the FIC website. 
Although they have a technical specs page for this laptop, it is very sparse 
and doesn't even specify the chipset used! Its possible that this machine 
needs one of the "un-probeable" drivers, but I don't know how to determine 
this. I seem to be getting sensible voltage and temperature readings, but it 
would be nice to have some fan info as well!




As I said, forgive me if I've sent this info to the wrong address, but 
hopefully you (and others) may find it useful.......

--
Pete Christy
christy@attglobal.net
