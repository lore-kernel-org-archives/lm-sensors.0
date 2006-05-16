From: millerlf@telus.net (lloyd)
Date: Tue, 16 May 2006 06:31:40 +0000
Subject: [lm-sensors] user prog sensors seg faults
Message-Id: <446971CC.3050409@telus.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <445F4C46.8000800@telus.net>
In-Reply-To: <445F4C46.8000800@telus.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"Mark M. Hoffman" <mhoffman at lightlink.com> wrote:

| > I did a debuging link of sensors and got the exact place where it crashes:
| > 
| > 
| > | Program received signal SIGSEGV, Segmentation fault.
| > | 0x000000000041e910 in sensors_read_one_sysfs_chip (dev=0x550230)
| > |     at lib/sysfs.c:57
| > | 57              if (attr->len >= 11 && !strcmp(attr->value + attr->len 
| > - 11,
| > 
| > 
| > (gdb) backtrace
| > #0  0x000000000041e910 in sensors_read_one_sysfs_chip (dev=0x550230)
| >    at lib/sysfs.c:57
| > #1  0x000000000041eb82 in sensors_read_sysfs_chips () at lib/sysfs.c:154
| > #2  0x000000000041e609 in sensors_init (input=0x54e6a0) at lib/init.c:45
| > #3  0x000000000040210c in main (argc=2, argv=0x7ffffb0a2168)
| >    at prog/sensors/main.c:237

|  Can you set a breakpoint at that line (lib/sysfs.c:57) and tell me 
what are the contents of attr->len and attr->value? Thanks

(gdb) run
Starting program: /home/lloyd/lm_sensors/lm_sensors-2.10.0/prog/sensors/sensors 

Program received signal SIGSEGV, Segmentation fault.
0x000000000041e910 in sensors_read_one_sysfs_chip (dev=0x550230)
    at lib/sysfs.c:57
57              if (attr->len >= 11 && !strcmp(attr->value + attr->len - 11,
(gdb) p attr
$1 = (struct sysfs_attribute *) 0x5524b0
(gdb) p *attr
$2 = {name = "name", '\0' <repeats 46 times>, "/sys/devices/p", 
  path = "latform/i2c-9191/9191-0480/name", '\0' <repeats 218 times>, "&U\000\000\000\000", value = 0x1000b <Address 0x1000b out of bounds>, len = 33, 
  method = 0}
(gdb) 


... so I looks like the name and path are messed up as well as the value pointer. the len of 33 might be ok, who knows.



