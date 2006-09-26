From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 26 Sep 2006 17:12:53 +0000
Subject: [lm-sensors] 2.10.1: No rule to make target `asm/io.h',
Message-Id: <20060926191253.3a565230.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926135555.GH10410@neu.nirvana>
In-Reply-To: <20060926135555.GH10410@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> I've been rebuilding packages for i2c/lm_sensors 2.10.1 and all build
> fine, only not for the upcoming FC6 release:
> 
> gcc -M -MG -I. -Ikernel/include -I/usr/include  -DSYSFS_SUPPORT -fpic -Wall -O2  lib/general.c | \
>         sed -e 's@^\(.*\)\.o:@lib/general.ld lib/general.lo: Makefile '`dirname lib/general.ld`/Module.mk' @' > lib/general.ld
> gcc -M -MG -I. -Ikernel/include -I/usr/include  -DSYSFS_SUPPORT -fpic -Wall -O2  lib/data.c | \
>         sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.lo: Makefile '`dirname lib/data.ld`/Module.mk' @' > lib/data.ld
> ( grep 'SENSORS SYSCTL START' /dev/null kernel/chips/*.c | \
>           sed -e 's/:.*//' -e 's#^#kernel/include/sensors.h: #' ) > kernel/include/sensors.hd
> cat kernel/include/sensors.h.template > kernel/include/sensors.h
> awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL END/' kernel/chips/*.c >> kernel/include/sensors.h
> echo '#endif' >> kernel/include/sensors.h
> gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include -I/usr/include  -Wundef -Wall -O2  prog/sensord/chips.c | \
>         sed -e 's@^\(.*\)\.o:@prog/sensord/chips.rd prog/sensord/chips.ro: Makefile '`dirname prog/sensord/chips.rd`/Module.mk' @' > prog/sensord/chips.rd
> gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include -I/usr/include  -Wundef -Wall -O2  prog/sensors/chips.c | \
>         sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro: Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' > prog/sensors/chips.rd
> make: *** No rule to make target `asm/io.h', needed by `prog/dump/isadump.rd'.  Stop.

Where were you when I asked for testers before the release? :p

What architecture are you building for?

asm/io.h should be /usr/include/asm/io.h, don't you have that file?
Maybe you're missing the /usr/include/asm symlink to the arch-specific
asm directory?

-- 
Jean Delvare

