From: whitney@Math.Berkeley.EDU (Wayne Whitney)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors current CVS on 2.6.0-test10
Message-Id: <Pine.SOL.4.44.0311271934150.3525-100000@blue1>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.SOL.4.44.0311261657140.26419-100000@blue1>
In-Reply-To: <Pine.SOL.4.44.0311261657140.26419-100000@blue1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 27 Nov 2003, Jean Delvare wrote:

> You should recompile sensors with -g instead of -O2 before (edit
> ALL_CPPFLAGS in Makefile), it'll provide a more usefull backtrace.
> Please update to the latest CVS version (use "cvs update"), we have been
> commiting a few fixes recently.

OK, I just did a cvs update and I recompiled the user programs with -g.
Kernel is 2.6.0-test11 with ruby patch from linuxconsole.sf.net, and the
relevant module stack is it87, i2c_sensor, i2c_isa, i2c_core.  The gdb
output is below.

Thanks,
Wayne

(gdb) run
Starting program: /usr/local/bin/sensors
it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore:     +1.77 V  (min =  +1.66 V, max =  +1.82 V)
+2.5V:     +2.54 V  (min =  +2.40 V, max =  +2.60 V)
+3.3V:     +3.31 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +5.02 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.28 V  (min = +11.36 V, max = +12.60 V)
fan1:     1864 RPM  (min = 1328 RPM, div = 4)
Temp1/MB:    +33C  (low  =   +35C, high =   +45C)   sensor = thermistor
Temp2/CPU:   +28C  (low  =   +45C, high =   +65C)   sensor = thermistor


Program received signal SIGSEGV, Segmentation fault.
0x009402bc in _int_free () from /lib/tls/libc.so.6
(gdb) bt
#0  0x009402bc in _int_free () from /lib/tls/libc.so.6
#1  0x0093f28b in free () from /lib/tls/libc.so.6
#2  0x40015618 in free_bus (bus      {number = -1, adapter = 0x8065330 "\231\006\bmain adapter", algorithm = 0x40019746 "ISA bus algorithm", lineno = 1073795018}) at lib/init.c:98
#3  0x40015553 in sensors_cleanup () at lib/init.c:78
#4  0x0804936c in main (argc=1, argv=0xbffff944) at prog/sensors/main.c:237


