From: DB <Freddog_de@yahoo.co.uk>
Date: Tue, 17 Feb 2009 15:36:35 +0000
Subject: [lm-sensors] Cannot make ver 3.0.3
Message-Id: <499AD983.7060708@yahoo.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Good afternoon,

I've just tried to make lm_sensors ver 3.0.3, with the following result:

[root@Fedora-Blue lm_sensors-3.0.3]# make all
gcc -DETCDIR=3D"\"/etc\"" -I. -Wall -O2 -Wstrict-prototypes -Wshadow=20
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings=20
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef -Wno-shadow=20
-Wno-undef -Wno-unused -Wno-missing-prototypes -Wno-sign-compare -c=20
lib/conf-lex.c -o lib/conf-lex.ao
rm -f lib/libsensors.a
ar rcvs lib/libsensors.a lib/data.ao lib/general.ao lib/error.ao=20
lib/access.ao lib/init.ao lib/sysfs.ao lib/conf-parse.ao lib/conf-lex.ao
a - lib/data.ao
a - lib/general.ao
a - lib/error.ao
a - lib/access.ao
a - lib/init.ao
a - lib/sysfs.ao
a - lib/conf-parse.ao
a - lib/conf-lex.ao
gcc -DETCDIR=3D"\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2=20
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align=20
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes=20
-Wundef -c lib/data.c -o lib/data.lo
gcc -DETCDIR=3D"\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2=20
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align=20
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes=20
-Wundef -c lib/general.c -o lib/general.lo
gcc -DETCDIR=3D"\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2=20
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align=20
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes=20
-Wundef -c lib/error.c -o lib/error.lo
gcc -DETCDIR=3D"\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2=20
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align=20
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes=20
-Wundef -c lib/access.c -o lib/access.lo
gcc -DETCDIR=3D"\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2=20
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align=20
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes=20
-Wundef -c lib/init.c -o lib/init.lo
gcc -DETCDIR=3D"\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2=20
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align=20
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes=20
-Wundef -c lib/sysfs.c -o lib/sysfs.lo
gcc -DETCDIR=3D"\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2=20
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align=20
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes=20
-Wundef -Wno-undef -c lib/conf-parse.c -o lib/conf-parse.lo
gcc -DETCDIR=3D"\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2=20
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align=20
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes=20
-Wundef -Wno-shadow -Wno-undef -Wno-unused -Wno-missing-prototypes=20
-Wno-sign-compare -c lib/conf-lex.c -o lib/conf-lex.lo
gcc -shared -Wl,-soname,libsensors.so.4 -o lib/libsensors.so.4.0.2=20
lib/data.lo lib/general.lo lib/error.lo lib/access.lo lib/init.lo=20
lib/sysfs.lo lib/conf-parse.lo lib/conf-lex.lo -lc -lm
rm -f lib/libsensors.so.4
ln -sf libsensors.so.4.0.2 lib/libsensors.so.4
rm -f lib/libsensors.so
ln -sf libsensors.so.4.0.2 lib/libsensors.so
gcc -DETCDIR=3D"\"/etc\"" -I. -Wall -O2 -Wstrict-prototypes -Wshadow=20
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings=20
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef -c=20
prog/sensors/main.c -o prog/sensors/main.ro
prog/sensors/main.c: In function =91set_degstr=92:
prog/sensors/main.c:128: warning: initialization discards qualifiers=20
from pointer target type
prog/sensors/main.c:128: warning: initialization discards qualifiers=20
from pointer target type
gcc -DETCDIR=3D"\"/etc\"" -I. -Wall -O2 -Wstrict-prototypes -Wshadow=20
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings=20
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef -c=20
prog/sensors/chips.c -o prog/sensors/chips.ro
gcc -Wl,-rpath,/usr/local/lib -o prog/sensors/sensors=20
prog/sensors/main.ro prog/sensors/chips.ro -Llib -lsensors
lib/libsensors.so: undefined reference to `sensors_yylex'
lib/libsensors.so: undefined reference to `sensors_lex_error'
lib/libsensors.so: undefined reference to `sensors_yylineno'
lib/libsensors.so: undefined reference to `sensors_scanner_exit'
lib/libsensors.so: undefined reference to `sensors_scanner_init'
collect2: ld returned 1 exit status
make: *** [prog/sensors/sensors] Error 1

Any suggestions on how to deal with the 5 undefined references????

I'm using Fedora 9

root@Fedora-Blue lm_sensors-3.0.3]# uname -r
2.6.27.12-78.2.8.fc9.i686
[root@Fedora-Blue lm_sensors-3.0.3]# uname -a
Linux Fedora-Blue 2.6.27.12-78.2.8.fc9.i686 #1 SMP Mon Jan 19 20:14:35=20
EST 2009 i686 athlon i386 GNU/Linux


Thanks

Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
