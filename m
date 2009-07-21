From: "J.I. Cameron" <jic23@cam.ac.uk>
Date: Tue, 21 Jul 2009 11:57:10 +0000
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire
Message-Id: <Prayer.1.3.1.0907211257100.23451@hermes-2.csi.cam.ac.uk>
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
 <528f13590907171421m26bc67ecg8d0334d20365406f@mail.gmail.com>
In-Reply-To: <528f13590907171421m26bc67ecg8d0334d20365406f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Jul 17 2009, alfred steele wrote:

>Hi Jonathan,
>
>> that look about right are going down them.
>I had some misconfiguration the way i had registered the interrupt handler.
>
>A very naive question at this point. Wouldnt it be possible to "not"
>use  a GPIO irq and bottom half and instead to simplify the driver to
>start with, use a synchronous read routine.? I know this may violate
>the kernel framework but...

It would indeed be possible but would come at the cost of having some 
pretty hideous hard coded delays. Seeing as the device tells you that it 
has new data available (and the delays in question are huge and probably 
not all that consistent - though I've never measured them on different 
chips) I'm personally of the view that the interrupt method is the nicest 
solution.


>This is what i get on the console now
>
> $ cat /sys/class/hwmon/hwmon0/device/hwmon\:hwmon0/device/humidi 
> ty1_input sht15 sht15: Command not acknowledged cat: read error: 
> Input/output error ~$ cat 
> /sys/class/hwmon/hwmon0/device/hwmon\:hwmon0/device/humidi ty1_input cat: 
> read error: Timer expired root@freescale ~$ cat 
> /sys/class/hwmon/hwmon0/device/hwmon\:hwmon0/device/humidi ty1_input 
> Unbalanced enable for IRQ 0 WARNING: at kernel/irq/manage.c:174 
> enable_irq() [<c002dce0>] (dump_stack+0x0/0x14) from [<c0074050>] 
> (enable_irq+0x74/0xdc) [<c0073fdc>] (enable_irq+0x0/0xdc) from 
> [<bf000408>]
Hmm. The unbalanced irq certainly looks like an actual bug even if this
condition should never occur if things are working correctly.

I'm not sure where that timer expired message is coming from and
unfortunately don't have easy access to source code here to track
it down.  

> (sht15_update_vals+0x190/0x 2c8 [sht15]) r6:00000010 
> r5:cfdbf420 r4:cfe331e0 [<bf000278>] (sht15_update_vals+0x0/0x2c8 
> [sht15]) from [<bf0007f4>] (sht15_show _humidity+0x1c/0x130 [sht15]) 
> [<bf0007d8>] (sht15_show_humidity+0x0/0x130 [sht15]) from [<c0175044>] 
> (dev_attr _show+0x24/0x30) [<c0175020>] (dev_attr_show+0x0/0x30) from 
> [<c00d99ac>] (sysfs_read_file+0xa8/0x 108) [<c00d9904>] 
> (sysfs_read_file+0x0/0x108) from [<c009ac40>] (vfs_read+0xb4/0x144) 
> [<c009ab8c>] (vfs_read+0x0/0x144) from [<c009b080>] (sys_read+0x44/0x70) 
> r7:00000000 r6:00000000 r5:fffffff7 r4:cfea93c0 [<c009b03c>] 
> (sys_read+0x0/0x70) from [<c0029ec0>] (ret_fast_syscall+0x0/0x2c) 
> r7:00000003 r6:4001da30 r5:beaa9ae0 r4:00002000 cat: read error: Timer 
> expired
That looks nasty. I'm out of the office at the moment, so can't realy look
into this in any depth. Should be back in action on Thursday.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
