From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Tue, 26 Sep 2006 13:55:55 +0000
Subject: [lm-sensors] 2.10.1: No rule to make target `asm/io.h',
Message-Id: <20060926135555.GH10410@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've been rebuilding packages for i2c/lm_sensors 2.10.1 and all build
fine, only not for the upcoming FC6 release:

gcc -M -MG -I. -Ikernel/include -I/usr/include  -DSYSFS_SUPPORT -fpic -Wall -O2  lib/general.c | \
        sed -e 's@^\(.*\)\.o:@lib/general.ld lib/general.lo: Makefile '`dirname lib/general.ld`/Module.mk' @' > lib/general.ld
gcc -M -MG -I. -Ikernel/include -I/usr/include  -DSYSFS_SUPPORT -fpic -Wall -O2  lib/data.c | \
        sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.lo: Makefile '`dirname lib/data.ld`/Module.mk' @' > lib/data.ld
( grep 'SENSORS SYSCTL START' /dev/null kernel/chips/*.c | \
          sed -e 's/:.*//' -e 's#^#kernel/include/sensors.h: #' ) > kernel/include/sensors.hd
cat kernel/include/sensors.h.template > kernel/include/sensors.h
awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL END/' kernel/chips/*.c >> kernel/include/sensors.h
echo '#endif' >> kernel/include/sensors.h
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include -I/usr/include  -Wundef -Wall -O2  prog/sensord/chips.c | \
        sed -e 's@^\(.*\)\.o:@prog/sensord/chips.rd prog/sensord/chips.ro: Makefile '`dirname prog/sensord/chips.rd`/Module.mk' @' > prog/sensord/chips.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include -I/usr/include  -Wundef -Wall -O2  prog/sensors/chips.c | \
        sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro: Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' > prog/sensors/chips.rd
make: *** No rule to make target `asm/io.h', needed by `prog/dump/isadump.rd'.  Stop.

-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060926/3db86ba7/attachment.bin 
