From: sam <samflanker@gmail.com>
Date: Fri, 04 Jul 2008 13:06:30 +0000
Subject: [lm-sensors] trouble of lm-sensors compilation on FreeBSD
Message-Id: <486E2056.4020406@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello

i am trying install lm-sensors on FreeBSD

------------------------------------------------------------------------------------------------------

# uname -a
FreeBSD damascus 7.0-STABLE FreeBSD 7.0-STABLE #19: Fri Jul  4 13:51:15 
MSD 2008     root@static:/usr/obj/usr/src/sys/DAMASCUS  i386
# gmake user

***

gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  lib/data.c | \
        sed -e 's@^\(.*\)\.o:@lib/data.ad lib/data.ao: Makefile 
'`dirname lib/data.ad`/Module.mk' @' > lib/data.ad
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/sysfs.c | \
        sed -e 's@^\(.*\)\.o:@lib/sysfs.ld lib/sysfs.lo: Makefile 
'`dirname lib/sysfs.ld`/Module.mk' @' > lib/sysfs.ld
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/init.c | \
        sed -e 's@^\(.*\)\.o:@lib/init.ld lib/init.lo: Makefile 
'`dirname lib/init.ld`/Module.mk' @' > lib/init.ld
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/access.c | \
        sed -e 's@^\(.*\)\.o:@lib/access.ld lib/access.lo: Makefile 
'`dirname lib/access.ld`/Module.mk' @' > lib/access.ld
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/error.c | \
        sed -e 's@^\(.*\)\.o:@lib/error.ld lib/error.lo: Makefile 
'`dirname lib/error.ld`/Module.mk' @' > lib/error.ld
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/general.c | \
        sed -e 's@^\(.*\)\.o:@lib/general.ld lib/general.lo: Makefile 
'`dirname lib/general.ld`/Module.mk' @' > lib/general.ld
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/data.c | \
        sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.lo: Makefile 
'`dirname lib/data.ld`/Module.mk' @' > lib/data.ld
ldconfig: illegal option -- p
usage: ldconfig [-32] [-aout | -elf] [-Rimrsv] [-f hints_file] 
[directory | file ...]
gmake: *** No rule to make target `asm/io.h', needed by 
`prog/dump/superio.rd'.  Stop.
------------------------------------------------------------------------------------------------------

please, any solutions?

/Vladimir Ermakov



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
