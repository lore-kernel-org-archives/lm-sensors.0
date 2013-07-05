From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Fri, 05 Jul 2013 11:23:10 +0000
Subject: Re: [lm-sensors] sensors quit working
Message-Id: <201307051123.r65BNAUw014799@mail03.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201307042128.r64LSOcp022588@mail01.lsn.net>
In-Reply-To: <201307042128.r64LSOcp022588@mail01.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Friday, July 05, 2013 2:35 AM
> To: Leslie Rhorer
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] sensors quit working
> 
> Hi Leslie,
> 
> On Thu, 4 Jul 2013 16:28:23 -0500, Leslie Rhorer wrote:
> > I had sensors working pretty well, but then I upgraded my distro and it
> quit
> > working completely.  I tried running sensors-detect, and it reports I
> need
> > to load it87, k10temp, and fam15_power in order to run sensors.  I can
> load
> > k10temp, but sensors does not find any monitor points when I do.
> >
> > Attempting to load it87 give an error: FATAL: "Error inserting it87
> > (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such
> device"
> >
> > The module fam15_power.o does not exist.
> 
> It is named fam15h_power. But this driver is only available since
> kernel 3.0.
> 
> > I vaguely recall having some
> > issues with fam15_power when I installed this motherboard several months
> > ago, but I also recall it did not seem to do very much that I needed.
> >
> > There are backup versions of it87.ko and k10temp.ko in the
> > /lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon directory.
> >
> > How should I proceed?
> 
> Send us the summary output of sensors-detect as a starter, because at
> this point we have no idea what hardware you have.

Sorry, I forgot to mention that:

# sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)
# Board: ASUSTeK COMPUTER INC. M5A99X EVO R2.0


Driver `it87':
  * ISA bus, address 0x290
    Chip `ITE IT8721F/IT8758E Super IO Sensors' (confidence: 9)

Driver `fam15h_power':
  * Chip `AMD Family 15h power sensors' (confidence: 9)

Driver `k10temp':
  * Chip `AMD Family 15h thermal sensors' (confidence: 9)

Warning: the required module fam15h_power is not currently installed
on your system. If it is built into the kernel then it's OK.
Otherwise, check http://www.lm-sensors.org/wiki/Devices for
driver availability.


> Kernel 2.6.32 isn't exactly new so it is no surprise that it wouldn't
> support relatively recent hardware out of the box.

	As I reported, it worked before, at least partially.  I don't know
if you recall, but I had issues with the fact there were more fans than
sensors knew how to handle, and the various scan points would hop around
from one physical sensor point to another.  The temps all worked OK, though.

> I can only guess
> that you previously had to build standalone flavors of the monitoring
> drivers.

	I don't recall that.  It's been a while.

> This would explain the backup versions of these drivers. If
> you reinstalled your system, you may have to build these standalone
> drivers again.

	No, as I reported, I did not reinstall the system.  I only did a
global upgrade (apt-get upgrade).

> I have a k10temp driver here:
> 
> http://khali.linux-fr.org/devel/lm-sensors/drivers/k10temp/
> 
> and an it87 driver there:
> 
> http://khali.linux-fr.org/devel/lm-sensors/drivers/it87/
> 
> I can't remember how up-to-date they are exactly, let me know if have
> problem building them or find bugs in them. Instructions are at:
> 
> http://khali.linux-fr.org/devel/lm-sensors/drivers/INSTALL

	I tried compiling k10temp, and it didn't work:

RAID-Server:/RAID/Server-Main/Temp/sensors# make
make[1]: Entering directory `/usr/src/linux-headers-2.6.32-5-amd64'
make[4]: *** No rule to make target
`/RAID/Server-Main/Temp/sensors/k10temp.c', needed by
`/RAID/Server-Main/Temp/sensors/k10temp.o'.  Stop.
make[3]: *** [_module_/RAID/Server-Main/Temp/sensors] Error 2
make[2]: *** [sub-make] Error 2
make[1]: *** [all] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-5-amd64'
make: *** [modules] Error 2


	I'm not certain, but I think the issue may be the line

SYSTEM_MAP      := $(shell if test -r /boot/System.map-$(TARGET)...

	In the Makefile.  I'm not all that familiar with makefiles, but to
me it looks like the expression "$(shell...)" is expecting "shell" to be a
command recognized by the system, and it is not.  (The earlier line " TARGET
:= $(shell uname -r)" also fails, but I replaced it with a specific kernel
name.)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
