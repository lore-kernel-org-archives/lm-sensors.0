From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Jul 2013 11:32:29 +0000
Subject: Re: [lm-sensors] sensors quit working
Message-Id: <20130705133229.27d5b37c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201307042128.r64LSOcp022588@mail01.lsn.net>
In-Reply-To: <201307042128.r64LSOcp022588@mail01.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 5 Jul 2013 06:23:10 -0500, Leslie Rhorer wrote:
> # sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)
> # Board: ASUSTeK COMPUTER INC. M5A99X EVO R2.0
> 
> 
> Driver `it87':
>   * ISA bus, address 0x290
>     Chip `ITE IT8721F/IT8758E Super IO Sensors' (confidence: 9)

Support was added in kernel 2.6.37.

> 
> Driver `fam15h_power':
>   * Chip `AMD Family 15h power sensors' (confidence: 9)

Support was added in kernel 3.0.

> Driver `k10temp':
>   * Chip `AMD Family 15h thermal sensors' (confidence: 9)

Support was added in kernel 3.0.

> (...)
> 	No, as I reported, I did not reinstall the system.  I only did a
> global upgrade (apt-get upgrade).

This is the same in this respect. If the kernel package was updated,
your local changes have been overwritten. So your custom it87 and
k10temp drivers are gone.

> > I have a k10temp driver here:
> > 
> > http://khali.linux-fr.org/devel/lm-sensors/drivers/k10temp/
> > 
> > and an it87 driver there:
> > 
> > http://khali.linux-fr.org/devel/lm-sensors/drivers/it87/
> > 
> > I can't remember how up-to-date they are exactly, let me know if have
> > problem building them or find bugs in them. Instructions are at:
> > 
> > http://khali.linux-fr.org/devel/lm-sensors/drivers/INSTALL
> 
> 	I tried compiling k10temp, and it didn't work:
> 
> RAID-Server:/RAID/Server-Main/Temp/sensors# make
> make[1]: Entering directory `/usr/src/linux-headers-2.6.32-5-amd64'
> make[4]: *** No rule to make target
> `/RAID/Server-Main/Temp/sensors/k10temp.c', needed by
> `/RAID/Server-Main/Temp/sensors/k10temp.o'.  Stop.
> make[3]: *** [_module_/RAID/Server-Main/Temp/sensors] Error 2
> make[2]: *** [sub-make] Error 2
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-5-amd64'
> make: *** [modules] Error 2

You are supposed to download all files from one location (for example
http://khali.linux-fr.org/devel/lm-sensors/drivers/k10temp/) to the
same directory on your disk. From the above it looks like you copied
Makefile but not k10temp.c.

> 	I'm not certain, but I think the issue may be the line
> 
> SYSTEM_MAP      := $(shell if test -r /boot/System.map-$(TARGET)...
> 
> 	In the Makefile.  I'm not all that familiar with makefiles, but to
> me it looks like the expression "$(shell...)" is expecting "shell" to be a
> command recognized by the system, and it is not.  (The earlier line " TARGET
> := $(shell uname -r)" also fails, but I replaced it with a specific kernel
> name.)

No, this is all fine, a Makefile is not a shell script. If you want to
understand the syntax of makefiles better, try "info make".

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
