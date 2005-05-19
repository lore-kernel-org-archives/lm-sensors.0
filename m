From: soppscum@online.no (Michael)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: sensors segfaults with glibc2.3.1
Message-Id: <200212161408.PAA05030@mail44.fg.online.no>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(gdb) run
Starting program: /usr/local/bin/sensors 

Program received signal SIGSEGV, Segmentation fault.
0x400c7184 in strcmp () from /lib/libc.so.6
(gdb) backtrace
#0  0x400c7184 in strcmp () from /lib/libc.so.6
#1  0x4002b485 in sensors_match_chip () from /usr/local/lib/libsensors.so.1
#2  0x0804915c in do_the_real_work ()
#3  0x08049069 in main ()
#4  0x40063bb4 in __libc_start_main () from /lib/libc.so.6

I tested the exact same binary in a chroot with glibc 2.2.5 and it runs fine.
Anyway hope this is the right place to "whine" =D

Thanks.
