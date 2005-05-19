From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: compilation error
Message-Id: <20031223224953.35de4526.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031223135304.7b789b49.marco@iftbqp.com>
In-Reply-To: <20031223135304.7b789b49.marco@iftbqp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[MDS, read below please.]

> I checked for the includes dir.
> ls -l /usr/local/include 
> total 0
> lrwxrwxrwx    1 root     staff          28 2003-05-27 17:12 linux ->
> /usr/src/linux/include/linux

This is wrong AFAIK. Your should not have such a link. If you have an
"asm" link here too, you shouldn't either. You must have two sets of
linux+asm includes. One in /usr/include, that matches the ones your libc
was build with. And one in /usr/src/linux/include (or whatever) with the
ones for your running kernel. The first ones should *not* be symlinks
pointing to the second ones. They must all be read directories.

I know that old systems do it that way but that's bad and it is known
that i2c and lm_sensors have difficulties building in these conditions.

Still...

> I try to make clean i2c, lm_sensors, the kernel tree etc. But I still
> have the error :
> 
> ..
> gcc -M -MG  -D__SMP__ -DMODVERSIONS -include
> /lib/modules/2.4.23-ben1/build/include/linux/modversions.h
> -D__KERNEL__-DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I.
> -Ikernel/include-I/usr/local/include 
> -I/lib/modules/2.4.23-ben1/build/include -nostdinc-I
> /usr/lib/gcc-lib/powerpc-linux/3.3.3/include  -Wall -O2
> kernel/busses/i2c-nforce2.c | \
>        	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-nforce2.d
> kernel/busses/i2c-nforce2.o: Makefile '`dirname
> kernel/busses/i2c-nforce2.d`/Module.mk' @' >
> kernel/busses/i2c-nforce2.d cat kernel/include/sensors.h.template >
> kernel/include/sensors.h awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL
> END/' kernel/chips/*.c >> kernel/include/sensors.h
> echo '#endif' >> kernel/include/sensors.h
> gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -Wall -O2 
> prog/sensors/chips.c | \
>        	sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd
> prog/sensors/chips.ro: Makefile '`dirname
> prog/sensors/chips.rd`/Module.mk' @' > prog/sensors/chips.rd
> make: *** No rule to make target `sys/io.h', needed by
> `prog/dump/isadump.rd'.  Stop.
> 
> Could someone help me. Or give me some pointers to any solution for
> managing the fan on g4 1ghz (the mirror one;))

isadump doesn't compile on non-i386 targets, and isn't useful here
either. Edit prog/dump/Module.mk and remove isadump from
PROGDUMPTARGETS, PROGDUMPSOURCES and PROGDUMPBININSTALL.

We should either fix isadump or remove it from the targets on non-i386
systems, but I don't know how to do that. MDS?

Thanks for reporting, let us know how it goes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
