From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 01 Oct 2012 19:35:32 +0000
Subject: Re: [lm-sensors] How to use SC18IS602 driver ?
Message-Id: <20121001193532.GA2781@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120928013559.GA14405@roeck-us.net>
In-Reply-To: <20120928013559.GA14405@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 01, 2012 at 01:41:00PM -0500, Bruce Parker wrote:
>  
> 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:linux@roeck-us.net] 
> > Sent: Monday, October 01, 2012 12:19 PM
> > To: Bruce Parker
> > Cc: lm-sensors@lm-sensors.org
> > Subject: Re: How to use SC18IS602 driver ?
> > 
> > On Mon, Oct 01, 2012 at 09:03:15AM -0500, Bruce Parker wrote:
> > 
> > [ ... ]
> > 
> > > 
> > > Ok...got i2cdetect installed and below is result:
> > > # i2cdetect 0
> > > WARNING! This program can confuse your I2C bus, cause data loss and
> > > worse!
> > > I will probe file /dev/i2c-0.
> > > I will probe address range 0x03-0x77.
> > > Continue? [Y/n] y
> > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 20: UU UU UU UU UU UU UU UU UU -- -- -- -- -- -- --
> > > 30: -- 31 -- -- -- -- -- UU -- -- -- -- -- -- -- --
> > > 40: -- -- -- -- -- -- -- -- -- -- -- -- UU -- -- --
> > > 50: UU UU UU UU UU UU UU -- -- -- -- -- -- -- -- --
> > > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 70: -- -- -- -- -- -- -- --
> > > I2C-SPI bridge is at addr 28, so it appears to be detected. 
> > > 
> > > Below is my entry in device tree, but I do not see anything 
> > special in
> > > /dev/mtd*
> > >                                 spi: spi@28 {
> > >                                         compatible = 
> > "nxp,sc18is602";
> > >                                         #address-cells = <1>;
> > >                                         #size-cells = <0>;
> > >                                         reg = <0x28>;
> > >                                         m25p80@0 {
> > >                                                 
> > #address-cells = <1>;
> > >                                                 #size-cells = <1>;
> > >                                                 compatible > > > "fsl,espi-flash";
> > >                                                 linux,modalias > > > "m25p80";
> > >                                                 spi-max-frequency > > > <25000000>;
> > >                                                 modal = "s25sl064a";
> > >                                                 reg = <0>;
> > >                                                 mode = <0>;
> > > 
> > >                                                 partition@0 {
> > >                                                     reg = <0x0
> > > 0x00080000>;
> > >                                                     label = "Test
> > > Image";
> > >                                                     read-only;
> > >                                                 };
> > >                                         };
> > >                                 };
> > 
> > I don't know much about devicetree instantiation, but the one 
> > example I found
> > for  m25p80 looks a bit different and much simpler.
> > 
> > 	flash: m25p80@0 {
> >         	compatible = "sst,sst25vf016b";
> > 		spi-max-frequency = <20000000>;
> > 		reg = <0>;
> > 	};
> > 
> Ok, tried your example in my device tree and it definitely changed
> something. Unfortunately, the kernel crashed during booting as shown
> below. But I guess it does imply it was trying to instantiate the
> device, where previous device tree didn't seem to be doing anything for
> the SPI. Do you know how I could try to instantiate the device outside
> of a device tree?
> 

I typically use the new_device ABI I introduced for that purpose:
	https://patchwork.kernel.org/patch/1426841/
Unfortunately, it was not accepted upstream, to some degree because no one
besides me supported it. It does not support creating partitions, but you
should be able to create a simple device with a single partition.

> Unable to handle kernel paging request for instruction fetch
> Faulting instruction address: 0x00000000
> Oops: Kernel access of bad area, sig: 11 [#1]
> PowerPC 44x Platform
> Modules linked in:
> NIP: 00000000 LR: 8022dcb4 CTR: 00000000
> REGS: 9f8a5ec0 TRAP: 0400   Not tainted  (3.4.0-tanisys-sx2-25227)
> MSR: 00029000 <CE,EE,ME>  CR: 22000022  XER: 20000000
> TASK = ef8fd5e0[1039] 'spi0' THREAD: 9f8a4000
> GPR00: 00000000 9f8a5f70 ef8fd5e0 ef8cf400 ef8fd5e0 ffff5762 ffffffff
> ffd23940
> GPR08: 00000001 00000000 ef8cf524 ef8cf524 22002022 10220170 7fff2500
> 7ffe122c
> GPR16: 7ffe1250 00000000 7ffed388 034f2c0f 03000040 7ff31f70 80000010
> 0000000e
> GPR24: 00000000 7ff31e90 00000e80 80047c38 ef8cf504 00029000 ef8cf504
> ef8cf400
> NIP [00000000]   (null)
> LR [8022dcb4] spi_pump_messages+0x108/0x160
> Call Trace:
> [9f8a5f70] [7ff31e90] 0x7ff31e90 (unreliable)
> [9f8a5f90] [80047ba0] kthread_worker_fn+0x98/0x130
> [9f8a5fb0] [80047cbc] kthread+0x84/0x88
> [9f8a5ff0] [8000b390] kernel_thread+0x4c/0x68
> Instruction dump:
> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> ---[ end trace f360c06729bfcc7f ]---

Odd, that suggests that something was not initialized properly. No idea what is
going on, though.

Guenter

> > > 
> > > 
> > > # ls /dev/mtd*
> > > /dev/mtd0        /dev/mtd6        /dev/mtdblock2   /dev/mtdr12
> > > /dev/mtd1        /dev/mtd7        /dev/mtdblock3   /dev/mtdr13
> > > /dev/mtd10       /dev/mtd8        /dev/mtdblock4   /dev/mtdr14
> > > /dev/mtd11       /dev/mtd9        /dev/mtdblock5   /dev/mtdr15
> > > /dev/mtd12       /dev/mtdblock0   /dev/mtdblock6   /dev/mtdr2
> > > /dev/mtd13       /dev/mtdblock1   /dev/mtdblock7   /dev/mtdr3
> > > /dev/mtd14       /dev/mtdblock10  /dev/mtdblock8   /dev/mtdr4
> > > /dev/mtd15       /dev/mtdblock11  /dev/mtdblock9   /dev/mtdr5
> > > /dev/mtd2        /dev/mtdblock12  /dev/mtdr0       /dev/mtdr6
> > > /dev/mtd3        /dev/mtdblock13  /dev/mtdr1       /dev/mtdr7
> > > /dev/mtd4        /dev/mtdblock14  /dev/mtdr10      /dev/mtdr8
> > > /dev/mtd5        /dev/mtdblock15  /dev/mtdr11      /dev/mtdr9
> > > 
> > Since you do see a whole lot of mtd devices, did you try to 
> > access any of those ?
> > 
> > Also, what is the output of /proc/mtd ? That should give you 
> > a mapping from
> > the partition label to the actual mtd device if the partition 
> > was created.
> > 
> > Thanks,
> > Guenter
> > 
> Forgot to include this before but /proc/mtd shows nothing even though
> all those files are there.
> # cat /proc/mtd
> dev:    size   erasesize  name
> #
> 
> Bruce...
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
