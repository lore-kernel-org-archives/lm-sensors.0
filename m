From: raj@ast.man.ac.uk (Richard James)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Ref ticket #: 755 - Still unable to find the 801 device.
Message-Id: <Pine.OSF.4.21.0112132053210.342-100000@axp0.ast.man.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I tried your suggestion with the same result.  After modifying
i2c-i801.c according to the results of lspci -n, I remade the lm_sensors
code (starting with make clean to ensure everything would re-compiled),
ran sensors-detect and then tried inserting the module manually, with and
without forcing.  I attach a transcript of the results with my input
edited in.  My input commands start after a blank line and are enclosed by
double curly brackets as {{.....}}.  My responses to sensors-detect are
just enclosed in double curly brackets and the enter key is represented by
{{ENTER}}.  I doubt if you will need more than a fraction of this
material, but thought I would include it in case it was useful.

It is of course quite possible that you do not support the device on the
845 chipset.  I do however know it is there as I can see motherboard
voltages, fan speeds and temperatures reported by the bios if I look at it
during the boot-up phase.

I will be most grateful for any comments you wish to make.

		Yours sincerely,

			Richard James.

----------------------------------------------------------------------------
TRANSCRIPT:

{{lspci -n}}
00:00.0 Class 0600: 8086:1a30 (rev 03)
00:01.0 Class 0604: 8086:1a31 (rev 03)
00:1e.0 Class 0604: 8086:244e (rev 12)
00:1f.0 Class 0601: 8086:2440 (rev 12)
00:1f.1 Class 0101: 8086:244b (rev 12)
00:1f.2 Class 0c03: 8086:2442 (rev 12)
00:1f.4 Class 0c03: 8086:2444 (rev 12)
00:1f.5 Class 0401: 8086:2445 (rev 12)
01:00.0 Class 0300: 10de:002d (rev 15)

{{cat kernel/busses/i2c-i801.c}}
/*
    i801.c - Part of lm_sensors, Linux kernel modules for hardware
              monitoring
    Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>,
    Philip Edelbrock <phil@netroedge.com>, and Mark D. Studebaker
    <mdsxyz123@yahoo.com>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

/*
    SUPPORTED DEVICES	PCI ID
    82801AA		2413           
    82801AB		2423           
    82801BA		2443           
    82801CA/CAM		2483           
    82801CC		1a30
    82801DD		1a31
    82801EE		244e
    82801FF		2440
    82801GG		244b
    82801HH		2445

CUT -------------------------------------------

{{make all}}              (Output not included)
{{make install}}          (Output not included)

{{sensors-detect >> temp}}
{{ENTER}}
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation,  just scanning
 the bus will break your thinkpad forever!

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
{{ENTER}}
 Probing for PCI bus adapters...
Use driver `i2c-riva' for device 01:00.0: RIVA UVTNT2
{{ENTER}}
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-riva' (say NO if built into your kernel)? (YES/no):
{{ENTER}}
 Loading failed ()... skipping.
** Note: i2c-riva module is available at 
** http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
{{ENTER}}
  To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
{{ENTER}}
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
{{ENTER}}
 Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT 82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 
{{ENTER}}

 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? 

{{smbus}}
WARNING! If you have some things built into your kernel, the 
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# I2C chip drivers
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----


{{modprobe i2c-i801}
/lib/modules/2.4.16/misc/i2c-i801.o: init_module: No such device
/lib/modules/2.4.16/misc/i2c-i801.o: insmod /lib/modules/2.4.16/misc/i2c-i801.o failed
/lib/modules/2.4.16/misc/i2c-i801.o: insmod i2c-i801 failed
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters

{{insmod -f i2c-i801}}
Using /lib/modules/2.4.16/misc/i2c-i801.o
/lib/modules/2.4.16/misc/i2c-i801.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters

