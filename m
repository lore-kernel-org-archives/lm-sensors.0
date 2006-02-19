From: juergh@gmail.com (Juerg Haefliger)
Date: Sun, 19 Feb 2006 21:56:41 +0000
Subject: [lm-sensors] infinite loop during 2.10.0 compilation
Message-Id: <191fb4ca0602191356u1b0e19dq1729de2b1b9649c9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I'm trying to build lm_sensors-2.10.0 (kernel 2.6.16-rc3-mm1) but the
compile process goes into an infinite loop.

Any ideas what's going on?

Thanks
...juerg


-bash-3.00#
-bash-3.00# make user
Makefile:297: kernel/include/sensors.hd: No such file or directory
Makefile:297: lib/data.ld: No such file or directory
Makefile:297: lib/general.ld: No such file or directory
Makefile:297: lib/error.ld: No such file or directory
Makefile:297: lib/chips.ld: No such file or directory
Makefile:297: lib/proc.ld: No such file or directory
Makefile:297: lib/access.ld: No such file or directory
Makefile:297: lib/init.ld: No such file or directory
Makefile:297: lib/sysfs.ld: No such file or directory
Makefile:297: lib/data.ad: No such file or directory
Makefile:297: lib/general.ad: No such file or directory
Makefile:297: lib/error.ad: No such file or directory
Makefile:297: lib/chips.ad: No such file or directory
Makefile:297: lib/proc.ad: No such file or directory
Makefile:297: lib/access.ad: No such file or directory
Makefile:297: lib/init.ad: No such file or directory
Makefile:297: lib/sysfs.ad: No such file or directory
Makefile:297: prog/detect/i2cdetect.rd: No such file or directory
Makefile:297: prog/dump/i2cdump.rd: No such file or directory
Makefile:297: prog/dump/i2cset.rd: No such file or directory
Makefile:297: prog/dump/i2cget.rd: No such file or directory
Makefile:297: prog/dump/i2cbusses.rd: No such file or directory
Makefile:297: prog/dump/isadump.rd: No such file or directory
Makefile:297: prog/dump/isaset.rd: No such file or directory
Makefile:297: prog/dump/superio.rd: No such file or directory
Makefile:297: prog/sensors/main.rd: No such file or directory
Makefile:297: prog/sensors/chips.rd: No such file or directory
make: Warning: File `etc/Module.mk' has modification time 1.2e+08 s in
the future
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/sensors/chips.c | \
sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro:
Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' >
prog/sensors/chips.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/sensors/main.c | \
sed -e 's@^\(.*\)\.o:@prog/sensors/main.rd prog/sensors/main.ro:
Makefile '`dirname prog/sensors/main.rd`/Module.mk' @' >
prog/sensors/main.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/superio.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/superio.rd prog/dump/superio.ro:
Makefile '`dirname prog/dump/superio.rd`/Module.mk' @' >
prog/dump/superio.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/isaset.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/isaset.rd prog/dump/isaset.ro:
Makefile '`dirname prog/dump/isaset.rd`/Module.mk' @' >
prog/dump/isaset.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/isadump.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/isadump.rd prog/dump/isadump.ro:
Makefile '`dirname prog/dump/isadump.rd`/Module.mk' @' >
prog/dump/isadump.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cbusses.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cbusses.rd prog/dump/i2cbusses.ro:
Makefile '`dirname prog/dump/i2cbusses.rd`/Module.mk' @' >
prog/dump/i2cbusses.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cget.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cget.rd prog/dump/i2cget.ro:
Makefile '`dirname prog/dump/i2cget.rd`/Module.mk' @' >
prog/dump/i2cget.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cset.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cset.rd prog/dump/i2cset.ro:
Makefile '`dirname prog/dump/i2cset.rd`/Module.mk' @' >
prog/dump/i2cset.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cdump.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cdump.rd prog/dump/i2cdump.ro:
Makefile '`dirname prog/dump/i2cdump.rd`/Module.mk' @' >
prog/dump/i2cdump.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/detect/i2cdetect.c | \
sed -e 's@^\(.*\)\.o:@prog/detect/i2cdetect.rd
prog/detect/i2cdetect.ro: Makefile '`dirname
prog/detect/i2cdetect.rd`/Module.mk' @' > prog/detect/i2cdetect.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/sysfs.c | \
sed -e 's@^\(.*\)\.o:@lib/sysfs.ad lib/sysfs.ao: Makefile '`dirname
lib/sysfs.ad`/Module.mk' @' > lib/sysfs.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/init.c | \
sed -e 's@^\(.*\)\.o:@lib/init.ad lib/init.ao: Makefile '`dirname
lib/init.ad`/Module.mk' @' > lib/init.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/access.c | \
sed -e 's@^\(.*\)\.o:@lib/access.ad lib/access.ao: Makefile '`dirname
lib/access.ad`/Module.mk' @' > lib/access.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/proc.c | \
sed -e 's@^\(.*\)\.o:@lib/proc.ad lib/proc.ao: Makefile '`dirname
lib/proc.ad`/Module.mk' @' > lib/proc.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/chips.c | \
sed -e 's@^\(.*\)\.o:@lib/chips.ad lib/chips.ao: Makefile '`dirname
lib/chips.ad`/Module.mk' @' > lib/chips.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/error.c | \
sed -e 's@^\(.*\)\.o:@lib/error.ad lib/error.ao: Makefile '`dirname
lib/error.ad`/Module.mk' @' > lib/error.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/general.c | \
sed -e 's@^\(.*\)\.o:@lib/general.ad lib/general.ao: Makefile
'`dirname lib/general.ad`/Module.mk' @' > lib/general.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/data.c | \
sed -e 's@^\(.*\)\.o:@lib/data.ad lib/data.ao: Makefile '`dirname
lib/data.ad`/Module.mk' @' > lib/data.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/sysfs.c | \
sed -e 's@^\(.*\)\.o:@lib/sysfs.ld lib/sysfs.lo: Makefile '`dirname
lib/sysfs.ld`/Module.mk' @' > lib/sysfs.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/init.c | \
sed -e 's@^\(.*\)\.o:@lib/init.ld lib/init.lo: Makefile '`dirname
lib/init.ld`/Module.mk' @' > lib/init.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/access.c | \
sed -e 's@^\(.*\)\.o:@lib/access.ld lib/access.lo: Makefile '`dirname
lib/access.ld`/Module.mk' @' > lib/access.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/proc.c | \
sed -e 's@^\(.*\)\.o:@lib/proc.ld lib/proc.lo: Makefile '`dirname
lib/proc.ld`/Module.mk' @' > lib/proc.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/chips.c | \
sed -e 's@^\(.*\)\.o:@lib/chips.ld lib/chips.lo: Makefile '`dirname
lib/chips.ld`/Module.mk' @' > lib/chips.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/error.c | \
sed -e 's@^\(.*\)\.o:@lib/error.ld lib/error.lo: Makefile '`dirname
lib/error.ld`/Module.mk' @' > lib/error.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/general.c | \
sed -e 's@^\(.*\)\.o:@lib/general.ld lib/general.lo: Makefile
'`dirname lib/general.ld`/Module.mk' @' > lib/general.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/data.c | \
sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.lo: Makefile '`dirname
lib/data.ld`/Module.mk' @' > lib/data.ld
( grep 'SENSORS SYSCTL START' /dev/null kernel/chips/*.c | \
  sed -e 's/:.*//' -e 's#^#kernel/include/sensors.h: #' ) >
kernel/include/sensors.hd
make: Warning: File `etc/Module.mk' has modification time 1.2e+08 s in
the future
cat kernel/include/sensors.h.template > kernel/include/sensors.h
awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL END/' kernel/chips/*.c >>
kernel/include/sensors.h
echo '#endif' >> kernel/include/sensors.h
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/sensors/chips.c | \
sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro:
Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' >
prog/sensors/chips.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/sensors/main.c | \
sed -e 's@^\(.*\)\.o:@prog/sensors/main.rd prog/sensors/main.ro:
Makefile '`dirname prog/sensors/main.rd`/Module.mk' @' >
prog/sensors/main.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/superio.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/superio.rd prog/dump/superio.ro:
Makefile '`dirname prog/dump/superio.rd`/Module.mk' @' >
prog/dump/superio.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/isaset.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/isaset.rd prog/dump/isaset.ro:
Makefile '`dirname prog/dump/isaset.rd`/Module.mk' @' >
prog/dump/isaset.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/isadump.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/isadump.rd prog/dump/isadump.ro:
Makefile '`dirname prog/dump/isadump.rd`/Module.mk' @' >
prog/dump/isadump.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cbusses.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cbusses.rd prog/dump/i2cbusses.ro:
Makefile '`dirname prog/dump/i2cbusses.rd`/Module.mk' @' >
prog/dump/i2cbusses.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cget.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cget.rd prog/dump/i2cget.ro:
Makefile '`dirname prog/dump/i2cget.rd`/Module.mk' @' >
prog/dump/i2cget.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cset.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cset.rd prog/dump/i2cset.ro:
Makefile '`dirname prog/dump/i2cset.rd`/Module.mk' @' >
prog/dump/i2cset.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cdump.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cdump.rd prog/dump/i2cdump.ro:
Makefile '`dirname prog/dump/i2cdump.rd`/Module.mk' @' >
prog/dump/i2cdump.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/detect/i2cdetect.c | \
sed -e 's@^\(.*\)\.o:@prog/detect/i2cdetect.rd
prog/detect/i2cdetect.ro: Makefile '`dirname
prog/detect/i2cdetect.rd`/Module.mk' @' > prog/detect/i2cdetect.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/sysfs.c | \
sed -e 's@^\(.*\)\.o:@lib/sysfs.ad lib/sysfs.ao: Makefile '`dirname
lib/sysfs.ad`/Module.mk' @' > lib/sysfs.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/init.c | \
sed -e 's@^\(.*\)\.o:@lib/init.ad lib/init.ao: Makefile '`dirname
lib/init.ad`/Module.mk' @' > lib/init.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/access.c | \
sed -e 's@^\(.*\)\.o:@lib/access.ad lib/access.ao: Makefile '`dirname
lib/access.ad`/Module.mk' @' > lib/access.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/proc.c | \
sed -e 's@^\(.*\)\.o:@lib/proc.ad lib/proc.ao: Makefile '`dirname
lib/proc.ad`/Module.mk' @' > lib/proc.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/chips.c | \
sed -e 's@^\(.*\)\.o:@lib/chips.ad lib/chips.ao: Makefile '`dirname
lib/chips.ad`/Module.mk' @' > lib/chips.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/error.c | \
sed -e 's@^\(.*\)\.o:@lib/error.ad lib/error.ao: Makefile '`dirname
lib/error.ad`/Module.mk' @' > lib/error.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/general.c | \
sed -e 's@^\(.*\)\.o:@lib/general.ad lib/general.ao: Makefile
'`dirname lib/general.ad`/Module.mk' @' > lib/general.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/data.c | \
sed -e 's@^\(.*\)\.o:@lib/data.ad lib/data.ao: Makefile '`dirname
lib/data.ad`/Module.mk' @' > lib/data.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/sysfs.c | \
sed -e 's@^\(.*\)\.o:@lib/sysfs.ld lib/sysfs.lo: Makefile '`dirname
lib/sysfs.ld`/Module.mk' @' > lib/sysfs.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/init.c | \
sed -e 's@^\(.*\)\.o:@lib/init.ld lib/init.lo: Makefile '`dirname
lib/init.ld`/Module.mk' @' > lib/init.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/access.c | \
sed -e 's@^\(.*\)\.o:@lib/access.ld lib/access.lo: Makefile '`dirname
lib/access.ld`/Module.mk' @' > lib/access.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/proc.c | \
sed -e 's@^\(.*\)\.o:@lib/proc.ld lib/proc.lo: Makefile '`dirname
lib/proc.ld`/Module.mk' @' > lib/proc.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/chips.c | \
sed -e 's@^\(.*\)\.o:@lib/chips.ld lib/chips.lo: Makefile '`dirname
lib/chips.ld`/Module.mk' @' > lib/chips.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/error.c | \
sed -e 's@^\(.*\)\.o:@lib/error.ld lib/error.lo: Makefile '`dirname
lib/error.ld`/Module.mk' @' > lib/error.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/general.c | \
sed -e 's@^\(.*\)\.o:@lib/general.ld lib/general.lo: Makefile
'`dirname lib/general.ld`/Module.mk' @' > lib/general.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/data.c | \
sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.lo: Makefile '`dirname
lib/data.ld`/Module.mk' @' > lib/data.ld
make: Warning: File `etc/Module.mk' has modification time 1.2e+08 s in
the future
cat kernel/include/sensors.h.template > kernel/include/sensors.h
awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL END/' kernel/chips/*.c >>
kernel/include/sensors.h
echo '#endif' >> kernel/include/sensors.h
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/sensors/chips.c | \
sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro:
Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' >
prog/sensors/chips.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/sensors/main.c | \
sed -e 's@^\(.*\)\.o:@prog/sensors/main.rd prog/sensors/main.ro:
Makefile '`dirname prog/sensors/main.rd`/Module.mk' @' >
prog/sensors/main.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/superio.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/superio.rd prog/dump/superio.ro:
Makefile '`dirname prog/dump/superio.rd`/Module.mk' @' >
prog/dump/superio.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/isaset.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/isaset.rd prog/dump/isaset.ro:
Makefile '`dirname prog/dump/isaset.rd`/Module.mk' @' >
prog/dump/isaset.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/isadump.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/isadump.rd prog/dump/isadump.ro:
Makefile '`dirname prog/dump/isadump.rd`/Module.mk' @' >
prog/dump/isadump.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cbusses.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cbusses.rd prog/dump/i2cbusses.ro:
Makefile '`dirname prog/dump/i2cbusses.rd`/Module.mk' @' >
prog/dump/i2cbusses.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cget.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cget.rd prog/dump/i2cget.ro:
Makefile '`dirname prog/dump/i2cget.rd`/Module.mk' @' >
prog/dump/i2cget.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cset.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cset.rd prog/dump/i2cset.ro:
Makefile '`dirname prog/dump/i2cset.rd`/Module.mk' @' >
prog/dump/i2cset.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cdump.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cdump.rd prog/dump/i2cdump.ro:
Makefile '`dirname prog/dump/i2cdump.rd`/Module.mk' @' >
prog/dump/i2cdump.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/detect/i2cdetect.c | \
sed -e 's@^\(.*\)\.o:@prog/detect/i2cdetect.rd
prog/detect/i2cdetect.ro: Makefile '`dirname
prog/detect/i2cdetect.rd`/Module.mk' @' > prog/detect/i2cdetect.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/sysfs.c | \
sed -e 's@^\(.*\)\.o:@lib/sysfs.ad lib/sysfs.ao: Makefile '`dirname
lib/sysfs.ad`/Module.mk' @' > lib/sysfs.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/init.c | \
sed -e 's@^\(.*\)\.o:@lib/init.ad lib/init.ao: Makefile '`dirname
lib/init.ad`/Module.mk' @' > lib/init.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/access.c | \
sed -e 's@^\(.*\)\.o:@lib/access.ad lib/access.ao: Makefile '`dirname
lib/access.ad`/Module.mk' @' > lib/access.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/proc.c | \
sed -e 's@^\(.*\)\.o:@lib/proc.ad lib/proc.ao: Makefile '`dirname
lib/proc.ad`/Module.mk' @' > lib/proc.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/chips.c | \
sed -e 's@^\(.*\)\.o:@lib/chips.ad lib/chips.ao: Makefile '`dirname
lib/chips.ad`/Module.mk' @' > lib/chips.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/error.c | \
sed -e 's@^\(.*\)\.o:@lib/error.ad lib/error.ao: Makefile '`dirname
lib/error.ad`/Module.mk' @' > lib/error.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/general.c | \
sed -e 's@^\(.*\)\.o:@lib/general.ad lib/general.ao: Makefile
'`dirname lib/general.ad`/Module.mk' @' > lib/general.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-Wall -O2  lib/data.c | \
sed -e 's@^\(.*\)\.o:@lib/data.ad lib/data.ao: Makefile '`dirname
lib/data.ad`/Module.mk' @' > lib/data.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/sysfs.c | \
sed -e 's@^\(.*\)\.o:@lib/sysfs.ld lib/sysfs.lo: Makefile '`dirname
lib/sysfs.ld`/Module.mk' @' > lib/sysfs.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/init.c | \
sed -e 's@^\(.*\)\.o:@lib/init.ld lib/init.lo: Makefile '`dirname
lib/init.ld`/Module.mk' @' > lib/init.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/access.c | \
sed -e 's@^\(.*\)\.o:@lib/access.ld lib/access.lo: Makefile '`dirname
lib/access.ld`/Module.mk' @' > lib/access.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/proc.c | \
sed -e 's@^\(.*\)\.o:@lib/proc.ld lib/proc.lo: Makefile '`dirname
lib/proc.ld`/Module.mk' @' > lib/proc.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/chips.c | \
sed -e 's@^\(.*\)\.o:@lib/chips.ld lib/chips.lo: Makefile '`dirname
lib/chips.ld`/Module.mk' @' > lib/chips.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/error.c | \
sed -e 's@^\(.*\)\.o:@lib/error.ld lib/error.lo: Makefile '`dirname
lib/error.ld`/Module.mk' @' > lib/error.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/general.c | \
sed -e 's@^\(.*\)\.o:@lib/general.ld lib/general.lo: Makefile
'`dirname lib/general.ld`/Module.mk' @' > lib/general.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT
-fpic -Wall -O2  lib/data.c | \
sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.lo: Makefile '`dirname
lib/data.ld`/Module.mk' @' > lib/data.ld
make: Warning: File `etc/Module.mk' has modification time 1.2e+08 s in
the future
cat kernel/include/sensors.h.template > kernel/include/sensors.h
awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL END/' kernel/chips/*.c >>
kernel/include/sensors.h
echo '#endif' >> kernel/include/sensors.h
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/sensors/chips.c | \
sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro:
Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' >
prog/sensors/chips.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/sensors/main.c | \
sed -e 's@^\(.*\)\.o:@prog/sensors/main.rd prog/sensors/main.ro:
Makefile '`dirname prog/sensors/main.rd`/Module.mk' @' >
prog/sensors/main.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/superio.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/superio.rd prog/dump/superio.ro:
Makefile '`dirname prog/dump/superio.rd`/Module.mk' @' >
prog/dump/superio.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/isaset.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/isaset.rd prog/dump/isaset.ro:
Makefile '`dirname prog/dump/isaset.rd`/Module.mk' @' >
prog/dump/isaset.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/isadump.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/isadump.rd prog/dump/isadump.ro:
Makefile '`dirname prog/dump/isadump.rd`/Module.mk' @' >
prog/dump/isadump.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cbusses.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cbusses.rd prog/dump/i2cbusses.ro:
Makefile '`dirname prog/dump/i2cbusses.rd`/Module.mk' @' >
prog/dump/i2cbusses.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cget.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cget.rd prog/dump/i2cget.ro:
Makefile '`dirname prog/dump/i2cget.rd`/Module.mk' @' >
prog/dump/i2cget.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cset.c | \
sed -e 's@^\(.*\)\.o:@prog/dump/i2cset.rd prog/dump/i2cset.ro:
Makefile '`dirname prog/dump/i2cset.rd`/Module.mk' @' >
prog/dump/i2cset.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2c

