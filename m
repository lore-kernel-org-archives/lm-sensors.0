From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 17 May 2006 03:24:18 +0000
Subject: [lm-sensors] user prog sensors seg faults
Message-Id: <20060517032418.GB8748@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <445F4C46.8000800@telus.net>
In-Reply-To: <445F4C46.8000800@telus.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi lloyd:

* lloyd <millerlf at telus.net> [2006-05-16 00:31:40 -0600]:
> "Mark M. Hoffman" <mhoffman at lightlink.com> wrote:
> 
> | > I did a debuging link of sensors and got the exact place where it crashes:
> | > 
> | > 
> | > | Program received signal SIGSEGV, Segmentation fault.
> | > | 0x000000000041e910 in sensors_read_one_sysfs_chip (dev=0x550230)
> | > |     at lib/sysfs.c:57
> | > | 57              if (attr->len >= 11 && !strcmp(attr->value + attr->len 
> | > - 11,
> | > 
> | > 
> | > (gdb) backtrace
> | > #0  0x000000000041e910 in sensors_read_one_sysfs_chip (dev=0x550230)
> | >    at lib/sysfs.c:57
> | > #1  0x000000000041eb82 in sensors_read_sysfs_chips () at lib/sysfs.c:154
> | > #2  0x000000000041e609 in sensors_init (input=0x54e6a0) at lib/init.c:45
> | > #3  0x000000000040210c in main (argc=2, argv=0x7ffffb0a2168)
> | >    at prog/sensors/main.c:237
> 
> |  Can you set a breakpoint at that line (lib/sysfs.c:57) and tell me 
> what are the contents of attr->len and attr->value? Thanks

Thanks for helping to debug further...

> (gdb) run
> Starting program: /home/lloyd/lm_sensors/lm_sensors-2.10.0/prog/sensors/sensors 
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x000000000041e910 in sensors_read_one_sysfs_chip (dev=0x550230)
>     at lib/sysfs.c:57
> 57              if (attr->len >= 11 && !strcmp(attr->value + attr->len - 11,
> (gdb) p attr
> $1 = (struct sysfs_attribute *) 0x5524b0
> (gdb) p *attr
> $2 = {name = "name", '\0' <repeats 46 times>, "/sys/devices/p", 

Aha:  the 'name' element of struct sysfs_attribute is supposed to be a (string)
array of 50 chars - according to libsysfs.h on my system.  Meanwhile, GDB thinks
yours is 64 chars.  I think you probably have a mismatch between the version of
the header file libsysfs.h and the version of the compiled library libsyfs.so.

I.e. libsensors is expecting attr.name to be 64 chars while your libsysfs treats
it as 50 chars.  Of course that will lead to segfaults.

>   path = "latform/i2c-9191/9191-0480/name", '\0' <repeats 218 times>, "&U\000\000\000\000",

This further confirms that the two libraries disagree about the structure
definition.  See how the path got chopped up?

>   value = 0x1000b <Address 0x1000b out of bounds>, len = 33, 
>   method = 0}
> (gdb) 
> 
> ... so I looks like the name and path are messed up as well as the value
> pointer. the len of 33 might be ok, who knows.

Nope, everything after 'name' in the struct is fubar.

What to do?  Make sure that you have just one version of libsysfs installed,
and just one set of header files from the same version.  Then rebuild sensors
(be sure to 'make clean' first) and I expect it will work.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


