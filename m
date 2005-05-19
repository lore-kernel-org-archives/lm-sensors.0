From: reg@dwf.com (Reg Clemens)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: 2.6.3 looks OK on this hardware.
Message-Id: <200206250631.g5P6Vq6G001972@orion.dwf.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a partial report for the code in 2.6.3 on kernel 2.4.18

The Motherboard here is a Asus P3V4X, with a 733 MHz PIII on it.
The chipset is a Via VT82C694X
	  and  a Via VT82C596B 
The Hardware monitor chip is a Asus As99127F

Sensors-detect recommends
	i2c-viapro
   and  w83781d

I will assume that the latter is somehow equivalent to the 99127.

These along with i2c-proc give me 'output' in /proc/sys/dev/sensors/w83782d-i2c-0-2d

The two temperatures seem 'reasonable' being close to what the BIOS sees.
Considering the problems Ive seen, I would have expected the CPU temperature
to 'run up' when I loaded the machine down with a kernel compile, but this
didnt happen.  They fluctuate a degree or so, but no runup.  [ then again
the compile didnt segfault...]

The Fan speed is definately WRONG, I cant identify anything else...

*** when the w83781d module is modloaded, a TONE appears on the CPU speaker.
VERY ANNOYING.  after a number of minutes (or a reboot) it stops.  I assume
this means that something is being set incorrectly by this driver.

Also, I have been forced to do fsck's after each reboot where I was previously
using these modules,- looks like something ELSE is getting set incorrectly.

Will try on different hardware tomorrow.

					Reg.Clemens
					reg@dwf.com
