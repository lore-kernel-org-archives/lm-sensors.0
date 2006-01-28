From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 28 Jan 2006 17:57:43 +0000
Subject: [lm-sensors] packaging problem with latest CVS snapshot ?
Message-Id: <43DBB097.2020100@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I just pulled lm_sensors-daily.tar.gz, unpacked and ran make,
got this error:

[jimc at harpo lm_sensors2]$ make user
...
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT 
-fpic -Wall -O2  lib/error.c | \
sed -e 's@^\(.*\)\.o:@lib/error.ld lib/error.lo: Makefile '`dirname 
lib/error.ld`/Module.mk' @' > lib/error.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT 
-fpic -Wall -O2  lib/general.c | \
sed -e 's@^\(.*\)\.o:@lib/general.ld lib/general.lo: Makefile '`dirname 
lib/general.ld`/Module.mk' @' > lib/general.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -DSYSFS_SUPPORT 
-fpic -Wall -O2  lib/data.c | \
sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.lo: Makefile '`dirname 
lib/data.ld`/Module.mk' @' > lib/data.ld
( grep 'SENSORS SYSCTL START' /dev/null kernel/chips/*.c | \
  sed -e 's/:.*//' -e 's#^#kernel/include/sensors.h: #' ) > 
kernel/include/sensors.hd
cat kernel/include/sensors.h.template > kernel/include/sensors.h
awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL END/' kernel/chips/*.c >> 
kernel/include/sensors.h
echo '#endif' >> kernel/include/sensors.h
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include 
-I/usr/local/include  -Wundef -Wall -O2  prog/sensors/chips.c | \
sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro: 
Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' > 
prog/sensors/chips.rd
make: *** No rule to make target `sysfs/libsysfs.h', needed by 
`lib/sysfs.ad'.  Stop.





A very similar thing happened when I pulled from SVN.
I pulled the entire tree, was unhappy with the great gobs of stuff I 
didnt need,
and pruned everything but the lmsensors2 stuff.
When I got the error (like above) I figured I over-trimmed,
but seeing above, maybe that wasnt the trouble.

