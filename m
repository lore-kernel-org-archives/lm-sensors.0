From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Feb 2009 15:48:53 +0000
Subject: Re: [lm-sensors] Cannot make ver 3.0.3
Message-Id: <20090217164853.5df48d14@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <499AD983.7060708@yahoo.co.uk>
In-Reply-To: <499AD983.7060708@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, 17 Feb 2009 16:36:35 +0100, DB wrote:
> Good afternoon,
> 
> I've just tried to make lm_sensors ver 3.0.3, with the following result:
> 
> [root@Fedora-Blue lm_sensors-3.0.3]# make all
> gcc -DETCDIR="\"/etc\"" -I. -Wall -O2 -Wstrict-prototypes -Wshadow 
> -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
> -Wnested-externs -Winline -W -Wmissing-prototypes -Wundef -Wno-shadow 
> -Wno-undef -Wno-unused -Wno-missing-prototypes -Wno-sign-compare -c 
> lib/conf-lex.c -o lib/conf-lex.ao
> rm -f lib/libsensors.a
> ar rcvs lib/libsensors.a lib/data.ao lib/general.ao lib/error.ao 
> lib/access.ao lib/init.ao lib/sysfs.ao lib/conf-parse.ao lib/conf-lex.ao
> a - lib/data.ao
> a - lib/general.ao
> a - lib/error.ao
> a - lib/access.ao
> a - lib/init.ao
> a - lib/sysfs.ao
> a - lib/conf-parse.ao
> a - lib/conf-lex.ao
> gcc -DETCDIR="\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2 
> -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
> -Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
> -Wundef -c lib/data.c -o lib/data.lo
> gcc -DETCDIR="\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2 
> -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
> -Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
> -Wundef -c lib/general.c -o lib/general.lo
> gcc -DETCDIR="\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2 
> -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
> -Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
> -Wundef -c lib/error.c -o lib/error.lo
> gcc -DETCDIR="\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2 
> -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
> -Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
> -Wundef -c lib/access.c -o lib/access.lo
> gcc -DETCDIR="\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2 
> -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
> -Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
> -Wundef -c lib/init.c -o lib/init.lo
> gcc -DETCDIR="\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2 
> -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
> -Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
> -Wundef -c lib/sysfs.c -o lib/sysfs.lo
> gcc -DETCDIR="\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2 
> -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
> -Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
> -Wundef -Wno-undef -c lib/conf-parse.c -o lib/conf-parse.lo
> gcc -DETCDIR="\"/etc\"" -I. -fpic -D_REENTRANT -Wall -O2 
> -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
> -Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
> -Wundef -Wno-shadow -Wno-undef -Wno-unused -Wno-missing-prototypes 
> -Wno-sign-compare -c lib/conf-lex.c -o lib/conf-lex.lo
> gcc -shared -Wl,-soname,libsensors.so.4 -o lib/libsensors.so.4.0.2 
> lib/data.lo lib/general.lo lib/error.lo lib/access.lo lib/init.lo 
> lib/sysfs.lo lib/conf-parse.lo lib/conf-lex.lo -lc -lm
> rm -f lib/libsensors.so.4
> ln -sf libsensors.so.4.0.2 lib/libsensors.so.4
> rm -f lib/libsensors.so
> ln -sf libsensors.so.4.0.2 lib/libsensors.so
> gcc -DETCDIR="\"/etc\"" -I. -Wall -O2 -Wstrict-prototypes -Wshadow 
> -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
> -Wnested-externs -Winline -W -Wmissing-prototypes -Wundef -c 
> prog/sensors/main.c -o prog/sensors/main.ro
> prog/sensors/main.c: In function ‘set_degstr’:
> prog/sensors/main.c:128: warning: initialization discards qualifiers 
> from pointer target type
> prog/sensors/main.c:128: warning: initialization discards qualifiers 
> from pointer target type
> gcc -DETCDIR="\"/etc\"" -I. -Wall -O2 -Wstrict-prototypes -Wshadow 
> -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
> -Wnested-externs -Winline -W -Wmissing-prototypes -Wundef -c 
> prog/sensors/chips.c -o prog/sensors/chips.ro
> gcc -Wl,-rpath,/usr/local/lib -o prog/sensors/sensors 
> prog/sensors/main.ro prog/sensors/chips.ro -Llib -lsensors
> lib/libsensors.so: undefined reference to `sensors_yylex'
> lib/libsensors.so: undefined reference to `sensors_lex_error'
> lib/libsensors.so: undefined reference to `sensors_yylineno'
> lib/libsensors.so: undefined reference to `sensors_scanner_exit'
> lib/libsensors.so: undefined reference to `sensors_scanner_init'
> collect2: ld returned 1 exit status
> make: *** [prog/sensors/sensors] Error 1
> 
> Any suggestions on how to deal with the 5 undefined references????

Please do "make clean" and then "make" again. The above log lacks the
beginning of the build, so I can't tell what went wrong.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
