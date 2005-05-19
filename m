From: jumpyboy@infinito.it (Gianni)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: lm_sensors 2.8.3
Message-Id: <200401291139.58838.jumpyboy@infinito.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I doesn't compile with "make users".
I'm using kernle 2.6.1 and trying to compile lm_sensors 2.8.3 with make users, 
but I get this:
/lib/modules/2.6.1/build/include/linux/highmem.h:87:36: macro 
"clear_user_page" requires 3 arguments, but only 2 given
/lib/modules/2.6.1/build/include/linux/highmem.h:119:41: macro 
"copy_user_page" requires 4 arguments, but only 3 given
cat kernel/include/sensors.h.template > kernel/include/sensors.h
awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL END/' kernel/chips/*.c >> 
kernel/include/sensors.h
echo '#endif' >> kernel/include/sensors.h
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -Wall -O2 
-march=athlon-xp -mcpu=athlon-xp -O3 -pipe -fomit-frame-pointer 
prog/sensors/chips.c | \
        sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro: 
Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' > 
prog/sensors/chips.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -Wall -O2 
-march=athlon-xp -mcpu=athlon-xp -O3 -pipe -fomit-frame-pointer lib/proc.c | 
\
        sed -e 's@^\(.*\)\.o:@lib/proc.ad lib/proc.ao: Makefile '`dirname 
lib/proc.ad`/Module.mk' @' > lib/proc.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -Wall -O2 
-march=athlon-xp -mcpu=athlon-xp -O3 -pipe -fomit-frame-pointer lib/chips.c | 
\
        sed -e 's@^\(.*\)\.o:@lib/chips.ad lib/chips.ao: Makefile '`dirname 
lib/chips.ad`/Module.mk' @' > lib/chips.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -fpic -Wall -O2 
-march=athlon-xp -mcpu=athlon-xp -O3 -pipe -fomit-frame-pointer lib/proc.c | 
\
        sed -e 's@^\(.*\)\.o:@lib/proc.ld lib/proc.lo: Makefile '`dirname 
lib/proc.ld`/Module.mk' @' > lib/proc.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -fpic -Wall -O2 
-march=athlon-xp -mcpu=athlon-xp -O3 -pipe -fomit-frame-pointer lib/chips.c | 
\
        sed -e 's@^\(.*\)\.o:@lib/chips.ld lib/chips.lo: Makefile '`dirname 
lib/chips.ld`/Module.mk' @' > lib/chips.ld
make: *** No rule to make target `users'.  Stop.

I've got Slackware 9.1. How can it possible I cannot compile
lm_sensors? I tryed with a lot of version but it's very complicated.

A linux user
