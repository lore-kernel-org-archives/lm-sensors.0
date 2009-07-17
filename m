From: alfred steele <alfred.jaquez@gmail.com>
Date: Fri, 17 Jul 2009 21:21:48 +0000
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire
Message-Id: <528f13590907171421m26bc67ecg8d0334d20365406f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>
	 <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com>
	 <4A5D6C0A.7030903@gmx.de>
	 <528f13590907150722q2a91139bve72d65cbd555b8e9@mail.gmail.com>
	 <4A5DEB12.3020602@cam.ac.uk>
	 <528f13590907151032y30ae62beo486d4e1056219983@mail.gmail.com>
	 <4A5E206F.8000001@cam.ac.uk>
	 <528f13590907160913n73dcb4fcuf09f4946d7578793@mail.gmail.com>
	 <528f13590907160929r1385c99el6c1ed16ca1b592d2@mail.gmail.com>
	 <4A5F76A8.8080001@cam.ac.uk>
In-Reply-To: <4A5F76A8.8080001-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Hi Jonathan,

> that look about right are going down them.
I had some misconfiguration the way i had registered the interrupt handler.

A very naive question at this point. Wouldnt it be possible to "not"
use  a GPIO irq and bottom half and instead to simplify the driver to
start with, use a synchronous read routine.? I know this may violate
the kernel framework but...
This is what i get on the console now

$ cat /sys/class/hwmon/hwmon0/device/hwmon\:hwmon0/device/humidi
ty1_input
sht15 sht15: Command not acknowledged
cat: read error: Input/output error
 ~$ cat /sys/class/hwmon/hwmon0/device/hwmon\:hwmon0/device/humidi
ty1_input
cat: read error: Timer expired
root@freescale ~$ cat /sys/class/hwmon/hwmon0/device/hwmon\:hwmon0/device/humidi
ty1_input
Unbalanced enable for IRQ 0
WARNING: at kernel/irq/manage.c:174 enable_irq()
[<c002dce0>] (dump_stack+0x0/0x14) from [<c0074050>] (enable_irq+0x74/0xdc)
[<c0073fdc>] (enable_irq+0x0/0xdc) from [<bf000408>] (sht15_update_vals+0x190/0x
2c8 [sht15])
 r6:00000010 r5:cfdbf420 r4:cfe331e0
[<bf000278>] (sht15_update_vals+0x0/0x2c8 [sht15]) from [<bf0007f4>] (sht15_show
_humidity+0x1c/0x130 [sht15])
[<bf0007d8>] (sht15_show_humidity+0x0/0x130 [sht15]) from [<c0175044>] (dev_attr
_show+0x24/0x30)
[<c0175020>] (dev_attr_show+0x0/0x30) from [<c00d99ac>] (sysfs_read_file+0xa8/0x
108)
[<c00d9904>] (sysfs_read_file+0x0/0x108) from [<c009ac40>] (vfs_read+0xb4/0x144)
[<c009ab8c>] (vfs_read+0x0/0x144) from [<c009b080>] (sys_read+0x44/0x70)
 r7:00000000 r6:00000000 r5:fffffff7 r4:cfea93c0
[<c009b03c>] (sys_read+0x0/0x70) from [<c0029ec0>] (ret_fast_syscall+0x0/0x2c)
 r7:00000003 r6:4001da30 r5:beaa9ae0 r4:00002000
cat: read error: Timer expired

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
